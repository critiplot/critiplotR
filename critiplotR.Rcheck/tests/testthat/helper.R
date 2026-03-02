
#' @noRd
skip_if_no_critiplot <- function() {
  if (!reticulate::py_module_available("critiplot")) {
    skip("Python module 'critiplot' is not available.")
  }
}