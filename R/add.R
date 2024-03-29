#' Configure a Zotero API call
#'
#' Functions to allow the user to specify which identifiers should be passed to
#' an API call.
#' @param .data An object of class `zotero`
#' @param ... fields to be pulled from `zotero_config` (optional)
#' @param user_id Optionally specify the user ID
#' @param group_id Optionally specify the group ID
#' @param api_key Optionally specify the API key
#' @details `add_config()` is a catch-all function that tries to do sensible things
#' when passing user data to a `zotero` call. Alternatively, the microfunctions
#' `add_user()`, `add_group()` and `add_key()` each add individual pieces of
#' information, with fewer checks.
#'
#' Regardless of which function is used, specifying any of `user_id`, `group_id`
#' or `api_key` will overrule use of the defaults as stored in `zotero_config()`.
#' In such cases, however, the defaults stored in `zotero_config` will not
#' themselves be overwritten.
#' @importFrom glue glue
#' @importFrom glue glue_collapse
#' @importFrom rlang as_label
#' @importFrom rlang enquos
#' @export
add_config <- function(.data, ..., user_id, group_id, api_key){

  # TODO:
  # write `boobook` package help
  # write tests for `add_config` as it has complex behaviour
  # change all piped functions to use `.data`, not `x` as first argument

  check_zotero_object(.data)
  dots <- enquos(..., .ignore_empty = "all") |>
    lapply(as_label) |>
    unlist() |>
    dequote()

  # if the user supplies field names via ...,
  # take them from `zotero_config()` via `pour()`
  if(length(dots) > 0){
    # check supplied arguments are valid
    dots_ok <- dots %in% c("user_id", "group_id", "api_key")
    if(all(dots_ok)){

      # if(all(c("user_id", "group_id") %in% dot_vec)){
      #   abort("please specify one of `user_id` or `group_id`, but not both")
      # }

      # extract the requested info from `zotero_config()`
      result <- lapply(seq_along(dots), function(a){
        current_arg <- dots[a]
        x <- pour(current_arg)
        if(is.null(x)){
          # abort if this information doesn't exist
          bullets <- c(
            glue("Argument `{current_arg}` has not been specified"),
            i = glue("Try using `zotero_config()` to set `{current_arg}` globally")
          )
          abort(bullets)
        }else{
          switch(current_arg,
                 "group_id" = glue("groups/{x}"),
                 "user_id" = glue("users/{x}"),
                 "api_key" = x)
        }
      })
      names(result) <- dots
      # if supplied names are invalid, abort
    }else{
      invalid_fields <- glue_collapse(dots[!dots_ok], sep = ", ", last = " and ")
      bullets <- c(
        glue("Invalid fields detected: {invalid_fields}"),
        i = "Valid fields are `user_id`, `group_id` or `api_key`") |>
        abort()
    }
  }else{
    # if no dots are given, then create an empty list to fill with other args
    result <- list()
  }

  # take named arguments and add to `result`
  # Note: putting this after the dots processing step is deliberate,
  # as it ensures defaults are overwritten by default
  if(!missing(user_id)){
    result$user_id <- glue("users/{user_id}")
  }
  if(!missing(group_id)){
    result$group_id <- glue("groups/{group_id}")
  }
  if(!missing(api_key)){
    result$add_api_key <- api_key
  }

  # both user_id and group_id cannot be specified at once
  # note: This is because we rely on `add_config()` to tell us what query to run
  # it is different behaviour from zotero_config(), which simply stores info
  # if both `user_id` and `group_id` are set - even via different means - abort
  if(all(c("user_id", "group_id") %in% names(result))){
    abort("both `user_id` and `group_id` are set; please choose one")
  }else{
    id_entry <- which(names(result) %in% c("user_id", "group_id"))[1]
    names(result)[id_entry] <- "user_or_group_id"
  }

  # if all args are missing, then abort
  if(length(result) < 1){
    abort("`add_config()` requires a `user_id` or `group_id` to work")
  }else{
    out <- c(.data, result)
    class(out) <- "zotero"
    return(out)
  }
}

#' @rdname add_config
#' @importFrom glue glue
#' @export
add_user <- function(.data, user_id){
  check_zotero_object(.data)
  user_id <- check_supplied_id(user_id, type = "user_id")
  .data$user_or_group_id <- glue("users/{user_id}")
  return(.data)
}

#' @rdname add_config
#' @importFrom glue glue
#' @export
add_group <- function(.data, group_id){
  check_zotero_object(.data)
  group_id <- check_supplied_id(group_id, type = "group_id")
  .data$user_or_group_id <- glue("groups/{group_id}")
  return(.data)
}

#' @rdname add_config
#' @export
add_key <- function(.data, api_key){
  check_zotero_object(.data)
  api_key <- check_supplied_id(api_key, type = "api_key")
  .data$api_key <- api_key
  return(.data)
}

# remove quote marks
dequote <- function(x){
  quoting_regex <- grepl("(^\").+(\"$)", x)
  if(any(quoting_regex)){
    quotes_tr <- which(quoting_regex)
    x[quotes_tr] <- gsub("(^\")|(\"$)", "", x[quotes_tr])
  }
  x
}
