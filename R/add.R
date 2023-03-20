#' @rdname configure
#' @importFrom glue glue
#' @export
add_user <- function(.data, user_id){
  check_zotero_object(.data)
  user_id <- check_supplied_id(user_id, type = "user_id")
  .data$user_or_group_id <- glue("users/{user_id}")
  return(.data)
}

#' @rdname configure
#' @importFrom glue glue
#' @export
add_group <- function(.data, group_id){
  check_zotero_object(.data)
  group_id <- check_supplied_id(group_id, type = "group_id")
  .data$user_or_group_id <- glue("groups/{group_id}")
  return(.data)
}

#' @rdname configure
#' @export
add_key <- function(.data, api_key){
  check_zotero_object(.data)
  api_key <- check_supplied_id(api_key, type = "api_key")
  .data$api_key <- api_key
  return(.data)
}
