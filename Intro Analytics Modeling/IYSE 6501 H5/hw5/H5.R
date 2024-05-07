

# Load necessary libraries
library(caret)

# Set working directory
setwd("C:/Users/yoges/OneDrive/Documents/R data/IYSE 6501 H5")

# Read the dataset
crime <- read.table("uscrime.txt", header = TRUE)

# Define the function to compute cross-validated R^2
compute_cv_r_squared <- function(model, data) {
  # Perform cross-validation
  cv_results <- train(model, data = data, method = "lm", trControl = trainControl(method = "cv"))
  
  # Extract the cross-validated R^2 value
  cv_r_squared <- cv_results$results$Rsquared
  return(cv_r_squared)
}

# Fit the linear model with selected predictors
lm_selected <- lm(Crime ~ M + Ed + Ineq + Prob, data = crime)

# Print the summary of the model
summary(lm_selected)

# Predict using the fitted model
predicted_values <- predict(lm_selected, newdata = test_data)

# Print the predicted values
print(predicted_values)

# Compute cross-validated R^2
cv_r_squared <- compute_cv_r_squared(Crime ~ M + Ed + Ineq + Prob, data = crime)
print(cv_r_squared)

