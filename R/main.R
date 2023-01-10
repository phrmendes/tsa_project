#################
## MAIN SCRIPT ##
#################

# working directory ----

setwd(system("git rev-parse --show-toplevel", intern = TRUE))

# creating results folder ----

if (!fs::dir_exists("results")) fs::dir_create("results")

# loading functions ----

fs::dir_ls("R/functions/") |>
  purrr::walk(~ source(.x))

# loading packages ----

c(
  "dplyr",
  "tidyr",
  "purrr",
  "ggplot2",
  "lubridate",
  "janitor",
  "fs",
  "glue",
  "quarto",
  "vars",
  "stargazer",
  "ipeadatar",
  "deflateBR"
) |>
  load_libraries()

# fetching ipeadata ----

ipea_series <- list(
  consumption = "SCN104_CFPPN104",
  pib = "SCN104_PIBPMV104",
  exchange_rate = "BM12_ERV12",
  exchange_rate_sd = "GM366_ERV366"
)

series <- purrr::map(
  ipea_series,
  download_serie
) |>
  purrr::reduce(
    dplyr::left_join,
    by = "date"
  )

names(series)[seq(2, ncol(series))] <- names(ipea_series)

# estimating marginal propensity to consume ----

series <- series |>
  dplyr::mutate(
    lag_consumption = dplyr::lag(consumption, n = 1),
    lag_pib = dplyr::lag(pib, n = 1),
    delta_consumption = consumption - lag_consumption,
    delta_pib = pib - lag_pib,
    mpc = delta_consumption / delta_pib
  ) |>
  dplyr::select(-tidyselect::matches("lag|delta")) |>
  tidyr::drop_na()

# series diagnostics ----

# unit root tests ----

# variables and data for the models ----

start_date <- c(lubridate::year(series$date[1]), 2)
end_date <- c(lubridate::year(series$date[nrow(series)]), 4)
model_variables <- list(
  model_1 = c("mpc", "exchange_rate"),
  model_2 = c("mpc", "exchange_rate_sd")
)

models_data <- purrr::map(
  .x = model_variables,
  ~ create_models_data(
    df = series,
    vars = .x,
    start_date,
    end_date
  )
)

# models ----

models <- purrr::map2(
  .x = models_data,
  .y = list("exchange_rate", "exchange_rate_sd"),
  ~ run_model(ts_obj = .x, impulse_var = .y)
)

# table models ----

sink(file = "results/model_results.tex")
stargazer::stargazer(models[[1]]$result, models[[2]]$result, type = "latex")
sink()

# ts plots ----

captions <- c(
  "Consumo das famílias (em R$ mi)",
  "PIB (em R$ mi)",
  "Taxa de câmbio nominal (R$/US$)",
  "Desvio padrão trimestral da taxa de câmbio nominal diária (R$/US$)",
  "Propensão marginal a consumir"
)

purrr::walk2(
  .x = names(series)[-1],
  .y = captions,
  ~ ts_plot(
    df = series,
    col = .x,
    caption = .y,
    start_date,
    end_date
  )
)

# impulse response plots ----

irf <- purrr::map(models, ~ .x$irf)
cum_irf <- purrr::map(models, ~ .x$cum_irf)

purrr::walk2(
  .x = list(irf, cum_irf),
  .y = c("irf", "cum_irf"),
  ~ impulse_response_plot(data = .x, type = .y)
)
