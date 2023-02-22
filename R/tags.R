#' Download tag data from Zotero
#'
#' First attempt
#' @param x An object of class `zotero`
#' @importFrom dplyr bind_rows
#' @importFrom glue glue
#' @importFrom httr2 request
#' @importFrom httr2 req_headers
#' @importFrom httr2 req_perform
#' @importFrom httr2 resp_body_json
#' @export
tags <- function(x){

  base_url <- pour("base_url", "boobook")
  url <- glue("{base_url}/{x$user_or_group_id}/tags")

  tags_list <- request(url) |>
    req_headers("Zotero-API-Key" = api_key) |> # this stage should be dependent on requirement
    req_perform() |>
    resp_body_json()

  tag_df <- lapply(tags_list, function(a){
    tibble(
      tag = a$tag,
      link = a$links$self$href,
      n = a$meta$numItems)
  }) |> bind_rows()

}

## is there a way to check this is actually required?
# check_api_key <- function(x){
#   if(is.null(x$api_key)){
#     stored_api <- pour("api_key", slot_name = "boobook")
#     if(is.null(stored_api)){
#       abort("`api_key` is missing, with no default; set using `zotero_config()")
#     }
#   }
# }
