library(shiny)
shinyServer(function(input, output) {
    airquality$Temp1<- ifelse(74 - airquality$Temp > 0, 74 - airquality$Temp, 0)
    fit1<- lm(Ozone ~ Temp, data = airquality)
    fit2<- lm(Ozone ~ Temp1 + Temp, data = airquality)
    
    fit1pred <- reactive({
        TempInput <- input$SliderTemp
        predict(fit1, newdata = data.frame(Temp = TempInput))
    })
    fit2pred<- reactive({
        TempInput <- input$SliderTemp
        predict(fit2, newdata = data.frame(Temp = TempInput,
                               Temp1 = ifelse(74 - TempInput > 0,
                                              74 - TempInput, 0)))
    })
    output$plot1<- renderPlot({
        TempInput <- input$SliderTemp
        
        plot(airquality$Temp, airquality$Ozone, xlab = "Temperature (degrees F)",
             ylab = "Ozone(ppb)", bty = "n", pch = 16, 
             xlim = c(50, 100), ylim = c(0, 170))
        if(input$showModel1){
            abline(fit1, col = "red", lwd = 2)
        }
        if(input$showModel2){
            fit2lines<- predict(fit2, newdata = data.frame(
                Temp = 56:97, Temp1 = ifelse(74 -56:97 > 0, 74 -56:97, 0)
            ))
            lines(56:97, fit2lines, col = "blue", lwd = 2)
        }
        legend(50, 150, c("Model 1 Prediction", "Model 2 Prediction"),
               pch = 16, col = c("red", "blue"), bty = "n", cex = 1.2)
        points(TempInput, fit1pred(), col = "red", pch = 16, cex = 2)
        points(TempInput, fit2pred(), col = "blue", pch = 16, cex = 2)
    })
    output$pred1<- renderText({
        round(fit1pred(), 2)
    })
    output$pred2<- renderText({
        round(fit2pred(), 2)
    })
    output$note <- renderText({
        "Splitting point Temp = 74 is chosen by visual observation of the graph."
    })
    
})
