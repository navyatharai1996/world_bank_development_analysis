SHOW VARIABLES LIKE 'local_infile';
SELECT VERSION();
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE
'D:/world_bank_development_analysis/data/cleaned/world_bank_long_format.csv'
INTO TABLE world_bank
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;  


LOAD DATA LOCAL INFILE
'D:/world_bank_development_analysis/data/cleaned/countries.csv'
INTO TABLE countries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;  

LOAD DATA LOCAL INFILE
'D:/world_bank_development_analysis/data/cleaned/indicators.csv'
INTO TABLE indicators
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


select count(*) from world_bank;
select count(*) from countries;
select count(*) from indicators;

