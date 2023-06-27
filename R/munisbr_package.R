#' munisbr: Download Official Socioeconomic Data of Brazilian Municipalities
#'
#' Downloads  official data of socioeconomic and population characteristics of 
#' Brazilian municipalities. The package offers a set of convenient functions to 
#' download IBGE's data through the "sidrar package.
#'
#' @section Usage:
#' Please check the vignettes and data documentation on the
#' [website](https://ipeagit.github.io/munisbr/index.html).
#'
#' @docType package
#' @name munisbr
#' @aliases munisbr-package
#'
#' @importFrom data.table := %chin% fifelse
#' @importFrom sidrar get_sidra
#' @importFrom utils globalVariables
#' 
#' @keywords internal
"_PACKAGE"


## quiets concerns of R CMD check re: the .'s that appear in pipelines
utils::globalVariables( c('.',
                          'abbrev_state',
                          'code_muni',
                          'code_state',
                          'name_muni',
                          'population',
                          'gdp_thousands'
                          ) )

