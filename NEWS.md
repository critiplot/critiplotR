# critiplotR 0.2.0

## New features

* `input_file` now accepts a data frame as well as a file path. Data frames are
  written to a temporary CSV for the Python backend.
* Legacy `.xls` files are converted with `readxl` before plotting.
* `plot_mmat()` returns the paths of every file it creates.
* Every plotting function has a `verbose` argument for Python messages.
* Added `inst/CITATION` and a package citation.

## Bug fixes

* Plots work in non-UTF-8 locales. Python output is captured, so emoji in
  status messages no longer raise `UnicodeEncodeError`.
* `plot_jbi_case_report()` passes the input file straight to Python. The old
  R-side rewrite renamed `Overall RoB` to `Overall.RoB`.
* Fixed a missing value in `sample_grade.csv`.

## Documentation

* Citation guidance now asks users to cite the original Critiplot software.
  The `critiplotR` citation is optional and is returned by `citation()`.

## Internal changes

* Input, output, and theme arguments are validated before the Python call.
* Tests cover all six plot types, CSV and Excel input, data-frame input,
  themes, and argument validation.
* The Python dependency is declared with `reticulate::py_require()`, checked
  at runtime, and imported on first use. The minimum version is `critiplot`
  2.1.1.
