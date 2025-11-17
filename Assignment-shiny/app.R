library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
library(plotly)

# ---- load data (check file exists) ----
rds_path <- "prizes.rds"
prizes <- readRDS(rds_path)
prizes <- prizes %>%
  mutate(
    prize_id  = factor(prize_id),
    person_id = factor(person_id),
    book_id   = factor(book_id),
    gender =factor(gender)
  )


prizes_text1 <- "This dataset contains primary categories of information on individual authors comprising gender, sexuality, UK residency, ethnicity, geography and details of educational background, including institutions where the authors acquired their degrees and their fields of study. Along with other similar projects, we aim to provide information to assess the cultural, social and political factors determining literary prestige. Our goal is to contribute to greater transparency in discussions around diversity and equity in literary prize cultures."
prizes_text2 <- "All of the information in this dataset is publicly available. Information about a writer’s location, gender identity, race, ethnicity, or education from scholarly and public sources can be sensitive. The data provided here enables the study of broad patterns and is not intended as definitive."
prizes_url   <- "Source Link: https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-10-28/readme.md"
prizes_name  <- colnames(prizes)

make_prize_genre_pie <- function(x = prizes) {
  df <- x %>%
    count(prize_genre) %>%
    mutate(
      prop  = n / sum(n),
      label = scales::percent(prop, accuracy = 0.1),
      ypos  = cumsum(prop) - 0.4 * prop
    )
  ggplot(df, aes(x = 1, y = prop, fill = prize_genre)) +
    geom_col(width = 1, color = "white") +
    coord_polar(theta = "y") +
    geom_text(aes(x = 1.3, y = ypos, label = label), size = 3) +
    theme_void() +
    labs(title = "Prize Genre Distribution", fill = "Genre")
}

make_gender_pie <- function(x = prizes) {
  df <- x %>%
    count(gender) %>%
    mutate(prop = n / sum(n),
           label = scales::percent(prop, accuracy = 0.1))
  ggplot(df, aes(x = "", y = prop, fill = gender)) +
    geom_col(width = 1) +
    coord_polar(theta = "y") +
    geom_text(aes(label = label), position = position_stack(vjust = 0.5), size = 4) +
    theme_void() +
    labs(title = "Gender Distribution", fill = "Gender")
}

make_gender_prize_line <- function(x = prizes) {
  df_gender_year <- x %>%
    filter(!is.na(gender)) %>%
    count(prize_year, gender) %>%
    group_by(prize_year) %>%
    mutate(prop = n / sum(n)) %>%
    ungroup()
  if (!is.numeric(df_gender_year$prize_year)) {
    df_gender_year$prize_year <- as.numeric(as.character(df_gender_year$prize_year))
  }
  ggplot(df_gender_year, aes(x = prize_year, y = prop, color = gender)) +
    geom_line(size = 1.2) +
    geom_point(size = 2) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    labs(
      title = "Gender Representation over Time",
      x = "Prize Year",
      y = "Proportion of Awardees",
      color = "Gender"
    ) +
    theme_minimal()
}

prize_genre_pie  <- make_prize_genre_pie()
gender_pie        <- make_gender_pie()
gender_prize_line <- make_gender_prize_line()

search_data <- prizes %>%
  select(book_title, prize_alias, prize_genre, prize_year, name, gender, ethnicity)

# ---- UI ----
ui <- dashboardPage(
  dashboardHeader(title = "Prize Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Project Intro", tabName = "intro", icon = icon("info")),
      menuItem("Charts", tabName = "charts", icon = icon("chart-pie")),
      menuItem("Search Data", tabName = "search", icon = icon("search"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro",
              fluidRow(
                box(width = 12,
                    h3("Project Description"),
                    textOutput("intro_text1"),
                    textOutput("intro_text2"),
                    textOutput("intro_link")
                ),
                box(width = 12,
                    selectInput("summary_var", "Selecting variable", choices = prizes_name)
                ),
                box(width = 8,
                    verbatimTextOutput("summary_output")
                )
              )
      ),
      tabItem(tabName = "charts",
              fluidRow(
                box(width = 6, plotOutput("plot_prize_genre")),
                box(width = 6, plotOutput("plot_gender"))
              ),
              fluidRow(
                box(width = 12, plotlyOutput("plot_gender_year"))
              )
      ),
      tabItem(tabName = "search",
              fluidRow(
                box(width = 4, textInput("keyword", "Search:", "")),
                box(width = 12, DTOutput("search_table"))
              )
      )
    )
  )
)

server <- function(input, output, session) {
  output$intro_text1 <- renderText({ prizes_text1 })
  output$intro_text2 <- renderText({ prizes_text2 })
  output$intro_link  <- renderText({ prizes_url })
  output$summary_output <- renderPrint({
    req(input$summary_var)
    summary(prizes[[input$summary_var]])
  })
  output$plot_prize_genre <- renderPlot({ prize_genre_pie })
  output$plot_gender      <- renderPlot({ gender_pie })
  output$plot_gender_year <- renderPlotly({ ggplotly(gender_prize_line)})
  output$search_table <- renderDT({
    filtered <- if (input$keyword == "") {
      head(search_data, 10)
    } else {
      search_data %>%
        filter(across(everything(), ~ grepl(input$keyword, .x, ignore.case = TRUE)))
    }
    datatable(filtered, options = list(pageLength = 10, scrollX = TRUE))
  })
}

# ---- run ----
shinyApp(ui = ui, server = server)
