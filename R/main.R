# ------------------- #
# --- MAIN SCRIPT --- #
# ------------------- #

# working directory ----

setwd(system("git rev-parse --show-toplevel", intern = TRUE))

# loading functions ----

fs::dir_ls("R/functions/") |>
  purrr::walk(~ source(.x))

# loading packages ----

c(
  "tidyverse",
  "janitor",
  "fs",
  "glue",
  "vroom",
  "quarto",
  "forecast",
  "lmtest",
  "urca",
  "vars",
  "deflateBR",
  "ipeadatar"
) |>
  load_libraries()

# fetching ipeadata ----

ipea_series <- list(
  consumption = "SCN104_CFPPN104",
  pib = "SCN10_PIBN10",
  exchange_rate = "BM_ERV"
)

series <- purrr::map(
  ipea_series,
  function(i) {
    df <- ipeadatar::ipeadata(i) |>
      dplyr::select(date, value) |>
      ## dplyr::mutate(date = lubridate::quarter(date, type = "year.quarter")) |>
      dplyr::filter(lubridate::year(date) %in% c(2000:2020))
  }
)

consumption |>
  dplyr::mutate(date = as.character(date)) |>
  dplyr::mutate(date = zoo::as.Date.yearqtr(date))

consumption <- ipeadatar::ipeadata("SCN104_CFPPN104")
pib <- ipeadatar::ipeadata("SCN10_PIBN10")
exchange_rate <- ipeadatar::ipeadata("BM_ERV")
