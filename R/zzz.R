# Minimum Python package version used by this release.
critiplot_min_version <- "2.1.1"

# Cache the Python module for the session.
.critiplot_env <- new.env(parent = emptyenv())
.critiplot_env$module <- NULL

#' @importFrom reticulate import py_module_available py_require
NULL

#' @noRd
.onLoad <- function(libname, pkgname) {
  # Record the Python requirement before Python starts. Nothing is downloaded
  # at load time, and a failure here must not stop the package from loading.
  try(
    reticulate::py_require(paste0("critiplot>=", critiplot_min_version)),
    silent = TRUE
  )
}

#' @noRd
get_critiplot_version <- function() {
  metadata <- tryCatch(
    reticulate::import("importlib.metadata"),
    error = function(e) NULL
  )
  if (is.null(metadata)) {
    return(NA_character_)
  }

  tryCatch(
    as.character(metadata$version("critiplot")),
    error = function(e) NA_character_
  )
}

#' @noRd
get_critiplot_module <- function() {
  if (!is.null(.critiplot_env$module)) {
    return(.critiplot_env$module)
  }

  # A managed environment can only be created before Python is initialized.
  if (!reticulate::py_available(initialize = FALSE)) {
    try(
      reticulate::py_require(paste0("critiplot>=", critiplot_min_version)),
      silent = TRUE
    )
  }

  if (!reticulate::py_module_available("critiplot")) {
    stop(
      "The 'critiplot' Python package is not available.\n",
      "Install it with:\n",
      "  reticulate::py_install(\"critiplot\", pip = TRUE)\n",
      "or let reticulate manage it by calling:\n",
      "  reticulate::py_require(\"critiplot\")\n",
      "Then restart R and try again. See ?critiplotR for details.",
      call. = FALSE
    )
  }

  version <- get_critiplot_version()
  if (is.na(version) ||
      utils::compareVersion(version, critiplot_min_version) < 0) {
    stop(
      "The 'critiplot' Python package is too old.\n",
      "critiplotR requires critiplot >= ", critiplot_min_version, ".\n",
      if (is.na(version)) {
        "The installed version could not be determined.\n"
      } else {
        paste0("Installed version: ", version, ".\n")
      },
      "Upgrade with:\n",
      "  reticulate::py_install(\"critiplot>=", critiplot_min_version,
      "\", pip = TRUE)\n",
      "Then restart R and try again. See ?critiplotR for details.",
      call. = FALSE
    )
  }

  module <- reticulate::import("critiplot")
  .critiplot_env$module <- module
  module
}
