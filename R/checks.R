# Script containing internal functions to check various objects,
# and return associated errors where applicable

#' @importFrom rlang abort
check_zotero_object <- function(x){
  if(missing(x)){
    bullets <- c("Object `.data` is missing, with no default",
                 i = "Pipes made with `{boobook}` should start with `zotero()`")
    abort(bullets)
  }else{
    if(!inherits(x, "zotero")){
      abort("Pipes made with `{boobook}` should start with `zotero()`")
    }
  }
}

check_id_present <- function(x){
  if(!any(names(x) == "user_or_group_id")){
    bullets <- c("please specify either a user or group ID",
                 i = "These parameters can be set globally via `zotero_config()`",
                 i = "You can specify a user ID in pipe using `user()`, or group ID using `group()`")
    abort(bullets)
  }
}

check_supplied_id <- function(id, type){
  if(missing(id)){
    id <- pour(type, slot_name = "boobook")
    if(is.null(id)){
      abort("`id` is missing, with no default")
    }
  }
  return(id)
}

## is there a way to check whether an API key is actually required?
# check_api_key <- function(x){
#   if(is.null(x$api_key)){
#     stored_api <- pour("api_key", slot_name = "boobook")
#     if(is.null(stored_api)){
#       abort("`api_key` is missing, with no default; set using `zotero_config()")
#     }
#   }
# }
