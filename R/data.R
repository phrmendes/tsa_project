# ------------ #
# --- DATA --- #
# ------------ #

# working directory ----

setwd(system("git rev-parse --show-toplevel", intern = T))

# libraries and functions ----

source("R/libraries.R")
source("R/functions.R")

# download data ----

pof_download()
