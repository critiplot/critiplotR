#' critiplotR: Visualize Risk-of-Bias Assessments with 'critiplot'
#'
#' `critiplotR` is an R interface to the Python package
#' [`critiplot`](https://critiplot.github.io). It creates
#' publication-ready traffic-light plots and stacked bar charts for
#' risk-of-bias assessments in systematic reviews and meta-analyses.
#'
#' \if{html}{\figure{logo.png}{options: width=180 alt="critiplotR logo"}}
#'
#' The package supports:
#'
#' * the Newcastle-Ottawa Scale (NOS), via [plot_nos()];
#' * the JBI critical appraisal checklist for case reports, via
#'   [plot_jbi_case_report()];
#' * the JBI critical appraisal checklist for case series, via
#'   [plot_jbi_case_series()];
#' * GRADE certainty of evidence, via [plot_grade()];
#' * ROBIS for systematic reviews, via [plot_robis()];
#' * the Mixed Methods Appraisal Tool (MMAT), via [plot_mmat()].
#'
#' ## Python requirement
#'
#' A Python installation (>= 3.9) with the `critiplot` package is required.
#' On first load, `critiplotR` declares `critiplot` as a Python requirement
#' with [reticulate::py_require()], so `reticulate` can provide it
#' automatically. To use an existing Python installation instead, install the
#' module yourself:
#'
#' ```r
#' reticulate::py_install("critiplot", pip = TRUE)
#' ```
#'
#' Use [reticulate::py_config()] to check which Python interpreter is in use
#' and [reticulate::py_module_available()] to check that `critiplot` is
#' available.
#'
#' ## Input data
#'
#' Every plotting function accepts a data frame or a path to a CSV (`.csv`) or
#' Excel (`.xls`/`.xlsx`) file. The required columns are those expected by the
#' corresponding `critiplot` function. The package README lists the column
#' names and accepted values for each plot type. Bundled example files are
#' available through [system.file()], for example:
#'
#' ```r
#' system.file("extdata", "sample_nos.csv", package = "critiplotR")
#' ```
#'
#' ## Citation
#'
#' If you use the plots in a publication, please cite the original Critiplot
#' software (Sahu, 2025, \doi{10.5281/zenodo.17236600}). To cite the R
#' interface itself as well, use `citation("critiplotR")`.
#'
#' @keywords internal
"_PACKAGE"
