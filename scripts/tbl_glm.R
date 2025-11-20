list(tbl_uvregression(data = opts$model$data_glm,
                      method = glm,
                      method.args = list(family = binomial),
                      y = opts$model$y,
                      exponentiate = TRUE,
                      pvalue_fun = opts$pvalue$format,
                      hide_n = TRUE),
     tbl_regression(x = opts$model$glm,
                    exponentiate = TRUE,
                    pvalue_fun = opts$pvalue$format)) |>
  map(~ . |>
        gtsum_format(model_mv = opts$model$glm,
                     label_reference = opts$labs$reference) |>
        add_global_p()) |>
  tbl_merge(tab_spanner = glue("**{opts$labs$spanner}**")) %>%
  gt_format(note_global =
              c(glue("{unique(.$table_body$N_event_1)} évènements sur"),
                opts$note$n(opts$model$data)),
            note_pvalue = glue("{opts$note$ajust} (régression linéaire)"),
            width = 650) |>
  easy_out("tbl_glm")
