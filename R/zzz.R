.onAttach <- function (lib, pkg){
  packageStartupMessage("This is biotic, dev version ",
                        utils::packageDescription("biotic", fields="Version"),
                        appendLF = TRUE)
}
