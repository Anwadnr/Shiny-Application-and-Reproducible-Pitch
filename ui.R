library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Quality Of Wine Based on Properties"),
        
        # Sidebar with options selectors
        sidebarLayout(
                sidebarPanel(
                        helpText("This application Compares Properties of Wine."),
                        h3(helpText("Select:")),
                        selectInput("Color", label = h4("Color"), 
                                      choices = list ("White", "Red")),
                        sliderInput("Alcohol",
                                     label = h4("Alcohol"),
                                    min = min(wine$alcohol),
                                    max = max(wine$alcohol),
                                    value = c(9,15),
                                    step = 0.1),
                         sliderInput("Sulphates", 
                                      label = h4("Sulphates"),
                                      min = min(wine$sulphates), 
                                      max = max(wine$sulphates), 
                                      value = c(0.30,1.0), 
                                      step = .01),
                         sliderInput("FixedAcidity", 
                                     label = h4("Fixed Acidity"),
                                     min = min(wine$fixed.acidity), 
                                     max = max(wine$fixed.acidity), 
                                     value = c(3,15), 
                                     step = 0.1),
                        checkboxGroupInput("quality", 
                                            label = h4("Quality"), 
                                            c("Three"=3, "Four"=4,
                                              "Five" = 5, "Six" = 6, "Seven"= 7,
                                              "Eight"= 8, "Nine"= 9), 
                                            selected = c(3,4,5,6,7,8,9)) 

                ),
                mainPanel(plotOutput("Plot"), 
                          tableOutput("Table"))
                )
        )
)