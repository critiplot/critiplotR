#' Generate a JBI Case Report risk-of-bias plot
#'
#' Creates a traffic-light plot and a stacked bar chart summarising the JBI
#' critical appraisal checklist for case reports.
#'
#' Categorical judgements such as `"Yes"`, `"No"`, `"Unclear"`, and
#' `"Not Applicable"` are normalized by the Python package itself, so the
#' input file can contain either these values or their `1`/`0` equivalents.
#'
#' @param input_file A data frame with JBI case report data, or a path to a
#'   CSV or Excel file (`.csv`, `.xls`, `.xlsx`) containing it.
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
#' plot_jbi_case_report(
#'   input_file = system.file(
#'     "extdata", "sample_jbi_case_report.csv", package = "critiplotR"
#'   ),
#'   output_file = tempfile(fileext = ".png")
#' )
#' }
plot_jbi_case_report <- function(input_file, output_file, theme = "default",
                                 verbose = FALSE) {
  check_output_file(output_file)
  theme <- check_theme(theme, critiplot_themes)
  input_file <- prepare_input(input_file)
  on.exit(cleanup_input(input_file), add = TRUE)
  crit <- get_critiplot_module()

  run_critiplot(
    crit$plot_jbi_case_report(input_file, output_file, theme = theme),
    verbose = verbose
  )

  if (!file.exists(output_file)) {
    stop("critiplot did not create the expected output file: ", output_file,
         call. = FALSE)
  }
  invisible(normalizePath(output_file))
}
