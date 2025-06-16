# 🌍 World Wide Energy Consumption — SQL Data Analysis Project

## 📚 Project Overview

This project was developed as part of my coursework to analyze worldwide energy data using SQL and MySQL. The dataset includes global data on energy consumption, production, emissions, population, and GDP.

By completing this project, I practiced:

- Database design and schema creation
- Data import using CSV files
- Defining relationships between multiple tables
- Writing advanced SQL queries to generate insights
- Performing both global and country-wise analyses

---

## 🗄 Database Schema

The database consists of 6 tables:

| Table Name  | Description                              |
| ------------ | ------------------------------------------ |
| `country`    | Country list with unique country IDs      |
| `emission_3` | Emission data by country, year, energy type |
| `population` | Yearly population data for countries      |
| `production` | Energy production data by year & type     |
| `gdp_3`      | Yearly GDP (PPP) values                   |
| `consumption`| Energy consumption data                   |

---

## 🔧 Technologies Used

- MySQL
- SQL
- MySQL Workbench
- CSV files
- Git / GitHub

---

## ⚙ Project Setup

### 1️⃣ Create Database and Tables

Run the script `database_creation.sql` to create the database and tables.

### 2️⃣ Import CSV Data

Use MySQL Workbench's **Table Data Import Wizard** to import data into each table. Follow the instructions in `data_import_instructions.txt`.

### 3️⃣ Run Queries

Once data is imported, run `queries.sql` to answer analytical questions.

---

## 🧮 Data Analysis Questions Answered

- Total emissions per country for the most recent year
- Top 5 countries by GDP
- Energy production vs consumption
- Global emissions trends
- GDP trends over years
- Population impact on emissions
- Energy consumption and production per capita
- Emissions-to-GDP ratio
- Global comparisons of emissions, GDP, population

---

## 🚀 Learning Outcomes

- SQL querying with real-world data
- Database normalization and foreign key constraints
- Data aggregation and joins
- Developing end-to-end analytics pipeline using SQL

---

✅ **This project demonstrates my practical skills in SQL and data analysis using relational databases.**
