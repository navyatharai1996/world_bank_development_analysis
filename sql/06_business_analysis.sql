-- Top 10 Largest Economies (2024)
select c.short_name, round(wb.value/1000000000,2) as GDP_IN_BILLIONS
FROM world_bank wb
join countries c
on wb.country_code=c.country_code
where wb.year=2024
and wb.indicator_code="NY.GDP.MKTP.CD"
order by wb.value desc Limit 10;

-- Top 10 Smallest Economies (2024)
select c.short_name, round(wb.value/1000000000,2) as GDP_IN_BILLIONS
FROM world_bank wb
join countries c
on wb.country_code=c.country_code
where wb.year=2024
and wb.indicator_code="NY.GDP.MKTP.CD"
order by wb.value asc Limit 10;

-- GDP by Income Group2024
select c.income_group, round(avg(wb.value)/9000000000,2) as AVG_GDP_BILLIONS
from world_bank wb
join countries c
on wb.country_code=c.country_code
where wb.year=2024
AND income_group IS NOT NULL
and wb.indicator_code="NY.GDP.MKTP.CD"
group by c.income_group ordER BY AVG_GDP_BILLIONS desc;

--  GDP by Region 2024
select c.region, round(avg(wb.value)/9000000000,2) as AVG_GDP_BILLIONS
from world_bank wb
join countries c
on wb.country_code=c.country_code
where wb.year=2024
and c.region<>""
and wb.indicator_code="NY.GDP.MKTP.CD"
group by c.region ordER BY AVG_GDP_BILLIONS desc;

-- Countries Above Average GDP 2024
select avg(value) from world_bank 
where year=2024 and indicator_code="NY.GDP.MKTP.CD";

SELECT c.short_name, ROUND(wb.value/1000000000,2) AS GDP_Billion FROM world_bank wb
JOIN countries c
ON wb.country_code = c.country_code
WHERE wb.year = 2024
AND wb.indicator_code = 'NY.GDP.MKTP.CD'
AND wb.value >
(
    SELECT AVG(value) FROM world_bank
    WHERE year = 2024 AND indicator_code = 'NY.GDP.MKTP.CD'
)
ORDER BY wb.value DESC; 