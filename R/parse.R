# Internal functions to parse queries correctly,
# depending on their source and structure.
# All are called internally by collect.zotero()

#' Internal function to determine which parser to use
#' @importFrom rlang abort
#' @importFrom httr2 resp_body_json
#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows
detect_parser <- function(url){
  # browser()
  url_lookup <- data.frame(
    parser = c("groups", "tags_all", "items_by_tag"),
    regex = paste0(
      "/(users|groups)/([[:digit:]]+)/",
      c(groups = "groups$",
        tags_all = "tags$",
        items_by_tag = "items\\?tag=([[:graph:]]+)$")))
  
  # example <- "/(users|groups)/([[:digit:]]+)/items\\?tags=([[:graph:]]+)$"
  # grepl(example, url)
    
  # example <- "https://api.zotero.org/groups/123345/tags"
  lookup <- lapply(url_lookup$regex, function(a){grepl(a, url)}) |>
    unlist() |>
    which()
  
  if(length(lookup) > 0){
    return(url_lookup$parser[lookup[1]])
  }else{
    abort("Couldn't find a valid parser for this query")
  }
  
}


parse_groups <- function(resp){
  lapply(resp_body_json(resp), function(a){
    cbind(
      as.data.frame(a$data[lengths(a$data) < 2]),
      as.data.frame(a$meta)
    ) |>
    tibble()
  }) |> 
  bind_rows()
}


parse_tags_all <- function(resp){
  lapply(resp_body_json(resp), function(a){
    tibble(
      tag = a$tag,
      link = a$links$self$href,
      n = a$meta$numItems)
  }) |> 
  bind_rows()
}


parse_items_by_tag <- function(resp){
  lapply(resp_body_json(resp), function(a){
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
}
