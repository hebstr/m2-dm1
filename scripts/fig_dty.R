set_fig_dty <- \(data, x) {
  .stat <- \(x) {
    summarise(
      .data = df,
      median = median(.data[[x]], na.rm = TRUE),
      mean = mean(.data[[x]], na.rm = TRUE),
      .by = sexe
    )
  }

  ggplot(data) +
    aes(
      x = .data[[x]],
      color = sexe,
      fill = after_scale(color)
    ) +
    geom_density(alpha = 0.4, linewidth = 0.3) +
    geom_rug(alpha = 0.5) +
    geom_vline(
      data = .stat(x),
      mapping = aes(xintercept = median, color = sexe),
      linewidth = 0.5
    ) +
    geom_vline(
      data = .stat(x),
      mapping = aes(xintercept = mean, color = sexe),
      linewidth = 0.5,
      linetype = "dotted"
    ) +
    labs(x = var_label(data[[x]]), y = "Densité (%)") +
    scale_color_manual(values = opts$palette) +
    scale_y_continuous(labels = scales::label_percent(suffix = "")) +
    theme_bar(grid = FALSE)
}

fig_dty <- opts$data$qt$vars$total |>
  map(~ set_fig_dty(df, .)) |>
  wrap_plots() +
  plot_layout(axis_titles = "collect_y")

easy_out(fig_dty, width = 7.5)
