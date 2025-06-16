CREATE DATABASE ENERGYDB;
USE ENERGYDB;

-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

SELECT 
    *
FROM
    COUNTRY;

-- 2. emission table
CREATE TABLE emission (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country)
        REFERENCES country (Country)
);

SELECT 
    *
FROM
    EMISSION;


-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries)
        REFERENCES country (Country)
);

SELECT 
    *
FROM
    POPULATION;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country)
        REFERENCES country (Country)
);


SELECT 
    *
FROM
    PRODUCTION;

-- 5. gdp table
CREATE TABLE gdp (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country)
        REFERENCES country (Country)
);

SELECT 
    *
FROM
    GDP;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country)
        REFERENCES country (Country)
);

SELECT 
    *
FROM
    CONSUMPTION;
SELECT 
    *
FROM
    emission;
-- 1. What is the total emission per country for the most recent year available?
SELECT 
    country, SUM(emission) AS total_emission
FROM
    emission
WHERE
    year = (SELECT 
            MAX(year) AS recent_year
        FROM
            emission)
GROUP BY country
ORDER BY total_emission DESC;

SELECT 
    *
FROM
    gdp;
-- 2. What are the top 5 countries by GDP in the most recent year?
SELECT 
    MAX(year)
FROM
    gdp;-- most recent year
SELECT 
    country, value
FROM
    gdp
WHERE
    year = (SELECT 
            MAX(year)
        FROM
            gdp)
ORDER BY value DESC
LIMIT 5;

SELECT 
    *
FROM
    production;
SELECT 
    *
FROM
    consumption;

-- 3.Compare energy production and consumption by country and year. 
SELECT 
    p.country, p.energy, c.consumption, p.production
FROM
    production p
        JOIN
    consumption c ON p.country = c.country
        AND p.year = c.year
        AND p.energy = c.energy
ORDER BY production DESC;

SELECT 
    *
FROM
    emission;
-- 4.Which energy types contribute most to emissions across all countries?
SELECT 
    energy_type, SUM(emission) AS total_emission
FROM
    emission
GROUP BY energy_type
ORDER BY total_emission DESC;

SELECT 
    *
FROM
    emission;
-- Trend Analysis Over Time
-- 5. How have global emissions changed year over year?
SELECT 
    year, SUM(emission)
FROM
    emission
GROUP BY year
ORDER BY year DESC;


SELECT 
    *
FROM
    gdp;
-- 6.What is the trend in GDP for each country over the given years?
SELECT 
    country, year, value AS gdp
FROM
    gdp
ORDER BY country , year;

SELECT 
    *
FROM
    population;
SELECT 
    *
FROM
    emission;
-- 7. How has population growth affected total emissions in each country?
SELECT 
    p.countries,
    p.year,
    SUM(e.emission) AS total_emission,
    p.value AS population
FROM
    population p
        JOIN
    emission e ON p.countries = e.country
        AND p.year = e.year
GROUP BY p.countries , p.year , p.value
ORDER BY countries , year;

SELECT 
    *
FROM
    consumption;
SELECT 
    *
FROM
    gdp;
-- major economies top 5
SELECT 
    country, SUM(value) AS total_gdp
FROM
    gdp
GROUP BY country
ORDER BY total_gdp DESC
LIMIT 5;
-- 8. Has energy consumption increased or decreased over the years for major economies?
SELECT 
    c.year, SUM(c.consumption) AS total_consumption
FROM
    consumption c
        JOIN
    (SELECT 
        country, SUM(value) AS total_gdp
    FROM
        gdp
    GROUP BY country
    ORDER BY total_gdp DESC
    LIMIT 5) AS major_economies ON c.country = major_economies.country
GROUP BY c.year
ORDER BY c.year;

SELECT 
    *
FROM
    emission;
-- 9.What is the average yearly change in emissions per capita for each country?
SELECT 
    country, year, AVG(per_capita_emission)
FROM
    emission
GROUP BY country , year
ORDER BY country , year;

with emissionchanges as ( 
select country,year,
per_capita_emission,
lag(per_capita_emission) over(partition by country order by year) as pre_year_emission
from emission)
select country,round(avg(per_capita_emission-pre_year_emission),2) as avg_year_percapita_change 
from emissionchanges 
where pre_year_emission is not null
group by country
order by avg_year_percapita_change desc;

SELECT 
    *
FROM
    gdp;
-- Ratio & Per Capita Analysis
-- 10. What is the emission-to-GDP ratio for each country by year?
SELECT 
    e.country,
    e.year,
    ROUND((SUM(e.emission) / SUM(g.value)), 4) AS ratio
FROM
    emission e
        JOIN
    gdp g ON e.country = g.country
        AND e.year = g.year
GROUP BY country , year
ORDER BY country , year;

SELECT 
    *
FROM
    consumption;
