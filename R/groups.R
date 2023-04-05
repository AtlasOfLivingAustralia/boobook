#' Add a group to a Zotero API call
#'
#' Designed to be piped following a `zotero()` call.
#' @param .data An object of class `zotero`
#' @export
groups <- function(.data){
  check_zotero_object(.data)
  next_entry <- length(.data) + 1
  .data[next_entry] <- "groups"
  names(.data)[next_entry] <- "groups"
  return(.data)
}
