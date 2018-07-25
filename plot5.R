# Reads the needed packages
      library(dplyr)
      library(ggplot2)

# Reads the RDS datasets
      SCC <- readRDS("Source_Classification_Code.rds")
      NEI <- readRDS("summarySCC_PM25.rds")      

# Get the total emissions per year
      baltimoreEmissions <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"),]
      baltEmissionsyear <- summarise(group_by(baltimoreEmissions, year), Emissions = sum(Emissions))

# Create a plot and saving it as png file
      png(filename = "plot5.png")
      ggplot(baltEmissionsyear, aes(x = factor(year), y = Emissions, fill = year,
                                    label = round(Emissions, 2))) +
        geom_bar(stat = "identity") +
        # facet_grid(. ~ type) +
        xlab("Years") +
        ylab(expression("Emissions")) +
        ggtitle(expression("Total PM" [2.5]*" Emissions from Motor Vehicles in Baltimore")) +
        theme(legend.position = "none", plot.title = element_text(hjust = 0.5))

# Close the PNG device 
      dev.off()