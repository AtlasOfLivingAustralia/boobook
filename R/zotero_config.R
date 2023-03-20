#' Configure a zotero session
#'
#' Store configuration options such as `user_id`, `group_id` or `api_key` that
#' can be used later without manual specification in each pipe. Alternatively,
#' a path to a configuration `file`
#' @param user_id (character) Unique identifier for users
#' @param group_id (character) Unique identifier for groups
#' @param api_key (character) A Zotero API key
#' @param clear (logical) Should the cache be cleared? This will forget all
#' previous arguments
#' @details This function automatically converts supplied arguments to strings
#' (class `character`).
#' @importFrom potions brew
#' @importFrom potions pour
#' @importFrom potions drain
#' @export
zotero_config <- function(user_id,
                          group_id,
                          api_key,
                          clear = FALSE){

  if(!is.logical(clear)){
    abort("Argument `clear` must be logical")
  }
  if(clear){
    message("Clearing stored data from {boobook}")
    drain()
  }else{
    # updates needed below to deal with case when `file` is supplied
    # or does this go in `potions`?
    if(missing(user_id)){user_id <- NULL}
    if(missing(group_id)){group_id <- NULL}
    if(missing(api_key)){api_key <- NULL}
    empty_check <- c(is.null(user_id), is.null(group_id), is.null(api_key))

    if(all(empty_check)){
      pour()
    }else{
      x <- list(user_id = user_id,
                group_id = group_id,
                api_key = api_key)[!empty_check]
      brew(lapply(x, as.character))
    }
  }
}
