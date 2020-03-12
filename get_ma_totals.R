source("config.R")


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

ma_cases <- get_ma_data()