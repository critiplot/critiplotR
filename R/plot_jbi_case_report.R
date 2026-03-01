#' Generate a JBI Case Report risk-of-bias plot
#'
#' @param input_file Path to input CSV or Excel file with JBI Case Report data.
#' @param output_file Path where the plot image will be saved (e.g., ".png").
#' @param theme Theme name. Options: "default", "blue", "gray", "smiley", "smiley_blue".
#'   Default is "default".
#'
#' @return Invisibly returns \code{output_file} on success.
#'
#' @export
#' @examplesIf reticulate::py_module_available("critiplot")
#' \dontrun{
#'   plot_jbi_case_report(
#'     input_file = system.file("extdata", "sample_jbi_case_report.csv", package = "critiplotR"),
#'     output_file = tempfile(fileext = ".png"),
#'     theme = "default"
#'   )
#' }
plot_jbi_case_report <- function(input_file, output_file, theme = "default") {
  crit <- get_critiplot_module()

  if (!file.exists(input_file)) {
    stop("Input file does not exist: ", input_file)
  }


  normalize_jbi_value <- function(val) {
    if (is.na(val)) return("Unclear")
    
    s_val <- tolower(as.character(val))
    s_val <- trimws(s_val)
    

    if (s_val %in% c("1", "yes", "low")) return("1")
    if (s_val %in% c("0", "no", "high")) return("0")
    if (s_val %in% c("unclear", "?")) return("Unclear")
    if (s_val %in% c("not applicable", "n/a", "na")) return("Not Applicable")
    
    return("Unclear") 
  }


  df <- suppressWarnings(read.csv(input_file, stringsAsFactors = FALSE))


  if ("Author, Year" %in% names(df) && !("Author,Year" %in% names(df))) {
    names(df)[names(df) == "Author, Year"] <- "Author,Year"
  } else if ("Author" %in% names(df) && "Year" %in% names(df)) {
    df[["Author,Year"]] <- paste(df[["Author"]], df[["Year"]])
  }


  cols_to_process <- c(
    "Demographics", "History", "ClinicalCondition", "Diagnostics",
    "Intervention", "PostCondition", "AdverseEvents", "Lessons", "Overall RoB"
  )

  
  for (col in cols_to_process) {
    if (col %in% names(df)) {

      df[[col]] <- sapply(df[[col]], normalize_jbi_value, USE.NAMES = FALSE)
    }
  }


  temp_input_file <- tempfile(fileext = ".csv")
  write.csv(df, temp_input_file, row.names = FALSE)

 
  crit$plot_jbi_case_report(temp_input_file, output_file, theme = theme)


  unlink(temp_input_file)

  invisible(output_file)
}