# ----------------- #
# --- LIBRARIES --- #
# ----------------- #

if (!require("pacman")) install.packages("pacman")

pacman::p_load(
    tidyverse,
    basedosdados,
    arrow,
    janitor
)
