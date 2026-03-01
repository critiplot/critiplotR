
test_that("plot_nos runs without error", {
  skip_if_no_critiplot()

  input  <- system.file("extdata", "sample_nos.csv", package = "critiplotR")
  if (input == "") {
    skip("Example input file 'sample_nos.csv' not found.")
  }

  output <- tempfile(fileext = ".png")

  expect_silent(plot_nos(input, output, theme = "default"))
  expect_true(file.exists(output))
})

