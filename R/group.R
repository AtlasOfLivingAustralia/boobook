#' Add a group to a Zotero API call
#'
#' Designed to be piped following a `zotero()` call.
#' @param x An object of class `zotero`
#' @param id User ID. Can be left blank if zotero_config(group_id) has been set.
#' @importFrom glue glue
#' @importFrom rlang abort
#' @export
group <- function(x, id){
  if(missing(id)){
    id <- pour("group_id", slot_name = "boobook")
    if(is.null(id)){
      abort("`id` is missing, with no default")
    }
  }
  x$user_or_group_id <- as.character(glue("groups/{id}"))
  return(x)
}
