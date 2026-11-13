# Regenerate the README/pkgdown gallery figures from the bundled example data.
# Run: Rscript -e 'library(critiplotR); source("figures-gallery.R")'

fig <- function(name) file.path("man", "figures", name)
inp <- function(f) system.file("extdata", f, package = "critiplotR")

jobs <- list(
  list("nos.png",              "sample_nos.csv",              "default", plot_nos),
  list("jbi-case-report.png",  "sample_jbi_case_report.csv",  "default", plot_jbi_case_report),
  list("jbi-case-series.png",  "sample_jbi_case_series.csv",  "default", plot_jbi_case_series),
  list("grade.png",            "sample_grade.csv",            "default", plot_grade),
  list("robis.png",            "sample_robis.csv",            "default", plot_robis),
  # Theme variants, so users can compare palettes at a glance
  list("nos-smiley.png",       "sample_nos.csv",              "smiley",  plot_nos),
  list("nos-blue.png",         "sample_nos.csv",              "blue",    plot_nos),
  list("grade-green.png",      "sample_grade.csv",            "green",   plot_grade)
)

for (j in jobs) {
  cat("Generating", j[[1]], "...\n")
  res <- j[[4]](inp(j[[2]]), fig(j[[1]]), theme = j[[3]])
  cat("  ->", res, "\n")
}

# MMAT writes one file per study category; keep only the Randomized plot.
cat("Generating mmat.png ...\n")
tmp <- plot_mmat(inp("sample_mmat.csv"), file.path(tempdir(), "mmat.png"))
picked <- grep("Randomized", tmp, value = TRUE)
if (length(picked) != 1L) stop("Expected one 'Randomized' MMAT file, got: ", picked)
file.copy(picked, fig("mmat.png"), overwrite = TRUE)
cat("  ->", fig("mmat.png"), "\n")

cat("Done.\n")
