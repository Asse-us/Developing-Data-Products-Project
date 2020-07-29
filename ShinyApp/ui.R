
library(shiny)

shinyUI(fluidPage(
    titlePanel("Estimating Ozone from Temperature"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("SliderTemp", "What is the Temperature?",56,97, value = 74),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
        ),
        mainPanel(
            plotOutput("plot1"),
            h4("Predicted Ozone from Model 1:"),
            textOutput("pred1"),
            h4("Predicted Ozone from Model 2:"),
            textOutput("pred2"),
            h3("Note:"),
            textOutput("note")
            
        )
    )
))
