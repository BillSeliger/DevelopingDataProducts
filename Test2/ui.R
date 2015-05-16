library(shiny)
shinyUI(
  pageWithSidebar(
    # Application Title
    headerPanel("Airline Revenue Optimization"),
    
    sidebarPanel(
      numericInput('regDemand','Regular Price demand', 100, min = 50, max = 200, step = 1),
      numericInput('discDemand','Discount Price demand', 150, min = 50, max = 200, step = 1),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Results of optimization'),
      h4('You entered Regular Price demand of'),
      verbatimTextOutput("outRegDemand"),
      h4('You entered Discount Price demand of'),
      verbatimTextOutput("outDiscDemand"),
      h4('If Regular/Discount are sold in the following quantities '),
      verbatimTextOutput("variables"),
      h4('it will result in optimized revenue of '),
      verbatimTextOutput("objective")
    )
  )
)
