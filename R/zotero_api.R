# Everything in this script is old code - do not export

#' Early code to collect zotero groups
#' @keywords internal
#' @noRd
zotero_groups <- function(user_id, api_key){

  if(missing(user_id)){
    stop("`user_id` is missing, with no default")}

  if(missing(api_key)){
    stop("`api_key` is missing, with no default")}

  url <- glue("https://api.zotero.org/users/{user_id}/groups")

  group_list <- request(url) |>
    req_headers("Zotero-API-Key" = api_key) |>
    req_perform() |>
    resp_body_json()

  result <- lapply(group_list, function(a){
    cbind(
      as.data.frame(a$data[lengths(a$data) < 2]),
      as.data.frame(a$meta)
    ) |>
      tibble()
  }) |> bind_rows()

  return(result)
}


#' early code to collect zotero tags
#' @keywords internal
#' @noRd
zotero_tags <- function(user_id, group_id, api_key){

  if(missing(user_id) & missing(group_id)){
    stop("one of `user_id` or `group_id` must be set")}

  if(!missing(user_id) & !missing(group_id)){
    message("both `user_id` and `group_id` are set; defaulting to `group_id`")}

  if(missing(api_key)){
    stop("`api_key` is missing, with no default")} # note: this should only be needed for private repos

  base_url <- "https://api.zotero.org"
  if(!missing(group_id)){
    url <- glue("{base_url}/groups/{group_id}/tags")
  }else{
    url <- glue("{base_url}/users/{user_id}/tags")
  }

  tags_list <- request(url) |>
    req_headers("Zotero-API-Key" = api_key) |>
    req_perform() |>
    resp_body_json()

  tag_df <- lapply(tags_list, function(a){
    tibble(
      tag = a$tag,
      link = a$links$self$href,
      n = a$meta$numItems)
  }) |> bind_rows()

  return(tag_df)
}


#' Early code to collect zotero items listed under a specific tag
#' @keywords internal
#' @noRd
zotero_items_by_tag <- function(user_id, group_id, api_key, tag){

  if(missing(user_id) & missing(group_id)){
    stop("one of `user_id` or `group_id` must be set")}

  if(!missing(user_id) & !missing(group_id)){
    message("both `user_id` and `group_id` are set; defaulting to `group_id`")}

  base_url <- "https://api.zotero.org"
  if(!missing(group_id)){
    url <- glue("{base_url}/groups/{group_id}/items?tag={tag}")
  }else{
    url <- glue("{base_url}/users/{user_id}/items?tag={tag}")
  }

  req <- request(url) |>
    req_headers("Zotero-API-Key" = api_key)

  data_list <- req_perform(req) |>
    resp_body_json()

  data_df <- lapply(data_list, function(a){
    x <- a$data
    if(any(names(x) == "itemType")){
      if(x$itemType == "journalArticle"){
        result <- as.data.frame(x[lengths(x) == 1]) |> tibble()
        creators <- lapply(x$creators, as.data.frame) |>
          bind_rows() |>
          tibble()
        result$creators <- list(creators)
        return(result)
      }else{NULL}
    }else{NULL}
  }) |>
  bind_rows()

  return(data_df)
}


#' Zotero attachments listed under a given itemKey
#' @keywords internal
#' @noRd
zotero_attachments <- function(user_id, group_id, api_key, item_key){

  if(missing(user_id) & missing(group_id)){
    stop("one of `user_id` or `group_id` must be set")}

  if(!missing(user_id) & !missing(group_id)){
    message("both `user_id` and `group_id` are set; defaulting to `group_id`")}

  base_url <- "https://api.zotero.org"
  if(!missing(group_id)){
    url <- glue("{base_url}/groups/{group_id}/items/{item_key}/children")
  }else{
    url <- glue("{base_url}/users/{user_id}/items/{item_key}/file")
  }

  req <- request(url) |>
    req_headers("Zotero-API-Key" = api_key) |>
    req_perform() |>
    resp_body_json()

  file_url <- req[[1]]$links$enclosure$href
  file_name <- req[[1]]$data$title

  result <- request(file_url) |>
    req_headers("Zotero-API-Key" = api_key) |>
    req_perform(path = glue("./data-raw/{file_name}"))
}
