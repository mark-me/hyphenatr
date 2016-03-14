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
