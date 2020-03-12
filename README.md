# covid19_tracking
Scrapers for daily tracking of COVID-19 reported cases in Massachusetts and New York for covidtracking.com project. Should probably be turned into a package but source data structure still fluid.

This project includes the following files in the R directory:

* _config.R_ -- Installs (if needed) and loads necessary package dependencies. Don't run if you don't want to potentially install and load new packages on your system. Also sets variables with URLs for Massachusetts and New York COVID19 data sites.

* _get_ma_totals.R_ -- Defines two functions: `get_ma_data()` that will pull data from the Mass. Dept. of Public Health website and a return a list with variables Date (date of data update), Total (most recent total of known positive COVID-19 cases), and State (in this case "MA"); and `get_ma_hospitalizations()` that returns a data frame with latest known cases hospitalized and not hospitalized. 

* _get_ny_totals.R_ -- Defines function `get_ny_data()` that will pull data from the New York State health dept. website and a return a list with variables Date (date of data update), Total (most recent total of known positive COVID-19 cases), and State (in this case "NY").

* _get_new_data.R_ -- Sample file for how to run the `get_ma_data()` and `get_ny_data()` functions to retrieve new data. There is also code to run `get_ma_hospitalizations()`. However, be advised that `get_ma_hospitalizations()` requires more detailed setup. It relies on the tabulizer package, which in turn relies on the rJava package, and rJava needs certain non-R software installed. This can be tricky, especially on Windows. See the [tabulizer GitHub repo's README](https://github.com/ropensci/tabulizer#installing-java-on-windows-with-chocolatey) and follow installation and troubleshooting instructions. Also note that `get_ma_hospitaliztions()` will download two files to your current working directory.

Finally, a caution: The formats of the public health department pages may change -- the Massachusetts page especially has changed multiple times recently -- so the scrapers may break even though they worked at the time I created them.

And, a plea: If you use this code, _please don't run these scrapers more than a couple of times a day._ We are in the midst of a public health emergency, and I wouldn't want to contribute to others who need to access these sites being unable to get to them. Thanks. My cron jobs only scrape each site once a day.





