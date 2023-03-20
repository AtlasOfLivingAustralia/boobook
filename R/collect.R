#' Collect data from Zotero
#'
#' Function to catch data from pipes, pass to Zotero API, and return a tibble
#' @param .data An object of class `zotero`
#' @param path An (optional) path to download files to
#' @importFrom httr2 request
#' @importFrom httr2 req_headers
#' @importFrom httr2 req_perform
#' @export
collect.zotero <- function(.data, path){

  x <- .data
  # input checks
  check_zotero_object(x)
  check_id_present(x)

  # if the user has added an API key to their path,
  # ensure it is handled correctly by setting `use_api`,
  # then remove from x
  if(any(names(x) == "api_key")){
    use_api <- TRUE
    supplied_api_key <- x[["api_key"]]
    x <- x[which(names(x) != "api_key")] # remove api info from x
  }else{
    use_api <- FALSE
  }

  # construct a url in order that suffixes are provided
  url <- construct_url(x)
  parser <- detect_parser(url)
  if(is.null(parser)){
    abort("Couldn't find a valid parser for this query")
  }
  req <- request(url)

  # add API key, if one has been specified
  if(use_api & !is.null(supplied_api_key)){
    req <- req |> req_headers("Zotero-API-Key" = supplied_api_key)
  }

  # run the query
  # Q: how to add `path` here?
  result <- req_perform(req)
  do.call(paste0("parse_", parser), list(result))
}


construct_url <- function(x){
  result <- paste(unlist(x), collapse = "/")
  gsub("\\/\\?", "\\?", result)
}
