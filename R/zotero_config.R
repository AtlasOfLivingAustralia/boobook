#' Configure a zotero session
#'
#' Simple config stuff
#' @param x a list of configurable options
#' @importFrom potions brew
#' @importFrom potions pour
#' @export
zotero_config <- function(user_id = NULL,
                          group_id = NULL,
                          api_key = NULL){

  empty_check <- c(is.null(user_id), is.null(group_id), is.null(api_key))

  if(all(empty_check)){
    pour(slot_name = "boobook")
  }else{
    x <- list(user_id = user_id,
              group_id = group_id,
              api_key = api_key)[!empty_check]
    brew(slot_name = "boobook", x = x)
  }
}
