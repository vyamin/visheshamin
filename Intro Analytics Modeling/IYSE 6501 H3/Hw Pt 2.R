
setwd("C:/Users/yoges/OneDrive/Documents/R data/IYSE 6501 H3/hw3")

# Load libr
library(dplyr)

sdtemperature_data <- read.table("temps.txt", header = TRUE)

# Adjust the data format
sdtemperature_data_long <- reshape2::melt(sdtemperature_data, id.vars = "DAY", variable.name = "Year", value.name = "Temperature")

sdtemperature_data_long$Date <- as.Date(sdtemperature_data_long$DAY, format = "%d-%b")

# Show new date values
print(unique(sdtemperature_data_long$Date))

# Filter by month
filtered_sdtemperature_data <- sdtemperature_data_long %>%
  filter(format(Date, "%b") %in% c("Jul", "Aug", "Sep", "Oct"))

# Find avg temp
sdavg_temperature_perday <- aggregate(Temperature ~ Date, data = filtered_sdtemperature_data, mean)

sdavg_temperature_perday$cusum <- cumsum(sdavg_temperature_perday$Temperature - mean(sdavg_temperature_perday$Temperature))

# Identify when the day temp drops
last_day_ofsummer <- sdavg_temperature_perday[sdavg_temperature_perday$cusum == min(sdavg_temperature_perday$cusum), "Date"]
print(last_day_ofsummer)

# Build plot
plot(sdavg_temperature_perday$Date, sdavg_temperature_perday$cusum, type = "l", col = "blue", xlab = "Date", ylab = "CUSUM", main = "CUSUM vs Average Daily High Temperature")
abline(h = 0, col = "red", lty = 2)  # Add a reference line at CUSUM = 0
points(last_day_ofsummer, min(sdavg_temperature_perday$cusum), col = "red", pch = 16)  # Mark the days when unofficial summer ends
