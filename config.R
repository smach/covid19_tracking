if(!require(pacman)){
  install.packages("pacman")
}

pacman::p_load(dplyr, htmltab, lubridate, rmarkdown, knitr, testthat, here, rvest, xml2)

proj_dir <- here::here()

ma_url <- "https://www.mass.gov/info-details/covid-19-cases-quarantine-and-monitoring"
ny_url <- "https://www.health.ny.gov/diseases/communicable/coronavirus/"