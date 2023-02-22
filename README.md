# boobook
Experimental package to support accessing the 
[Zotero API v3](https://www.zotero.org/support/dev/web_api/v3/start). So far this
implementation is fairly minimal, but may be extended in future. It is built around 
a tidy workflow and uses the `{tidyverse}` family of packages, namely:

- `{glue}` for string construction
- `{httr2}` for queries
- `{rlang}` for error handling
- `{testthat}` and `{httrtest2}` for testing

## installation
`boobook` is not on CRAN; install using `{remotes}`. It depends on another experimental
package named `{potions}`, also from ALA [repo](https://github.com/AtlasOfLivingAustralia/potions)
```
# install.packages("remotes")
install_github("atlasoflivingaustralia/potions")
install_github("atlasoflivingaustralia/boobook")
library(boobook)
```

## Example usage
`{boobook}` uses a piped syntax. All queries start with a call to `zotero()` and
are enacted via a call to `collect()`

```
zotero() |>
  user(id = "12345") |>
  items()
```

Alternatively, `user_id`, `group_id` or `api_key` can be stored via `zotero_config()`

```
zotero_config(user_id = "12345")

zotero() |>
  user() |>
  tags()
```
