set_fig_ql <- \(data, x) ggcount(
  data = data,
  var = x,
  color = opts$palette[2],
  size = 3,
  nudge_y = 0.05
)

fig_ql <-
opts$data$ql$vars |>
  map(~ set_fig_ql(df, .)) |>
  wrap_plots() +
  plot_layout(axis_titles = "collect_y")

easy_out(fig_ql, size = c(3, 7.25))
