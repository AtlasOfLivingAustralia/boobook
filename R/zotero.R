#' Start a pipe for querying Zotero
#'
#' This function creates an object of class 'zotero', which can then be used
#' to pipe arguments to construct and enact a query
#' @export
zotero <- function(){
  x <- list()
  class(x) <- "zotero"
  return(x)
}
