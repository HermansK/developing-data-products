shinyUI(
    fluidPage(
        fluidRow(
            column(
                7, 
                style = "height:90vh; width:40vh; background-color: #EDEDED;",
                #file uploader
                fileInput('externalFile', 
                          h4('Select CSV'), 
                          accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')
                ),
                #add check box to indicate header
                checkboxInput(
                    'header', 
                    'Header',
                    TRUE
                ),
                
                #add the possibility to choose a separator
                selectInput(
                    inputId = "sep", 
                    label = "Separator", 
                    choices = list("Comma" = ',', "Semicolon" = ';', "Tab" = '\t', "Pipe" = '|'), 
                    selected = 1
                ),
                
                #add the possibility to choose quote options
                selectInput(
                    inputId = "quote", 
                    label = "Quote", 
                    choices = list("None" = '', "Single quotes" = "'", "Double quotes" = '"'), 
                    selected = 1),
                #just two add some space before
                tags$br(),
                
                #add metadata of file
                tags$p(h4("Metadata of the file uploaded")),
                textOutput("totalRows"),
                textOutput("totalColumns"),
                textOutput("classes")
            ),
            
            # Main area (middelste gedeelte)
            column(width=3, 
                   
                   #box to select which header you wish to select
                   uiOutput(outputId="colSelector")
                   
                  
            ),
            
            column(width=3,
                   offset = 1,
                   sliderInput("bins", "Number of bins:", min = 1, max = 30, value = 15)
            ),
            column(8,
            plotOutput("distPlot"))
        )
    )
)


