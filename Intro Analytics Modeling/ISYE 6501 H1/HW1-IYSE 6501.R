# Load the kernlab library
library(kernlab)

# Set the working directory 
setwd("C:/Users/yoges/OneDrive/Documents/R data/ISYE 6501 H1")

# Load the data
data <- read.table("credit_card_data-headers.txt", header = TRUE)

# Specify candidate values for k (e.g., 1 to 15)
k_candidate_values <- 1:15

# Store accuracy values for different k
accuracy_kvalues <- numeric(length(k_candidate_values))

# Iterate over k values and evaluate classification performance
for (X in k_candidate_values) {
  
  predicted <- rep(0, nrow(data)) # predictions: start with a vector of all zeros
  
  for (i in 1:nrow(data)) {
    # Exclude the ith data point for training
    predictor_training <- data[-i, 1:10]
    response_training <- as.factor(data[-i, 11])
    
    # Use the ith for testing
    predictor_test <- data[i, 1:10, drop = FALSE]
    
    # Train the kknn 
    model_kknn <- kknn(response_training ~ ., predictor_training, test = predictor_test, k = X, scale = TRUE)
    
    # Use ith for prediction
    pred_kknn <- as.numeric(as.character(fitted(model_kknn)))  
    
    # Convert to binary values
    predict_bin <- ifelse(pred_kknn > 0.5, 1, 0)
    
    # Check accuracy of prediction
    predicted[i] <- predict_bin == data[i, 11]
  }
  
  # Calculate accuracy for the current k
  accuracy_kvalues[X] <- sum(predicted) / nrow(data)
}

# Find the best most accurate K value
best_kvalue <- which.max(accuracy_kvalues)

# Print the best k and its corresponding accuracy
cat("Optimal k:", best_kvalue, "\n")
cat("Accuracy for optimal k:", accuracy_kvalues[best_kvalue], "\n")

# Plot of accuracy
plot(accuracy_kvalues, type = "l", xlab = "Number of Neighbors (k)", ylab = "Accuracy",
     main = "K-Nearest-Neighbors")

# Print the plot
print("Plot of accuracy")
