.stat <- \(stat, level) {

  expr(do.call(!!enexpr(stat), list(get(.x)[sexe == levels(sexe)[!!enexpr(level)]])))

}

fig_dty <-
opts$data$qt$vars$total |>
  map(~ df |>
        ggplot() +
        aes(x = get(.x),
            color = sexe,
            fill = after_scale(color)) +
        geom_density(alpha = 0.4,
                     linewidth = 0.3) +
        geom_rug(alpha = 0.5) +
        geom_vline(aes(xintercept = !!.stat("median", 1)),
                   color = opts$palette[1],
                   linewidth = 0.5) +
        geom_vline(aes(xintercept = !!.stat("mean", 1)),
                   color = opts$palette[1],
                   linewidth = 0.5,
                   linetype = "dotted") +
        geom_vline(aes(xintercept = !!.stat("median", 2)),
                   color = opts$palette[2],
                   linewidth = 0.5) +
        geom_vline(aes(xintercept = !!.stat("mean", 2)),
                   color = opts$palette[2],
                   linewidth = 0.5,
                   linetype = "dotted") +
        labs(x = var_label(df[[.]]),
             y = "Densité (%)") +
        scale_color_manual(values = opts$palette) +
        scale_y_continuous(labels = scales::label_percent(suffix = "")) +
        theme_bar(grid = FALSE)) |>
  wrap_plots() +
  plot_layout(axis_titles = "collect_y")

easy_out(fig_dty, size = c(5, 7.5))
