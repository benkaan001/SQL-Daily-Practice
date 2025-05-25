CREATE DATABASE IF NOT EXISTS daily_practice_20250522_schema;
USE daily_practice_20250522_schema;

DROP TABLE IF EXISTS product_launches;
CREATE TABLE product_launches (
    launch_year INT,
    company_name VARCHAR(255),
    product_name VARCHAR(255)
);

INSERT INTO product_launches (launch_year, company_name, product_name) VALUES
(2019, 'Toyota', 'Avalon'),
(2019, 'Toyota', 'Camry'),
(2020, 'Toyota', 'Corolla'),
(2019, 'Honda', 'Accord'),
(2019, 'Honda', 'Passport'),
(2019, 'Honda', 'CR-V'),
(2020, 'Honda', 'Pilot'),
(2019, 'Honda', 'Civic'),
(2020, 'Chevrolet', 'Trailblazer'),
(2020, 'Chevrolet', 'Trax'),
(2019, 'Chevrolet', 'Traverse'),
(2020, 'Chevrolet', 'Blazer'),
(2019, 'Ford', 'Figo'),
(2020, 'Ford', 'Aspire'),
(2019, 'Ford', 'Endeavour'),
(2020, 'Jeep', 'Wrangler'),
(2020, 'Jeep', 'Cherokee'),
(2020, 'Jeep', 'Compass'),
(2019, 'Jeep', 'Renegade'),
(2019, 'Jeep', 'Gladiator');
