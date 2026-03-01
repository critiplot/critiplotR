
#' Generate a GRADE certainty-of-evidence plot
#'
#' @param input_file Path to input CSV or Excel file with GRADE data.
#' @param output_file Path where the plot image will be saved (e.g., ".png").
#' @param theme Theme name. Options for GRADE: "default", "green", "blue".
#'   Default is "default".
#'
#' @return Invisibly returns \code{output_file} on success.
#'
#' @export
#' @examplesIf reticulate::py_module_available("critiplot")
#' \dontrun{
#'   plot_grade(
#'     input_file = system.file("extdata", "sample_grade.csv", package = "critiplotR"),
#'     output_file = tempfile(fileext = ".png"),
#'     theme = "green"
#'   )
#' }
plot_grade <- function(input_file, output_file, theme = "default") {
  crit <- get_critiplot_module()

  if (!file.exists(input_file)) {
    stop("Input file does not exist: ", input_file)
  }

  crit$plot_grade(input_file, output_file, theme = theme)

  invisible(output_file)
}