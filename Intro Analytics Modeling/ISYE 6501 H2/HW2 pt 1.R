install.packages("ggplot2")

library(kknn)
library(ggplot2)

# Set wd
setwd("C:/Users/yoges/OneDrive/Documents/R data/ISYE 6501 H1")

# Load data with headers
credit_data_knn <- read.table("credit_card_data-headers.txt", header = TRUE)

# Establishing possible values k
k_values_cv_knn <- 1:25

# Accuracy vectors
acc_values_cv_knn <- numeric(length(k_values_cv_knn))
acc_values_test_knn <- numeric(length(k_values_cv_knn))

# Loop for k values and evaluate classification with cross-validation and test set
for (k_cv_knn in k_values_cv_knn) {
  newpredictions_cv_knn <- rep(0, nrow(credit_data_knn))
  newpredictions_test_knn <- rep(0, nrow(credit_data_knn))
  
  # Cross-validation
  for (i_cv_knn in 1:nrow(credit_data_knn)) {
    bdpredictors_train_cv_knn <- credit_data_knn[-i_cv_knn, 1:10]
    bdresponse_train_cv_knn <- as.factor(credit_data_knn[-i_cv_knn, 11])
    bdpredictors_test_cv_knn <- credit_data_knn[i_cv_knn, 1:10, drop = FALSE]
    
    # Training of the model
    trainmodel_kknn_cv_knn <- kknn(bdresponse_train_cv_knn ~ ., bdpredictors_train_cv_knn, test = bdpredictors_test_cv_knn, k = k_cv_knn, scale = TRUE)
    
    trainpred_kknn_cv_knn <- as.numeric(as.character(fitted(trainmodel_kknn_cv_knn)))
    
    # Convert to binary
    predict_bin_cv_knn <- ifelse(trainpred_kknn_cv_knn > 0.5, 1, 0)
    
    newpredictions_cv_knn[i_cv_knn] <- predict_bin_cv_knn
  }
  
  # Accuracy for cross-validation
  acc_values_cv_knn[k_cv_knn] <- sum(newpredictions_cv_knn == credit_data_knn[, 11]) / nrow(credit_data_knn)
  
  # Test set evaluation
  for (i_test_knn in 1:nrow(credit_data_knn)) {
    bdpredictors_train_test_knn <- credit_data_knn[-i_test_knn, 1:10]
    bdresponse_train_test_knn <- as.factor(credit_data_knn[-i_test_knn, 11])
    bdpredictors_test_test_knn <- credit_data_knn[i_test_knn, 1:10, drop = FALSE]
    
    # Training of the model
    trainmodel_kknn_test_knn <- kknn(bdresponse_train_test_knn ~ ., bdpredictors_train_test_knn, test = bdpredictors_test_test_knn, k = k_cv_knn, scale = TRUE)
    
    trainpred_kknn_test_knn <- as.numeric(as.character(fitted(trainmodel_kknn_test_knn)))
    
    # Convert to binary
    predict_bin_test_knn <- ifelse(trainpred_kknn_test_knn > 0.5, 1, 0)
    
    newpredictions_test_knn[i_test_knn] <- predict_bin_test_knn
  }
  
  # Accuracy for test set
  acc_values_test_knn[k_cv_knn] <- sum(newpredictions_test_knn == credit_data_knn[, 11]) / nrow(credit_data_knn)
}

# Identify the optimal K value for cross-validation
optimal_k_cv <- which.max(acc_values_cv_knn)
optimal_accuracy_cv <- max(acc_values_cv_knn)

# Identify the optimal K value for test set
optimal_k_test <- which.max(acc_values_test_knn)
optimal_accuracy_test <- max(acc_values_test_knn)

# Generate plot for accuracy
ggplot(data = data.frame(K = k_values_cv_knn, Accuracy = acc_values_cv_knn), aes(x = K, y = Accuracy)) +
  geom_line() +
  geom_point(aes(x = optimal_k_cv, y = optimal_accuracy_cv), color = "red", size = 3) +
  ggtitle("K-Nearest Neighbors: Cross-Validation Accuracy") +
  xlab("K Value") +
  ylab("Accuracy")

# Output Results
cat("Optimal K (Cross-validation):", optimal_k_cv, ".\n")
cat("Accuracy for optimal K (Cross-validation):", optimal_accuracy_cv, "\n")

cat("Optimal K (Test set):", optimal_k_test, ".\n")
cat("Accuracy for optimal K (Test set):", optimal_accuracy_test, "\n")
