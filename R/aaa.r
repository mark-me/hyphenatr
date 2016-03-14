.onLoad<- function(libname, pkgname) {
  if (interactive()) packageStartupMessage("Loading hyphenation rules...")
  invisible(.Call('hyphenatr_init', PACKAGE = 'hyphenatr',
        system.file("extdata/dicts/hyph_en_US.dic", package="hyphenatr")))
}

.onUnload <- function (libpath) {
  if (interactive()) message("Unloading hyphenation rules...")
  invisible(.Call('hyphenatr_cleanup', PACKAGE = 'hyphenatr'))
  library.dynam.unload("hyphenatr", libpath)
}
