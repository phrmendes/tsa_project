sum_cols <- function(vec) {
  vec |>
    dplyr::all_of() |>
    dplyr::across() |>
    rowSums()
}
