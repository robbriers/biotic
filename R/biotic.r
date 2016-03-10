#' biotic: A package for calculating a range of UK freshwater invertebrate
#' biotic indices.
#'
#' The biotic package provides a main function, wrappers functions for
#' easy calculation of specific indices and a data processing function
#' which is called internally when needed, but may be of use more
#' generally
#'
#' @section Main function:
#' The main function is \code{\link{calcindex}} which allows the
#' calculation of any of the indices implemented.
#'
#' @section Wrapper functions:
#' A function is provided for each of the individual indices to
#' allow for quick calculations. An example is
#' \code{\link{calcPSI}} which implements calculation of the
#' PSI index of sedimentation impacts.
#'
#' @section Data transposition function:
#' The \code{\link{transposedata}} function allows for simple
#' conversion between the default format and a 'tidy' format.
#' It is called internally when needed but access is provided in case
#' it is of more general utility.
#'
#' @docType package
#' @name biotic
NULL