CREATE DATABASE IF NOT EXISTS daily_practice_20250720_schema;
USE daily_practice_20250720_schema;

CREATE TABLE website_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    ip_address VARCHAR(45),
    log_timestamp DATETIME,
    request_url VARCHAR(255),
    http_status INT,
    bytes_sent INT,
    user_agent VARCHAR(255)
);

INSERT INTO website_logs (user_id, ip_address, log_timestamp, request_url, http_status, bytes_sent, user_agent) VALUES
(101, '192.168.1.10', '2023-04-01 08:05:15', '/home', 200, 15234, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'),
(102, '10.0.0.5', '2023-04-01 08:06:22', '/login', 200, 3045, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15'),
(102, '10.0.0.5', '2023-04-01 08:06:50', '/products/123', 200, 25876, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15'),
(NULL, '8.8.8.8', '2023-04-01 09:10:05', '/about', 200, 8092, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0'),
(101, '192.168.1.10', '2023-04-01 09:15:30', '/products/456', 200, 26010, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'),
(101, '192.168.1.10', '2023-04-01 09:16:10', '/cart', 200, 12534, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'),
(103, '172.16.0.100', '2023-04-01 10:20:00', '/products/789', 404, 512, 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Mobile/15E148 Safari/604.1'),
(NULL, '8.8.8.8', '2023-04-01 11:30:45', '/products/123', 200, 25876, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0'),
(102, '10.0.0.5', '2023-04-01 11:35:12', '/checkout', 500, 1024, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15'),
(104, '203.0.113.15', '2023-04-02 14:00:55', '/home', 200, 15300, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'),
(104, '203.0.113.15', '2023-04-02 14:01:25', '/products/123', 200, 25876, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'),
(104, '203.0.113.15', '2023-04-02 14:02:00', '/cart', 200, 12600, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'),
(105, '198.51.100.2', '2023-04-02 15:10:10', '/products/456', 200, 26010, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0'),
(NULL, '198.51.100.3', '2023-04-02 15:12:00', '/products/nonexistent', 404, 512, 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Mobile/15E148 Safari/604.1'),
(101, '192.168.1.10', '2023-04-02 18:30:00', '/account', 200, 9050, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'),
(102, '10.0.0.5', '2023-04-02 18:35:00', '/products/456', 200, 26010, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15'),
(103, '172.16.0.100', '2023-04-03 08:00:00', '/home', 200, 15234, 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Mobile/15E148 Safari/604.1'),
(103, '172.16.0.100', '2023-04-03 08:01:00', '/products/123', 200, 25876, 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Mobile/15E148 Safari/604.1'),
(103, '172.16.0.100', '2023-04-03 08:02:30', '/products/789', 200, 27180, 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Mobile/15E148 Safari/604.1'),
(NULL, '8.8.4.4', '2023-04-03 09:00:00', '/login', 200, 3045, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'),
(105, '198.51.100.2', '2023-04-03 09:30:00', '/api/data', 500, 1024, 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0');
