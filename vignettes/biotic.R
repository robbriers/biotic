## ---- eval=FALSE---------------------------------------------------------
#  install.packages("devtools")

## ---- eval=FALSE---------------------------------------------------------
#  devtools::install_github('robbriers/biotic')

## ------------------------------------------------------------------------
# load library
library(biotic)

# load built-in almond dataset
data(almond)
head(almond)

## ------------------------------------------------------------------------
# calculate the PSI index for the almond samples
# tidy argument not needed as the data are in the default format
calcindex(almond, "PSI")

## ------------------------------------------------------------------------
# to illustrate the use of the 'tidy' argument, first transpose the data
# use the 'transposedata' function in the package to do this
t_almond<-transposedata(almond)

# calculate the WHPT index for the transposed dataset
# this time specify the tidy argument, to allow for layout of data
calcindex(t_almond, "WHPT", tidy=TRUE)

## ------------------------------------------------------------------------
# calculate the BMWP index for almond samples
calcBMWP(almond)

# calculate the AWIC index for almond samples
calcAWIC(almond)

# calculate the WHPT abundance-weighted index for almond samples
calcWHPT_AB(almond)

# calculate the LIFE index on the transposed almond sample data
calcLIFE(t_almond, tidy=TRUE)

