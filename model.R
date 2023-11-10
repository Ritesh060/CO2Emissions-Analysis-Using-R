# Set the working directory
setwd("C:\\Users\\Ritesh\\Desktop\\llama")

# Read CSV file into a data frame
dataset <- read.csv("CO2 Emissions.csv")

# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(broom)

# Select necessary columns for the model
model_data <- dataset %>%
  select(Engine.Size.L., Cylinders, Fuel.Consumption.Comb..L.100.km., CO2.Emissions.g.km.)

# Check for missing values in the selected columns
print("Missing values in selected columns:")
print(colSums(is.na(model_data)))

# Drop rows with missing values
model_data <- na.omit(model_data)

# Build a linear regression model
lm_model <- lm(CO2.Emissions.g.km. ~ Engine.Size.L. + Cylinders + Fuel.Consumption.Comb..L.100.km., data = model_data)

# Summary of the linear regression model
summary(lm_model)

# Hypothesis testing
anova_result <- anova(lm_model)
print("ANOVA Test:")
print(anova_result)

# Model diagnostics
model_diagnostics <- augment(lm_model)

# Visualize model diagnostics
par(mfrow=c(2,2))
plot(model_diagnostics$Engine.Size.L., model_diagnostics$.resid, main = "Residuals vs. Engine Size")
abline(h = 0, col = "red")

plot(model_diagnostics$Cylinders, model_diagnostics$.resid, main = "Residuals vs. Cylinders")
abline(h = 0, col = "red")

plot(model_diagnostics$Fuel.Consumption.Comb..L.100.km., model_diagnostics$.resid, main = "Residuals vs. Fuel Consumption")
abline(h = 0, col = "red")

hist(model_diagnostics$.resid, main = "Histogram of Residuals")

# Predict CO2 emissions using the linear regression model
predictions <- predict(lm_model, newdata = model_data)

# Model performance metrics
rsquared <- summary(lm_model)$r.squared
mse <- mean((model_data$CO2.Emissions.g.km. - predictions)^2)
print(paste("R-squared:", rsquared))
print(paste("Mean Squared Error:", mse))

# Visualize the actual vs. predicted values
ggplot(model_data, aes(x = CO2.Emissions.g.km., y = predictions)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
  labs(title = "Actual vs. Predicted CO2 Emissions", x = "Actual CO2 Emissions", y = "Predicted CO2 Emissions")

# Plot residuals vs. fitted values
plot(lm_model, which = 1)

# Normal Q-Q plot of residuals
plot(lm_model, which = 2)

# Scale-Location plot
plot(lm_model, which = 3)

