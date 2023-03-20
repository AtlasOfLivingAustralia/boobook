.onLoad <- function(libname, pkgname) {
  if(pkgname == "boobook") {
    potions::brew(.pkg = "boobook")
  }
}
