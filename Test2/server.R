library(shiny)
library(lpSolveAPI)
shinyServer(function(input, output) {
  lprec <- make.lp(5, 2)
  invisible(lp.control(lprec, sense = "max"))
  set.objfn(lprec, c(617, 238))
  set.constr.value(lprec, rhs = c(166,150,100,0,0), constraints=seq(1:5))
  set.constr.type(lprec, c(rep("<=", 3), rep(">=", 2)))
  set.row(lprec, 1, c(1, 1), indices = c(1, 2))
  set.row(lprec, 2, 1, indices = 1)
  set.row(lprec, 3, 1, indices = 2)
  set.row(lprec, 4, 1, indices = 1)
  set.row(lprec, 5, 1, indices = 2)
  dimnames(lprec) <- list(c("capacity","reg_demand", "discount_demand", "reg_positive", "disc_positive"), c("reg","disc"))
  output$outRegDemand <- renderPrint({input$regDemand})
  output$outDiscDemand <- renderPrint({input$discDemand})
  
  output$objective <- renderText({
    set.constr.value(lprec, rhs = c(166,input$regDemand,input$discDemand,0,0), constraints=seq(1:5))
    solve(lprec)
    get.objective(lprec)
  })
  
  output$variables <- renderText({
    set.constr.value(lprec, rhs = c(166,input$regDemand,input$discDemand,0,0), constraints=seq(1:5))
    solve(lprec)
    get.variables(lprec)
  })
  
}
)
