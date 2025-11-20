fig_ql <-
opts$data$ql$vars |>
  map(~ ggcount(data = df,
                var = .,
                color = opts$palette[2],
                size = 3,
                nudge_y = 0.05)) |>
  wrap_plots() +
  plot_layout(axis_titles = "collect_y")

easy_out(fig_ql, size = c(3, 7.25))
