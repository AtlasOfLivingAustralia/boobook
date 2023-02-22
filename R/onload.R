.onLoad <- function(libname, pkgname) {
    if (pkgname == "galah") {
      zotero_config(base_url =  "https://api.zotero.org")
    }
}
