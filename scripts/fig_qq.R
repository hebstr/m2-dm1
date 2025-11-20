fig_qq <-
opts$data$qt$vars$total |> 
  map(~ df |> 
        ggplot() +
        aes(sample = get(.)) +
        geom_qq_line(color = opts$palette[1],
                     linewidth = 0.5) +
        stat_qq(color = opts$palette[2],
                alpha = 0.2,
                size = 0.7) + 
        labs(x = var_label(df[[.]]),
             y = "Valeur") +
        theme_bar(grid = FALSE)) |>
  wrap_plots() +
  plot_layout(axis_titles = "collect_y")

easy_out(fig_qq, size = c(5, 7.5))
