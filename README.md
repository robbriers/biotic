
# biotic

[![Build
Status](https://travis-ci.org/robbriers/biotic.svg?branch=master)](https://travis-ci.org/robbriers/biotic)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/robbriers/biotic?branch=master&svg=true)](https://ci.appveyor.com/project/robbriers/biotic/branch/master)
[![DOI](https://zenodo.org/badge/21485/robbriers/biotic.svg)](https://zenodo.org/badge/latestdoi/21485/robbriers/biotic)
[![CRAN
Version](http://www.r-pkg.org/badges/version/biotic)](http://www.r-pkg.org/pkg/biotic)
[![Coverage
Status](https://coveralls.io/repos/github/robbriers/biotic/badge.svg?branch=master)](https://coveralls.io/github/robbriers/biotic?branch=master)
[![](http://cranlogs.r-pkg.org/badges/biotic)](http://cran.rstudio.com/web/packages/biotic/index.html)
[![](https://cranlogs.r-pkg.org/badges/grand-total/biotic)](http://cran.rstudio.com/web/packages/biotic/index.html)

### Introduction

The biotic package calculates a range of commonly used UK freshwater
invertebrate biotic indices, based on family level identification.
Indices that can be calculated are BMWP (and associated N-Taxa and
ASPT), Whalley revised BWMP, habitat-specific BMWP, WHPT (presence-only
and abundance-weighted), LIFE, PSI and AWIC. Links to the definitions of
these indices are given at the end of the text.

### Installation

The current release (0.1.2) of the package can be installed from CRAN
via the normal means.

``` r
install.packages("biotic")
```

The current development version (0.1.3) can be obtained from GitHub. The
homepage of the package is <https://github.com/robbriers/biotic>. In
order to install the development version, you need to first install the
‘devtools’ package.

``` r
install.packages("devtools")
```

Then use the ‘install_github’ function within this package to load the
development version from GitHub.

``` r
devtools::install_github('robbriers/biotic')
```

### Data required

The package assumes that the data are derived from standard three-minute
kick sampling (with additional one minute hand search) as per [standard
RIVPACS/RICT
methods](http://www.eu-star.at/pdf/RivpacsMacroinvertebrateSamplingProtocol.pdf).
Identification should be taken to family level. BMWP composite families
are combined automatically, as well as oligochaete families combined to
Class level where required.

### Input format

The data are assumed to be stored in a dataframe with the first column
containing a list of taxon names and subsequent columns containing
sample headers and individual taxon abundances. Absences should be
recorded as ‘NA’ rather than zero (so NA or blank cells in a csv file
imported via read.csv), although the calculations will work with zero
abundances as well, but this is not recommended. In addition to actual
abundances, log categories (1-5) or alphabetic log categories (A-E) can
also be processed, through specification of the data type (see below).

If you have data that are stored in a ‘tidy’ format [sensu
Wickham](https://www.jstatsoft.org/article/view/v059i10), then these can
be converted to the correct format for this package using the
[reshape2](https://cran.r-project.org/package=reshape2) package, or the
[tidyr](https://cran.r-project.org/package=tidyr) package prior to
calculation.

An example of the default layout of data can be seen by accessing the
built-in ‘almond’ dataset.

``` r
# load library
library(biotic)
```

    ## This is biotic, version 0.1.2

``` r
# show the format of the built-in almond dataset
head(almond)
```

    ##          Taxon HowdenUS3 KirktonUS1 MidcalderUS1 MidcalderDS3 SeafieldDS1
    ## 1    Ancylidae        NA         NA           NA           NA           1
    ## 2    Asellidae        46        115           NA            1           2
    ## 3     Baetidae        NA          6          102           86          86
    ## 4 Chironomidae        31         16            7            6           2
    ## 5   Dytiscidae         1          1           NA           NA           3
    ## 6      Elmidae        NA         NA           NA            2           1

### Functions

The workhorse function of the package is ‘calcindex’. The allows the
user to specify which index is to be calculated as well as the type of
data being processed through the ‘index’ and ‘type’ arguments. The first
relates to the choice of index. Possible values for index are: “BMWP”,
“Whalley”, “Riffle”, “Pool”, “RiffPool”, “WHPT”, “WHPT_AB”, “LIFE”, and
“PSI”. The second argument relates to the format of the dataset.The
options are “num” for numeric abundances, “log” for integer log
categories (1-5) or “alpha” for alphabetic log abundance categories
(A-E). If the data are in the default format (actual integer abundances)
then it can be omitted. The use of these is best illustrated through
examples using the built-in datasets (‘almond’, ‘braidburn’ and
‘greenburn’).

``` r
# calculate the BMWP index for the River Almond dataset
# 'index' and 'type' do not have to specified as defaults are used
# ("BMWP" and "num")

calcindex(almond)
```

    ##         Sample BMWP Ntaxa ASPT
    ## 1    HowdenUS3   57    14 4.07
    ## 2   KirktonUS1   81    17 4.76
    ## 3 MidcalderUS1   77    12 6.42
    ## 4 MidcalderDS3   90    15 6.00
    ## 5  SeafieldDS1  146    24 6.08

``` r
# calculate the PSI index for the almond samples
# 'type' argument again not needed as the data are numeric abundances
calcindex(almond, "PSI")
```

    ##         Sample   PSI
    ## 1    HowdenUS3 17.39
    ## 2   KirktonUS1 44.83
    ## 3 MidcalderUS1 83.33
    ## 4 MidcalderDS3 76.67
    ## 5  SeafieldDS1 62.50

To process data in either integer or alphabetic log categories, the
‘type’ argument should specify either “log” or “alpha”. Examples are
shown below.

``` r
# example of processing data in alphabetic log abundance categories
# using the 'type' argument

# 'braidburn' dataset contains alphabetic log category data
# see ?braidburn for details

# calculate the Whalley revised BMWP index (including N-taxa and ASPT)

calcindex(braidburn, "Whalley", "alpha")
```

    ##   Sample Whalley_BMWP Whalley_Ntaxa Whalley_ASPT
    ## 1     A4          115            19         6.05
    ## 2     B6          115            19         6.05
    ## 3     B4          115            19         6.05
    ## 4     A3          115            19         6.05
    ## 5     A2          115            19         6.05
    ## 6     A5          115            19         6.05
    ## 7     A1          115            19         6.05

``` r
# example of processing data in numeric log abundance categories
# using the 'type' argument

# 'greenburn' dataset contains numeric log category data
# see ?greenburn for details

# calculate the LIFE index for this dataset

calcindex(greenburn, "LIFE", "log")
```

    ##   Sample LIFE
    ## 1    GB1 8.45
    ## 2    GB2 8.43
    ## 3    GB3 8.23
    ## 4    GB4 8.08
    ## 5    GB5 8.11
    ## 6    GB6 8.70
    ## 7    GB7 8.23

### Individual index functions

In order to make calculating individual indices more straightforward,
wrapper functions are also provided for each index. The specification of
each index follows the string provided in the calcindex function (see
above). Again these can process data in either integer abundance,
integer log category or alphabetic log category format, through the type
argument, which defaults to “num” if not specified as per the main
function. Full details of these are provided in the help file (e.g
?calcBMWP), but examples are given below.

``` r
# calculate the BMWP index for almond samples

calcBMWP(almond)
```

    ##         Sample BMWP Ntaxa ASPT
    ## 1    HowdenUS3   57    14 4.07
    ## 2   KirktonUS1   81    17 4.76
    ## 3 MidcalderUS1   77    12 6.42
    ## 4 MidcalderDS3   90    15 6.00
    ## 5  SeafieldDS1  146    24 6.08

``` r
# calculate the AWIC index for almond samples

calcAWIC(almond)
```

    ##         Sample AWIC
    ## 1    HowdenUS3 5.00
    ## 2   KirktonUS1 4.71
    ## 3 MidcalderUS1 4.17
    ## 4 MidcalderDS3 4.33
    ## 5  SeafieldDS1 4.67

``` r
# calculate the WHPT abundance-weighted index for Green Burn samples
# (numeric log abundance categories)

calcWHPT_AB(greenburn, "log")
```

    ##   Sample WHPT_AB_ASPT WHPT_AB_Ntaxa
    ## 1    GB1         7.90            22
    ## 2    GB2         7.00             8
    ## 3    GB3         7.09            15
    ## 4    GB4         6.95            14
    ## 5    GB5         7.31             9
    ## 6    GB6         8.30            10
    ## 7    GB7         7.61            14

``` r
# calculate LIFE index for Braid Burn samples (alphabetic log categories)

calcLIFE(braidburn, type="alpha")
```

    ##   Sample LIFE
    ## 1     A4 7.29
    ## 2     B6 7.29
    ## 3     B4 7.29
    ## 4     A3 7.29
    ## 5     A2 7.29
    ## 6     A5 7.29
    ## 7     A1 7.29

### Reporting problems

The package has been tested fairly extensively using different test
datasets, but if you come across an error or bug, then please submit an
[issue](https://github.com/robbriers/biotic/issues) or [email
me](mailto:r.briers@napier.ac.uk), giving as much information as
possible, and ideally the dataset that caused the problem.

### Sources of information about the indices calculated

BMWP, Whalley Revised BMWP and Habitat-specific scores were taken from
the table given [here](http://www.cies.staffs.ac.uk/bmwptabl.htm).

The derivation and history of the BMWP score is described in [Hawkes,
H.A. (1998)](http://dx.doi.org/10.1016/S0043-1354(97)00275-3) Origin and
development of the Biological Monitoring Working Party (BMWP) score
system. *Water Research* **32**, 964-968. Details of the revised scores
are given in [Walley W.J. & Hawkes H.A.
(1997)](http://dx.doi.org/10.1016/S0043-1354(96)00249-7) A
computer-based development of the Biological Monitoring Working Party
score system incorporating abundance rating, biotope type and indicator
value. *Water Research*, **31**, 201-210.

Details of the family level scores for LIFE, WHPT (both versions) and
PSI were taken from the [FBA RICT Development report for
SEPA](http://www.fba.org.uk/sites/default/files/SEPARICTWorkstream1(WHPTandotherAbundance-WeightedIndices)Final%20Report.pdf).

The original derivation of the LIFE family level score is described in
[Extence et
al. (1999)](http://dx.doi.org/10.1002/(SICI)1099-1646(199911/12)15:6%3C545::AID-RRR561%3E3.0.CO;2-W)
River flow indexing using British benthic macroinvertebrates: a
framework for setting hydroecological objectives. *Regulated Rivers:
Research and Management* **15**, 543-574 and the PSI index in [Extence
et al. (2013)](http://dx.doi.org/10.1002/rra.1569) The assessment of
fine sediment accumulation in rivers using macro-invertebrate community
response. *Regulated Rivers: Research and Management* **29**, 17-55.

There is no published reference for the WHPT index beyond the report
given above.

AWIC Family level scores were taken from the [DEFRA commissioned
report](https://www.gov.uk/government/publications/development-of-the-acid-water-indicator-community-awic-macroinvertebrate-family-and-species-level).

The original derivation of the AWIC family level score is described in
[Davey-Bowker et
al. (2005)](http://dx.doi.org/10.1127/0003-9136/2005/0163-0383) The
development and testing of a macroinvertebrate biotic index for
detecting the impact of acidity on streams. *Archiv fur Hydrobiologie*
**163**, 383-403.
