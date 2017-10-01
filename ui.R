library(shiny)

shinyUI(fluidPage(
  titlePanel("Linear models bewteen Key Country variables"),
  sidebarLayout(
    sidebarPanel(
        h3("HDI Ranking of Countries"),
        h5("188 Countries in the World by their Human Development Index (HDI)"),
        sliderInput("sliderX", "Pick a range of HDI Index and click Submit",
                    0, 200, value = c(50, 120)),
        submitButton("Submit"),
        h3("Linear models"),
        h4("GDP per Capita vs. Education Index"),
        h5("Linear model R squared = "),
        textOutput("slopeOut"),
        h4("GDP per Capita vs. CO2 Emissions"),
        h5("Linear model R squared = "),
        textOutput("slopeOut2")
    ),
    mainPanel(
              fluidRow(
                     plotOutput("plot1"),
                plotOutput("plot2"))

    )
  )
))
