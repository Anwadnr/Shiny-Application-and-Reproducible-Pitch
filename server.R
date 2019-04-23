# library(shiny)
library(ggplot2)
library(dplyr)
# library(rsconnect)


# Defining data
# white_wine <- read.csv("winequality-white.csv", header = T, sep = ";") %>% 
#                 mutate(Color = "White")
# red_wine <- read.csv("winequality-red.csv", header = T, sep = ";") %>% 
#                 mutate(Color = "Red")
# 
# wine <- bind_rows(white_wine, red_wine) %>% 
#         filter(residual.sugar <= 40)
# 
# # Select columns to be used in the analysis
# wine <- wine[,c(1,4,10,11,12,13)]

# Define server logic 
shinyServer(function(input, output, session) {
        
        
        
# Plot        
        output$Plot <- renderPlot({

                # Select wine properties

                wine <- filter(wine,
                               sulphates >= input$Sulphates[1],
                               sulphates <= input$Sulphates[2],
                               alcohol >= input$Alcohol[1],
                               alcohol <= input$Alcohol[2],
                               fixed.acidity >= input$FixedAcidity[1],
                               fixed.acidity <= input$FixedAcidity[2],
                               quality %in% input$quality,
                               input$Color == Color)
                
        output$mean<-renderText({ 
                        mean(wine$quality)
                        
                })                   

                # Draw the plot

                plot <- ggplot(data=wine, aes(x=alcohol, y = residual.sugar)) +
                        geom_point(aes(color = quality), alpha = 1, size = 2) +
                        geom_smooth(method = "lm",
                                     formula = y~x) +
                        scale_colour_gradient(low = "purple", high = "yellow")
        
                plot

        })     
        

# Table               
         output$Table <- renderTable({
         
                 data <- filter(wine, 
                        sulphates >= input$Sulphates[1],
                        sulphates <= input$Sulphates[2],
                        alcohol >= input$Alcohol[1],
                        alcohol <= input$Alcohol[2],
                        fixed.acidity >= input$FixedAcidity[1],
                        fixed.acidity <= input$FixedAcidity[2],
                        quality %in% input$quality,
                        input$Color == Color)
                 
                  data <- arrange(data, -quality) 
                  data <- head(data, 20)
                  data
                 
                 } )
         
                  
    }) 

