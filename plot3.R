# Reads the needed packages
      library(dplyr)
      library(ggplot2)

# Reads the RDS datasets
      SCC <- readRDS("Source_Classification_Code.rds")
      NEI <- readRDS("summarySCC_PM25.rds")      

# Get the total emissions per year
      baltEmissionsyear <- summarise(group_by(filter(NEI, fips == "24510"), year, type),
                                      Emissions = sum(Emissions))

# Create a plot and saving it as png file
      png(filename = "plot3.png")
      ggplot(baltEmissionsyear, aes(x = factor(year), y = Emissions, fill = type,
                                     label = round(Emissions, 2))) +
        geom_bar(stat = "identity") +
        facet_grid(. ~ type) +
        xlab("Years") +
        ylab(expression("Emissions")) +
        ggtitle(expression("Total PM" [2.5]*" Emissions in Baltimore City by Source Type")) +
        theme(legend.position = "none", plot.title = element_text(hjust = 0.5))
      
# Close the PNG device 
      dev.off()