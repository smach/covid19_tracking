library(testthat)

test_that(
  "Can find MA case date and total",
  {
    ma_cases <- get_ma_data()
    expect_type(ma_cases$Total, "integer")
    date_check <- ma_cases$Date[1]
    expect_true(is.Date(lubridate::ymd(date_check)))
    expect_equal("MA", ma_cases$State)
  }
  
  
)
