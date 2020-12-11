
<!-- README.md is generated from README.Rmd. Please edit that file -->

`hyphenatr` : HY-PHEN-ATE ALL THE THINGS

Based on the [Hunspell hyphenation
library](https://github.com/hunspell/hyphen) and includes hyphenation
rules dictionaries from
[LibreOffice](https://github.com/LibreOffice/dictionaries). See the
<inst/COPYRIGHTS> file for individual copyright information.

The following functions are implemented:

  - `curr_dict`: Identify current hyphen rules language
  - `hyphenate`: Hyphenate a character vector of words
  - `list_dicts`: List available hyphenation languages rules
  - `switch_dict`: Switch hyphen rules language

### Special thanks to

  - @daroczig & @edwindj for language testing.

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
#> [1] '0.4.2'

list_dicts()
#>  [1] "af_ZA"  "bg_BG"  "ca"     "cs_CZ"  "da_DK"  "de"     "de_AT"  "de_CH"  "de_DE"  "el_GR"  "en_GB"  "en_US" 
#> [13] "es_ANY" "et_EE"  "fr"     "gl"     "hr_HR"  "hu_HU"  "id_ID"  "is"     "it_IT"  "lt"     "lt_LT"  "lv_LV" 
#> [25] "nb_NO"  "nl_NL"  "nn_NO"  "pl_PL"  "pt_BR"  "pt_PT"  "ro_RO"  "ru_RU"  "sh"     "sk_SK"  "sl_SI"  "sr"    
#> [37] "sv"     "te_IN"  "uk_UA"  "zu_ZA"

curr_dict()
#> [1] "en_US"

# test word list (10K words)
dat <- readLines(system.file("extdata/top10000en.txt", package="hyphenatr"))

microbenchmark(out1 <- hyphenate(dat))
#> Unit: milliseconds
#>                    expr      min       lq     mean   median       uq      max neval
#>  out1 <- hyphenate(dat) 25.79321 27.80007 29.10339 28.68965 30.22017 37.46743   100

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
#>                                      expr      min       lq     mean   median       uq      max neval
#>  out2 <- hyphenate(dat, simplify = FALSE) 37.32594 38.97343 41.20213 40.32986 42.62161 51.69166   100

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
#>  out3 <- hyphenate(dat, simplify = "-") 38.76724 42.34603 49.87003 48.23965 55.32755 73.66214   100

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
#>                                        expr      min       lq     mean   median       uq      max neval
#>  out4 <- hyphenate(dat, simplify = "&shy;") 45.29019 48.68628 50.84506 50.06046 51.78429 63.37514   100

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

switch_dict("de_DE")

hyphenate("tägelîch")
#> [1] "tä=gelîch"
```

### Test Results

``` r
library(hyphenatr)
library(testthat)

date()
#> [1] "Fri Dec 11 10:31:25 2020"

switch_dict("en_US")

test_dir("tests/")
#> ✓ |  OK F W S | Context
#> ⠏ |   0       | testthat                                                                                                
#> ══ Results ═════════════════════════════════════════════════════════════════════════════════════════════════════════════
#> Duration: 0.4 s
#> 
#> [ FAIL 0 | WARN 0 | SKIP 0 | PASS 0 ]
#> 
#> 🐝 Your tests are the bees knees 🐝
```

### Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
