
#' Generate MMAT (Mixed Methods Appraisal Tool) plots
#'
#' @param input_file Path to input CSV or Excel file with MMAT data.
#' @param output_file Path where the plot images will be saved.
#'   Note: If the data contains multiple study categories (e.g., Qualitative, Randomized),
#'   multiple files will be generated with the category name appended to this filename.
#' @param theme Theme name. Options: "default", "blue", "gray", "smiley", "smiley_blue".
#'   Default is "default".
#'
#' @return Invisibly returns \code{output_file} on success.
#'
#' @export
#' @examplesIf reticulate::py_module_available("critiplot")
#' \dontrun{
#'   plot_mmat(
#'     input_file = system.file("extdata", "sample_mmat.csv", package = "critiplotR"),
#'     output_file = tempfile(fileext = ".png"),
#'     theme = "default"
#'   )
#' }
plot_mmat <- function(input_file, output_file, theme = "default") {
  crit <- get_critiplot_module()

  if (!file.exists(input_file)) {
    stop("Input file does not exist: ", input_file)
  }

  crit$plot_mmat(input_file, output_file, theme = theme)

  invisible(output_file)
}