source("config.R")


#' Function to get date and total COVID19 cases from NY public health dept. website
#'
#' @param the_url character string with URL of COVID19 case updates
#'
#' @return list with Date, Total, State
#' @export
#'
get_ny_data <- function(the_url = ny_url){
  ny_dataframe <- htmltab::htmltab(the_url, which = 1)
  names(ny_dataframe) <- c("Category", "Cases")
  ny_total <- dplyr::filter(ny_dataframe, grepl("Total", ny_dataframe$Category))
  ny_total <- as.integer(ny_total$Cases[1])
  ny_html <- xml2::read_html(ny_url)
  ny_css <- "caption"
  ny_text <- ny_html %>%
    rvest::html_nodes(ny_css) %>%
    rvest::html_text()
  
  ny_date <- lubridate::mdy(gsub("Data last updated .*?m\\s", "", ny_text))
  ny_results <- list(ny_date, ny_total)
  names(ny_results) <- c("Date", "Total")
  ny_results$State <- "NY"
  return(ny_results)
}





