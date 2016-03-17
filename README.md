
<!-- README.md is generated from README.Rmd. Please edit that file -->
`hyphenatr` : HYPHENATE ALL THE THINGS

At the moment, this requires <https://github.com/hunspell/hyphen> to be installed on the local system first. Am working to get it to ship with the package.

Support for extra hyphenation rules from <http://www.textcontrol.com/en_US/downloads/dictionaries/> coming soon.

The following functions are implemented:

-   `curr_dict`: Identify current hyphen rules language
-   `hyphenate`: Hyphenate a character vector of words
-   `list_dicts`: List available hyphenation languages rules
-   `switch_dict`: Switch hyphen rules language

### News

-   Version 0.1.0.9000 released

### Installation

``` r
devtools::install_github("hrbrmstr/hyphenatr")
```

### Usage

``` r
library(hyphenatr)
library(jsonlite)
library(microbenchmark)

# current verison
packageVersion("hyphenatr")
#> [1] '0.1.0.9000'

list_dicts()
#>  [1] "af_ZA"  "bg_BG"  "ca"     "cs_CZ"  "da_DK"  "de"     "el_GR"  "en_GB"  "en_US"  "es_ANY" "et_EE"  "fr"    
#> [13] "hr_HR"  "it_IT"  "lt_LT"  "nb_NO"  "nl_NL"  "nn_NO"  "pl_PL"  "pt_BR"  "pt_PT"  "ro_RO"  "ru_RU"  "sh"    
#> [25] "sk_SK"  "sl_SI"  "sr"     "uk_UA"

curr_dict()
#> [1] "en_US"

# test word list (10K words)
dat <- readLines(system.file("extdata/top10000en.txt", package="hyphenatr"))

microbenchmark(out1 <- hyphenate(dat))
#> Unit: milliseconds
#>                    expr    min       lq     mean   median       uq      max neval
#>  out1 <- hyphenate(dat) 21.084 22.46623 23.75113 23.76099 24.98613 27.44503   100

out1[500:550]
#>  [1] "got"            "fam=ily"        "pol=icy"        "in=vestors"     "record"         "loss"          
#>  [7] "re=ceived"      "April"          "Ex=change"      "code"           "graph=ics"      "agency"        
#> [13] "in=creased"     "man=ager"       "keep"           "look"           "of=ten"         "de=signed"     
#> [19] "Euro=pean"      "earn=ings"      "en=vi=ron=ment" "July"           "job"            "third"         
#> [25] "wa=ter"         "net"            "banks"          "an=a=lysts"     "strong"         "party"         
#> [31] "econ=omy"       "away"           "dol=lar"        "taken"          "de=vel=oped"    "con=tinue"     
#> [37] "al=low"         "Mi=crosoft"     "key"            "ei=ther"        "se=cu=rity"     "project"       
#> [43] "agreed"         "though"         "Ja=pan"         "rather"         "coun=tries"     "plant"         
#> [49] "along"          "Ap=ple"         "ac=tion"

microbenchmark(out2 <- hyphenate(dat, simplify=FALSE))
#> Unit: milliseconds
#>                                      expr    min       lq     mean   median       uq     max neval
#>  out2 <- hyphenate(dat, simplify = FALSE) 26.244 28.34472 29.85532 29.76182 31.35217 35.7828   100

jsonlite::toJSON(out2[530:540], pretty=TRUE)
#> [
#>   ["econ", "omy"],
#>   ["away"],
#>   ["dol", "lar"],
#>   ["taken"],
#>   ["de", "vel", "oped"],
#>   ["con", "tinue"],
#>   ["al", "low"],
#>   ["Mi", "crosoft"],
#>   ["key"],
#>   ["ei", "ther"],
#>   ["se", "cu", "rity"]
#> ]

microbenchmark(out3 <- hyphenate(dat, simplify="-"))
#> Unit: milliseconds
#>                                    expr      min       lq   mean   median       uq      max neval
#>  out3 <- hyphenate(dat, simplify = "-") 26.53168 28.38128 29.848 29.67211 31.11331 33.99726   100

out3[500:550]
#>  [1] "got"            "fam-ily"        "pol-icy"        "in-vestors"     "record"         "loss"          
#>  [7] "re-ceived"      "April"          "Ex-change"      "code"           "graph-ics"      "agency"        
#> [13] "in-creased"     "man-ager"       "keep"           "look"           "of-ten"         "de-signed"     
#> [19] "Euro-pean"      "earn-ings"      "en-vi-ron-ment" "July"           "job"            "third"         
#> [25] "wa-ter"         "net"            "banks"          "an-a-lysts"     "strong"         "party"         
#> [31] "econ-omy"       "away"           "dol-lar"        "taken"          "de-vel-oped"    "con-tinue"     
#> [37] "al-low"         "Mi-crosoft"     "key"            "ei-ther"        "se-cu-rity"     "project"       
#> [43] "agreed"         "though"         "Ja-pan"         "rather"         "coun-tries"     "plant"         
#> [49] "along"          "Ap-ple"         "ac-tion"

microbenchmark(out4 <- hyphenate(dat, simplify="&shy;"))
#> Unit: milliseconds
#>                                        expr      min       lq     mean  median       uq      max neval
#>  out4 <- hyphenate(dat, simplify = "&shy;") 28.67563 30.22896 31.43619 31.1238 32.90817 35.23374   100

out4[500:550]
#>  [1] "got"                        "fam&shy;ily"                "pol&shy;icy"                "in&shy;vestors"            
#>  [5] "record"                     "loss"                       "re&shy;ceived"              "April"                     
#>  [9] "Ex&shy;change"              "code"                       "graph&shy;ics"              "agency"                    
#> [13] "in&shy;creased"             "man&shy;ager"               "keep"                       "look"                      
#> [17] "of&shy;ten"                 "de&shy;signed"              "Euro&shy;pean"              "earn&shy;ings"             
#> [21] "en&shy;vi&shy;ron&shy;ment" "July"                       "job"                        "third"                     
#> [25] "wa&shy;ter"                 "net"                        "banks"                      "an&shy;a&shy;lysts"        
#> [29] "strong"                     "party"                      "econ&shy;omy"               "away"                      
#> [33] "dol&shy;lar"                "taken"                      "de&shy;vel&shy;oped"        "con&shy;tinue"             
#> [37] "al&shy;low"                 "Mi&shy;crosoft"             "key"                        "ei&shy;ther"               
#> [41] "se&shy;cu&shy;rity"         "project"                    "agreed"                     "though"                    
#> [45] "Ja&shy;pan"                 "rather"                     "coun&shy;tries"             "plant"                     
#> [49] "along"                      "Ap&shy;ple"                 "ac&shy;tion"
```

### Test Results

``` r
library(hyphenatr)
library(testthat)

date()
#> [1] "Wed Mar 16 23:06:43 2016"

test_dir("tests/")
#> testthat results ========================================================================================================
#> OK: 0 SKIPPED: 0 FAILED: 0
```

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
