<!-- README.md is generated from README.Rmd. Please edit that file -->
`hyphenatr` : HYPHENATE ALL THE THINGS

extra dictionaries from <http://www.textcontrol.com/en_US/downloads/dictionaries/>

more docs coming, i just needed to get this into gh

The following functions are implemented:

The following data sets are included:

### News

-   Version released

### Installation

``` r
devtools::install_github("hrbrmstr/hyphenatr")
```

### Usage

``` r
library(hyphenatr)

# current verison
packageVersion("hyphenatr")
#> [1] '0.0.0.9000'
```

### Test Results

``` r
library(hyphenatr)
library(testthat)

date()
#> [1] "Mon Mar 14 09:39:37 2016"

test_dir("tests/")
#> testthat results ========================================================================================================
#> OK: 0 SKIPPED: 0 FAILED: 0
```

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
