#' Add tag data to a Zotero API call
#'
#' First attempt
#' @param x An object of class `zotero`
#' @export
tags <- function(x){
  check_zotero_object(x)
  next_entry <- length(x) + 1
  x[next_entry] <- "tags"
  names(x)[next_entry] <- "tags"
  x
  ## alternatively:
  # c(x, list("tag" = "tag")) # less code, but more copying (?)
}
