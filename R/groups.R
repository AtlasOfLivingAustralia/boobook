#' Add a group to a Zotero API call
#'
#' Designed to be piped following a `zotero()` call.
#' @param .data An object of class `zotero`
#' @export
groups <- function(.data){
  x <- .data
  check_zotero_object(x)
  next_entry <- length(x) + 1
  x[next_entry] <- "groups"
  names(x)[next_entry] <- "groups"
  return(x)
}
