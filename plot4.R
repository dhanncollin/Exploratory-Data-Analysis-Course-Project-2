# Reads the needed packages
      library(dplyr)
      library(ggplot2)

# Reads the RDS datasets
      SCC <- readRDS("Source_Classification_Code.rds")
      NEI <- readRDS("summarySCC_PM25.rds")      

# Get the total emissions from coal combustion related sources per year
      coalcombustion <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
      coalcombustionsources <- SCC[coalcombustion,]      
      ccEmissions <- NEI[(NEI$SCC %in% coalcombustionsources$SCC), ]    
      ccEmissionsrelated <- summarise(group_by(ccEmissions, year), Emissions = sum(Emissions))
      
# Create a plot and saving it as png file
      png(filename = "plot4.png")
      ggplot(ccEmissionsrelated, aes(x = factor(year), y = Emissions, fill = year,
                                     label = round(Emissions, 2))) +
        geom_bar(stat = "identity") +
        # facet_grid(. ~ type) +
        xlab("Years") +
        ylab(expression("Emissions")) +
        ggtitle(expression("Total PM" [2.5]*" Emissions from Coal Combustion Related Sources")) +
        theme(legend.position = "none", plot.title = element_text(hjust = 0.5))
      
# Close the PNG device 
      dev.off()