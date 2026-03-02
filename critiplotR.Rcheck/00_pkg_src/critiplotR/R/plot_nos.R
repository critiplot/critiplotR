

#' Generate a NOS (Newcastle–Ottawa Scale) risk-of-bias plot
#'
#' @param input_file Path to input CSV or Excel file with NOS data.
#' @param output_file Path where the plot image will be saved (e.g., ".png").
#' @param theme Theme name. Options: "default", "blue", "gray", "smiley", "smiley_blue".
#'   Default is "default".
#'
#' @return Invisibly returns \code{output_file} on success.
#'
#' @export
#' @examplesIf reticulate::py_module_available("critiplot")
#' \dontrun{
#'   plot_nos(
#'     input_file = system.file("extdata", "sample_nos.csv", package = "critiplotR"),
#'     output_file = tempfile(fileext = ".png"),
#'     theme = "blue"
#'   )
#' }
plot_nos <- function(input_file, output_file, theme = "default") {
  crit <- get_critiplot_module()

  if (!file.exists(input_file)) {
    stop("Input file does not exist: ", input_file)
  }

  crit$plot_nos(input_file, output_file, theme = theme)

  invisible(output_file)
}