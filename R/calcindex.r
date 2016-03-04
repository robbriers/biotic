#' Calculate biotic indices for invertebrate samples.
#' @description Calculates a range of freshwater invertebrate biotic indices
#'  in use in the UK (based on family level identification. Currently
#'  calculates BMWP (N-taxa and ASPT), Whalley revised BMWP, Whalley habitat
#'   specific BWMP (riffle, pool and riffle/pool), LIFE, PSI, WHPT and AWIC.  For
#'   details of these indices see the vignette.
#'
#' @param df A dataframe containing list of taxa followed by their abundances
#' in samples, with sample names as headers.  Default format is for taxon
#' names to be in the first column and sample abundances in subsequent
#' columns, but data can also be processed in the transposed layout by
#' setting the \code{tidy} argument to TRUE (see below).
#' @param index A choice of index to be calculated. Defaults to BMWP.
#' Options are: \code{"BMWP"}, \code{"Whalley"}, \code{"Riffle"}, \code{"Pool"},
#' \code{"Intermed"}, \code{"LIFE"}, \code{"PSI"}, \code{"WHPT"} and
#' \code{"AWIC"}.
#' @param tidy Whether the data are in a 'tidy' format (sensu Wickham). The
#' default is FALSE as data are commonly stored as columns as samples rather
#' than rows (with the taxon list in the first column). This is the default
#' format; if set to FALSE the data are transposed prior to processing.
#' @return A data frame consisting of columns of indices with samples in rows
#'  (tidy format). The number of columns returned depends on the index
#'  selected.
#' @examples
#' # load the built-in River Almond dataset
#'
#' data(almond)
#'
#' # calculate the PSI index for this dataset
#' # tidy is not specified as default is used (FALSE)
#'
#' calcindex(almond, index="PSI")
#' @export calcindex

calcindex<-function(df, index="BMWP", tidy=FALSE){

  # check that a correct method has been specified
  TYPES<-c("BMWP", "Whalley", "Riffle", "Pool", "Intermed", "PSI", "LIFE", "WHPT", "AWIC")
  indextype<-pmatch(index, TYPES)
  ind<-TYPES[indextype]
  if (is.na(indextype))
    stop("invalid index choice")

  # if tidy data are are supplied, transpose before calculation
  if (tidy=="TRUE"){
    df<-t(df)
  }

  # check for BWMP composite families and remove, except for PSI and WHPT
  if (index!="PSI" | index!="WHPT"){

    # extract composite families from BMWPtab
    composites<-BMWPtab[BMWPtab$Composite!="",]
    composites<-as.data.frame(cbind.data.frame(composites$Taxon, composites$Composite))

    # locate any rows to delete
    rowstodelete<-apply(composites, 1, findcomposites, df=df)

    # remove NAs from vector
    rowstodelete<-na.omit(rowstodelete)

    # remove double counting rows from input df
    df<-df[-rowstodelete, ]
  }

  # separate out sample taxon list
  taxonlist<-df[,1]

  # and samples
  samples<-df[,2:ncol(df)]

  # check whether the data look like presence-absence and warn if calculating abundance-based index
  maxabund<-max(samples,na.rm=TRUE)
  if (maxabund==1){
    if (index=="PSI" | index=="LIFE"){
      warning("Maximum abundance in samples is 1. Abundance weighted indices may not be meaningful")
    }
  }

  # run through columns and calculate scores
  # need to check here how it deals with single sample data
  output<-apply(samples, 2, calcscore, taxonlist=taxonlist, index=index)

  # convert returned list back to df
  output<-do.call(rbind, output)

  # add column names depending on index
  if (index=="BMWP"){
    colnames(output)<-c("BMWP", "N-taxa", "ASPT")
  }
  if (index=="Whalley"){
    colnames(output)<-c("Whalley_BMWP", "Whalley_N-taxa", "Whalley_ASPT")
  }
  if (index=="Riffle"){
    colnames(output)<-c("Riffle_BMWP", "Riffle_N-taxa", "Riffle_ASPT")
  }
  if (index=="Pool"){
    colnames(output)<-c("Pool_BMWP", "Pool_N-taxa", "Pool_ASPT")
  }
  if (index=="Intermed"){
    colnames(output)<-c("Intermed_BMWP", "Intermed_N-taxa", "Intermed_ASPT")
  }
  if (index=="LIFE"){
    colnames(output)<-c("LIFE")
  }
  if (index=="PSI"){
    colnames(output)<-c("PSI")
  }
  if (index=="AWIC"){
    colnames(output)<-c("AWIC")
  }
  if (index=="WHPT"){
    colnames(output)<-c("WHPT_ASPT", "WHPT_N-taxa")
  }

  return(output)
}