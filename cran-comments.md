CRAN submission notes
================
Rob Briers
2016-04-20

Test environments
-----------------

-   Local Win 7 Enterprise, R 3.2.4 Revised
-   ubuntu 12.04 on travis-ci, R 3.2.3
-   Local lubuntu 15.10, R 3.2.2
-   win-builder, R-release (3.2.5), R-devel (3.3.0)

This is a resubmission; additional examples that are executed at run-time were requested. Additional datasets have been included to allow the running of a full range of examples. Additional examples are given in the main functions and also an example in each of the wrapper functions.

R CMD check results
-------------------

There were no ERRORs or WARNINGs.

There is one NOTE:

Possibly mis-spelled words in DESCRIPTION: AWIC (9:59) BMWP (9:15, 9:53) Biotic (3:23) Indices (3:30) WHPT (9:30) Whalley (9:21) biotic (8:63) indices (8:70)

These are all correct and are mostly abbreviations used for the different indexes.

Downstream dependencies
-----------------------

There aren't any.
