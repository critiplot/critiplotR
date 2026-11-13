#' Generate MMAT (Mixed Methods Appraisal Tool) plots
#'
#' Creates MMAT traffic-light plots and stacked bar charts. When the data
#' contains several study categories, `critiplot` writes one plot per category,
#' naming each file by appending `_<category>` to the supplied output name.
#' For example, an `output_file` of `"mmat.png"` produces files such as
#' `"mmat_Qualitative.png"` and `"mmat_Randomized.png"`.
#'
#' @param input_file A data frame with MMAT data, or a path to a CSV or Excel
#'   file (`.csv`, `.xls`, `.xlsx`) containing it.
#' @param output_file Base path for the plot files. The file extension must be
#'   one of `"png"`, `"pdf"`, `"svg"`, or `"eps"`. Category names are appended
#'   to this name.
#' @param theme Colour theme. One of `"default"`, `"blue"`, `"gray"`,
#'   `"smiley"`, or `"smiley_blue"`.
#' @param verbose If `TRUE`, relay the messages printed by the Python
#'   package to the R console.
#'
#' @return Invisibly returns a character vector of the normalized paths of all
#'   files created, one per study category.
#'
#' @seealso [critiplotR] for the Python requirement and input data details.
#'
#' @export
#' @examples
#' \dontrun{
#' plot_mmat(
#'   input_file = system.file("extdata", "sample_mmat.csv", package = "critiplotR"),
#'   output_file = tempfile(fileext = ".png")
#' )
#' }
plot_mmat <- function(input_file, output_file, theme = "default",
                      verbose = FALSE) {
  check_output_file(output_file)
  theme <- check_theme(theme, critiplot_themes)
  input_file <- prepare_input(input_file)
  on.exit(cleanup_input(input_file), add = TRUE)
  crit <- get_critiplot_module()

  before <- output_files(output_file)

  run_critiplot(
    crit$plot_mmat(input_file, output_file, theme = theme),
    verbose = verbose
  )

  files <- setdiff(output_files(output_file), before)
  if (!length(files)) {
    # Files from an earlier run may have been overwritten.
    files <- output_files(output_file)
  }
  if (!length(files)) {
    stop("critiplot did not create any output files for: ", output_file,
         call. = FALSE)
  }
  invisible(files)
}
