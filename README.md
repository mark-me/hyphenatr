
<!-- README.md is generated from README.Rmd. Please edit that file -->
`hyphenatr` : HYPHENATE ALL THE THINGS

The following functions are implemented:

-   `curr_dict`: Identify current hyphen rules language
-   `hyphenate`: Hyphenate a character vector of words
-   `list_dicts`: List available hyphenation languages rules
-   `switch_dict`: Switch hyphen rules language

### News

-   Version 0.2.0.9000 - no external library required
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
#> [1] '0.2.0.9000'

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
#>                    expr      min       lq     mean   median       uq      max neval
#>  out1 <- hyphenate(dat) 20.60129 21.76488 23.34045 23.16855 24.66982 28.32694   100

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
#>                                      expr      min       lq     mean   median       uq     max neval
#>  out2 <- hyphenate(dat, simplify = FALSE) 26.90225 28.79702 30.20364 30.16404 31.23261 36.7191   100

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
#>                                    expr      min       lq     mean   median       uq      max neval
#>  out3 <- hyphenate(dat, simplify = "-") 26.66264 28.41522 29.53422 29.41618 30.73699 34.23482   100

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
#>                                        expr      min       lq     mean   median       uq     max neval
#>  out4 <- hyphenate(dat, simplify = "&shy;") 28.83835 31.25626 32.52042 32.43939 33.59321 36.1052   100

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
#> [1] "Wed Mar 16 23:28:57 2016"

test_dir("tests/")
#> testthat results ========================================================================================================
#> OK: 1 SKIPPED: 0 FAILED: 0
```

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
