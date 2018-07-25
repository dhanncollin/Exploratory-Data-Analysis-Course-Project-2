# Reads the needed packages
      library(dplyr)

# Reads the RDS datasets
      SCC <- readRDS("Source_Classification_Code.rds")
      NEI <- readRDS("summarySCC_PM25.rds")      

# Get the total emissions per year
      baltimoreEmissions <- summarise(group_by(filter(NEI, fips == "24510"), year),
                                      Emissions = sum(Emissions))

# Create a plot and saving it as png file
      png(filename = "plot2.png")
      barplot(height = baltimoreEmissions$Emissions, names.arg = baltimoreEmissions$year,
              xlab = "Years", ylab = "Emissions",
              main = expression("Total PM" [2.5]*" Emissions in Baltimore City, Maryland per Year"),
              col = "Aquamarine")

# Close the PNG device 
      dev.off()