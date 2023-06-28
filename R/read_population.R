#' Population data
#'
#' Download annual population estimates of Brazilian municipalities.
#' 
#' @param year Numeric. Year in the formart YYYY. It can also take a vector with 
#'        the period of the data, such as `c(2010, 2015)`. Defaults to the last 
#'        year available.
#'
#' @family Demographic data
#'
#' @examplesIf identical(tolower(Sys.getenv("NOT_CRAN")), "true")
#' library(munisbr)
#' 
#' pop_br <- read_population(year = 2020)
#' head(pop_br)
#'
#' @export
read_population <- function(year){
  
  # check inputs
  checkmate::assert_numeric(year)
  year <- as.character(year)
  
  # download data
  suppressMessages(
    df_raw <- sidrar::get_sidra(period = year,
                                x = 6579, # table,
                                variable = 9324,
                                geo = "City", 
                                format = 3
                                )
                              )
  
  # ceck result
  if (nrow(df_raw) == 0) {stop("Data not available for this year.")}
  
  # rename muni columns
  df <- rename_muni_columns(df_raw)
  data.table::setnames(df, "Valor", "population")
  
  # select columns
  df <- df[, .(year, code_muni, name_muni, population)]
  
  # recode muni columns
  recode_muni_columns(df)
  
  # reorder columns
  data.table::setcolorder(df, c('year', 'abbrev_state', 'code_state', 'code_muni', 'name_muni', 
                                'population'))
  
  return(df)
}
  