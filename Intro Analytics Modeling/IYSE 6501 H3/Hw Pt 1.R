# Set working directory
setwd("C:/Users/yoges/OneDrive/Documents/R data/IYSE 6501 H3/hw3")

# Load package
library(outliers)

# Load data with headers
uscrime_data <- read.table("uscrime.txt", header = TRUE)

# Extract the last column (number of crimes per 100,000 people)
crime_rate <- uscrime_data$Crime

# Perform Grubbs' test for outliers
sdgrubbs_result <- grubbs.test(crime_rate)

# Print the result
print(sdgrubbs_result)
