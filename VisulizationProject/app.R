#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(shinydashboard)

flights <- read.csv("flights/APR2019.csv", stringsAsFactors = FALSE)
airlines <- unique(flights$OP_UNIQUE_CARRIER)
carrier_code<-read.csv("L_UNIQUE_CARRIERS.csv_")
merged<-merge(x=flights,y=carrier_code,by.x="OP_UNIQUE_CARRIER", by.y = "Code",all.x = TRUE)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(tags$head(
    disable = TRUE,
    tags$style(HTML('.navbar {margin-bottom:0 !important;}
                    .container-fluid{padding:0 !important}
                    .navbar-header{padding-left:15px}'))
),
navbarPage(
    "Flights Dahboard",
    tabPanel("Dashboard",
             dashboardPage(skin = "blue",
                           dashboardHeader(disable = TRUE),
                           dashboardSidebar(
                               selectInput("airline", "Airlines",
                                           choices = unique(merged$Description),
                                           selected = NULL, multiple = FALSE,
                                           selectize = TRUE),
                               selectInput("Month", "Month",
                                           choices = c("All Year",unique(month.abb[merged$MONTH])),
                                           selected = NULL, multiple = FALSE,
                                           selectize = TRUE)
                           ),
                           dashboardBody(
                               valueBoxOutput("nof"),
                               valueBoxOutput("avgflights"),
                               valueBoxOutput("delflights")
                           )
             )),
    tabPanel("Seattle Flights",
             dashboardPage(skin = "blue",
                           dashboardHeader(disable = TRUE),
                           dashboardSidebar(
                               
                           ),
                           dashboardBody(
                               
                           )
             )),
    tabPanel("Predictive Analytics",
             dashboardPage(skin = "blue",
                           dashboardHeader(disable = TRUE),
                           dashboardSidebar(
                               
                           ),
                           dashboardBody(
                               
                           )
             ))
)
))

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    }) 
}


# Run the application 
shinyApp(ui = ui, server = server)
