library(shiny)
shinyUI(
  navbarPage("Airline Revenue Optimization",
             tabPanel("Instructions",
                      mainPanel(
h3('Instructions for use'),
h4('This app asks the user to input two values, demand for regular priced seats and demand 
for discount seats.  Upon clicking the Submit button the shiny App will update a linear program
with the two demand constraints entered and solve it using the lpSolveAPI package in R.  
The App will return the optimized decision variables - the number of seats to be sold at each price level
and the optimized objective value - the maximum possible revenue given the demand.'),
h4('There are several other constraints that cannot be changed by user input:'),
h4('- No more than 166 total seats can be sold, the maximum capacity of the airplane'),
h4('(there is no overbooking on this airline)'),
h4('- Regular priced seats sold cannot exceed Regular demand'),
h4('- Discount seats sold cannot exceed Discount demand '),
h4('- Seats sold must be nonnegative'),
h4('Regular priced seats are priced at US$617 and Discount seats at US$238'),
h4('This App is based on a lesson presented in the edX/MITx MOOC:'),
h3(a('The Analytics Edge', href="https://www.edx.org/course/analytics-edge-mitx-15-071x-0")),
h4('The lesson for this problem is solved in LibreOffice in the video linked below'),
h3(a('Airline Revenue Management', href="https://www.youtube.com/watch?v=Jw38g53g-s0")),
h3('Background on Optimization'),
h4('Linear programming (LP, also called linear optimization) is a method to achieve the best outcome 
(such as maximum profit or lowest cost) using a mathematical model whose requirements are represented 
by linear relationships. Linear programming is a special case of mathematical programming 
(mathematical optimization). The lpSolveAPI package capably handles even very large Linear Programs
(LPs) with many thousands of variables and constraints as well as Mixed Integer Programs (MIPs).  Several 
commercial solvers are available - Gurobi and CPLEX being the most well known - that can be used for 
problems that are insolvable using the lpSolveAPI solver.  It should be mentioned that many MIPs have proven 
intractable to even these commercial solvers.' ))),           
             tabPanel("LP Model",
                      mainPanel(
                        h3('The LP formulation below is created in R based on the user inputs and is solved using the 
                           lpSolveAPI package'),
                        verbatimTextOutput("model"))),
             
             tabPanel("Optimization of Airline Revenue",
             sidebarPanel(
               h3('Please select demand for both price levels'),
               numericInput('regDemand','Regular Price demand', 100, min = 50, max = 200, step = 1),
               numericInput('discDemand','Discount Price demand', 150, min = 50, max = 200, step = 1),
               submitButton('Submit')),
             mainPanel(
               h3('Results of optimization'),
               h4('You entered Regular Price demand of'),
               verbatimTextOutput("outRegDemand"),
               h4('You entered Discount Price demand of'),
               verbatimTextOutput("outDiscDemand"),
               h4('If Regular/Discount seats are sold in the following quantities '),
               verbatimTextOutput("variables"),
               h4('it will result in optimized revenue of '),
               verbatimTextOutput("objective")))
             ))
