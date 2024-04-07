library(rhandsontable)
library(shiny)
library(dplyr)

gradeTable <- function(){
	DF <- data.frame(
		name = "<name>"
		, weight = 0
		, score = 0
	)
	ui <- shinyUI(fluidPage(

		titlePanel("Edit and save a table"),
		sidebarLayout(
			sidebarPanel(
				helpText("Right-click on the table to delete/insert rows" 
					, "Double-click on a cell to edit"
				)

				, wellPanel(
					h3("Calculate"), 
					actionButton("Calculate", "Calculate grade")
				)				
				, br()
				, wellPanel(
					h3("Save"), 
					actionButton("save", "Save table")
				)				

			),

			mainPanel(

				rHandsontableOutput("hot")

			)
		)
	))

	server <- shinyServer(function(input, output) {

		values <- reactiveValues()

		## Handsontable
		observe({
			if (!is.null(input$hot)) {
				DF = hot_to_r(input$hot)
			} else {
				if (is.null(values[["DF"]]))
					DF <- DF
				else
					DF <- values[["DF"]]
			}
			values[["DF"]] <- DF
		})

		output$hot <- renderRHandsontable({
			DF <- values[["DF"]]
			if (!is.null(DF))
				rhandsontable(DF,  stretchH = "all")
		})

		## Save 
		observeEvent(input$save, {
			finalDF <- isolate(values[["DF"]])
			saveRDS(finalDF, file=file.path(outdir, sprintf("%s.rds", outfilename)))
		})

		observeEvent(input$Calculate, {
			finalDF <- (isolate(values[["DF"]]) |> gradeCalc())
			values[["DF"]] <- finalDF
		})

	})

	## run app 
	runApp(list(ui=ui, server=server))
	return(invisible())
}

gradeCalc <- function(df){
	fin <- df |> filter(!is.na(points)) 
	tot <- (fin 
		|> mutate(points = weight*score)
		|> summarize(list(weight = sum(weight)
			, points = sum(points)
		))
		|> transmute(name="Final", score=points, weight=weight)
	)
	return(bind_rows(fin, tot))
}

gradeTable()
