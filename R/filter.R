#' Filter a Zotero query
#'
#' Test port from {dplyr}
#' @param .data An object of class `zotero`
#' @param ... additional
#' importFrom glue glue
#' @export
filter.zotero <- function(.data, ...){
  # basic checks
  check_zotero_object(.data)
  next_entry <- length(.data) + 1

  # handle ...
  dots <- list(...)
  result_list <- vector(mode = "list", length = length(dots))
  for(i in seq_along(dots)){
    field <- names(dots)[i]
    value <- dots[[i]]
    result_list[[i]] <- glue("?{field}={value}")
  }
  names(result_list) <- names(dots)

  # return
  result <- c(.data, result_list)
  class(result) <- "zotero"
  result
}
