#' Add a user to a Zotero API call
#'
#' Designed to be piped following a `zotero()` call.
#' @param x An object of class `zotero`
#' @param id User ID. Can be left blank if zotero_config(user_id) has been set.
#' @export
users <- function(x, id){
  check_zotero_object(x)
  check_supplied_id(id, type = "user_id")
  x$user_or_group_id <- paste0("users/", id)
  return(x)
}
