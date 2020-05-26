
library(shiny)
library(webshot)

shinyUI(fluidPage(
  titlePanel( div(HTML("<em><h4>Diamonds analysis</em>"))),

    mainPanel(
      #tab panel to split information
      tabsetPanel(type="tabs",
                  #tab containind data
                  tabPanel("Data",br(), checkboxInput("filterCut", "Filter by cut", value = TRUE),
                           selectInput(inputId = "cut",
                                       label = "Choose a diamond cut:",
                                       choices = c("Fair", "Good", "Very Good","Ideal","Premium")),
                           verbatimTextOutput("summary"),
                           # Output: HTML table with requested number of observations
                           tableOutput("view")),
                  #tab containing plot
                  tabPanel("Simple plot and model",br(),
                    sliderInput("slider", "What is the price of the diamond?", 0, 3.5, value = 1,step=0.25),
                    #checkboxInput("showModel", "Show/Hide Model", value = TRUE),
                    h5("Predicted diamond price (Sin$):",textOutput("pred"),plotOutput("plot"))),
                  #tab containing filtered plot
                  tabPanel("Filtered plot and model",br(),
                           selectInput(inputId = "color",label = "Choose a diamond color:",choices = c("D","F","G","H","I","J")),
                           sliderInput("slider2", "What is the price of the diamond?", 0, 3.5, value = 1,step=0.25),
                           h5("Predicted diamond price (Sin$):",textOutput("pred2"),plotOutput("plot2"))),
                  #tab containing how-to
                  tabPanel("How to use the application",br(),
                    h5(" This page displays the diamonds data available in the UsingR package.
                       It contains four diferent tabs with different pieces of information:"),
                    h5("\n"),
                    strong("1. Data Tab."),
                    h5("\n"),
                    h5("Shows a summary of the Diamonds dataset and the first three rows of values.
                       The information can be filtered by diamond cut clicking the checkbox and selecting the cut type in the dropdown list.
                       In case the checkbox is not selected, no filter is applied."),
                    h5("\n"),
                    strong(("2. Simple plot and model.")),
                    h5("\n"),
                    h5("Displays a carat vs. price plot and a linear model fitting prices based on the number of carats.
                      With a slider, the user can move along the model selecting the number of carats and get an estimation of the price (based
                      on the model prediction."),
                    h5("\n"),
                    strong("3. Filtered plot and model."),
                    h5("\n"),
                    h5("In this tab the user can select the diamond color and both the plot and a liner model (carats vs. price) will be
                       filtered with the selection. Like in tab 2, the user can move along the linear fit selecting the number of carats
                       with a slider to see the estimated diamond price."),
                    h5("\n"),
                    h5("Tabs 2 and 3 can be used together to see how the estimated price value changes when filtering data and model by color."),
                    strong("4. How-to."),
                    h5("\n"),
                    h5(" Finally the last tab shows the basic documnentation you're reading on how to use the aplication.")

                  )
                )
      )
    )
)
