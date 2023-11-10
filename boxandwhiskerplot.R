# Set the working directory
setwd("C:\\Users\\Ritesh\\Desktop\\llama")

# Read CSV file into a data frame
dataset <- read.csv("CO2 Emissions.csv")

# Load necessary libraries
library(ggplot2)

# Create a box and whisker plot
boxplot_plot <- ggplot(dataset, aes(x = 1, y = CO2.Emissions.g.km.)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Box and Whisker Plot of CO2 Emissions",
       x = "CO2 Emissions (g/km)") +
  theme_minimal() +
  theme(axis.text.x = element_blank())  # Hide x-axis label

# Print the box and whisker plot
print(boxplot_plot)
