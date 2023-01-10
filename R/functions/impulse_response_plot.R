impulse_response_plot <- function(data, type) {
  purrr::walk2(
    .x = data,
    .y = names(data),
    ~ plot(.x) |>
      export_png(x = _, path = glue::glue("results/{type}_{.y}.png"))
  )
}
