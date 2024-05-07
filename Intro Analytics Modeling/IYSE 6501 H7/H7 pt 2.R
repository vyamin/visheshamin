# Load necessary libraries
library(tidyverse)
# Load the dataset
data <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/statlog/german/german.data", as.is = TRUE)
# Convert target to binary
data$V21 <- as.factor(data$V21 - 1)
# Prepare the data
# Fit logistic regression model
model <- glm(V21 ~ ., data = data, family = binomial(link = "logit"))
# Summarize the model to see coefficients and statistical significance
summary(model)
# Evaluate the model's performance (ROC curve, AUC, confusion matrix, etc.)
# Assuming 'pROC' library for ROC curve analysis
library(pROC)
roc_response <- roc(response = data$V21, predictor = fitted(model))
# Plot ROC curve
plot(roc_response)
# Determine the optimal threshold
thresholds <- seq(0, 1, by = 0.01)
costs <- sapply(thresholds, function(threshold) {
  predictions <- ifelse(fitted(model) > threshold, 1, 0)
  table <- table(actual = data$V21, predicted = predictions)
  # Ensure the table has both dimensions
  if (!all(c(1, 2) %in% dim(table))) {
    return(NA)
  }
  # Extract counts safely
  FP <- if("1" %in% rownames(table) && "2" %in% colnames(table)) table["1", "2"] else 0
  FN <- if("2" %in% rownames(table) && "1" %in% colnames(table)) table["2", "1"] else 0
  # Assuming cost of FP is 5 and FN is 1
  cost <- 5 * FP + FN
  return(cost)
})
costs <- na.omit(costs) # This removes NA values

# Find the threshold w min
min_cost_index <- which.min(costs)
min_cost_threshold <- thresholds[min_cost_index]

# Output the minimum cost threshold
min_cost_threshold

