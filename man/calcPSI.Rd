% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrappers.r
\name{calcPSI}
\alias{calcPSI}
\title{Calculate PSI index}
\usage{
calcPSI(df, type = "num")
}
\arguments{
\item{df}{A dataframe containing list of taxa in first column, followed by
columns of abundances with sample names in header row.}

\item{type}{Indicates format of data. Options are "num" for numeric data,
"log" for integer log abundance categories (1-5) or "alpha" for alphabetic
abundance categories (A-E). Default value is "num".}
}
\value{
A data frame consisting of a column of index values with samples
in rows.
}
\description{
Calculates PSI index for invertebrate samples.
for invertebrate samples.
}
\examples{

# calculate the PSI index for the Braid Burn dataset
# data are alphabetic log abundance categories, so type is "alpha"

calcPSI(braidburn, "alpha")
}

