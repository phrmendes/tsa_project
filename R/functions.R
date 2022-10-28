# ----------------- #
# --- FUNCTIONS --- #
# ----------------- #

# radian restart ----

radian_restart <- function(args = NULL) {
  getOption("rchitect.py_tools")$attach()
  os <- import("os") # nolint
  sys <- import("sys") # nolint
  os$execv(sys$executable, c("sys$executable", "-m", "radian", args))
}

# download pof data in .parquet files ----

pof_download <- function(args = NULL) {

  data_url <- "https://ftp.ibge.gov.br/Orcamentos_Familiares/Pesquisa_de_Orcamentos_Familiares_2017_2018/Microdados/Dados_20210304.zip" # nolint

  tmp_dir <- fs::dir_create(glue::glue("{tempdir()}/pof"))

  tmp_file <- tempfile()

  pof_parameters <- rjson::fromJSON(file = "data/aux_files/pof.json")

  curl::curl_download(
    url = data_url,
    destfile = tmp_file
  )

  zip::unzip(
    zipfile = tmp_file,
    exdir = tmp_dir
  )

  purrr::walk(
    pof_parameters,
    function(i) {
      df <- readr::read_fwf(
        file = glue::glue("{tmp_dir}/{i$file_name}.txt"),
        col_positions = readr::fwf_widths(i$widths),
        show_col_types = FALSE
      )

      names(df) <- janitor::make_clean_names(i$col_names)

      file_name <- janitor::make_clean_names(i$file_name)

      df |>
        janitor::remove_empty(which = c("rows", "cols")) |>
        arrow::write_parquet(glue::glue("data/{file_name}.parquet"))
    }
  )
}