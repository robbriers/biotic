# biotic
[![Build Status](https://travis-ci.org/robbriers/biotic.svg?branch=master)](https://travis-ci.org/robbriers/biotic)


## Repository for the development of the biotic package for R.
Note that this is still under development so may contain bugs.

### Introduction
The biotic package calculates a range of commonly used UK freshwater invertebrate biotic indices, based on family level identification.  Indices that can be calculated are BMWP (and associated N-Taxa and ASPT), Whalley revised BWMP, habitat specific BMWP, WHPT (presence-only and abundance-weighted), LIFE, PSI and AWIC. Links to the definitions of these indices are given at the end of the text.

### Installation
The package is still in the development/testing stage so is only available from GitHub. Once testing is complete it will be submitted to CRAN.  The homepage of the package is [https://github.com/robbriers/biotic](https://github.com/robbriers/biotic). In order to install it, you need to first install the 'devtools' package.

```r
install.packages("devtools")
```
Then use the 'install_github' function within this package to load the development version from GitHub.

```r
devtools::install_github('robbriers/biotic')
```

### Data required
The package assumes that the data are derived from standard three-minute kick sampling (with additional one minute hand search) as per [standard RIVPACS/RICT methods](http://www.eu-star.at/pdf/RivpacsMacroinvertebrateSamplingProtocol.pdf). Identification should be taken to family level. BMWP composite families are combined automatically, as well as oligochaete families combined to Class level where required.

### Input format
The data are assumed to be stored in a dataframe with the first column containing a list of taxon names and subsequent columns containing sample headers and individual taxon abundances. Absences should be recorded as 'NA' rather than zero (so blank cells in a csv file imported via read.csv), although the calculations will work with zero abundances as well, but this is not recommended. An example of the layout of data can be seen by accessing the built-in 'almond' dataset.


```r
# load library
library(biotic)

# load built-in almond dataset
data(almond)
head(almond)
```

```
##          Taxon HowdenUS3 KirktonUS1 MidcalderUS1 MidcalderDS3 SeafieldDS1
## 1    Ancylidae        NA         NA           NA           NA           1
## 2    Asellidae        46        115           NA            1           2
## 3     Baetidae        NA          6          102           86          86
## 4 Chironomidae        31         16            7            6           2
## 5   Dytiscidae         1          1           NA           NA           3
## 6      Elmidae        NA         NA           NA            2           1
```

### Functions
The workhorse function of the package is 'calcindex'. The allows the user to specify which index is to be calculated as well as the format of the data through the 'index' and 'tidy' arguments. The first relates to the choice of index.  Possible values for index are: "BMWP", "Whalley", "Riffle", "Pool", "RiffPool", "WHPT", "WHPT_AB", "LIFE", "PSI" and "PSI".  The second argument relates to the format of the dataset.  If it is in the default format detailed above then it can be omitted. The use of these is best illustrated through examples, again using the built-in almond dataset.


```r
# calculate the PSI index for the almond samples
# tidy argument not needed as the data are in the default format
calcindex(almond, "PSI")
```

```
##         Sample   PSI
## 1    HowdenUS3 25.00
## 2   KirktonUS1 52.00
## 3 MidcalderUS1 95.24
## 4 MidcalderDS3 85.19
## 5  SeafieldDS1 69.44
```
The default data layout is contrary to the concept of 'tidy' data [sensu Wickham](https://www.jstatsoft.org/article/view/v059i10) (see also the [tidyr](https://cran.r-project.org/package=tidyr) package), but is a common format for such data to be stored. The package also allows for data in a tidy format (i.e. each row is a sample and columns represent each taxon) by setting the tidy parameter to TRUE (defaults to FALSE).

```r
# to illustrate the use of the 'tidy' argument, first transpose the data
# use the 'transposedata' function in the package to do this
t_almond<-transposedata(almond)

# calculate the WHPT index for the transposed dataset
# this time specify the tidy argument, to allow for layout of data
calcindex(t_almond, "WHPT", tidy=TRUE)
```

```
##         Sample WHPT_ASPT WHPT_Ntaxa
## 1    HowdenUS3      4.46         11
## 2   KirktonUS1      5.47         15
## 3 MidcalderUS1      6.93         12
## 4 MidcalderDS3      6.58         15
## 5  SeafieldDS1      6.80         23
```
### Individual index functions
In order to make calculating individual indices more straightforward, wrapper functions are also provided for each index. The specification of each index follows the string provided in the calcindex function (see above).  Again these can process data in either layout, through the tidy argument, which defaults to FALSE if not specified as per the main function. Full details of these are provided in the help file (e.g ?calcBMWP), but examples are given below.

```r
# calculate the BMWP index for almond samples
calcBMWP(almond)
```

```
##         Sample BMWP Ntaxa ASPT
## 1    HowdenUS3   48    11 4.36
## 2   KirktonUS1   75    15 5.00
## 3 MidcalderUS1   77    12 6.42
## 4 MidcalderDS3   90    15 6.00
## 5  SeafieldDS1  143    23 6.22
```

```r
# calculate the AWIC index for almond samples
calcAWIC(almond)
```

```
##         Sample AWIC
## 1    HowdenUS3 4.73
## 2   KirktonUS1 4.53
## 3 MidcalderUS1 4.17
## 4 MidcalderDS3 4.33
## 5  SeafieldDS1 4.61
```

```r
# calculate the WHPT abundance-weighted index for almond samples
calcWHPT_AB(almond)
```

```
##         Sample WHPT_AB_ASPT WHPT_AB_Ntaxa
## 1    HowdenUS3        13.41            11
## 2   KirktonUS1        18.59            15
## 3 MidcalderUS1        22.43            12
## 4 MidcalderDS3        14.91            15
## 5  SeafieldDS1        24.38            23
```

```r
# calculate the LIFE index on the transposed almond sample data
calcLIFE(t_almond, tidy=TRUE)
```

```
##         Sample LIFE
## 1    HowdenUS3 6.00
## 2   KirktonUS1 6.62
## 3 MidcalderUS1 8.40
## 4 MidcalderDS3 8.08
## 5  SeafieldDS1 7.57
```
### Reporting problems
The package is still in the development phase.  It has been tested fairly extensively using different test datasets, but if you come across an error or bug, then please submit an [issue](https://github.com/robbriers/biotic/issues) or [email me](mailto:r.briers@napier.ac.uk), giving as much information as possible, and ideally the dataset that caused the problem.

### Sources of information about the indices calculated

BMWP, Whalley Revised BMWP and Habitat-specific scores were taken from the table given [here](www.cies.staffs.ac.uk/bmwptabl.htm).

The derivation and history of the BMWP score is described in [Hawkes, H.A. (1998)](http://dx.doi.org/10.1016/S0043-1354(97)00275-3) Origin and development of the Biological Monitoring Working Party (BMWP) score system. *Water Research* **32**, 964-968. Details of the revised scores are given in [Walley W.J. &  Hawkes H.A. (1997)](http://dx.doi.org/10.1016/S0043-1354(96)00249-7) A computer-based development of the Biological Monitoring Working Party score system incorporating abundance rating, biotope type and indicator value. *Water Research*, **31**, 201-210.

Details of the family level scores for LIFE, WHPT (both versions) and PSI were taken from the [FBA RICT Development report for SEPA](http://www.fba.org.uk/sites/default/files/SEPARICTWorkstream1(WHPTandotherAbundance-WeightedIndices)Final%20Report.pdf).

The original derivation of the LIFE family level score is described in [Extence et al. (1999)](http://dx.doi.org/10.1002/(SICI)1099-1646(199911/12)15:6<545::AID-RRR561>3.0.CO;2-W) River flow indexing using British benthic macroinvertebrates: a framework for setting hydroecological objectives. *Regulated Rivers: Research and Management* **15**, 543-574 and the PSI index in [Extence et al. (2013)](http://dx.doi.org/10.1002/rra.1569) The assessment of fine sediment accumulation in rivers using macro-invertebrate community response. *Regulated Rivers: Research and Management* **29**, 17-55.

There is no published reference for the WHPT index beyond the report given above.

AWIC Family level scores were taken from the [DEFRA commissioned report](https://www.gov.uk/government/publications/development-of-the-acid-water-indicator-community-awic-macroinvertebrate-family-and-species-level).

The original derivation of the AWIC family level score is described in [Davey-Bowker et al. (2005)](http://dx.doi.org/10.1127/0003-9136/2005/0163-0383) The development and testing of a macroinvertebrate biotic index for detecting the impact of acidity on streams. *Archiv fur Hydrobiologie* **163**, 383-403.

