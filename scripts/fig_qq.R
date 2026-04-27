set_fig_qq <- \(data, x) {
  ggplot(data) +
    aes(sample = .data[[x]]) +
    geom_qq_line(
      color = opts$palette[1],
      linewidth = 0.5
    ) +
    stat_qq(
      color = opts$palette[2],
      alpha = 0.2,
      size = 0.7
    ) +
    labs(
      x = var_label(data[[x]]),
      y = "Valeur"
    ) +
    theme_bar(grid = FALSE)
}

fig_qq <- opts$data$qt$vars$total |>
  map(~ set_fig_qq(df, .)) |>
  wrap_plots() +
  plot_layout(axis_titles = "collect_y")

easy_out(fig_qq, width = 7.5)
