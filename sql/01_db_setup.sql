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
    
    