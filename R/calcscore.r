#' Calculates biotic index scores for individual samples.
#' @description Calculates chosen biotic index on individual samples,
#' based on vectors of abundances and taxon names passed as arguments.
#'
#' @param abundances An integer vector representing the abundances of taxa
#' in a sample. Absences should be represented as \code{NA} rather than
#' zero values but it will process data with zeros.
#' @param taxonlist A string vector containing taxon names (family level)
#' present in all the samples being analysed.
#' @param index A string representing the choice of index value. Defaults to
#' BMWP.
#' @return A list containing the different components of each score. List
#' dimensions depend on the index calculated.
#' @export calcscore

calcscore<-function(abundances, taxonlist, index){

  # recombine taxon list and abundances
  sampledata<-as.data.frame(cbind.data.frame(taxonlist, abundances))

  # find rows where taxa are present (>0 abundance)
  taxapresent<-sampledata[sampledata[,2] > 0,]

  # check that there are any taxa present in the sample, then extract scores
  if (nrow(taxapresent)!=0){
    if (index=="BMWP"){
      samplescores<-extractrows(taxapresent, BMWPtab)
      scorelist<-list(sum(samplescores$BMWP, na.rm=TRUE), sum(!is.na(samplescores$BMWP)), sum(samplescores$BMWP, na.rm=TRUE)/sum(!is.na(samplescores$BMWP)))
    }
    if (index=="Whalley"){
      samplescores<-extractrows(taxapresent, BMWPtab)
      scorelist<-list(sum(samplescores$Whalley, na.rm=TRUE), sum(!is.na(samplescores$Whalley)), sum(samplescores$Whalley, na.rm=TRUE)/sum(!is.na(samplescores$Whalley)))
    }
    if (index=="Riffle"){
      samplescores<-extractrows(taxapresent, BMWPtab)
      scorelist<-list(sum(samplescores$Riffle, na.rm=TRUE), sum(!is.na(samplescores$Riffle)), sum(samplescores$Riffle, na.rm=TRUE)/sum(!is.na(samplescores$Riffle)))
    }
    if (index=="Pool"){
      samplescores<-extractrows(taxapresent, BMWPtab)
      scorelist<-list(sum(samplescores$Pool, na.rm=TRUE), sum(!is.na(samplescores$Pool)), sum(samplescores$Pool, na.rm=TRUE)/sum(!is.na(samplescores$Pool)))
    }
    if (index=="Intermed"){
      samplescores<-extractrows(taxapresent, BMWPtab)
      scorelist<-list(sum(samplescores$Intermed, na.rm=TRUE), sum(!is.na(samplescores$Intermed)), sum(samplescores$Intermed, na.rm=TRUE)/sum(!is.na(samplescores$Intermed)))
    }
    if (index=="WHPT"){
      samplescores<-extractrows(taxapresent, BMWPtab)
      scorelist<-list(sum(samplescores$WHPT, na.rm=TRUE)/sum(!is.na(samplescores$WHPT)), sum(!is.na(samplescores$WHPT)))
    }

    if (index=="AWIC"){
      samplescores<-extractrows(taxapresent, BMWPtab)
      scorelist<-list( sum(samplescores$AWIC, na.rm=TRUE) / sum(!is.na(samplescores$AWIC)))
    }

    if (index=="PSI"){

      # slice abundance array and extract scores
      PSIscores<-logslice(taxapresent)

      # increment PSI scores based on log abundance class
      PSIscores$PSI<-ifelse(PSIscores$class==2, PSIscores$PSI+1, ifelse(PSIscores$class==3, PSIscores$PSI+2, ifelse(PSIscores$class==4, PSIscores$PSI+3, PSIscores$PSI)))

      # calculate PSI index
      PSI_ABscores<-PSIscores[PSIscores$PSIcat=="A" | PSIscores$PSIcat=="B",]
      PSI_AB<-sum(PSI_ABscores$PSI, na.rm=TRUE)
      PSI_All<-sum(PSIscores$PSI, na.rm=TRUE)

      scorelist<-list((PSI_AB/PSI_All)*100)
    }
    if (index=="LIFE"){
      # LIFE calculation

      # slice abundance array and extract scores
      LIFEscores<-logslice(taxapresent)

      # divide array based on LIFE score
      LIFEabove7<-LIFEscores[LIFEscores$LIFE > 7,]
      LIFE7<-LIFEscores[LIFEscores$LIFE==7,]
      LIFEbelow7<-LIFEscores[LIFEscores$LIFE < 7,]

      # modify LIFE scores based on log abundance class
      LIFEabove7$LIFE<-ifelse(LIFEabove7$class==2, LIFEabove7$LIFE+1, ifelse(LIFEabove7$class==3, LIFEabove7$LIFE+2, ifelse(LIFEabove7$class==4, LIFEabove7$LIFE+3, LIFEabove7$LIFE)))
      LIFEbelow7$LIFE<-ifelse(LIFEbelow7$class==2, LIFEbelow7$LIFE-1, ifelse(LIFEbelow7$class==3, LIFEbelow7$LIFE-2, ifelse(LIFEbelow7$class==4, LIFEbelow7$LIFE-3, LIFEbelow7$LIFE)))

      # recombine sections
      LIFEscores<-rbind(LIFEabove7, LIFE7, LIFEbelow7)

      # calculate LIFE index (sum/n)
      scorelist<-list(sum(LIFEscores$LIFE, na.rm=TRUE)/sum(!is.na(LIFEscores$LIFE)))
    }
  return(scorelist)
  # this closes the nrows loop
  }
  # this is the function closure
}