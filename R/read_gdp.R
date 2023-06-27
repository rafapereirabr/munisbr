#' GDP data
#'
#' Download annual GDP estimates of Brazilian municipalities.
#' 
#' @param year Numeric. Year in the formart YYYY. It can also take a vector with 
#'        the period of the data, such as `c(2010, 2015)`. Defaults to the last 
#'        year available.
#'
#' @family Economic data
#'
#' @examplesIf identical(tolower(Sys.getenv("NOT_CRAN")), "true")
#' library(munisbr)
#' 
#' gdp_br <- read_gdp(year = 2020)
#' head(gdp_br)
#'
#' @export
read_gdp <- function(year){
  
  # check inputs
  checkmate::assert_numeric(year)
  year <- as.character(year)
  
  # download data
  suppressMessages(
    df_raw <- sidrar::get_sidra(period = year,
                                x = 5938, # table,
                                variable = 37,
                                geo = "City", 
                                format = 3
                                )
                              )

  # rename muni columns
  df <- rename_muni_columns(df_raw)
  data.table::setnames(df, "Valor", "gdp_thousands")

  # select columns
  df <- df[, .(year, code_muni, name_muni, gdp_thousands)]
  
  # recode muni columns
  recode_muni_columns(df)

    # reorder columns
  data.table::setcolorder(df, c('year', 'abbrev_state', 'code_state', 'code_muni', 'name_muni', 
                                'gdp_thousands'))
  
  return(df)
}
  