#' Filter a Zotero query
#' 
#' Test port from {dplyr}
#' @param .data An object of class `zotero`
#' @param ... additional 
#' @export
filter.zotero <- function(.data, ...){
  # basic checks
  check_zotero_object(.data)
  next_entry <- length(.data) + 1
  
  # handle ...
  dots <- list(...)
  result_list <- vector(mode = "list", length = length(dots))
  for(i in seq_along(dots)){
    result_list[[i]] <- paste0("?", names(dots)[i], "=",  dots[[i]])
  }
  names(result_list) <- names(dots)
  
  # return
  result <- c(.data, result_list)
  class(result) <- "zotero"
  result
}