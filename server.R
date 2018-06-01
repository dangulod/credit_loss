library(shiny)
library(shinydashboard)
library(creditRisk)
library(highcharter)

set.seed(12345)
n  = 1e6
Sn = rnorm(n)

shinyServer(function(input, output) 
{
  data = reactive({
    x = bucketRetail(PD  = input$PD,
                     EAD = input$EAD,
                     LGD = input$LGD,
                     rho = input$rho)
    
    x$loss(Sn)
  })
  
  EL = reactive({
    x = bucketRetail(PD  = input$PD,
                     EAD = input$EAD,
                     LGD = input$LGD,
                     rho = input$rho)
    
    x$getEL()
  })
  
  output$Lossplot = renderHighchart({
    
    highchart() %>% 
      hc_add_series(density(data()), 
                    type = "area",
                    color = "#B71C1C",
                    name = "Loss") %>% 
      hc_add_series(density(data() * ( 1 - input$alpha ) + input$FL - EL() * input$alpha), 
                    type = "area", 
                    color = "#008080", 
                    name = "Securitized")
    # hchart(density(data()), type = "area", color = "#B71C1C", name = "Loss") %>% 
    #   hc_add_series(density(data() * ( 1 - input$alpha ) + input$FL - EL() * input$alpha), 
    #                 type = "area", 
    #                 color = "#008080", 
    #                 name = "Securitized")
  })
  
  
  
})
