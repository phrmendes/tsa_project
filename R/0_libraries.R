# ----------------- #
# --- LIBRARIES --- #
# ----------------- #

if (!require("pacman")) install.packages("pacman")

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
  formatR
)
