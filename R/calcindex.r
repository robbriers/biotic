#' Calculate biotic indices for invertebrate samples.
#' @description Calculates a range of freshwater invertebrate biotic indices
#'  in use in the UK (based on family level identification. Currently
#'  calculates BMWP (N-taxa and ASPT), Whalley revised BMWP, Whalley habitat
#'   specific BWMP (riffle, pool and riffle/pool), LIFE, PSI, WHPT (presence
#'  -absence and abundance-weighted) and AWIC.  For details of these indices
#'    see the vignette.
#'
#' @param df A dataframe containing list of taxa followed by their abundances
#' in samples, with sample names as headers.  Default format is for taxon
#' names to be in the first column and sample abundances in subsequent
#' columns, but data can also be processed in the transposed layout by
#' setting the \code{tidy} argument to TRUE (see below).
#' @param index A choice of index to be calculated. Defaults to \code{"BMWP"}.
#' Options are: \code{"BMWP"}, \code{"Whalley"}, \code{"Riffle"}, \code{"Pool"}
#' ,\code{"RiffPool"}, \code{"LIFE"}, \code{"PSI"}, \code{"WHPT"},
#' \code{"WHPT_AB"} and \code{"AWIC"}.
#' @param tidy Whether the data are in a 'tidy' format (sensu Wickham). The
#' default is FALSE as data are commonly stored as columns as samples rather
#' than rows (with the taxon list in the first column). This is the default
#' format; if set to TRUE the data are transposed prior to processing using
#'  the internal \code{\link{transposedata}} function.
#' @return A data frame consisting of columns of indices with samples in rows
#'  (tidy format). The number of columns returned depends on the index
#'  selected.
#' @export calcindex
#' @examples
#' # load the built-in River Almond dataset
#'
#' data(almond)
#'
#' # calculate the PSI index for this dataset
#' # tidy is not specified as default is used (FALSE)
#'
#' calcindex(almond, index="PSI")


calcindex<-function(df, index="BMWP", tidy=FALSE){

  # check that a correct method has been specified
  TYPES<-c("BMWP", "Whalley", "Riffle", "Pool", "RiffPool", "PSI", "LIFE", "WHPT", "WHPT_AB", "AWIC")
  indextype<-pmatch(index, TYPES)
  ind<-TYPES[indextype]
  if (is.na(indextype))
    stop("invalid index choice")

  # if tidy data are are supplied, transpose before calculation
  if (tidy=="TRUE"){
    df<-transposedata(df)
  }

  # check for BWMP composite families and remove, except for PSI and WHPT
  if (index!="PSI" | index!="WHPT" | index!="WHPT_AB"){

    # extract composite families from BMWPtab
    composites<-BMWPtab[BMWPtab$Composite!="",]
    composites<-as.data.frame(cbind.data.frame(composites$Taxon, composites$Composite))

    # locate any rows to delete
    rowstodelete<-apply(composites, 1, findcomposites, df=df)

    # remove NAs from vector
    rowstodelete<-na.omit(rowstodelete)

    # remove double counting rows from input df if there are any
    if (length(rowstodelete)>0){
      df<-df[-rowstodelete, ]
    }

    # also need to check for and combine oligochaete families

    # set up vector of oligochaete taxa
    families<-c("Lumbricidae", "Lumbriculidae", "Enchytraeidae", "Oligochaeta")

    # create logical vector of rows with oligochaetes
    present<- df[,1] %in% families

    # extract non oligochaete rows
    rest<-df[!present,]

    # subset rows with worms present
    worms<-df[present,]

    if (!is.null(worms)){
      # convert taxon to character for replacement
      worms[,1]<-as.character(worms[,1])

      # if there is more than one row of worms
      if(nrow(worms)>1){
      # sum abundance across all oligochaetes and add to first row
      worms[1,-1]<-colSums(worms[,-1],na.rm=TRUE)
      }
      # add taxon string back in
      worms[1,1]<-"Oligochaeta"

      # convert back to factor
      worms[,1]<-as.factor(worms[,1])

      # just take first row (sum)
      worms<-worms[1,]

      # recombine with rest of taxa
      df<-rbind(rest, worms)
    }
  }

  # separate out sample taxon list
  taxonlist<-df[,1]

  # and samples
  samples<-df[,2:ncol(df)]

  # check whether the data look like presence-absence and warn if calculating abundance-based index
  maxabund<-max(samples,na.rm=TRUE)
  if (maxabund==1){
    if (index=="PSI" | index=="LIFE" | index=="WHPT_AB"){
      warning("Maximum abundance in samples is 1. Abundance-weighted indices may not be meaningful")
    }
  }

  # if only one sample present, need to process differently
  if (ncol(df)==2){

    # calculate scores
    output<-calcscore(samples, taxonlist=taxonlist, index=index)

    # transpose output
    output<-t(output)

    # add on sample name to row
    row.names(output)<-names(df[2])
  }
  # if there is more than one sample, apply across columns
  else{
    output<-apply(samples, 2, calcscore, taxonlist=taxonlist, index=index)
  }

  # only need to bind rows for multiple samples
  if (ncol(df)>2){
    output<-rbind(output)
    output<-t(output)
  }

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
  if (index=="RiffPool"){
    colnames(output)<-c("RiffPool_BMWP", "RiffPool_N-taxa", "RiffPool_ASPT")
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
  if (index=="WHPT_AB"){
    colnames(output)<-c("WHPT_AB_ASPT", "WHPT_AB_N-taxa")
  }

  # add on sample identifier column and set row names to null
  output<-as.data.frame(cbind.data.frame(row.names(output), output))
  row.names(output)<-NULL
  colnames(output)[1]<-"Sample"

  return(output)
}