-- 11.What is the energy consumption per capita for each country over the last decade?
WITH recent_years AS (
  SELECT MAX(year) AS max_year FROM consumption
),
consumption_data AS (
  SELECT c.country, c.year, c.consumption, p.value AS population
  FROM consumption c
  JOIN population p 
    ON c.country = p.countries AND c.year = p.year
  WHERE c.year >= (SELECT max_year - 9 FROM recent_years)  -- last 10 years
)
SELECT country,year,
  ROUND(SUM(consumption) / SUM(population), 4) AS consumption_per_capita
FROM 
  consumption_data
GROUP BY 
  country, year
ORDER BY 
  country,year;

SELECT 
    *
FROM
    population;
    
-- 12.How does energy production per capita vary across countries? 
SELECT 
    p.countries,
    ROUND(SUM(p1.production) / SUM(p.value), 4) AS production_percapita
FROM
    population p
        JOIN
    production p1 ON p.countries = p1.country
        AND p.year = p1.year
GROUP BY p.countries
ORDER BY production_percapita DESC;

-- 13.Which countries have the highest energy consumption relative to GDP?
SELECT 
    c.country,
    ROUND(SUM(consumption) / SUM(g.value), 4) AS relative_consumption_for_gdp
FROM
    consumption c
        JOIN
    gdp g ON c.country = g.country
        AND c.year = g.year
GROUP BY country
ORDER BY relative_consumption_for_gdp DESC;


-- 14.What is the correlation between GDP growth and energy production growth?
WITH gdp_growth AS (
  SELECT
    country,
    year,
    value,
    LAG(value) OVER (PARTITION BY country ORDER BY year) AS prev_value,
    (value - LAG(value) OVER (PARTITION BY country ORDER BY year)) / LAG(value) OVER (PARTITION BY country ORDER BY year) AS gdp_growth_rate
  FROM gdp
),
 production_growth AS (
  SELECT
    country,
    year,
    production,
    LAG(production) OVER (PARTITION BY country ORDER BY year) AS prev_production,
    (production - LAG(production) OVER (PARTITION BY country ORDER BY year)) / LAG(production) OVER (PARTITION BY country ORDER BY year) AS production_growth_rate
  FROM production
)
SELECT
  CORR(g.gdp_growth_rate, p.production_growth_rate) AS correlation_gdp_production_growth
FROM gdp_growth g
JOIN production_growth p ON g.country = p.country AND g.year = p.year
WHERE g.gdp_growth_rate IS NOT NULL AND p.production_growth_rate IS NOT NULL;

SELECT 
    *
FROM
    emission;
-- Global Comparisons
-- 15. What are the top 10 countries by population and how do their emissions compare?
SELECT 
    p.countries,
    SUM(p.value) AS total_population,
    SUM(e.emission) AS total_emission
FROM
    population p
        JOIN
    emission e ON p.countries = e.country
        AND p.year = e.year
GROUP BY p.countries
ORDER BY total_population DESC
LIMIT 10;

-- 16. Which countries have improved (reduced) their per capita emissions the most over the last decade?
WITH per_capita AS (
  SELECT
    p.countries,
    p.year,
    SUM(e.emission) / SUM(p.value) AS percapita_emission
  FROM population p
  JOIN emission e ON e.country = p.countries AND e.year = p.year
  WHERE p.year >= (SELECT MAX(year) FROM population) - 9
  GROUP BY p.countries, p.year
),
first_last AS (
  SELECT
    countries,
    MIN(year) AS start_year,
    MAX(year) AS end_year
  FROM per_capita
  GROUP BY countries
),
emission_change AS (
  SELECT
    pc1.countries,
    pc1.percapita_emission AS start_percapita,
    pc2.percapita_emission AS end_percapita,
    (pc1.percapita_emission - pc2.percapita_emission) AS reduction
  FROM per_capita pc1
  JOIN per_capita pc2 ON pc1.countries = pc2.countries
  JOIN first_last fl ON pc1.countries = fl.countries
  WHERE pc1.year = fl.start_year AND pc2.year = fl.end_year
)
SELECT
  countries,
  ROUND(reduction, 5) AS percapita_emission_reduction
FROM emission_change
ORDER BY percapita_emission_reduction DESC
LIMIT 10;

-- 17. What is the global share (%) of emissions by country?
with total_emission_percountry as(
select country, sum(emission)  as total_emission from emission group by country)
select country,round(total_emission*100/(select sum(emission) from emission),5) as share 
from total_emission_percountry order by share desc;

-- 18. What is the global average GDP, emission, and population by year?
SELECT 
    e.year,
    ROUND(AVG(g.value), 5) AS avg_gdp,
    ROUND(AVG(e.emission), 5) AS avg_emission,
    ROUND(AVG(p.value), 5) AS avg_population
FROM
    emission e
        JOIN
    gdp g ON e.country = g.country
        AND e.year = g.year
        JOIN
    population p ON p.countries = e.country
        AND p.year = e.year
GROUP BY e.year
ORDER BY e.year;