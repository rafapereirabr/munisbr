
#' docs api
#' https://apisidra.ibge.gov.br/home/ajuda
#' 
#' 
#' git
#' https://github.com/rpradosiqueira/sidrar



# [15] "Tabela 138 - População residente por grupos de idade, tipo de deficiência, sexo e situação"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
# [16] "Tabela 139 - População residente por grupos de idade, religião, sexo e situação"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     

a <-  sidrar::search_sidra('nascimentos')
a[a %like% 'Residente']

b <-  sidrar::info_sidra(2609)
c <- b$variable



df_raw <- sidrar::get_sidra(period = year,
                             x = 2609, # table,
                              variable = 217,
                             geo = "City", 
                             format = 3
                             )
head(df_raw)



##### tabelas disponiveis ------------------------

https://sidra.ibge.gov.br/Acervo?nivel=6&unidade=1100015#/S/Q


##### Coverage ------------------------
# library(uci)
library(testthat)
library(covr)
Sys.setenv(NOT_CRAN = "true")


# each function separately
t1 <- covr::function_coverage(fun=uci, test_file("tests/testthat/test_uci.R"))
# t2 <- covr::function_coverage(fun=read_airports, test_file("tests/testthat/test_read_airports.R"))
t1

# nocov start

# nocov end

# the whole package
Sys.setenv(NOT_CRAN = "true")
cov <- covr::package_coverage(path = ".", type = "tests", clean = FALSE)
cov

rep <- covr::report()

x <- as.data.frame(cov)
covr::codecov( coverage = cov, token ='aaaaa' )




# checks spelling
library(spelling)
devtools::spell_check(pkg = ".", vignettes = TRUE, use_wordlist = TRUE)

# Update documentation
# devtools::document(pkg = ".")





### Check URL's----------------

urlchecker::url_update()


### CMD Check ----------------
# Check package errors

# LOCAL
Sys.setenv(NOT_CRAN = "true")
devtools::check(pkg = ".",  cran = FALSE, env_vars = c(NOT_CRAN = "true"))

# CRAN
Sys.setenv(NOT_CRAN = "false")
devtools::check(pkg = ".",  cran = TRUE, env_vars = c(NOT_CRAN = "false"))


# quick no vignettes
devtools::check(pkg = ".",  cran = TRUE, env_vars = c(NOT_CRAN = "false"),vignettes = F)

devtools::check_win_release(pkg = ".")

# devtools::check_win_oldrelease()
# devtools::check_win_devel()


beepr::beep()



tictoc::tic()
devtools::check(pkg = ".",  cran = TRUE, env_vars = c(NOT_CRAN = "false"))
tictoc::toc()


# submit to CRAN -----------------
# usethis::use_cran_comments('teste 2222, , asdadsad')


devtools::submit_cran()


# build binary -----------------
system("R CMD build . --resave-data") # build tar.gz







library(dlstats)
library(ggplot2)
x <- dlstats::cran_stats(packages = c( 'cppRouting'))

head(x)
ggplot(x, aes(end, downloads, group=package, color=package)) +
  geom_line() + geom_point(aes(shape=package))
