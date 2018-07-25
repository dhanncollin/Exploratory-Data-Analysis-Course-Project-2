# Reads the needed packages
      library(dplyr)
      library(ggplot2)

# Reads the RDS datasets
      SCC <- readRDS("Source_Classification_Code.rds")
      NEI <- readRDS("summarySCC_PM25.rds")      

# Get the total emissions per year
      baltimoreEmissions <- summarise(group_by(filter(NEI, fips == "24510" & type == "ON-ROAD"), year),
                                      Emissions = sum(Emissions))
      
      LAemissions <- summarise(group_by(filter(NEI, fips == "06037" & type == "ON-ROAD"), year),
                               Emissions = sum(Emissions))
      
      baltimoreEmissions$Country <- "Baltimore City, MD"
      LAemissions$Country <- "Los Angeles Country, CA"
      combinedEmissionsofcities <- rbind(baltimoreEmissions, LAemissions)
      
# Create a plot and saving it as png file
      png(filename = "plot6.png")
      ggplot(combinedEmissionsofcities, aes(x = factor(year), y = Emissions, fill = Country,
                                    label = round(Emissions, 2))) +
        geom_bar(stat = "identity") +
        facet_grid(scales = "free", space = "free", . ~ Country) +
        xlab("Years") +
        ylab(expression("Emissions")) +
        ggtitle(expression("Total PM" [2.5]*" Emissions from Motor Vehicles in Baltimore and Los Angeles")) +
        theme(legend.position = "none", plot.title = element_text(hjust = 0.5))

# Close the PNG device 
      dev.off()