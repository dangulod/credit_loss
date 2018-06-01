library(shiny)
library(shinydashboard)
library(highcharter)

dashboardPage(
  skin = "red",
  dashboardHeader(title = "Loss distribution"),
  dashboardSidebar(disable = T),
  dashboardBody(
    box(
        title = "Parameters",
        width = 12,
        collapsible = T,
        solidHeader = T, 
        status = "danger",
        fluidRow(
          column(
            numericInput(inputId = "EAD", 
                         label = "Exposure at Defatult", 
                         value = 10000, 
                         step = 1000,
                         min = 0),
            width = 3
          ),
          column(
            sliderInput(inputId = "PD",
                        label = "Probability of Default", 
                        value = 0.15,
                        min = 0, 
                        max = 1),
            width = 3),
          column(
            sliderInput(inputId = "LGD",
                        label = "Loss Given Default", 
                        value = 0.35,
                        min = 0, 
                        max = 1),
            width = 3),
          column(
            sliderInput(inputId = "rho",
                        label = "Asset Correlation", 
                        value = 0.15,
                        min = 0, 
                        max = 1),
            width = 3)
        ),
        fluidRow(
          column(
            numericInput(inputId = "FL", 
                         label = "First Loss", 
                         value = 1000, 
                         step = 100,
                         min = 0),
            width = 3
          ),
          column(
            sliderInput(inputId = "alpha",
                        label = "% Securitized", 
                        value = 0.15,
                        min = 0, 
                        max = 1),
            width = 3)
        )
    ),
    box(
      highchartOutput(outputId = "Lossplot"),
      width = 12
    )
  )
)

