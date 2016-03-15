#' @export
switch_dict <- function(code) {

}

#' List available hyphenation dictionaries
#'
#' @export
list_dicts <- function() {

  sort(gsub("(^.*_|\\.dic$)", "",
            list.files(system.file("extdata/dicts",
                                   package="hyphenatr"))))

}


#' Hyphenate a character vector of words
#'
#' Given a character vector (one word per element), this function
#' will hyphenate the strings or return a list of separated
#' hyphenated string components.
#'
#' @param words character vector of words
#' @param simplify if \code{TRUE}, will return \code{words} with
#'        \code{=} as the hyphen character. If \code{FALSE}, will
#'        return a list of separated, hyphenated word components.
#'        If a string (e.g. "\code{-}", "\code{&shy;}" or '\code{&#173;}")
#'        will use that character for the hyphen character.)
#' @return a character vector or a list depending on the value of
#'         \code{simplify}.
#' @export
#' @examples
#' dat <- readLines(system.file("extdata/top10000en.txt", package="hyphenatr"))
#'
#' out1 <- hyphenate(dat)
#' out2 <- hyphenate(dat, simplify=FALSE)
#' out3 <- hyphenate(dat, simplify="-")
#' out4 <- hyphenate(dat, simplify="&shy;")
hyphenate <- function(words, simplify=TRUE) {

  out <- .Call('hyphenatr_hyphenate', words, PACKAGE = 'hyphenatr')

  if (inherits(simplify, "logical")) {
    if (!simplify) {
      stri_split_regex(out, "=")
    } else {
      out
    }
  } else {
    stri_replace_all_regex(out, "=", simplify)
  }

}

