import_flow <- function(flowfilename, startdate, enddate, timestep, flowunit) {
  
  flow <- read.csv(file = flowfilename, header = FALSE) # Import flow data [date, flow(liter per second)]
  flow <- flow[-(1:6),]                                 # Remove first 6 rows (data specification)
  flow <- flow[1:2]                                     # only select the first 2 columns, in case there are additional columns
  colnames(flow) <- c("date", "flow_lps")               # Adjust column names
  flow$date <- as.POSIXct(flow$date,format = "%d/%m/%Y %H:%M",tz=Sys.timezone())   # Change the Time type so that R can read it
  flow <- flow[flow$date >= startdate & 
                 flow$date < enddate,]                  # Select the period of interest

  flow$flow_lps <- as.numeric(flow$flow_lps)            # Change the flow data type (from character) to number
  
  if(timestep == 'hourly')
  {
    flow <- aggregate(flow[names(flow) != 'date'], list(date_hourly = cut(flow$date, 'hour')), mean, na.rm = F)
  }
  else if (timestep == 'daily')
  {
    flow <- aggregate(flow[names(flow) != 'date'], list(date_daily = cut(flow$date, 'DSTday')), mean, na.rm = F)
  }
  else if (timestep == 'default')
  {
    
  }
  
  
    if (flowunit == 'cms')
  {
    flow$flow_lps <- flow$flow_lps/1000 
    # update column name
    colnames(flow) <- c("date", "flow_cms")
  }
  else if (flowunit == 'lps')
  {
    
  }
  
  flow
}

