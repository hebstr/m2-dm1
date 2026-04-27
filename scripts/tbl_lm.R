.lm_models <- lst(
  uv = tbl_uvregression(
    data = opts$model$data,
    method = lm,
    y = opts$model$y,
    pvalue_fun = opts$pvalue$format,
    hide_n = TRUE
  ),
  mv = tbl_regression(
    x = opts$model$lm,
    pvalue_fun = opts$pvalue$format
  )
)

tbl_lm <- .lm_models |>
  map(
    ~ . |>
      gtsum_format(model_mv = opts$model$lm) |>
      add_global_p()
  ) |>
  tbl_merge(tab_spanner = str_glue("**{opts$labs$spanner}**")) |>
  gt_format(
    note_global = opts$note$n(opts$model$data),
    note_pvalue = opts$note$ajust,
    width = 650
  )

easy_out(tbl_lm)
