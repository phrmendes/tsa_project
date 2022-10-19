# ----------------- #
# --- LIBRARIES --- #
# ----------------- #

if (!require("pacman")) install.packages("pacman")

options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/latest"))

pacman::p_load(
  languageserver,
  httpgd,
  tidyverse,
  arrow,
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
