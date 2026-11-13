# Themes accepted by the NOS, ROBIS, MMAT and JBI plot functions.
critiplot_themes <- c("default", "blue", "gray", "smiley", "smiley_blue")

# Themes accepted by the GRADE plot function.
grade_themes <- c("default", "green", "blue")

check_input_file <- function(input_file) {
  if (!is.character(input_file) || length(input_file) != 1L ||
      is.na(input_file) || !nzchar(input_file)) {
    stop("`input_file` must be a single, non-empty file path.", call. = FALSE)
  }
  if (!file.exists(input_file)) {
    stop("Input file does not exist: ", input_file, call. = FALSE)
  }
  if (dir.exists(input_file)) {
    stop("`input_file` must be a file, not a directory: ", input_file,
         call. = FALSE)
  }
  ext <- tolower(tools::file_ext(input_file))
  if (!ext %in% c("csv", "xls", "xlsx")) {
    stop("Unsupported input file type '.", ext,
         "'. Use a CSV or Excel (.xls/.xlsx) file.", call. = FALSE)
  }
  invisible(input_file)
}

# Accept a data frame or a path to a CSV/Excel file. Data frames and legacy
# .xls files are converted to a temporary CSV for the Python functions.
prepare_input <- function(input) {
  if (!is.data.frame(input)) {
    check_input_file(input)

    if (tolower(tools::file_ext(input)) == "xls") {
      if (!requireNamespace("readxl", quietly = TRUE)) {
        stop(
          "Reading .xls files requires the 'readxl' package.\n",
          "Install it with install.packages(\"readxl\"), or save the file ",
          "as .xlsx.",
          call. = FALSE
        )
      }
      input <- readxl::read_excel(input, .name_repair = "minimal")
      input <- input[rowSums(is.na(input)) < ncol(input), , drop = FALSE]
    }
  }

  if (is.data.frame(input)) {
    if (!ncol(input)) {
      stop("`input_file` must have at least one column.", call. = FALSE)
    }
    if (!nrow(input)) {
      stop("`input_file` must have at least one row.", call. = FALSE)
    }
    nms <- names(input)
    if (is.null(nms) || anyNA(nms) || any(!nzchar(nms)) || anyDuplicated(nms)) {
      stop("All columns in `input_file` must have unique, non-empty names.",
           call. = FALSE)
    }
    atomic <- vapply(input, is.atomic, logical(1))
    if (!all(atomic)) {
      stop("All columns in `input_file` must be atomic vectors.",
           call. = FALSE)
    }
    path <- tempfile(fileext = ".csv")
    utils::write.csv(input, path, row.names = FALSE, na = "",
                     fileEncoding = "UTF-8")
    return(structure(path, critiplot_temp = TRUE))
  }

  structure(input, critiplot_temp = FALSE)
}

cleanup_input <- function(input) {
  if (isTRUE(attr(input, "critiplot_temp"))) {
    unlink(input)
  }
  invisible(NULL)
}

check_output_file <- function(output_file) {
  if (!is.character(output_file) || length(output_file) != 1L ||
      is.na(output_file) || !nzchar(output_file)) {
    stop("`output_file` must be a single, non-empty file path.", call. = FALSE)
  }
  ext <- tolower(tools::file_ext(output_file))
  if (!ext %in% c("png", "pdf", "svg", "eps")) {
    stop("Unsupported output file type '.", ext,
         "'. Use one of: png, pdf, svg, eps.", call. = FALSE)
  }
  if (!dir.exists(dirname(output_file))) {
    stop("Output directory does not exist: ", dirname(output_file),
         call. = FALSE)
  }
  invisible(output_file)
}

check_theme <- function(theme, allowed) {
  if (!is.character(theme) || length(theme) != 1L || is.na(theme)) {
    stop("`theme` must be a single character string.", call. = FALSE)
  }
  if (!theme %in% allowed) {
    stop("Unknown theme '", theme, "'. Available themes: ",
         paste(allowed, collapse = ", "), ".", call. = FALSE)
  }
  theme
}

# Capture Python output so emoji in status messages do not break ASCII
# locales. With verbose = TRUE the captured text is relayed as an R message.
run_critiplot <- function(expr, verbose = FALSE) {
  output <- reticulate::py_capture_output(expr)
  if (isTRUE(verbose)) {
    output <- output[nzchar(output)]
    if (length(output)) {
      message(paste(output, collapse = "\n"))
    }
  }
  invisible(output)
}

# Find the files written for an output name. plot_mmat() appends the study
# category to the file stem, so those files share the same prefix.
output_files <- function(output_file) {
  dir <- dirname(output_file)
  base <- tools::file_path_sans_ext(basename(output_file))
  ext <- tolower(tools::file_ext(output_file))

  files <- list.files(dir, full.names = TRUE)
  stems <- tools::file_path_sans_ext(basename(files))
  keep <- tolower(tools::file_ext(files)) == ext &
    (stems == base | startsWith(stems, paste0(base, "_")))

  if (!length(files[keep])) {
    return(character())
  }
  normalizePath(files[keep], mustWork = TRUE)
}
