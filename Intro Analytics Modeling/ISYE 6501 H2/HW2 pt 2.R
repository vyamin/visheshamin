# Load libraries
library(cluster)
library(factoextra)
library(dplyr)

rm(list = ls())

# Load data
iris_data <- read.table("iris.txt", stringsAsFactors = FALSE, header = TRUE)

# Convert species names to numbers
new_class_mapping <- c("setosa" = 1, "versicolor" = 2, "virginica" = 3)
iris_data$Class <- new_class_mapping[iris_data$Species]

# Clean the data
bdimp_clustering_data <- iris_data[, 1:4]

# Iterate across predictor combos
opt_combination <- NULL
opt_accuracy <- 0

for (i in 1:(ncol(bdimp_clustering_data) - 1)) {
  for (j in (i + 1):ncol(bdimp_clustering_data)) {
    # Create predictor set
    bd_predictor_subset <- bdimp_clustering_data[, c(i, j)]
    
    # Use feature scaling
    bd_scaled_data <- scale(bd_predictor_subset)
    
    # Hierarchical clustering
    bd_hclust_result <- hclust(dist(bd_scaled_data), method = "ward.D2")
    bd_cut_tree_result <- cutree(bd_hclust_result, k = 3)  # Adjust the number of clusters as needed
    
    # Assess clustering accuracy
    bd_accuracy <- sum(bd_cut_tree_result == as.integer(iris_data$Class)) / nrow(iris_data)
    
    # Check if the current combo is the best
    if (bd_accuracy > opt_accuracy) {
      opt_accuracy <- bd_accuracy
      opt_combination <- c(names(bd_predictor_subset))
    }
  }
}

# Results
cat("The best combination of predictors for hierarchical clustering is:", paste(opt_combination, collapse = ", "), "\n")
cat("The clustering model with the best combination correctly assigned", 
    round(opt_accuracy * 100, 3), "% of the instances.\n")
