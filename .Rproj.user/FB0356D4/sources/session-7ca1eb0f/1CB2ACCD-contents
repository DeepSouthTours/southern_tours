# Load required libraries
library(shiny)
library(dplyr)
library(ggplot2)

# Load the results data frame
results <- readRDS("tour_cost_results.rds")

# Define UI
ui <- fluidPage(
  titlePanel("深南行费用估算"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "num_adult",
        "成人及年龄12岁及以上儿童人数:",
        choices = 1:4,
        selected = 1
      ),
      selectInput(
        "num_children",
        "12岁以下儿童人数:",
        choices = 0:3,
        selected = 0
      ),
      actionButton("get_quote", "获取报价")
    ),
    mainPanel(
      h3("您的家庭报价为："),
      uiOutput("quote_output") 
    )
  )
)

# Define server
server <- function(input, output, session) {
  
  observeEvent(input$get_quote, {
    # Filter results based on user input with fixed family_number = 3
    quote <- results %>%
      filter(
        num_adult == as.integer(input$num_adult),
        num_children == as.integer(input$num_children),
        family_number == 3
      ) %>%
      select(family_number, family_total_price, family_total_cost, 
             family_person_cost, family_person_price, family_total_profit, family_size) %>%
      slice(1) # Take the first row
    
    # Update the quote output
    output$quote_output <- renderUI({
      if (nrow(quote) == 0) {
        HTML("<p>无效输入，请重新输入人数.</p>")
      } else {
        HTML(paste0(
          "<p style='font-size:18px; color:blue; font-weight:bold;'>全家总费用: $", sprintf("%.2f", quote$family_total_price), "</p>",
          "<p style='font-size:18px; color:blue; font-weight:bold;'>人均费用: $", sprintf("%.2f", quote$family_person_price), "</p>",
          "<p> * 此报价包含全程住宿，餐饮（不包括自费点餐项目，详情参见<a href='https://r4miao.github.io/southern_tour/itinerary.html'>行程安排</a>）），门票，活动，交通，常备医药，以及服务费用（司机，导游，翻译，及其他人工）。</p>"
        ))
      }
    })
    
  })
}

# Run the application
shinyApp(ui = ui, server = server)