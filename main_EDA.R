# Set the working directory
setwd("C:\\Users\\Ritesh\\Desktop\\llama")

# Read CSV file into a data frame
dataset <- read.csv("CO2 Emissions.csv")

# Load the necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Display basic information about the dataset
str(dataset)

# Summary statistics of the dataset
summary(dataset)

# Check for missing values
missing_values <- colSums(is.na(dataset))
cat("Missing values:\n")
print(missing_values)

# Handle outliers
outlier_vars <- c("Engine.Size.L.", "Cylinders", "Fuel.Consumption.Comb..L.100.km.", "CO2.Emissions.g.km.")

# Set up a 4x3 grid layout
par(mfrow=c(4, 3))

# Boxplot for variables with outliers
for (var in outlier_vars) {
  boxplot(dataset[[var]], main = var)
}

# Remove outliers (consider adjusting the threshold)
threshold <- 3
dataset_no_outliers <- dataset
for (var in outlier_vars) {
  dataset_no_outliers[[var]] <- ifelse(abs(scale(dataset[[var]])) > threshold, NA, dataset[[var]])
}

# Impute missing values after removing outliers
dataset_no_outliers <- dataset_no_outliers %>%
  tidyr::replace_na(list(Engine.Size.L. = median(dataset_no_outliers$Engine.Size.L., na.rm = TRUE),
                         Cylinders = median(dataset_no_outliers$Cylinders, na.rm = TRUE),
                         Fuel.Consumption.Comb..L.100.km. = median(dataset_no_outliers$Fuel.Consumption.Comb..L.100.km., na.rm = TRUE)))

# Boxplot for variables without outliers
for (var in outlier_vars) {
  boxplot(dataset_no_outliers[[var]], main = paste(var, " (No Outliers)"))
}

# Scatterplot matrix for numeric variables without outliers
numeric_vars_no_outliers <- c("Engine.Size.L.", "Cylinders", "Fuel.Consumption.City..L.100.km.", "Fuel.Consumption.Hwy..L.100.km.", "Fuel.Consumption.Comb..L.100.km.", "CO2.Emissions.g.km.")
pairs(dataset_no_outliers[, numeric_vars_no_outliers])

# Pairwise correlation matrix without outliers
cor_matrix_no_outliers <- cor(dataset_no_outliers[, numeric_vars_no_outliers])
print("Correlation Matrix (No Outliers):")
print(cor_matrix_no_outliers)

# Heatmap of the correlation matrix without outliers
ggplot(data = as.data.frame(cor_matrix_no_outliers), aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  theme_minimal() +
  labs(title = "Correlation Heatmap (No Outliers)")

# Density plots for numerical variables without outliers
for (var in numeric_vars_no_outliers) {
  ggplot(dataset_no_outliers, aes(x = dataset_no_outliers[[var]])) +
    geom_density(fill = "skyblue", color = "black") +
    labs(title = paste("Density Plot of", var))
}

# Bar plots for categorical variables
categorical_vars <- c("Make", "Model", "Vehicle.Class", "Transmission", "Fuel.Type")

# Set up a 3x2 grid layout for categorical variables
par(mfrow=c(3, 2))

for (var in categorical_vars) {
  barplot(table(dataset[[var]]), main = var, cex.names = 0.7, las = 2)
}