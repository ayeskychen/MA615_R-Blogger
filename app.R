
library(shiny)
library(ggvis)


ui <- fluidPage(sidebarLayout(
  sidebarPanel(
    sliderInput("n", "Number of points", min = 1, max = nrow(USArrests),
                value = 10, step = 1),
    uiOutput("plot_ui")
  ),
  mainPanel(
    ggvisOutput("plot"),
    tableOutput("ARST_table")
  )
)
)


server <- function(input, output,session) {
   

  # A reactive subset of USArrests
  data <- reactive({ USArrests[1:input$n, ] })
  
  # A simple visualisation. In shiny apps, need to register observers
  # and tell shiny where to put the controls
  data %>%
    ggvis(~UrbanPop, ~Murder) %>%
    layer_points() %>%
    bind_shiny("plot", "plot_ui")
  

}

# Run the application 
shinyApp(ui = ui, server = server)

