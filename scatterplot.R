# Set the working directory
setwd("C:\\Users\\Ritesh\\Desktop\\llama")

# Read CSV file into a data frame
dataset <- read.csv("CO2 Emissions.csv")
# Load the necessary libraries
library(ggplot2)
library(dplyr)

# Select numeric variables for scatter plot matrix
numeric_vars <- c("Engine.Size.L.", "Cylinders", "Fuel.Consumption.City..L.100.km.", "Fuel.Consumption.Hwy..L.100.km.", "Fuel.Consumption.Comb..L.100.km.", "CO2.Emissions.g.km.")

# Create a scatter plot matrix
scatter_plot_matrix <- ggplot(dataset, aes(x = Engine.Size.L., y = Cylinders)) +
  geom_density_2d(aes(color = "Engine Size vs. Cylinders"), alpha = 0.5) +
  geom_point(aes(color = "Engine Size vs. Cylinders")) +
  geom_point(aes(x = Engine.Size.L., y = Fuel.Consumption.City..L.100.km., color = "Engine Size vs. City MPG")) +
  geom_point(aes(x = Engine.Size.L., y = Fuel.Consumption.Hwy..L.100.km., color = "Engine Size vs. Hwy MPG")) +
  geom_point(aes(x = Engine.Size.L., y = Fuel.Consumption.Comb..L.100.km., color = "Engine Size vs. Comb MPG")) +
  geom_point(aes(x = Engine.Size.L., y = CO2.Emissions.g.km., color = "Engine Size vs. CO2 Emissions")) +
  geom_point(aes(x = Cylinders, y = Fuel.Consumption.City..L.100.km., color = "Cylinders vs. City MPG")) +
  geom_point(aes(x = Cylinders, y = Fuel.Consumption.Hwy..L.100.km., color = "Cylinders vs. Hwy MPG")) +
  geom_point(aes(x = Cylinders, y = Fuel.Consumption.Comb..L.100.km., color = "Cylinders vs. Comb MPG")) +
  geom_point(aes(x = Cylinders, y = CO2.Emissions.g.km., color = "Cylinders vs. CO2 Emissions")) +
  geom_point(aes(x = Fuel.Consumption.City..L.100.km., y = Fuel.Consumption.Hwy..L.100.km., color = "City MPG vs. Hwy MPG")) +
  geom_point(aes(x = Fuel.Consumption.City..L.100.km., y = Fuel.Consumption.Comb..L.100.km., color = "City MPG vs. Comb MPG")) +
  geom_point(aes(x = Fuel.Consumption.City..L.100.km., y = CO2.Emissions.g.km., color = "City MPG vs. CO2 Emissions")) +
  geom_point(aes(x = Fuel.Consumption.Hwy..L.100.km., y = Fuel.Consumption.Comb..L.100.km., color = "Hwy MPG vs. Comb MPG")) +
  geom_point(aes(x = Fuel.Consumption.Hwy..L.100.km., y = CO2.Emissions.g.km., color = "Hwy MPG vs. CO2 Emissions")) +
  geom_point(aes(x = Fuel.Consumption.Comb..L.100.km., y = CO2.Emissions.g.km., color = "Comb MPG vs. CO2 Emissions")) +
  theme_minimal() +
  labs(title = "Scatter Plot Matrix")

# Print the scatter plot matrix
print(scatter_plot_matrix)