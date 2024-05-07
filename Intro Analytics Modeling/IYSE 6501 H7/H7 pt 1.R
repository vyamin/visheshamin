# Load necessary library

library(randomForest)

# Set working directory
setwd("C:/Users/yoges/OneDrive/Documents/R data/IYSE 6501/IYSE 6501 H7")

# Read the dataset
crime <- read.table("uscrime.txt", header = TRUE)

# Fit a random forest model to predict 'Crime'
fit_rf <- randomForest(Crime ~ ., data = crime, importance = TRUE)

# Print the model summary
print(fit_rf)

# Look at variable importance
importance(fit_rf)
varImpPlot(fit_rf)
