opts$data$ql$vars |>
  set_names() |>
  map(~ df |>
        use_vars() |>
        tbl_summary(by = all_of(.),
                    statistic = opts$vars$stat,
                    digits = opts$digits) |>
        add_p(test = opts$vars$test,
              pvalue_fun = opts$pvalue$format) |>
        add_stat_label(label = opts$vars$label) |>
        gtsum_format() |>
        gt_format(note_global = opts$note$n(df),
                  width = 950)) |>
  easy_out_map("tbl_bv")
