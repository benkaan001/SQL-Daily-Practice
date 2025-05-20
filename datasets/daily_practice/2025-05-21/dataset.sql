CREATE DATABASE IF NOT EXISTS daily_practice_20250521_schema;
USE daily_practice_20250521_schema;

DROP TABLE IF EXISTS google_file_store;
CREATE TABLE google_file_store (
    filename VARCHAR(255),
    contents TEXT
);

INSERT INTO google_file_store (filename, contents) VALUES
('draft1.txt', 'The stock exchange predicts a bull market. This is good news for investors.'),
('draft2.txt', 'Further analysis of the stock exchange suggests the bull market might continue. However, some predict a bear market soon.'),
('report_q1.txt', 'Q1 report: The market showed strong bull signals. Investor confidence is high. No indication of a bear trend yet.'),
('final_summary.txt', 'Final summary: The predicted bull market materialized. Investors are happy. The risk of a bear market seems low for now, but caution is advised.');