.pkgenv <- new.env(parent=emptyenv())

.onLoad<- function(libname, pkgname) {
  assign("curr_lang", "en_US", envir=.pkgenv)
  if (interactive()) packageStartupMessage("Loading hyphenation rules...")
  invisible(.Call('hyphenatr_init', PACKAGE = 'hyphenatr',
        system.file("extdata/dicts/hyph_en_US.dic", package="hyphenatr")))
}

.onUnload <- function (libpath) {
  if (interactive()) message("Unloading hyphenation rules...")
  invisible(.Call('hyphenatr_cleanup', PACKAGE = 'hyphenatr'))
  library.dynam.unload("hyphenatr", libpath)
}