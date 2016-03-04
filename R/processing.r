#' Locates BMWP composite families in sample data
#' @description Takes a listing of taxa and abundances and locates those
#' taxa that are represented as composites in the BMWP index to avoid double
#' counting of scores.
#'
#' @param composites A dataframe containing the list of composite taxa with
#' each pair of composites in two columns.
#' @param df A dataframe containing list of taxa in first column, followed by
#'  columns of abundances with sample names in header row.
#' @return An indexing vector, giving the rows of the sample data that need
#' to be deleted to avoid double counting.

findcomposites<-function(composites, df){

  # check for match with each composite pair. Use column index to avoid
  # assumptions over title of column
  firstrow<-match(composites[1], df[,1])
  secondrow<-match(composites[2], df[,1])
  # is the second of the pair present?
  if (!is.null(secondrow)){
    # if so then if the first is also present, then need to delete the row
    if (!is.null(firstrow)){
      remove<-firstrow
    }
  }
  return(remove)

  # add in Oligochaeta and Chironomidae - this might be better outside
  # is Oligochaeta present in taxon list
  #  if (is.null(match("Oligochaeta", df[,1]))){
  #
  #  }

  # end of function
}


#' Extract taxon scores based on presence.
#' @description Extracts a subset of biotic index score table data based on
#' taxon names in first row of dataframe passed in which represent taxa
#' present in any of the samples being analysed.
#'
#' @param df A dataframe or atomic vector representing the sample. If in vector
#'  form, should be a string vector of taxon names. If a dataframe, should
#'  contain taxon names in strong format in first column, followed by columns
#'  of numeric abundances in samples.
#' @param indextable A dataframe of biotic index values, with strings of taxon
#'  names in the first column and scores in subsequent columns. Usually
#'  loaded from object in the sysdata.rda file.
#' @return A dataframe consisting of the rows of the index table matching the
#' taxa present in the sample.

extractrows<-function(df, indextable){

  # create logical vector of taxa present in sample
  present<-indextable$Taxon %in% df[,1]

  # subset of indices for present taxa
  scorerows<-indextable[present,]

  return(scorerows)
}


#' Classify taxa into log class score sets based on their sample abundance.
#' @description Takes a dataframe of taxon names and abundances and returns a dataframe of taxon index scores (through a call to extractrows), along with a 'class' index column indicating the log abundance class for each taxon in the sample.
#'
#' @param df A dataframe containing list of taxa in first column, followed by a column of abundances with sample names in header row.
#' @return A data frame consisting of taxon names in the first column followed by all taxon index values and a log abundance class index column.

logslice<-function(df){
  # 1-9 abundance
  logclass1<-df[df[,2]>0 & df[,2]<10,]
  log1scores<-extractrows(logclass1, BMWPtab)
  log1scores$class<-rep(1, times=nrow(log1scores))

  # 10-99 abundance
  logclass2<-df[df[,2]>9 & df[,2]<100,]
  log2scores<-extractrows(logclass2, BMWPtab)
  log2scores$class<-rep(2, times=nrow(log2scores))

  # 100-999 abundance
  logclass3<-df[df[,2]>99 & df[,2]<1000,]
  log3scores<-extractrows(logclass3, BMWPtab)
  log3scores$class<-rep(3, times=nrow(log3scores))

  # 1000+ abundance
  logclass4<-df[df[,2]>999,]
  log4scores<-extractrows(logclass4, BMWPtab)
  log4scores$class<-rep(4, times=nrow(log4scores))
  sliced<-list(log1scores, log2scores, log3scores, log4scores)
  sliced<-do.call(rbind, sliced)

  return(sliced)
}

