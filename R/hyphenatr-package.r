#' Tools to Hyphenate Strings Using the 'Hunspell' Hyphenation Library
#'
#' Identifying hyphenation points in strings can be useful for both
#' text processing and display functions. The 'Hunspell' hyphenation library
#' provides tools to perform hyphenation using custom language rule dictionaries.
#' Words can be hyphenated directly or split into hyphenated component strings
#' for further processing.
#'
#' @name hyphenatr
#' @docType package
#' @author Bob Rudis (@@hrbrmstr)
#' @useDynLib hyphenatr
#' @importFrom Rcpp sourceCpp
#' @importFrom stringi stri_split_regex stri_replace_all_regex
NULL
