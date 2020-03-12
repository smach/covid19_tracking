source("get_ma_totals.R")
ma_cases <- get_ma_data()

source("get_ny_totals.R")
ny_cases <- get_ny_data()

#### If you've set up to scrape PDFs with tabulizer ####
source("config_for_pdfs.R")
source("get_ma_totals.R")
ma_dph_html <- xml2::read_html(ma_url)
ma_hospitalized_cases <- get_ma_hospitalizations(ma_dph_html)
