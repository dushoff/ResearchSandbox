library(rhandsontable)
library(shiny)
library(dplyr)

gradeTable <- function(tab=NULL){
	if(is.null(tab)){
		tab <- data.frame(
			name = "<name>"
			, weight = 0
			, score = 0
		)
	}
	ui <- shinyUI(fluidPage(

		titlePanel("Grade calculator"),
		sidebarLayout(
			sidebarPanel(
				helpText("Right-click on the table to delete/insert rows" 
					, "Double-click on a cell to edit"
				)

				, wellPanel(actionButton("Calculate", "Calculate grade"))
				, br()
				, wellPanel(NULL
					, numericInput("goal", "goal", 90)
					, actionButton("Project", "Project")
				)
			)

			, mainPanel(

				rHandsontableOutput("tab")
				, br()
				, rHandsontableOutput("project")
			)
		)
	))

	server <- shinyServer(function(input, output) {

		values <- reactiveValues()

		## Handsontable
		observe({
			if (!is.null(input$tab)) {
				tab = hot_to_r(input$tab)
			} else {
				if (is.null(values[["tab"]]))
					tab <- tab
				else
					tab <- values[["tab"]]
			}
			values[["tab"]] <- tab
		})

		output$tab <- renderRHandsontable({
			tab <- values[["tab"]]
			if (!is.null(tab))
				rhandsontable(tab,  stretchH = "all")
		})

		output$project <- renderRHandsontable({
			proj <- values[["proj"]]
			if (!is.null(proj))
				rhandsontable(proj,  stretchH = "all")
		})

		observeEvent(input$Calculate, {
			final <- (isolate(values[["tab"]]) |> gradeCalc())
			values[["tab"]] <- final
		})

		observeEvent(input$Project, {
			goal <- input$goal
			tab <- isolate(values[["tab"]])
			final <- projectGrade(goal, tab)
			values[["proj"]] <- final
		})

	})

	## run app 
	runApp(list(ui=ui, server=server))
	return(invisible())
}

gradeCalc <- function(df){
	df <- df |> filter(name != "Average") 
	fin <- df |> filter(!is.na(score)) 
	tot <- (fin 
		|> mutate(points = weight*score)
		|> summarize(weight = sum(weight)
			, points = sum(points)
		)
		|> transmute(name="Average", weight=weight, score=points/weight)
	)
	return(bind_rows(df, tot))
}

projectGrade <- function(goal, df){
	curr <- (df
		|> gradeCalc()
		|> filter(name == "Average") 
	)
	available <- (df
		|> filter(is.na(score))
		|> summarize(weight=sum(weight))
		|> pull(weight)
	)
	if (available <= 0) return(data.frame(note="No weight available"))
	req <- (goal*(curr$weight + available) - curr$weight*curr$score)/available
	return(df
		|> mutate(score = ifelse(is.na(score), req, score))
		|> gradeCalc()
	)
}

d <- data.frame(
	name = as.factor(1:4)
	, weight = 1:4
	, score = c(1:3, NA)
)

gradeTable()
