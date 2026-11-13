test_that("plot_nos() creates a PNG from CSV and Excel input", {
  skip_if_no_critiplot()

  for (ext in c("csv", "xlsx")) {
    output <- tempfile(fileext = ".png")
    result <- plot_nos(sample_file(paste0("sample_nos.", ext)), output)
    expect_identical(result, normalizePath(output))
    expect_plot_created(result)
  }
})

test_that("plot_robis() creates a PNG", {
  skip_if_no_critiplot()

  output <- tempfile(fileext = ".png")
  result <- plot_robis(sample_file("sample_robis.csv"), output)
  expect_plot_created(result)
})

test_that("plot_mmat() creates one file per study category", {
  skip_if_no_critiplot()

  output <- tempfile(fileext = ".png")
  result <- plot_mmat(sample_file("sample_mmat.csv"), output)

  expect_gt(length(result), 1)
  expect_plot_created(result)
  expect_true(all(grepl("_[A-Za-z].*\\.png$", basename(result))))
})

test_that("plot_jbi_case_report() accepts categorical values", {
  skip_if_no_critiplot()

  output <- tempfile(fileext = ".png")
  result <- plot_jbi_case_report(
    sample_file("sample_jbi_case_report.csv"),
    output
  )
  expect_plot_created(result)
})

test_that("plot_jbi_case_series() creates a PNG", {
  skip_if_no_critiplot()

  output <- tempfile(fileext = ".png")
  result <- plot_jbi_case_series(
    sample_file("sample_jbi_case_series.csv"),
    output
  )
  expect_plot_created(result)
})

test_that("plot_grade() creates a PNG", {
  skip_if_no_critiplot()

  for (ext in c("csv", "xlsx")) {
    output <- tempfile(fileext = ".png")
    result <- plot_grade(sample_file(paste0("sample_grade.", ext)), output)
    expect_plot_created(result)
  }
})

test_that("plot_nos() accepts a legacy .xls file", {
  skip_if_no_critiplot()
  skip_if_not_installed("readxl")

  output <- tempfile(fileext = ".png")
  result <- plot_nos(test_path("fixtures", "sample_nos.xls"), output)
  expect_plot_created(result)
})

test_that("all plot functions accept a data frame", {
  skip_if_no_critiplot()

  cases <- list(
    list(plot_nos, "sample_nos.csv"),
    list(plot_robis, "sample_robis.csv"),
    list(plot_mmat, "sample_mmat.csv"),
    list(plot_jbi_case_report, "sample_jbi_case_report.csv"),
    list(plot_jbi_case_series, "sample_jbi_case_series.csv"),
    list(plot_grade, "sample_grade.csv")
  )

  for (case in cases) {
    dat <- read.csv(sample_file(case[[2]]), check.names = FALSE)
    original <- dat
    output <- tempfile(fileext = ".png")
    result <- case[[1]](dat, output)

    expect_plot_created(result)
    expect_identical(dat, original)
  }
})

test_that("all themes accepted by a plot function work", {
  skip_if_no_critiplot()

  input <- sample_file("sample_robis.csv")
  for (theme in critiplot_themes) {
    output <- tempfile(fileext = ".png")
    expect_silent(plot_robis(input, output, theme = theme))
    expect_true(file.exists(output))
  }
})

test_that("verbose = TRUE relays the Python messages", {
  skip_if_no_critiplot()

  output <- tempfile(fileext = ".png")
  expect_message(
    plot_nos(sample_file("sample_nos.csv"), output, verbose = TRUE)
  )
})

test_that("plot functions are silent by default", {
  skip_if_no_critiplot()

  output <- tempfile(fileext = ".png")
  expect_silent(plot_nos(sample_file("sample_nos.csv"), output))
})
