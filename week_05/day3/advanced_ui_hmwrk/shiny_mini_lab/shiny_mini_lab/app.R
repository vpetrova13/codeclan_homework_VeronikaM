library(tidyverse)
library(shiny)
library(shinythemes)

olympics_overall_medals  <- read_csv("~/codeclan_work/week_05/day3/shiny_mini_lab/data/olympics_overall_medals.csv")

ui <- fluidPage(
    titlePanel(tags$h3("Five Country Medal Comparison")),
    
    tabsetPanel(
        tabPanel("Which season?",
            radioButtons(inputId = "season",
                tags$h5("Summer or winter olympics?"),
                choices = c("Winter", "Summer")
            )
        )
    , tabPanel("Which medal type?", 
                 radioButtons(
                     inputId = "medal",
                     tags$h5("Gold, silver or bronze?"),
                     choices = c("Gold", "Silver", "Bronze"))
        ), tabPanel("Plot",
                   plotOutput(outputId = "medal_plot")
                   )
        )
    )


server <- function(input, output) {
    
    output$medal_plot <- renderPlot({
            colour <- case_when(input$medal == "Gold" ~ "goldenrod1",
                                input$medal == "Silver" ~ "gray79",
                                input$medal == "Bronze" ~ "sienna3")
            olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%  
            ggplot() +
            aes(x = team, y = count) +
            geom_col(fill = colour) 
    })
}


# Run the application 
shinyApp(ui = ui, server = server)
