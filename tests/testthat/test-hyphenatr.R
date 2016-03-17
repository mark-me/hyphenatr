context("basic functionality")
test_that("we can do something", {

  expect_that(hyphenate("testing"), equals("test=ing"))

})
