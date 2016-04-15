## ---- eval=FALSE---------------------------------------------------------
#  install.packages("biotic")

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
# type argument not needed as the data are in the default format of abundances
calcindex(almond, "PSI")

## ---- eval=FALSE---------------------------------------------------------
#  # process data with integer log abundance categories
#  calcindex(log_cat_data, "PSI", type="log")
#  
#  # similarly for alphabetic category data
#  calcindex(alpha_cat_data, "PSI", type="alpha")

## ------------------------------------------------------------------------
# calculate the BMWP index for almond samples
calcBMWP(almond)

# calculate the AWIC index for almond samples
calcAWIC(almond)

# calculate the WHPT abundance-weighted index for almond samples
calcWHPT_AB(almond)

## ---- eval=FALSE---------------------------------------------------------
#  # calculate LIFE index based on integer log abundance categories
#  # not run, just for illustration
#  calcLIFE(log_cat_data, type="log")

