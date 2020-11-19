library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinythemes)



ui <- fluidPage(
    theme = shinytheme("cyborg"),
    
    titlePanel(tags$h4("Cars speed and distance")),
    
    plotOutput("cars_plot"),
    
    fluidRow(
        
        column(6, 
               sliderInput("slider1", label = h3("Speed"), min = 4, 
                           max = 25, value = 20)),
        column(6, 
               sliderInput("slider2", label = h3("Distance"), min = 2, 
                           max = 120, value = 50)
        )
    )
)

    

server <- function(input, output) {
   output$cars_plot <- renderPlot({
        ggplot(cars) +
        aes(x = input$slider1, y = input$slider2) +
        geom_col(fill = "sky blue") +
        theme_light() +
        labs(x = "Speed",
             y = "Distance") +
           ylim(NA, 130) +
           xlim(0, 30)
    })
}
shinyApp(ui = ui, server = server)