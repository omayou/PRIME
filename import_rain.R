import_rain <- function(filename, startdate, enddate, timestep) {
  
  rain <- read.csv(file = filename, header = FALSE) # Import rainfall data [date, rain(mm)]
  rain <- rain[-(1:6),]                             # Remove the first 6 rows (data specification)
  colnames(rain) <- c("date", "rain_mm")            # Adjust column names
  rain$date <- as.POSIXct(rain$date,format = "%d/%m/%Y %H:%M",tz = Sys.timezone())   # Change the Time type so that R can read it
  rain <- rain[rain$date >= startdate & 
                 rain$date < enddate,]              # Select only the period of interest
  rain$rain_mm <- as.numeric(rain$rain_mm)          # Change the rain data type (from character) to number

  if(timestep == 'hourly')
  {
    rain <- aggregate(rain[names(rain) != 'date'], list(hour = cut(rain$date, 'hour')), sum, na.rm = F)
  }
  else if (timestep == 'daily')
  {
    rain <- aggregate(rain[names(rain) != 'date'], list(hour = cut(rain$date, 'day')), sum, na.rm = F)
  }
  else if (timestep == 'default')
  {
    rain
  }
  rain
}
