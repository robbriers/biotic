library(biotic)
context("calcindex")

test_that("calcindex returns a dataframe", {
  # load built-in dataset
  data(almond)

  # calculate the BMWP index (default) for this dataset
  testindex<-calcindex(almond)
  # check that it outputs matrix object
  expect_is(testindex, "matrix")

})

