library(shiny)
library(dplyr)
library(ggplot2)
library(patchwork) #

shinyServer(function(input, output) {
    
    dmain <- function(){iris} #in case
    
    scatter_plot <- eventReactive(input$scatter, {
        stopifnot(any(dmain()[as.character(input$xcol)]>0))
        stopifnot(any(dmain()[as.character(input$ycol)]>0))
        ggplot(dmain(), aes_string(x = input$xcol, y = input$ycol, fill = input$col))+
            geom_point(pch = 21)+
            scale_y_continuous(limits = c(0,NA))+
            scale_x_continuous(limits = c(0,NA))})
    
    density_plot <- eventReactive(input$density, {
        stopifnot(any(dmain()[as.character(input$xcol)]>0))
        stopifnot(any(dmain()[as.character(input$ycol)]>0))
        patchwork::wrap_plots(
            ggplot(dmain(), aes_string(x = input$xcol, fill = input$col))+
                geom_density(alpha = 0.3),
            ggplot(dmain(), aes_string(x = input$ycol, fill = input$col))+
                geom_density(alpha = 0.3), ncol = 2)+
            coord_flip()+
            scale_y_continuous(limits = c(0,NA))+
            scale_x_continuous(limits = c(0,NA))})
    
    box_plot <- eventReactive(input$boxplot, {
        #stopifnot(length(unique(dmain()[as.character(input$col)]))<value)
        # grouping variable must be of class factor
        # todo: check # of unique values 
        # todo: make var a factor
        # todo: if not throw error or warning
        patchwork::wrap_plots(
            ggplot(dmain(), aes_string(x = input$xcol, y = input$col))+
                geom_boxplot(),
            ggplot(dmain(), aes_string(x = input$col, y = input$ycol))+
                geom_boxplot(), nrow = 1)})
    
    observeEvent(input$scatter, { output$plot <- renderPlot({scatter_plot()})})
    observeEvent(input$density, { output$plot <- renderPlot({density_plot()})})
    observeEvent(input$boxplot, { output$plot <- renderPlot({box_plot()})})})
