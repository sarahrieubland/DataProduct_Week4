library(shiny)
shinyServer(function(input, output) {
        df1 <- read.csv("HDIdata_compact.csv",stringsAsFactors = F)

        model1 <- reactive({
                minX <- input$sliderX[1]
                maxX <- input$sliderX[2]
                ind2 <- which(df1$HDI_Rank >= minX & df1$HDI_Rank <= maxX)
                if(nrow(df1[ind2,]) < 2){
                        return(NULL)
                }
                lm(GDP_percapita ~ EducationIndex , data = df1[ind2,])
        })

        model2 <- reactive({
                minX <- input$sliderX[1]
                maxX <- input$sliderX[2]
                ind2 <- which(df1$HDI_Rank >= minX & df1$HDI_Rank <= maxX)
                if(nrow(df1[ind2,]) < 2){
                        return(NULL)
                }
                lm(GDP_percapita ~ CO2_emi , data = df1[ind2,])
        })

        output$slopeOut <- renderText({
        if(is.null(model1())){
        "No Model Found"
                } else {
                        summary(model1())$r.squared
        }
        })

        output$slopeOut2 <- renderText({
                if(is.null(model2())){
                        "No Model Found"
                } else {
                        summary(model2())$r.squared
                }
        })

        output$plot1 <- renderPlot({
        plot(df1$EducationIndex, df1$GDP_percapita,
                xlab = "Education Index",
                ylab = "GDP per capita [$]",
                cex = 1.5, pch = 16, bty = "n")
                if(!is.null(model1())){
                        points(model1()$model$EducationIndex, model1()$model$GDP_percapita,
                        cex = 1.5, pch = 16, bty = "n", col = "red")
                        abline(model1(), col = "red", lwd = 2)
                        legend("topright", legend = c("all countries", "selected countries"),
                               col = c("black", "red"),
                               cex = 1, pch = 16, bty = "n")

                }
        })

        output$plot2 <- renderPlot({
                plot(df1$CO2_emi, df1$GDP_percapita,
                     xlab = "Co2 Emissions per capita [tonnes]",
                     ylab = "GDP per capita [$]",
                     cex = 1.5, pch = 16, bty = "n")
                if(!is.null(model2())){
                        points(model2()$model$CO2_emi, model2()$model$GDP_percapita,
                               cex = 1.5, pch = 16, bty = "n", col = "blue")
                        abline(model2(), col = "blue", lwd = 2)
                        legend("topright", legend = c("all countries", "selected countries"),
                               col = c("black", "blue"),
                               cex = 1, pch = 16, bty = "n")

                }
        })
})
