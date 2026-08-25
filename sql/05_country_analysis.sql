/*First find the Indicator Code */
SELECT
    indicator_code,
    indicator_name
FROM indicators
WHERE indicator_name = "GDP (current US$)";

/*Now use Country Name */
SELECT year, value FROM world_bank
WHERE country_code = 'IND'
AND indicator_code = "NY.GDP.MKTP.CD"
ORDER BY year;

SELECT year, ROUND(value / 1000000000, 2) AS GDP_Billion_USD FROM world_bank
WHERE country_code = 'NZL'
AND indicator_code = 'NY.GDP.MKTP.CD'
ORDER BY year;

SELECT year, FORMAT(value, 0) AS GDP_USD FROM world_bank
WHERE country_code = 'AUS'
AND indicator_code = 'NY.GDP.MKTP.CD'
ORDER BY year;

-- Comparison
SELECT country_name, year,
    ROUND(value/1000000000,2) AS GDP_Billion_USD
FROM world_bank
WHERE indicator_code='NY.GDP.MKTP.CD'
AND year=2024
AND country_code IN ('IND','AUS','NZL')
ORDER BY GDP_Billion_USD DESC;

-- Top 10 Countries by GDP (2024)
select country_name, year, round(value/1000000000,2) as GDP_Billion_USD
from world_bank where year=2024
and indicator_code="NY.GDP.MKTP.CD"
order by value DESC LIMIT 10;

-- Count Countries by Region 
SELECT region, COUNT(*) AS total_countries
FROM countries where region is not null
GROUP BY region
ORDER BY total_countries DESC;

-- Remove " " whitespaces from Region
select count(*) from countries 
where region ="";

select count(*) from countries
where trim(region) = "";

-- Rewrite
SELECT region, COUNT(*) AS total_countries
FROM countries where region is not null
AND region <> ""
GROUP BY region
ORDER BY total_countries DESC;

-- Count Countries by Income Group
select count(*) from countries
where income_group = ""; 

select concat("[",income_group,"]"), count(*) from countries
group by income_group;

SELECT income_group, LENGTH(income_group) AS len,
HEX(income_group) AS hex_value, COUNT(*) AS total
FROM countries GROUP BY income_group;

SELECT short_name, region, income_group
FROM countries WHERE income_group IS NULL
LIMIT 10;

UPDATE countries
SET income_group = NULL
WHERE HEX(income_group) = '0D';

-- Rewrite
select income_group, count(*) as total_countries from countries
where income_group is not null
group by income_group order by total_countries desc;



-- GDP Trend of India (using JOIN)
select wb.year, c.short_name, round(wb.value/1000000000,2) as GDP_BILLIONS
from world_bank wb
inner join countries c
on wb.country_code=c.country_code
where wb.country_code='IND'
and wb.indicator_code="NY.GDP.MKTP.CD"
order by wb.year;

-- Adding Indicator Details
select wb.year, c.short_name, i.indicator_name, round(wb.value/1000000000,2) as GDP_BILLIONS
from world_bank wb
inner join countries c
on wb.country_code=c.country_code
join indicators i 
on wb.indicator_code=i.indicator_code
where wb.country_code='IND'
and wb.indicator_code="NY.GDP.MKTP.CD"
order by wb.year;

-- Compare IND / AUS/ NZ
select wb.year, c.short_name, i.indicator_name, round(wb.value/1000000000,2) as GDP_BILLIONS
from world_bank wb
inner join countries c
on wb.country_code=c.country_code
join indicators i 
on wb.indicator_code=i.indicator_code
where wb.country_code IN("IND","AUS","NZl")
AND wb.year=2024
and wb.indicator_code="NY.GDP.MKTP.CD"
order by wb.value desc;