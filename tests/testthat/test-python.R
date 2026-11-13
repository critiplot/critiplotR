test_that("the installed critiplot version meets the minimum", {
  skip_if_no_critiplot()

  version <- get_critiplot_version()
  expect_false(is.na(version))
  expect_true(utils::compareVersion(version, critiplot_min_version) >= 0)
})
