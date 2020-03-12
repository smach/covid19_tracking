# Installs needed packages if not already on local system.
# Loads required packages.
# Sets state COVID-19 reporting URLs.

if(!require(pacman)){
  install.packages("pacman")
}

pacman::p_load(dplyr, htmltab, lubridate, testthat, rvest, xml2)

proj_dir <- here::here()

ma_url <- "https://www.mass.gov/info-details/covid-19-cases-quarantine-and-monitoring"
ny_url <- "https://www.health.ny.gov/diseases/communicable/coronavirus/"