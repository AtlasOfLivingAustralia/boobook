#' Add item data to a Zotero API call
#'
#' First attempt
#' @param x An object of class `zotero`
#' @param id An (optional) id to look up
#' @export
items <- function(x, id){
  # basic checks
  check_zotero_object(x)
  next_entry <- length(x) + 1

  # if an id is specified, add that next
  str_value <- "items"
  if(missing(id)){
    value <- str_value
  }else{
    value <- paste(str_value, id, sep = "/")
  }

  # add to x and return
  x[next_entry] <- value
  names(x)[next_entry] <- str_value
  x
}
