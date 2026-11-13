#' Generate a GRADE certainty-of-evidence plot
#'
#' Creates a GRADE evidence profile plot summarising risk of bias,
#' inconsistency, indirectness, imprecision, publication bias, and overall
#' certainty of evidence.
#'
#' @param input_file A data frame with GRADE data, or a path to a CSV or Excel
#'   file (`.csv`, `.xls`, `.xlsx`) containing it.
#' @param output_file Path where the plot will be saved. The file extension
#'   must be one of `"png"`, `"pdf"`, `"svg"`, or `"eps"`.
#' @param theme Colour theme. One of `"default"`, `"green"`, or `"blue"`.
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
#' plot_grade(
#'   input_file = system.file("extdata", "sample_grade.csv", package = "critiplotR"),
#'   output_file = tempfile(fileext = ".png")
#' )
#' }
plot_grade <- function(input_file, output_file, theme = "default",
                       verbose = FALSE) {
  check_output_file(output_file)
  theme <- check_theme(theme, grade_themes)
  input_file <- prepare_input(input_file)
  on.exit(cleanup_input(input_file), add = TRUE)
  crit <- get_critiplot_module()

  run_critiplot(
    crit$plot_grade(input_file, output_file, theme = theme),
    verbose = verbose
  )

  if (!file.exists(output_file)) {
    stop("critiplot did not create the expected output file: ", output_file,
         call. = FALSE)
  }
  invisible(normalizePath(output_file))
}
