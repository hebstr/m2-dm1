.stat <- \(x) {

  df |>
    summarise(
      median = median(.data[[x]], na.rm = TRUE),
      mean = mean(.data[[x]], na.rm = TRUE),
      .by = sexe
    )

}

fig_dty <-
opts$data$qt$vars$total |>
  map(
    ~ df |>
      ggplot() +
      aes(
        x = .data[[.]],
        color = sexe,
        fill = after_scale(color)
      ) +
      geom_density(alpha = 0.4, linewidth = 0.3) +
      geom_rug(alpha = 0.5) +
      geom_vline(
        data = .stat(.),
        mapping = aes(xintercept = median, color = sexe),
        linewidth = 0.5
      ) +
      geom_vline(
        data = .stat(.),
        mapping = aes(xintercept = mean, color = sexe),
        linewidth = 0.5,
        linetype = "dotted"
      ) +
      labs(x = var_label(df[[.]]), y = "Densité (%)") +
      scale_color_manual(values = opts$palette) +
      scale_y_continuous(labels = scales::label_percent(suffix = "")) +
      theme_bar(grid = FALSE)
  ) |>
  wrap_plots() +
  plot_layout(axis_titles = "collect_y")

easy_out(fig_dty, size = c(5, 7.5))
