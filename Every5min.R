# Just for ISCO sampler data with 5-minute intervals that always end in 0 or 5. 
# Organize a mixed data in every 1 and 5 min to only every 5 min.
# Create random time series
time_index <- seq(from = as.POSIXct("2020-01-01 01:00:00"), 
                  to = as.POSIXct("2020-01-03 23:00:00"), by = "min")
random_values <- sample.int(10, length(time_index), replace = TRUE)
df <- data.frame(date = time_index, Val = random_values)
df_every5 <- df[as.numeric(format(df$date, '%M')) %% 5 == 0,]
