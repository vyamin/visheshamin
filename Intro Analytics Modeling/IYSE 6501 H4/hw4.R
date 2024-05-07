
library(dplyr)
library(reshape2)

# Set wd
setwd("C:/Users/yoges/OneDrive/Documents/R data/IYSE 6501 H3/hw3")
sdtemperature_data <- read.table("temps.txt", header = TRUE)

# Adjust the data format
sdtemperature_data_long <- reshape2::melt(sdtemperature_data, id.vars = "DAY", variable.name = "Year", value.name = "Temperature")

# Convert DAY column to Date format
sdtemperature_data_long$Date <- as.Date(sdtemperature_data_long$DAY, format = "%d-%b")

# Extract month from Date
sdtemperature_data_long$Month <- format(sdtemperature_data_long$Date, "%m")

# Filter data for July through October
sdtemperature_data_filtered <- sdtemperature_data_long %>%
  filter(Month %in% c("07", "08", "09", "10"))

#exponential smoothing
newsmoothed_data <- sdtemperature_data_filtered %>%
  group_by(Year) %>%
  summarise(newsmoothed_temperature = forecast::ets(Temperature)$fitted)

# Assess trend for the end of summer
# Calculate the avg peak temperature for each year
avg_peak_temperature <- newsmoothed_data %>%
  group_by(Year) %>%
  summarise(average_temp = mean(smoothed_temperature))

# Perform linear regression to assess trend
trend <- lm(average_temp ~ Year, data = avg_peak_temperature)

# Check if there is a significant shift over the 20 years
if (coef(trend)[2] > 0) {
  cat("Trend towards later peak temperatures, indicating the unofficial end of summer has gotten later over the 20 years.\n")
} else if (coef(trend)[2] < 0) {
  cat("There is a trend towards earlier peak temperatures, indicating the unofficial end of summer has gotten earlier over the 20 years.\n")
} else {
  cat("There is no significant trend observed in the peak temperatures over the 20 years.\n")
}
