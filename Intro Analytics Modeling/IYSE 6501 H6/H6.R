# Intercept from the PCA model
intercept <- coef(model_pca)[1]

# Coefficients for the principal components
coefficients_pc <- coef(model_pca)[-1]

# Calculating alpha vector (transformation to original variables)
alpha_vector <- crime_pca$rotation[, 1:5] %*% coefficients_pc

# Mean and standard deviation of the original data
original_means <- colMeans(crime[,-ncol(crime)])
original_sds <- apply(crime[,-ncol(crime)], 2, sd)

# Calculating coefficients for the original variables
original_coefficients <- alpha_vector / original_sds

# Adjusting intercept
adjusted_intercept <- intercept - sum(original_coefficients * original_means)
