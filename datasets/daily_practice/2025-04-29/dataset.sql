CREATE DATABASE IF NOT EXISTS daily_practice_20250429_schema;
USE daily_practice_20250429_schema;

CREATE TABLE cities (
    city VARCHAR(50),
    country VARCHAR(50),
    population INT,
    area INT
);

INSERT INTO cities VALUES
('Metropolis', 'Countryland', 1000000, 500),
('Smallville', 'Countryland', 50000, 1000),
('Coastcity', 'Oceanland', 300000, 0),
('Starcity', 'Mountainous', 600000, 600),
('Gotham', 'Islander', 1500000, 300),
('Rivertown', 'Plainsland', 100000, 5000),
('Lakecity', 'Forestland', 100000, 5000),
('Hilltown', 'Hillside', 200000, 450),
('Forestville', 'Forestland', 500000, 700),
('Oceanview', 'Seaside', 800000, 0);