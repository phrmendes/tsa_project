create_models_data <- function(df, vars, start_date, end_date) {
  data <- ts(
    data = df[, vars],
    start = start_date,
    end = end_date,
    frequency = 4
  )

  return(data)
}
