% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zotero_config.R
\name{zotero_config}
\alias{zotero_config}
\title{Configure a zotero session}
\usage{
zotero_config(user_id, group_id, api_key, clear = FALSE)
}
\arguments{
\item{user_id}{(character) Unique identifier for users}

\item{group_id}{(character) Unique identifier for groups}

\item{api_key}{(character) A Zotero API key}

\item{clear}{(logical) Should the cache be cleared? This will forget all
previous arguments}
}
\description{
Store configuration options such as \code{user_id}, \code{group_id} or \code{api_key} that
can be used later without manual specification in each pipe. Alternatively,
a path to a configuration \code{file}
}
\details{
This function automatically converts supplied arguments to strings
(class \code{character}).
}
