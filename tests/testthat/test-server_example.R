test_that("Server-side example works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  skip_if(is.null(chromote::find_chrome()))

  example_dir <- system.file("examples", "server", package = "howler")
  app <- shinytest2::AppDriver$new(example_dir, name = "howler_app")
  on.exit(app$stop())

  Sys.sleep(1L)

  expect_false(app$get_value(input = "sound_playing"))
  expect_identical(app$get_value(input = "sound_seek"), 0L)
  expect_gte(app$get_value(input = "sound_duration"), 0L)

  app$click(selector = "#add_track")
  Sys.sleep(1L)
  expect_identical(app$get_value(input = "sound_track")$name, "running_out A")
})
