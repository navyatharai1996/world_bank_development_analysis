-- LISTING ALL THE INDICATORS
SELECT
    indicator_code,
    indicator_name,
    topic,
    unit_of_measure
FROM indicators
ORDER BY indicator_name;

-- GDP INDICATORS
SELECT
    indicator_code,
    indicator_name,
    topic,
    unit_of_measure
FROM indicators
WHERE indicator_name LIKE '%GDP%'
ORDER BY indicator_name;

-- POPULATION INDICATORS
SELECT
    indicator_code,
    indicator_name,
    topic,
    unit_of_measure
FROM indicators
WHERE indicator_name LIKE '%population%'
ORDER BY indicator_name;

-- INTERNET INDICATORS
SELECT
    indicator_code,
    indicator_name,
    topic,
    unit_of_measure
FROM indicators
WHERE indicator_name LIKE '%internet%'
ORDER BY indicator_name;

-- LIFE EXPECTANCY INDICATORS
SELECT
    indicator_code,
    indicator_name,
    topic,
    unit_of_measure
FROM indicators
WHERE indicator_name LIKE '%life expectancy%'
ORDER BY indicator_name;

-- CO2 INDICATORS
SELECT
    indicator_code,
    indicator_name,
    topic,
    unit_of_measure
FROM indicators
WHERE indicator_name LIKE '%CO2%'
ORDER BY indicator_name;

-- ENERGY INDICATORS
SELECT
    indicator_code,
    indicator_name,
    topic,
    unit_of_measure
FROM indicators
WHERE indicator_name LIKE '%energy%'
ORDER BY indicator_name;

-- EDUCATION INDICATORS
SELECT
    indicator_code,
    indicator_name,
    topic,
    unit_of_measure
FROM indicators
WHERE indicator_name LIKE '%education%'
ORDER BY indicator_name;

-- COUNTRY LOOKUP
SELECT
    country_code,
    short_name,
    region,
    income_group
FROM countries
ORDER BY short_name;



