# ----------------- #
# --- LIBRARIES --- #
# ----------------- #

options(repos = c(RSPM = "https://packagemanager.rstudio.com/all/latest"))

if (!require("pacman")) install.packages("pacman")

if (!require("stringi")) install.packages(
  "stringi",
  dependencies = TRUE,
  INSTALL_opts = "--no-lock",
  configure.args = "--disable-pkg-config"
)

pacman::p_load(
  tidyverse,
  arrow,
  data.table,
  janitor,
  curl,
  zip,
  fs,
  glue,
  lintr,
  styler,
  rjson,
  formatR,
  yaml,
  quarto
)
