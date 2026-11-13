# Generate README gallery figures from the bundled example data.
dir.create("man/figures", showWarnings = FALSE)

input <- function(f) system.file("extdata", f, package = "critiplotR")
out <- function(f) file.path("man", "figures", f)

jobs <- list(
  list("nos",  "sample_nos.csv",              "default"),
  list("jbi-case-report", "sample_jbi_case_report.csv", "default"),
  list("jbi-case-series", "sample_jbi_case_series.csv", "default"),
  list("grade", "sample_grade.csv",           "default"),
  list("robis", "sample_robis.csv",           "default"),
  list("mmat",  "sample_mmat.csv",            "default")
)

for (j in jobs) {
  f <- paste0(j[[1]], ".png")
  fn <- switch(
    j[[1]],
    nos = plot_nos,
    `jbi-case-report` = plot_jbi_case_report,
    `jbi-case-series` = plot_jbi_case_series,
    grade = plot_grade,
    robis = plot_robis,
    mmat = plot_mmat
  )
  cat("Generating", f, "...\n")
  res <- fn(input(j[[2]]), out(f), theme = j[[3]])
  cat("  ->", res, "\n")
}
cat("Done.\n")
