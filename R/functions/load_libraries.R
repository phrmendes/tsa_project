load_libraries <- function(pkgs) {
  invisible(
    lapply(
      pkgs,
      function(pkgs) library(pkgs, character.only = TRUE)
    )
  )
}
