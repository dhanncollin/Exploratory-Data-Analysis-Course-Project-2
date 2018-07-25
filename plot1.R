# Reads the needed packages
      library(dplyr)

# Reads the RDS datasets
      SCC <- readRDS("Source_Classification_Code.rds")
      NEI <- readRDS("summarySCC_PM25.rds")      

# Get the total emissions per year
      totalEmissions <- summarise(group_by(NEI, year), Emissions = sum(Emissions))

# Create a plot and saving it as png file
      png(filename = "plot1.png")
      barplot(height = totalEmissions$Emissions, names.arg = totalEmissions$year,
              xlab = "Years", ylab = "Emissions", main = expression("Total PM" [2.5]*" Emissions per Year"),
              col = "Aquamarine")
      
# Close the PNG device 
      dev.off()