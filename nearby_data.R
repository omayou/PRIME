nearby_data <- function (station, satrtdate, enddate, whatdata, timestep) {
  

  if (timestep == 'hourly') {
    if (station == 'Mullingar') {
      nearby <- fread("https://cli.fusio.net/cli/climate_data/webdata/hly875.csv",
                      select = c("date", whatdata))
    } else if (station == 'MtDillon') {
      nearby <- fread("https://cli.fusio.net/cli/climate_data/webdata/hly1975.csv", 
                      select = c("date", whatdata))
   } else if (station == 'Ballyhaise') {
     nearby <- fread("https://cli.fusio.net/cli/climate_data/webdata/hly675.csv", 
                     select = c("date", whatdata))
   } else if (station == 'Johnstown') {
     nearby <- fread("https://cli.fusio.net/cli/climate_data/webdata/hly1775.csv", 
                     select = c("date", whatdata))
   } 
  }
    
    
    else if (timestep == 'daily') {
      if (station == 'Mullingar') {
        nearby <- fread("https://cli.fusio.net/cli/climate_data/webdata/dly875.csv", 
                        select = c("date", whatdata))
      } else if (station == 'MtDillon') {
        nearby <- fread("https://cli.fusio.net/cli/climate_data/webdata/dly1975.csv", 
                        select = c("date", whatdata))
      } else if (station == 'Ballyhaise') {
        nearby <- fread("https://cli.fusio.net/cli/climate_data/webdata/dly675.csv", 
                        select = c("date", whatdata))  
      } else if (station == 'Johnstown') {
        nearby <- fread("https://cli.fusio.net/cli/climate_data/webdata/dly1775.csv", 
                        select = c("date", whatdata))  
      }
    }
 
 
  if (nchar(nearby[2,1]) >= 17) {
    nearby$date <- as.POSIXct(nearby$date,format = "%d-%b-%Y  %H:%M",tz = Sys.timezone())
  } else if (nchar(nearby[2,1]) <= 12) {
    nearby$date <- as.POSIXct(nearby$date,format = "%d-%b-%Y",tz = Sys.timezone())
  }
  nearby <- nearby[nearby$date >= startdate & 
               nearby$date < enddate,]    
    
    nearby
   
}

