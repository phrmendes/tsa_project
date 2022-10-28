# ------------ #
# --- DATA --- #
# ------------ #

# working directory ----

setwd(system("git rev-parse --show-toplevel", intern = TRUE))

# libraries and functions ----

source("R/libraries.R")
source("R/functions.R")

# download data ----

pof_download()
