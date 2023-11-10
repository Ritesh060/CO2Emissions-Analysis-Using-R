# Set the working directory
setwd("C:\\Users\\Ritesh\\Desktop\\llama")

# Read CSV file into a data frame
dataset <- read.csv("CO2 Emissions.csv")

# Load necessary libraries
library(graphics)

# Select columns for the dotchart
dotchart_data <- dataset %>%
  select(Make, CO2.Emissions.g.km.)

# Sort the data by CO2 emissions for better visualization
dotchart_data <- dotchart_data[order(dotchart_data$CO2.Emissions.g.km.),]

# Create a dotchart
dotchart(dotchart_data$CO2.Emissions.g.km., 
         labels = dotchart_data$Make,
         main = "CO2 Emissions by Make",
         xlab = "CO2 Emissions (g/km)",
         color = "blue",
         cex = 0.7)
