download_serie <- function(serie) {
  df <- ipeadatar::ipeadata(serie) |>
    dplyr::select(date, value) |>
    dplyr::filter(lubridate::year(date) %in% c(2000:2019))

  if (serie %in% c("SCN104_CFPPN104", "SCN104_PIBPMV104")) {
    df <- df |>
      dplyr::mutate(
        value = deflateBR::ipca(
          nominal_values = value,
          nominal_dates = date,
          real_date = "10/2019"
        ),
        value = value / 10^6
      )
  }

  if (serie == "BM12_ERV12") {
    df <- df |>
      dplyr::mutate(date = lubridate::quarter(date, type = "date_first")) |>
      dplyr::group_by(date) |>
      dplyr::summarise(value = mean(value, na.rm = TRUE))
  }

  if (serie == "GM366_ERV366") {
    df <- df |>
      dplyr::mutate(date = lubridate::quarter(date, type = "date_first")) |>
      dplyr::group_by(date) |>
      dplyr::summarise(value = sd(value, na.rm = TRUE))
  }

  return(df)
}
