Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_91')
library(shiny)
library(RJDBC)

shinyServer(
    function(input, output) {
        
        ##reactives (connection, file, basic information)
        #read in the data
        getData <- reactive({
            inFile <- input$externalFile
            if (is.null(inFile))
                data <- NULL
            else  {
                data <- (read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote))
                return(data)
            }
        })
        
        #get metadata
        output$totalRows <- renderText({
            data <- getData()
            if (is.null(data))
                return ("If a file is uploaded, the metadata will appear") 
            else 
                paste(NROW(data),"cases")
        })
        
        output$totalColumns <- renderText({
            data <- getData()
            if (is.null(data))
                return ("") 
            else
                paste(NCOL(data), "columns")
        })
        
        output$colSelector <- renderUI({
            data <- getData()
            if (is.null(data))
                return ("") 
            else
                selectInput("ColSelect", h5("Choose a column you wish to observe"), choices = c("Choose a column...", colnames(data)))
            
        })
        
        output$distPlot <- renderPlot({
            data <- getData()
            x    <- input$ColSelect
            
            if (is.null(data) || class(data[,x])=="Factor")
                return ("") 
            else
                bins <- seq(min(data[,x]), max(data[,x]), length.out = input$bins + 1)
                hist(data[,x], breaks = bins, col = 'orange', border = 'white')
        })
    })
