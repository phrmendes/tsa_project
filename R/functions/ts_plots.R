ts_plot <- function(df, col, caption, start_date, end_date) {
  file_name <- janitor::make_clean_names(caption)
  selected_cols <- c("date", col)
  df <- df |> dplyr::select(dplyr::all_of(selected_cols))

  ts_obj <- ts(
    data = df[[2]],
    start = c(start_date, 1),
    end = c(end_date, 3),
    frequency = 4
  )

  plot <- plot(ts_obj, ylab = caption, xlab = NULL)

  export_png(plot, glue::glue("results/{file_name}.png"))
}
