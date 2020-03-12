source("config.R")


#' Function to get date and total COVID19 cases from Mass Dept of Public Health website
#'
#' @param the_url character string with URL of COVID19 case updates
#'
#' @return list with Date, Total, State
#' @export
#'
get_ma_data <- function(the_url = ma_url) {
  ma_dataframe <- htmltab::htmltab(the_url, which = 1)
  ma_date <- names(ma_dataframe)[1]
  ma_date <- lubridate::mdy(gsub(".*?as\\sof\\s(.*2020).*$", "\\1", ma_date))
  names(ma_dataframe) <- c("Category", "Cases")
  ma_total <- as.integer(ma_dataframe$Cases[tolower(ma_dataframe$Category) == "total"])
  ma_results <- list(ma_date, ma_total)
  names(ma_results) <- c("Date", "Total")
  ma_results$State <- "MA"
  return(ma_results)
}



get_ma_hospitalizations <- function(the_page_html){
  ma_links <- the_page_html %>%
    html_nodes("a") %>%  
    html_attr('href')
  ma_link_text <- the_page_html %>%
    html_nodes("a") %>%
    html_text()
  
  pdf_index <- which(grepl("cases in Massachusetts PDF", ma_link_text))
  word_index <- pdf_index + 1
  pdf_link <-paste0("https://www.mass.gov", ma_links[pdf_index] )
  doc_link <- paste0("https://www.mass.gov", ma_links[word_index] )
  
  ma_pdf <- pdf_link
  ma_doc <- doc_link
  pdf_file_name <-  paste0(here::here(), "ma_covid19_cases_", Sys.Date(), ".pdf")
  doc_file_name <-  paste0(here::here(), "ma_covid19_cases_", Sys.Date(), ".docx")
  download.file(ma_pdf, destfile = pdf_file_name, quiet = TRUE, mode = "wb")
  download.file(ma_doc, destfile = doc_file_name, quiet = TRUE, mode = "wb")
  
  ma_doc_text <- textreadr::read_docx(doc_file_name)
  ma_doc_date <- ma_doc_text[2]
  ma_doc_date <- gsub("As of ", "", ma_doc_date)
  ma_doc_date <- lubridate::mdy(ma_doc_date)
  
  ma_tables <- tabulizer::extract_tables(pdf_file_name)

  ma_county_totals <- as.data.frame(ma_tables[[2]])
  names(ma_county_totals) <- c("Category", "Cases")
  ma_county_totals$Date <- ma_doc_date
  ma_county_totals$Category <- as.character(ma_county_totals$Category)
  
  ma_county_totals$Cases <- as.character(ma_county_totals$Cases)
  ma_county_totals$Cases <- as.integer(ma_county_totals$Cases)
  ma_hospitalized <- filter(ma_county_totals, grepl("hospitalized", ma_county_totals$Category))
  ma_hospitalized$State <- "MA"
  return(ma_hospitalized)
  
  
  
}


