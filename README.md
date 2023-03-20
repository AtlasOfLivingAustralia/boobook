# boobook
Experimental package to support accessing the 
[Zotero API v3](https://www.zotero.org/support/dev/web_api/v3/start). So far this
implementation is fairly minimal, but may be extended in future.

## Installation
`{boobook}` is not on CRAN (yet); install using `{remotes}`. It depends on another experimental
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
  configure(user_id = "12345") |>
  items() |>
  collect()
```

Alternatively, `user_id`, `group_id` or `api_key` can be stored via `zotero_config()`

```
zotero_config(user_id = "12345")

zotero() |>
  configure("user_id") |> # `add_user()` (no args) would work the same way
  tags() |> 
  collect()
```

Some example use cases:
```
zotero_config(api_key = "6789")

# find user ID and privileges of a specified API key
# NOTE: not implemented yet
zotero() |> 
  add_key() |> 
  keys() |>
  collect()
zotero_config(user_id = "12345") # add to config

# find what groups are available
zotero() |> 
  configure("user_id", "api_key") |>
  groups() |> 
  collect()
zotero_config(group_id = "ABCD") # add to config

# find tags for a specified group
zotero() |> 
  add_group() |> 
  add_key() |>
  tags() |> 
  collect()

# find items in a group with a specific tag
# NOTE: not implemented yet
zotero() |> 
  add_group() |> 
  add_key() |>
  items() |> 
  tags(id = "tag+name")
```

## Dependencies

`{boobook}` is built around a tidy workflow and relies on the following packages:

- `{httr2}` for queries
- `{rlang}` for error handling
- `{testthat}` and `{httrtest2}` for testing
