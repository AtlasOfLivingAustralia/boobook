test_that("add_config() requires a zotero object", {
  expect_error(add_config())
})

test_that("add_config() fails when wrong arguments provided", {
  expect_error(add_config(zotero(), "something"))
})

test_that("add_config() fails when user_id requested but not set", {
  expect_error(add_config(zotero(), "user_id"))
})

test_that("add_config() fails when api_key requested but not set", {
  expect_error(add_config(zotero(), "api_key"))
})

test_that("add_config() fails when user_id and group_id are both set (using ...)", {
  zotero_config(user_id = "1234", group_id = "5678")
  expect_error(add_config(zotero(), "user_id", "group_id"))
})

test_that("add_config() fails when user_id and group_id are both set (using named args)", {
  expect_error(add_config(zotero(), user_id = "1234", group_id = "1234"))
})
