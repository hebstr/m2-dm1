df |>
  tbl_wide_summary(
    include = opts$data$qt$vars$total,
    statistic = opts$qt_stat_wide,
    digits = ~ 1
  ) |>
  modify_header(
    label = str_glue("**{opts$labs$header}**"),
    stat_6 = str_glue("**{names(opts$qt_stat$mean)}**")
  ) |>
  gt_format(
    note_global = opts$note$n(df),
    width = 680
  ) |>
  easy_out("tbl_qt")
