### DF -------------------------------------------------------------------------

df <-
read_csv2("data/retinol.csv") |>
  select(
    age, sexe, bmi, tabac, alcool, vitamine, cholesterol, retdiet, retplasma
  ) |>
  mutate(
    bmi = round(bmi, 1),
    sexe =
      as_factor(sexe) |>
        fct_recode(
          "Masculin" = "1",
          "Féminin" = "2"
        ),
    tabac =
      as_factor(tabac) |>
        fct_recode(
          "Jamais" = "1",
          "Sevré" = "2",
          "Actif" = "3"
        ),
    vitamine =
      as_factor(vitamine) |>
        fct_recode(
          "Fréquent" = "1",
          "Rare" = "2",
          "Jamais" = "3"
        ) |>
        fct_rev()
  ) |>
  set_variable_labels(
    age = "Âge, années",
    sexe = "Sexe",
    bmi = "BMI, kg/m2",
    tabac = "Tabagisme",
    alcool = "Alcool, verres/sem",
    vitamine = "Vitamines, AJ",
    cholesterol = "Cholestérol, AJ en mg/j",
    retdiet = "Rétinol, AJ en μg/j",
    retplasma = "Rétinol plasmatique, ng/mL"
  )

### OPTS -----------------------------------------------------------------------

set_opts(
  data = easy_descr(df),
  acro = acro(
    n ~ "nombre d'évènements",
    N ~ "nombre d'observations",
    BMI ~ "indice de masse corporelle",
    AJ ~ "apport journalier"
  ),
  model = lst(
    data = df[-c(20, 62, 171, 296), ],
    data_glm = data |> mutate(retplasma = ifelse(retplasma < median(retplasma), 0, 1)),
    y = "retplasma",
    x = lst(
      uv = names(data),
      mv = p_picking(
        data = data,
        model = "lm",
        y = y,
        vars = uv,
        pv = set_opts()$pvalue$seuil
      )
    ),
    fun = reformulate(x$mv, y),
    lm = lm(fun, data = data),
    glm = glm(fun, family = binomial, data = data_glm)
  ),
  note = list(
    n = \(x) {
      glue("{nrow(x)} observations, dont {sum(!complete.cases(x))}
           contenant au moins une valeur manquante.")
    },
    ajust =
      glue("Ajustement sur tous les facteurs statistiquement
           significatifs dans l'analyse univariée.")
  )
)

### AUTO EXEC ------------------------------------------------------------------

# auto_exec()
