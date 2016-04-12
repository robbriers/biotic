#' Calculates BMWP indices for invertebrate samples.
#'
#' @param df A dataframe containing list of taxa in first column, followed by
#'  columns of abundances with sample names in header row.
#' @param type Indicates format of data. Options are "num" for numeric data,
#' "log" for integer log abundance categories (1-5) or "alpha" for alphabetic
#' abundance categories (A-E). Default value is "num".
#' @return A data frame consisting of columns of indices with samples in rows.
#' @export calcBMWP

calcBMWP<-function(df, type="num"){
  calcindex(df, index="BMWP", type=type)
}

#' Calculates Whalley revised BMWP indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in rows.
#' @export calcWhalley

calcWhalley<-function(df, type="num"){
  calcindex(df, index="Whalley", type=type)
}

#' Calculates Whalley 'Riffle' Habitat specific BMWP indices for invertebrate
#'  samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in rows.
#' @export calcRiffle

calcRiffle<-function(df, type="num"){
  calcindex(df, index="Riffle", type=type)
}

#' Calculates Whalley 'Pool' habitat specific BMWP indices for invertebrate
#' samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows.
#' @export calcPool

calcPool<-function(df, type="num"){
  calcindex(df, index="Pool", type=type)
}

#' Calculates Whalley 'Riffle/Pool' habitat specific BMWP indices for
#' invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows.
#' @export calcRiffPool

calcRiffPool<-function(df, type="num"){
  calcindex(df, index="RiffPool", type=type)
}

#' Calculates presence-only WHPT indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows.
#' @export calcWHPT

calcWHPT<-function(df, type="num"){
  calcindex(df, index="WHPT", type=type)
}

#' Calculates abundance-weighted WHPT indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows.
#' @export calcWHPT_AB

calcWHPT_AB<-function(df, type="num"){
  calcindex(df, index="WHPT_AB", type=type)
}

#' Calculates LIFE score indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows.
#' @export calcLIFE

calcLIFE<-function(df, type="num"){
  calcindex(df, index="LIFE", type=type)
}


#' Calculates PSI score indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows.
#' @export calcPSI

calcPSI<-function(df, type="num"){
  calcindex(df, index="PSI", type=type)
}

#' Calculates AWIC score indices for invertebrate samples.
#'
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of indices with samples in
#' rows.
#' @export calcAWIC

calcAWIC<-function(df, type="num"){
  calcindex(df, index="AWIC", type=type)
}
