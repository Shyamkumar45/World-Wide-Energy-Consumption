🌍 World Wide Energy Consumption — SQL Data Analysis Project
📚 Project Overview
This project is part of my coursework at the institute where I am currently learning Data Analysis, SQL, and Database Management Systems (DBMS). The objective of this project is to analyze real-world energy data using SQL queries and database concepts.

The dataset simulates data collected from the EIA (U.S. Energy Information Administration) and includes information about:

Energy consumption

Energy production

Emissions

Population

GDP (PPP)

Countries

By working on this project, I have practiced core concepts of:

Database design and schema creation

Data import and normalization

Establishing table relationships with foreign keys

Writing complex SQL queries for data analysis

Conducting multi-level aggregations

Deriving meaningful insights from real-world data

🔧 Tools & Technologies
MySQL (RDBMS)

SQL (Structured Query Language)

CSV Data Import

MySQL Workbench

Git & GitHub (for version control and portfolio building)

🗄 Database Schema
The project consists of 6 interrelated tables:

Table Name	Description
country	Master table containing country codes and country names
emission_3	Emission data by country, year, and energy type
population	Yearly population data by country
production	Energy production data by country, year, and energy type
gdp_3	GDP data (Purchasing Power Parity) by country and year
consumption	Energy consumption data by country, year, and energy type

Each table (except country) has a foreign key relationship with the country table to maintain referential integrity.

📥 Dataset Source
The data provided for this project is a simulated version of actual energy statistics inspired by international organizations such as EIA, World Bank, and IMF. The dataset was shared as multiple CSV files which were imported into MySQL using Table Data Import Wizard.

🧮 Project Workflow
1️⃣ Database Creation
Created a new database ENERGYDB2 in MySQL.

2️⃣ Table Creation
Defined tables and data types based on the provided schema.

Applied appropriate primary and foreign keys to maintain data relationships.

3️⃣ Data Import
Imported CSV files into respective tables using MySQL Workbench.

4️⃣ Data Cleaning & Verification
Verified row counts, null values, and data consistency after import.

Ensured proper foreign key relationships are intact.

5️⃣ Data Analysis via SQL Queries
Wrote SQL queries to answer a variety of data analysis questions related to:

Total emissions

GDP comparisons

Energy production & consumption

Population growth effects

Per capita ratios

Global comparisons

6️⃣ Insights & Visualizations
The output of SQL queries can be exported to tools like Excel, Power BI, or Tableau for visual reporting.

