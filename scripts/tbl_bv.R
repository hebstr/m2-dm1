set_tbl_bv <- \(data, x) {
  data |>
    use_vars() |>
    tbl_summary(
      by = all_of(x),
      statistic = opts$vars$stat,
      digits = opts$digits
    ) |>
    add_p(
      test = opts$vars$test,
      pvalue_fun = opts$pvalue$format
    ) |>
    add_stat_label(label = opts$vars$label) |>
    gtsum_format() |>
    gt_format(
      note_global = opts$note$n(data),
      width = 950
    )
}

tbl_bv <- opts$data$ql$vars |>
  set_names() |>
  map(~ set_tbl_bv(df, .))

easy_out_map(tbl_bv)
