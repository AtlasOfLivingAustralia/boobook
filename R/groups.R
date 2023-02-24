#' Add a group to a Zotero API call
#'
#' Designed to be piped following a `zotero()` call.
#' @param x An object of class `zotero`
#' @export
groups <- function(x, id){
  check_zotero_object(x)

  # if this function occurs straight after `zotero()`,
  # it should be used to specify an id
  if(length(x) == 1 & names(x)[1] == "base_url"){
    check_supplied_id(id, type = "group_id")
    x$user_or_group_id <- paste0("groups/", id)

  # if the function occurs later in the pipe, add 'groups'
  # in practice this only occurs in once case;
  # to find all groups a user has access to.
  }else{
    next_entry <- length(x) + 1
    x[next_entry] <- "groups"
    names(x)[next_entry] <- "groups"
  }

  return(x)
}
