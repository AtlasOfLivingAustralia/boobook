test_that("configure() requires a zotero object", {
  expect_error(configure())
})

test_that("configure() fails when wrong arguments provided", {
  expect_error(configure(zotero(), "something"))
})

test_that("configure() fails when user_id requested but not set", {
  expect_error(configure(zotero(), "user_id"))
})

test_that("configure() fails when api_key requested but not set", {
  expect_error(configure(zotero(), "api_key"))
})

test_that("configure() fails when user_id and group_id are both set (using ...)", {
  zotero_config(user_id = "1234", group_id = "5678")
  expect_error(configure(zotero(), "user_id", "group_id"))
})

test_that("configure() fails when user_id and group_id are both set (using named args)", {
  expect_error(configure(zotero(), user_id = "1234", group_id = "1234"))
})
