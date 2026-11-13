## R CMD check results

Local (`--as-cran`, macOS, R 4.5.1): 0 errors, 0 warnings, 2 notes.

* The standard "New submission" note from the CRAN incoming feasibility check.
* "Unable to verify current time": `worldtimeapi.org` is unreachable from this
  machine. This is a local network restriction, not a package issue.

## Windows and Linux

Submitted to win-builder for R-devel and R-release. The R-release check
(Windows Server 2022, R 4.6.2) reports 0 errors, 0 warnings, and one NOTE:
the standard "New submission" note. The package is pure R, so no compilation
is involved. The only platform-specific requirement is Python (>= 3.9) with
`critiplot`, which is declared under `SystemRequirements`.

Checked in the R-hub `ubuntu-release` container (Ubuntu 26.04, R 4.6.2):
0 errors, 0 warnings. The container does not provide pandoc or curl, so the
README and URL checks were skipped; the NOTEs are the standard "New
submission" note and the missing-pandoc notice.

## Submission notes

`critiplotR` is an R interface to the Python package `critiplot`
(<https://pypi.org/project/critiplot/>), installed from PyPI. The package uses
`reticulate`; the Python dependency is declared with
`reticulate::py_require()` in `.onLoad()` and imported on first use. Nothing is
downloaded when the package loads; reticulate provisions the environment only
when a plotting function is first called. The minimum version is `critiplot`
2.1.1; pip installs the newest release that satisfies this minimum.

The documentation asks users to cite the original Critiplot software.
`citation("critiplotR")` returns that citation together with the optional
citation for the R interface.

Legacy `.xls` input is converted with the suggested `readxl` package. CSV and
`.xlsx` input need no extra R packages.

Examples are wrapped in `\dontrun{}` because they need Python and write image
files. Tests that need Python call `testthat::skip_on_cran()` and skip when
the module is unavailable; argument-validation tests run everywhere.

## Test environments

* local: macOS Sequoia 15.7.3, R 4.5.1 (aarch64-apple-darwin24.4.0)
* win-builder: R-devel and R-release (submitted 2026-11-13)
* Linux: R-hub `ubuntu-release` container, R 4.6.2
