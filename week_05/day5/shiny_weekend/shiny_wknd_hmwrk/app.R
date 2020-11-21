library(tidyverse)
library(CodeClanData)
library(shiny)
library(DT)
library(shinythemes)
game_sales

ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Game Chooser"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "platform", "What platform do you use?",
                  choices = sort(unique(game_sales$platform)), 
                  selected = "PS4"
                  ),
      
      selectInput("genre",
                  "What genre do you like?",
                  choices = sort(unique(game_sales$genre))
      ),
      radioButtons("age", "How old are you?",
                   choices = c("6 - 10 years old",
                               "10 - 13 years old",
                               "13 - 17 years old",
                               "18+ years old")),
      
      
      actionButton("update", "Show Games I like")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Popular Genres", plotOutput("plot")
                 ),
        tabPanel("Table of Games", DT::dataTableOutput("table"))
      )
    )
  )
)

server <- function(input, output) {
  
  output$plot <- renderPlot({
#I plotted this data to show the user the most popular genre by a platform is used.
    #It supposed to help the user to pick up genre with the highest user score.
    game_sales %>% 
      filter(platform == input$platform) %>% 
      ggplot() +
      aes(x = reorder(genre, -user_score, FUN = sum), y = user_score)+
      geom_col(color = "light green", fill = "light green")  +
      theme_light() +
      theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
      labs(title = "Most Popular Genres",
           x = "Genre",
           y = "User Score")
  })
  
  filtered_data <- eventReactive(input$update, {
   game_sales %>%
      filter(platform == input$platform) %>%
      filter(genre == input$genre) %>% 
      select(name, platform, genre, year_of_release, user_score, rating)
  })
  
  output$table <- DT::renderDataTable(
    
                    if (input$age == "6 - 10 years old") {
                      filtered_data() %>% 
                      filter(rating == "E") }
                    
                    else if (input$age == "10 - 13 years old") {
                      filtered_data() %>% 
                        filter(rating == "E10+") } 
                    
                    else if (input$age == "13 - 17 years old") {
                      filtered_data() %>% 
                        filter(rating == "T") } 
                    
                    else {
                      filtered_data() %>% 
                        filter(rating == "M") } 
                    
                    
      
  )}
              

shinyApp(ui = ui, server = server)