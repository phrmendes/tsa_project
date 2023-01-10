run_model <- function(ts_obj, impulse_var) {
  model <- vars::VAR(ts_obj, p = 1, type = "const")

  result <- model$varresult

  irf <- vars::irf(
    x = model,
    impulse = impulse_var,
    response = "mpc",
    ortho = FALSE,
    n.ahead = 16,
    boot = TRUE,
    runs = 1000,
    ci = 0.95
  )

  cum_irf <- vars::irf(
    x = model,
    impulse = impulse_var,
    response = "mpc",
    ortho = FALSE,
    n.ahead = 16,
    boot = TRUE,
    runs = 1000,
    ci = 0.95,
    cumulative = TRUE
  )

  saveRDS(model, glue::glue("results/model_mpc_{impulse_var}.rds"))

  return(
    list(
      result = result,
      irf = irf,
      cum_irf = cum_irf
    )
  )
}
