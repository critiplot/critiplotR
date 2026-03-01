

#' Generate a ROBIS (Risk Of Bias In Systematic reviews) plot
#'
#' @param input_file Path to input CSV or Excel file with ROBIS data.
#' @param output_file Path where the plot image will be saved (e.g., ".png").
#' @param theme Theme name. Options: "default", "blue", "gray", "smiley", "smiley_blue".
#'   Default is "default".
#'
#' @return Invisibly returns \code{output_file} on success.
#'
#' @export
#' @examplesIf reticulate::py_module_available("critiplot")
#' \dontrun{
#'   plot_robis(
#'     input_file = system.file("extdata", "sample_robis.csv", package = "critiplotR"),
#'     output_file = tempfile(fileext = ".png"),
#'     theme = "smiley_blue"
#'   )
#' }
plot_robis <- function(input_file, output_file, theme = "default") {
  crit <- get_critiplot_module()

  if (!file.exists(input_file)) {
    stop("Input file does not exist: ", input_file)
  }

  crit$plot_robis(input_file, output_file, theme = theme)

  invisible(output_file)
}