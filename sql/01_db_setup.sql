create database world_bank_database;
use world_bank_database;

create table world_bank(
	country_name varchar(100) not null,
    country_code varchar(50) not null,
    indicator_name varchar(100) not null,
    indicator_code varchar(50) not null,
    year int not null,
    value double not null,
    primary key(country_code, indicator_code, year));  /* Composite Primary Key */
    
describe world_bank;
drop table world_bank;    

/* Inspect the Data */
select COUNT(*) FROM world_bank;  
select * from world_bank limit 10;
select min(year), max(year) from world_bank;
select count(distinct country_code) from world_bank;
select count(distinct indicator_code) from world_bank;
select count(*) from world_bank where value is null;
