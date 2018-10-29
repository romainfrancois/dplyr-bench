
#' @export
setup_libs <- function(){
  dir.create("libs")
  dir.create("libs/0.7.7")
  dir.create("libs/0.8.0-unwind")
  dir.create("libs/0.8.0-no-unwind")

  install.packages("dplyr", lib = "libs/0.7.7")

  withr::with_envvar(
    c("DPLYR_COMPILER_FLAGS" = "-URCPP_USE_UNWIND_PROTECT"),
    withr::with_libpaths("libs/0.8.0-no-unwind",
      devtools::install_github("tidyverse/dplyr")
    )
  )

  withr::with_envvar(
    c("DPLYR_COMPILER_FLAGS" = "-DRCPP_USE_UNWIND_PROTECT"),
    withr::with_libpaths("libs/0.8.0-unwind",
      devtools::install_github("tidyverse/dplyr")
    )
  )

}
