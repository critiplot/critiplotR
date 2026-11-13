test_that("input_file is validated", {
  output <- tempfile(fileext = ".png")

  expect_error(
    plot_nos(tempfile(fileext = ".csv"), output),
    "does not exist"
  )
  expect_error(plot_nos(c("a.csv", "b.csv"), output), "single, non-empty")
  expect_error(plot_nos(NA_character_, output), "single, non-empty")
  expect_error(plot_nos(tempdir(), output), "must be a file")

  txt <- tempfile(fileext = ".txt")
  writeLines("x", txt)
  expect_error(plot_nos(txt, output), "Unsupported input file type")

  expect_error(plot_nos(data.frame(), output), "at least one column")
  expect_error(plot_nos(data.frame(x = numeric()), output), "at least one row")
  expect_error(
    plot_nos(data.frame(x = I(list(1))), output),
    "atomic vectors"
  )

  unnamed <- data.frame(x = 1)
  names(unnamed) <- ""
  expect_error(plot_nos(unnamed, output), "unique, non-empty names")

  duplicated_names <- data.frame(x = 1, y = 2)
  names(duplicated_names) <- c("x", "x")
  expect_error(plot_nos(duplicated_names, output), "unique, non-empty names")
})

test_that("output_file is validated", {
  input <- tempfile(fileext = ".csv")
  writeLines("x", input)

  expect_error(plot_nos(input, tempfile(fileext = ".jpg")),
               "Unsupported output file type")
  expect_error(plot_nos(input, NA_character_), "single, non-empty")
  expect_error(
    plot_nos(input, file.path(tempdir(), "no-such-dir", "plot.png")),
    "Output directory does not exist"
  )
})

test_that("theme is validated", {
  input <- sample_file("sample_nos.csv")

  expect_error(plot_nos(input, tempfile(fileext = ".png"), theme = "nope"),
               "Unknown theme")
  expect_error(plot_nos(input, tempfile(fileext = ".png"), theme = 1),
               "single character string")
  expect_error(
    plot_grade(sample_file("sample_grade.csv"), tempfile(fileext = ".png"),
               theme = "smiley"),
    "Unknown theme"
  )
})
