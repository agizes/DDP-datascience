library(shiny)
library(webshot)
library(UsingR)
library(dplyr)
data("diamonds")


shinyServer(function(input, output) {
 #linear model
  model<- lm(price ~ carat, data = diamonds)

  modelpred <- reactive({
    caratInput <- input$slider
    predict(model, newdata = data.frame(carat = caratInput))
  })
  #diamonds scatterplot (1)
  output$plot<- renderPlot({
    caratInput <- input$slider
    plot(diamonds$carat, diamonds$price, xlab = "Mass(carats)", ylab = "Price (Sin$)",
         bg="lightblue",cex=1,pch=21,frame=FALSE,col = alpha("blue", 0.05),
         xlim = c(0, 3.5))
   # plot line with the model
      abline(model, col = "red", lwd = 2)
    #}
   points(caratInput, modelpred(), col = "red", pch = 16, cex = 2)
    legend(0, 0, "Model prediction", pch = 16,
          col = "red", bty = "n", cex = 1.2)

  })
  #diamondss prediction (1)
  output$pred<- renderText({modelpred()})


  cutInput <- reactive({
    switch(input$cut,"Fair" = "Fair", "Good" = "Good","Very Good" = "Very Good","Ideal"="Ideal", "Premium"="Premium")
  })


  output$summary <- renderPrint({
    cutSelected <- cutInput()
    if(input$filterCut){
      summary(diamonds[diamonds$cut==cutSelected,])
      }
    else{
      summary(diamonds)
    }
  })

  output$view <- renderTable({
    if(input$filterCut){
      head(diamonds[diamonds$cut==cutInput(),], n = 3)
    }
    else{
      head(diamonds, n = 3)
    }
  })

  colorInput <- reactive({
    switch(input$color,"D" = "D", "F" = "F","G" = "G","H"="H", "I"="I","J"="J")
  })


  #model2<- lm(price ~ carat, data = diamondss)
  modelpred2 <- reactive({

    colorSelected <- input$color
    caratInput2 <- input$slider2
    model2<- lm(price ~ carat, data = filter(diamonds,color==colorSelected))
    predict(model2, newdata = data.frame(carat = caratInput2,color=colorSelected))

  })

  #diamondss scatterplot (2)
  output$plot2<- renderPlot({
    caratInput2 <- input$slider2
    colorSelected <- colorInput()

    model2<- lm(price ~ carat, data = filter(diamonds,color==colorSelected))

    with(diamonds[(diamonds$color == colorSelected),],

    plot(carat, price, xlab = "Mass(carats)", ylab = "Price (Sin$)",
         bg="lightgreen",cex=1,pch=21,frame=FALSE,col = alpha("green", 0.05),
         xlim = c(0, 3.5)))
    # plot line with the model
    abline(model2, col = "black", lwd = 2)
    points(caratInput2, modelpred2(), col = "black", pch = 16, cex = 2)


  })
  #diamondss prediction (2)
  output$pred2<- renderText({modelpred2()})
  })
