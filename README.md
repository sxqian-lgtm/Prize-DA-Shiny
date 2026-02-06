## Prize DashboardDescription: An interactive Shiny dashboard for exploring diversity and representation in literary prize data.

Project OverviewThis project builds a Shiny dashboard to visualize demographic and prize-related characteristics of authors included in the TidyTuesday Literary Prizes dataset. The goal is to support transparent, data-driven discussions about diversity, equity, and representation in literary prize cultures. The dashboard provides charts, summaries, and a searchable data table.

Dataset DescriptionThe dataset contains publicly available information about authors, including gender, sexuality, UK residency, ethnicity, geography, and educational background. These variables allow researchers to study cultural, social, and political factors that shape literary prestige. Because demographic information can be sensitive, the dataset is intended for examining broad patterns rather than making definitive claims about individuals.

Data Sourcehttps://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-10-28/readme.md

Dashboard Features

Project Introduction

Displays project description and data source

Allows users to select any variable and view summary statistics

Charts

Prize Genre Distribution: pie chart showing proportions of prize genres

Gender Distribution: pie chart showing gender representation

Gender Representation Over Time: line chart showing gender proportions by year

Genre Representation Over Time: line chart showing genre proportions by year

Search Data

Searchable table including book title, prize alias, prize genre, prize year, author name, gender, and ethnicity

Keyword search across all fields

Code StructureThe app includes UI components (header, sidebar, body), server logic for rendering text, summaries, plots, and search results, and helper functions for generating the charts.

Running the AppPlace prizes.rds in your working directory and run shinyApp(ui = ui, server = server).

AuthorShuxin QianBoston UniversityMaster of Science in Statistical Practice
