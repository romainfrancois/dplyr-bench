#' @import dplyr
#' @import purrr
#'
#' @export
benchs <- function(setup, code){
  setup <- substitute(setup)
  code  <- substitute(code)

  f <- function(){}
  body(f) <- substitute({
    library(dplyr)
    setup
    bench::mark(code)
  }, list(setup = setup, code = code))

  libs <- list.files("libs", full.names = TRUE)

  suppressWarnings({
    map_dfr(libs, ~callr::r(f, libpath = .)) %>%
      mutate(version = !!basename(libs)) %>%
      select(version, everything())
  })
}
