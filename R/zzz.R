

#' @importFrom reticulate py_require import py_module_available
NULL


.critiplot_env <- new.env(parent = emptyenv())
.critiplot_env$critiplot <- NULL

#' @noRd
.onLoad <- function(libname, pkgname) {
  
  reticulate::py_require("critiplot")

  .critiplot_env$critiplot <<- reticulate::import(
    "critiplot",
    delay_load = TRUE
  )
}

#' @noRd
get_critiplot_module <- function() {
  mod <- .critiplot_env$critiplot


  if (is.null(mod)) {
    stop(
      "The 'critiplot' Python module is not available. ",
      "Ensure Python >= 3.11 is installed and that 'critiplot' ",
      "can be installed. You can install it manually with:\n",
      "  reticulate::py_install('critiplot', pip = TRUE)"
    )
  }

  mod
}