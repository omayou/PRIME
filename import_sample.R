import_sample <- function(samplefilename, flow) {
  
  sampleevent <- read.csv(file = samplefilename, header = FALSE) # Import sample event data [date, number of samples]
  colnames(sampleevent) <- c("date", "number")                # Adjust column names
  sampleevent$date <- as.POSIXct(sampleevent$date,format = "%d/%m/%Y %H:%M",tz = Sys.timezone())   # Change the Time type so that R can read it

  sampleevent$number <- as.numeric(sampleevent$number)              # to make sure sample numbers are numeric
  sampleevent <- sampleevent[complete.cases(sampleevent), ]
  
  
  # closest time to each sampling event should be first initialized:
  ClosestTimeToSample <- as.POSIXct("1990-01-01 00:00:00")
  
  # find above time for each sampling event
  for (i in 1:nrow(sampleevent)) {
    ClosestTimeToSample[i] = flow$date[which.min(abs(difftime(flow$date, sampleevent$date[i], units = "secs")))]
  }
  # find the below interval as well as the time distance to above limit to calculate the abstract flow for plotting
  for (i in 1:nrow(sampleevent)) {
    
    if (ClosestTimeToSample[i] >= sampleevent$date[i]) {
      above.t = ClosestTimeToSample[i]
      below.t = flow$date[which(flow$date == ClosestTimeToSample[i])-1]
    } else {
      below.t = ClosestTimeToSample[i]
      above.t = flow$date[which(flow$date == ClosestTimeToSample[i])+1]
    }
    ToAbovePortion = as.numeric(difftime(above.t, sampleevent$date[i], units = "secs")) / as.numeric(difftime(above.t, below.t, units = "secs"))
    
    sampleevent_above_flow <- flow[flow$date %in% above.t, 2]
    sampleevent_below_flow <- flow[flow$date %in% below.t, 2]
    sampleevent_flow <- sampleevent_above_flow - (sampleevent_above_flow - sampleevent_below_flow) * ToAbovePortion
    
    
    sampleevent[i, 3] <- sampleevent_flow
    colnames(sampleevent)[3] <- 'abstract_flow'

    
  }
  
  sampleevent
}
