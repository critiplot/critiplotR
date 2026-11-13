#' Generate a ROBIS risk-of-bias plot
#'
#' Creates a traffic-light plot and a stacked bar chart summarising ROBIS
#' (Risk Of Bias In Systematic reviews) assessments.
#'
#' @param input_file A data frame with ROBIS data, or a path to a CSV or Excel
#'   file (`.csv`, `.xls`, `.xlsx`) containing it.
#' @param output_file Path where the plot will be saved. The file extension
#'   must be one of `"png"`, `"pdf"`, `"svg"`, or `"eps"`.
#' @param theme Colour theme. One of `"default"`, `"blue"`, `"gray"`,
#'   `"smiley"`, or `"smiley_blue"`.
#' @param verbose If `TRUE`, relay the messages printed by the Python
#'   package to the R console.
#'
#' @return Invisibly returns the normalized path to the created file.
#'
#' @seealso [critiplotR] for the Python requirement and input data details.
#'
#' @export
#' @examples
#' \dontrun{
#' plot_robis(
#'   input_file = system.file("extdata", "sample_robis.csv", package = "critiplotR"),
#'   output_file = tempfile(fileext = ".png")
#' )
#' }
plot_robis <- function(input_file, output_file, theme = "default",
                       verbose = FALSE) {
  check_output_file(output_file)
  theme <- check_theme(theme, critiplot_themes)
  input_file <- prepare_input(input_file)
  on.exit(cleanup_input(input_file), add = TRUE)
  crit <- get_critiplot_module()

  run_critiplot(
    crit$plot_robis(input_file, output_file, theme = theme),
    verbose = verbose
  )

  if (!file.exists(output_file)) {
    stop("critiplot did not create the expected output file: ", output_file,
         call. = FALSE)
  }
  invisible(normalizePath(output_file))
}
