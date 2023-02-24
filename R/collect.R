#' Collect data from Zotero
#'
#' Function to catch data from pipes, pass to Zotero API, and return a tibble
#' @param x An object of class `zotero`
#' @param path An (optional) path to download files to
#' @importFrom dplyr bind_rows
#' @importFrom httr2 request
#' @importFrom httr2 req_headers
#' @importFrom httr2 req_perform
#' @importFrom httr2 resp_body_json
#' @export
collect <- function(x, path){

  # Issues:
  # make tags just add `/tag`
  # ditto `item(id = "12345")`, collection(id = "12345") etc
  # add `collect()` to glue together these tags (in order) and actually run the query
  # challenge will then be to ensure that parsing is correct for different object types
  # another change will be in UI; how does the user know which combinations are valid?

  # input checks
  check_zotero_object(x)
  check_id_present(x)

  # construct a url in order that suffixes are provided
  req <- paste(unlist(x), collapse = "/") |>
         request()

  # probably worth checking if url is 'valid', somehow?

  # add API key, if one has been specified
  if(!is.null(pour("api_key", "boobook"))){
    req <- req |> req_headers("Zotero-API-Key" = api_key)
  }

  # run the query
  if(missing(path)){
    req_perform() |> resp_body_json() # |> parse_to_tibble_somehow() ?
  }else{
    req_perform(path = path)
  }

}
