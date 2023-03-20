#' Tools for calling the Zotero API (v3)
#'
#' @description
#' Zotero (https://www.zotero.org) is a bibliographic management tool. It
#' includes an online version whereby data can be accessed through an API.
#'
#' To import data exported from a desktop version of Zotero - where files are
#' stored locally - try using `{synthesisr}` instead.
#'
#' @name boobook
#' @docType package
#' @section Functions:
#' **Infrastructure**
#'
#'    * [zotero_config()] Store information on user or group IDs, or API keys
#'    * [zotero()] Start a pipe
#'    * [configure()] Specify which identifiers to pass to the API
#'    * [collect.zotero()] Make an API call
#'
#' **Specify required data**
#'
#'    * [groups()]
#'    * [items()]
#'    * [collections()]
#'    * [tags()]
#'    * [filter.zotero()] Filtering (may not work properly yet)
#'
NULL
