-- Assign a unique rank to the top GDP countries in 2024.
select row_number() over (order by wb.value desc) as row_num,
c.short_name,
    ROUND(wb.value/1000000000,2) AS GDP_Billion
FROM world_bank wb
JOIN countries c
    ON wb.country_code = c.country_code
WHERE wb.year = 2024
AND wb.indicator_code = 'NY.GDP.MKTP.CD'
AND c.region IS NOT NULL;

-- Replace Row() with Rank()
SELECT
    RANK() OVER (ORDER BY wb.value DESC) AS GDP_Rank,
    c.short_name,
    ROUND(wb.value/1000000000,2) AS GDP_Billion
FROM world_bank wb
JOIN countries c
    ON wb.country_code = c.country_code
WHERE wb.year = 2024
AND wb.indicator_code = 'NY.GDP.MKTP.CD'
AND c.region IS NOT NULL;

-- Dense Rank()
SELECT
    DENSE_RANK() OVER (ORDER BY wb.value DESC) AS GDP_Rank,
    c.short_name,
    ROUND(wb.value/1000000000,2) AS GDP_Billion
FROM world_bank wb
JOIN countries c
    ON wb.country_code = c.country_code
WHERE wb.year = 2024
AND wb.indicator_code = 'NY.GDP.MKTP.CD'
AND c.region IS NOT NULL;

-- What was India's GDP every year, and what was it in the previous year?
select wb.year, round(wb.value/1000000000,2) as GDP_BILLIONS,
LAG(ROUND(wb.value/1000000000,2)) over (order by wb.year) as Prev_Year_GDP
from world_bank wb
where wb.country_code="ind" and wb.indicator_code="NY.GDP.MKTP.CD"
order by wb.year;

-- Year-over-Year GDP Change
SELECT wb.year, ROUND(wb.value/1000000000,2) AS GDP_Billion,
    ROUND(
        LAG(wb.value)OVER(ORDER BY wb.year)/1000000000,
    2) AS Previous_GDP,

    ROUND(
        (wb.value - LAG(wb.value)OVER(ORDER BY wb.year))/1000000000,
    2) AS GDP_Change

FROM world_bank wb
WHERE wb.country_code='IND' AND wb.indicator_code='NY.GDP.MKTP.CD'
ORDER BY wb.year;


-- GDP Growth %   (Current - Previous)/ Previous × 100
SELECT wb.year, ROUND(wb.value/1000000000,2) AS GDP_Billion,
    ROUND(
        ((wb.value - LAG(wb.value)OVER(ORDER BY wb.year))/LAG(wb.value)OVER(ORDER BY wb.year))*100,
    2) AS GDP_Growth_Percent
FROM world_bank wb
WHERE wb.country_code='IND'
AND wb.indicator_code='NY.GDP.MKTP.CD'
ORDER BY wb.year;

-- Lead()
SELECT wb.year, ROUND(wb.value/1000000000,2) AS GDP,
    LEAD(ROUND(wb.value/1000000000,2))OVER(ORDER BY wb.year) AS Next_Year_GDP
FROM world_bank wb
WHERE wb.country_code='IND' AND wb.indicator_code='NY.GDP.MKTP.CD'
ORDER BY wb.year;

-- CTE (Common Table Expressions)
SELECT c.short_name, ROUND(wb.value/1000000000,2) AS GDP_Billion,
	DENSE_RANK()OVER(ORDER BY wb.value DESC) AS GDP_Rank
    FROM world_bank wb
    JOIN countries c
	ON wb.country_code = c.country_code
    WHERE wb.year = 2024
	AND wb.indicator_code = 'NY.GDP.MKTP.CD'
	AND c.region IS NOT NULL;


WITH GDP_RANKING AS
( SELECT c.short_name, ROUND(wb.value/1000000000,2) AS GDP_Billion,
	DENSE_RANK()OVER(ORDER BY wb.value DESC) AS GDP_Rank
    FROM world_bank wb
    JOIN countries c
	ON wb.country_code = c.country_code
    WHERE wb.year = 2024
	AND wb.indicator_code = 'NY.GDP.MKTP.CD'
	AND c.region IS NOT NULL )
Select * from GDP_RANKING
LIMIT 10;

-- OR

 WITH GDP_Ranking AS (
    SELECT c.short_name, ROUND(wb.value/1000000000,2) AS GDP_Billion,
	DENSE_RANK() OVER(ORDER BY wb.value DESC) AS GDP_Rank
    FROM world_bank wb
    JOIN countries c
	ON wb.country_code = c.country_code
    WHERE wb.year = 2024
	AND wb.indicator_code = 'NY.GDP.MKTP.CD'
	AND c.region IS NOT NULL
)
SELECT * FROM GDP_Ranking
WHERE GDP_Rank <= 10;   

-- Find the country with the highest GDP in each region - CTE + Window Functions
SELECT c.region, c.short_name, ROUND(wb.value/1000000000,2) AS GDP_Billion,
      DENSE_RANK() OVER
        (
            PARTITION BY c.region
            ORDER BY wb.value DESC
        ) AS Region_Rank
    FROM world_bank wb
    JOIN countries c
	ON wb.country_code = c.country_code
    WHERE wb.year = 2024
	AND wb.indicator_code = 'NY.GDP.MKTP.CD'
	AND c.region <> "";
    
    
WITH Regional_GDP AS
(
    SELECT c.region, c.short_name, ROUND(wb.value/1000000000,2) AS GDP_Billion,
      DENSE_RANK() OVER
        (
            PARTITION BY c.region
            ORDER BY wb.value DESC
        ) AS Region_Rank
    FROM world_bank wb
    JOIN countries c
	ON wb.country_code = c.country_code
    WHERE wb.year = 2024
	AND wb.indicator_code = 'NY.GDP.MKTP.CD'
	AND c.region <> ""
)
SELECT region, short_name, GDP_Billion
FROM Regional_GDP
WHERE Region_Rank = 1
ORDER BY GDP_Billion DESC;

-- Find the top 3 countries by GDP within each region.
WITH Regional_GDP AS
(
    SELECT c.region, c.short_name, ROUND(wb.value/1000000000,2) AS GDP_Billion,
      DENSE_RANK() OVER
        (
            PARTITION BY c.region
            ORDER BY wb.value DESC
        ) AS Region_Rank
    FROM world_bank wb
    JOIN countries c
	ON wb.country_code = c.country_code
    WHERE wb.year = 2024
	AND wb.indicator_code = 'NY.GDP.MKTP.CD'
	AND c.region <> ""
)
SELECT region, short_name, GDP_Billion, region_rank
FROM Regional_GDP
WHERE Region_Rank <=3;
