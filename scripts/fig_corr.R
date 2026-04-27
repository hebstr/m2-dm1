fig_corr <- df |>
  correlate() |>
  rearrange() |>
  shave() |>
  rplot(
    print_cor = TRUE,
    colors = c(opts$color$warm[2], "white", opts$color$cold[2])
  ) +
  theme_bar(
    axis.text = element_text(face = "bold"),
    legend.position = c(0.825, 0.7),
    legend.text = element_text(size = 6),
    legend.text.position = "left",
    legend.key.width = unit(0.4, "lines")
  )

easy_out(fig_corr, height = 4, width = 4.65)
