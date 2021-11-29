library(shiny)
library(shinydashboard)

vars <- unique(names(iris))

shinyUI(
    dashboardPage(skin = "yellow",
        dashboardHeader(title = "little-jibe"),
        dashboardSidebar(
            br(),
            tags$p("presents the", tags$code("iris"), "dataset"),
            br(),
            selectInput("xcol","x axis", vars),
            selectInput("ycol","y axis", vars, selected = vars[2]),
            selectInput("col","fill colour", vars, selected = vars[length(vars)]),
            hr(),
            actionButton(inputId = "scatter", label = "scatter plot"),
            actionButton(inputId = "density", label = "density plot"),
            #helpText("*if needed"),
            actionButton(inputId = "boxplot", label = "boxplot")),
        dashboardBody(
            fluidRow(
                title = "Plot",
                box(plotOutput("plot"))))
    ))
