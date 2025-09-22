CREATE DATABASE IF NOT EXISTS daily_practice_20250922_schema;
USE daily_practice_20250922_schema;

-- This table logs credit card transactions, including location data.
CREATE TABLE credit_card_transactions (
    transaction_id VARCHAR(50) PRIMARY KEY,
    card_number VARCHAR(50),
    transaction_timestamp DATETIME(3),
    amount DECIMAL(10, 2),
    merchant_name VARCHAR(100),
    merchant_city VARCHAR(50),
    merchant_country VARCHAR(50)
);

INSERT INTO credit_card_transactions (transaction_id, card_number, transaction_timestamp, amount, merchant_name, merchant_city, merchant_country) VALUES
-- Card A: Normal, geographically plausible transactions
('txn_A01', 'card_A', '2023-11-01 10:00:00.000', 50.00, 'Starbucks', 'New York', 'USA'),
('txn_A02', 'card_A', '2023-11-01 14:30:00.000', 120.50, 'Macys', 'New York', 'USA'),
('txn_A03', 'card_A', '2023-11-02 09:00:00.000', 25.00, 'Pret A Manger', 'London', 'UK'),

-- Card B: An impossible journey (USA to UK in < 2 hours)
('txn_B01', 'card_B', '2023-11-05 08:15:00.000', 75.20, 'Walmart', 'Chicago', 'USA'),
('txn_B02', 'card_B', '2023-11-05 09:30:00.000', 150.00, 'Harrods', 'London', 'UK'), -- IMPOSSIBLE

-- Card C: Multiple transactions, but all within the same country
('txn_C01', 'card_C', '2023-11-08 11:00:00.000', 200.00, 'Apple Store', 'San Francisco', 'USA'),
('txn_C02', 'card_C', '2023-11-08 11:15:00.000', 30.00, 'Blue Bottle Coffee', 'San Francisco', 'USA'),
('txn_C03', 'card_C', '2023-11-08 16:00:00.000', 95.00, 'Gap', 'Los Angeles', 'USA'),

-- Card D: Another impossible journey (Japan to Australia in minutes)
('txn_D01', 'card_D', '2023-11-10 20:00:00.000', 5000.00, 'Isetan', 'Tokyo', 'Japan'),
('txn_D02', 'card_D', '2023-11-10 20:45:00.000', 85.00, 'Sydney Opera House Gift Shop', 'Sydney', 'Australia'), -- IMPOSSIBLE

-- Card E: A legitimate long-distance transaction
('txn_E01', 'card_E', '2023-11-12 10:00:00.000', 1200.00, 'Air France', 'Paris', 'France'),
('txn_E02', 'card_E', '2023-11-12 22:00:00.000', 45.00, 'Taxi G7', 'Paris', 'France'),
('txn_E03', 'card_E', '2023-11-13 18:00:00.000', 60.00, 'Ippudo Ramen', 'New York', 'USA'); -- Plausible (next day)
