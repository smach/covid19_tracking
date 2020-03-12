library(testthat)

test_that(
  "Can find NY case date and total",
  {
    ny_cases <- get_ny_data()
    expect_type(ny_cases$Total, "integer")
    date_check <- ny_cases$Date[1]
    expect_true(is.Date(lubridate::ymd(date_check)))
    expect_equal("NY", ny_cases$State)
  }
  
  
)
