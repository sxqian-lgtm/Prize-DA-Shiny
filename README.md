# Prize Dashboard

An interactive Shiny dashboard for exploring diversity and representation in literary prize data. This project visualizes demographic patterns, prize genres, and temporal trends using the TidyTuesday Literary Prizes dataset.

## Project Overview

This dashboard provides an interface for examining demographic and prize‑related characteristics of authors. It supports transparent, data‑driven discussions about diversity, equity, and representation in literary prize cultures.

The app includes summary statistics, interactive charts, and a keyword‑searchable data table.

## Dataset Description

The dataset contains publicly available information about authors, including:

Gender

Sexuality

UK residency

Ethnicity

Geography

Educational background (institutions and fields of study)

These variables help researchers study cultural, social, and political factors that shape literary prestige. Because demographic information can be sensitive, the dataset is intended for analyzing broad patterns rather than making definitive claims about individuals.

Data Source:https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-10-28/readme.md

## Dashboard Features

1. Project Introduction

Displays project description and data source

Allows users to select any variable and view summary statistics

2. Charts

Prize Genre Distribution — pie chart of prize genres

Gender Distribution — pie chart of gender representation

Gender Representation Over Time — interactive line chart

Genre Representation Over Time — interactive line chart

3. Search Data

A searchable table that includes:

Book title

Prize alias

Prize genre

Prize year

Author name

Gender

Ethnicity

Keyword search is applied across all fields.

Code Structure

The app includes:

UI components (header, sidebar, body)

Server logic for rendering text, summaries, plots, and search results

Helper functions for generating all charts

## Running the App

Place prizes.rds in your working directory and run:

shinyApp(ui = ui, server = server)

## Author

Shuxin Qian

Boston University

Master of Science in Statistical Practice
