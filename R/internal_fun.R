#' @keywords internal
rename_muni_columns <- function(df_raw) {

  df <- data.table::copy(df_raw)
  
  # remove accents
  names(df) <- stringi::stri_trans_general(names(df), id = "Latin-ASCII")
  
  # rename columns
  data.table::setDT(df)
  data.table::setnames(df, "Municipio (Codigo)", "code_muni")
  data.table::setnames(df, "Municipio", "name_muni")
  data.table::setnames(df, "Ano", "year")
  
  return(df)
}


#' @keywords internal
recode_muni_columns <- function(df) {
  
  df[, code_state := substring(code_muni, 1, 2)]
  df[, abbrev_state := substring(name_muni, nchar(name_muni)-2, nchar(name_muni))]
  df[, name_muni := substring(name_muni, 1, nchar(name_muni)-5)]
}
