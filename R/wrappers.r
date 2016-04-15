#' Calculate BMWP indices for invertebrate samples
#' @description Calculates BMWP, ASPT and N-taxa index values for invertebrate samples.
#' @param df A dataframe containing list of taxa in first column, followed by
#'  columns of abundances with sample names in header row.
#' @param type Indicates format of data. Options are "num" for numeric data,
#' "log" for integer log abundance categories (1-5) or "alpha" for alphabetic
#' abundance categories (A-E). Default value is "num".
#' @return A data frame consisting of columns of index values with samples in
#' rows.
#' @export calcBMWP

calcBMWP<-function(df, type="num"){
  calcindex(df, index="BMWP", type=type)
}

#' Calculate Whalley revised BMWP indices for invertebrate samples
#' @description Calculates Whalley revised BMWP, ASPT and N-taxa indices
#' for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of index values with samples
#' in rows.
#' @export calcWhalley

calcWhalley<-function(df, type="num"){
  calcindex(df, index="Whalley", type=type)
}

#' Calculate Whalley 'Riffle' habitat-specific BMWP indices for invertebrate
#' samples
#' @description Calculates Whalley riffle-specific BMWP, ASPT and N-taxa
#' indices for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of index values with samples
#' in rows.
#' @export calcRiffle

calcRiffle<-function(df, type="num"){
  calcindex(df, index="Riffle", type=type)
}

#' Calculate Whalley 'Pool' habitat-specific BMWP indices for invertebrate
#' samples
#' @description Calculates Whalley pool-specific BMWP, ASPT and N-taxa indices
#' for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of index values with samples
#' in rows.
#' @export calcPool

calcPool<-function(df, type="num"){
  calcindex(df, index="Pool", type=type)
}

#' Calculate Whalley 'Riffle/Pool' habitat-specific BMWP indices
#' @description Calculates Whalley riffle/pool-specific BMWP, ASPT and N-taxa
#' indices for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of index values with samples
#' in rows.
#' @export calcRiffPool

calcRiffPool<-function(df, type="num"){
  calcindex(df, index="RiffPool", type=type)
}

#' Calculate presence-only WHPT indices
#' @description Calculates WHPT presence-only ASPT and N-taxa indices
#' for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of index values with samples
#' in rows.
#' @export calcWHPT

calcWHPT<-function(df, type="num"){
  calcindex(df, index="WHPT", type=type)
}

#' Calculate abundance-weighted WHPT indices
#' @description Calculates WHPT abundance-weighted ASPT and N-taxa indices
#' for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of columns of index values with samples
#' in rows.
#' @export calcWHPT_AB

calcWHPT_AB<-function(df, type="num"){
  calcindex(df, index="WHPT_AB", type=type)
}

#' Calculate LIFE index
#' @description Calculates LIFE index values for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of a column of index values with samples
#' in rows.
#' @export calcLIFE

calcLIFE<-function(df, type="num"){
  calcindex(df, index="LIFE", type=type)
}


#' Calculate PSI index
#' @description Calculates PSI index for invertebrate samples.
#' for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of a column of index values with samples
#' in rows.
#' @export calcPSI

calcPSI<-function(df, type="num"){
  calcindex(df, index="PSI", type=type)
}

#' Calculate AWIC index
#' @description Calculates AWIC index for invertebrate samples.
#' @inheritParams calcBMWP
#' @return A data frame consisting of a column of index values with samples
#' in rows.
#' @export calcAWIC

calcAWIC<-function(df, type="num"){
  calcindex(df, index="AWIC", type=type)
}
