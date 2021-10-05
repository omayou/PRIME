# Aggregate and average all data at any time step
# Create random time series
time_index <- seq(from = as.POSIXct("2020-01-01 01:00:00"), 
                  to = as.POSIXct("2020-01-03 23:00:00"), by = "min")
random_values <- sample.int(10, length(time_index), replace = TRUE)
df <- data.frame(date = time_index, Val = random_values)
df_aggregated <- aggregate(df[names(df) != 'date'], list(hour = cut(df$date,'hour')), mean, na.rm = F)
