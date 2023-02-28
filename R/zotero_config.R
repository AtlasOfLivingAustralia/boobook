#' Configure a zotero session
#'
#' Simple config stuff
#' @param user_id Unique identifier for users
#' @param group_id Unique identifier for groups
#' @param api_key A Zotero API key
#' @param clear (logical) Should the cache be cleared? This will forget all previous arguments
#' @details This function automatically converts supplied arguments to strings (class `character`).
#' @importFrom potions brew
#' @importFrom potions pour
#' @importFrom potions drain
#' @export
zotero_config <- function(user_id = NULL,
                          group_id = NULL,
                          api_key = NULL,
                          clear = FALSE){

  if(!is.logical(clear)){
    abort("Argument `clear` must be logical")
  }
  if(clear){
    message("Clearing stored data from {boobook}")
    drain(slot_name = "boobook")
  }else{
    empty_check <- c(is.null(user_id), is.null(group_id), is.null(api_key))

    if(all(empty_check)){
      pour(slot_name = "boobook")
    }else{
      x <- list(user_id = user_id,
                group_id = group_id,
                api_key = api_key)[!empty_check]
      brew(slot_name = "boobook", x = lapply(x, as.character))
    }
  }
}
