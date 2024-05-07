library(mice)

# Set working directory
setwd("C:/Users/yoges/OneDrive/Documents/R data/IYSE 6501/IYSE 6501 H10")

# Load the data
data <- read.csv("breast-cancer-wisconsin.data.txt", header = FALSE, na.strings = "?")

# Using mice package for multiple and assume all predictors are true

# Perform multiple imputation
imputed_data <- mice(data, method = 'norm.predict', m = 1)

# fill in data
completed_data <- complete(imputed_data)

  