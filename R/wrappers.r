#' Calculates BMWP indices for invertebrate samples.
#'
#' @param df A dataframe containing list of taxa in first column, followed by
#'  columns of abundances with sample names in header row.
#' @param alpha Boolean indicating whether abundances are recorded as
#' alphabetic categories. Defaults to FALSE.
#' @param tidy Whether the data are in a 'tidy' format (sensu Wickham). The
#' default is FALSE as data are commonly stored as columns as samples rather
#' than rows (with the taxon list in the first column). This is the default
#'  format; if set to TRUE the data are transposed prior to processing using
#'  the internal \code{\link{transposedata}} function.
#' @return A data frame consisting of columns of indices with samples in rows (tidy format).
#' @export calcBMWP

calcBMWP<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="BMWP", alpha=alpha, tidy=tidy)
}

#' Calculates Whalley revised BMWP indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in rows
#' (tidy format).
#' @export calcWhalley

calcWhalley<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="Whalley", alpha=alpha, tidy=tidy)
}

#' Calculates Whalley 'Riffle' Habitat specific BMWP indices for invertebrate
#'  samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows (tidy format).
#' @export calcRiffle

calcRiffle<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="Riffle", alpha=alpha, tidy=tidy)
}

#' Calculates Whalley 'Pool' habitat specific BMWP indices for invertebrate
#' samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows (tidy format).
#' @export calcPool

calcPool<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="Pool", alpha=alpha, tidy=tidy)
}

#' Calculates Whalley 'Riffle/Pool' habitat specific BMWP indices for
#' invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows (tidy format).
#' @export calcRiffPool

calcRiffPool<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="RiffPool", alpha=alpha, tidy=tidy)
}

#' Calculates presence-only WHPT indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows (tidy format).
#' @export calcWHPT

calcWHPT<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="WHPT", alpha=alpha, tidy=tidy)
}

#' Calculates abundance-weighted WHPT indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows (tidy format).
#' @export calcWHPT_AB

calcWHPT_AB<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="WHPT_AB", alpha=alpha, tidy=tidy)
}

#' Calculates LIFE score indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows (tidy format).
#' @export calcLIFE


calcLIFE<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="LIFE", alpha=alpha, tidy=tidy)
}


#' Calculates PSI score indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows (tidy format).
#' @export calcPSI

calcPSI<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="PSI", alpha=alpha, tidy=tidy)
}

#' Calculates AWIC score indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows (tidy format).
#' @export calcAWIC

calcAWIC<-function(df, alpha=FALSE, tidy=FALSE){
  calcindex(df, index="AWIC", alpha=alpha, tidy=tidy)
}
