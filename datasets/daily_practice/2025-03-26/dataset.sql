-- Create the database schema for a text drafts platform
CREATE DATABASE IF NOT EXISTS daily_practice_20250326_schema;
USE daily_practice_20250326_schema;

-- Drafts table containing draft_id, author, contents, and created_at
CREATE TABLE drafts (
    draft_id INT PRIMARY KEY,
    author VARCHAR(100),
    contents TEXT,
    created_at DATE
);

-- Insert sample data
INSERT INTO drafts (draft_id, author, contents, created_at) VALUES
(1, 'Alice', 'Hello world, this is a draft. #announcement', '2025-03-01'),
(2, 'Bob', 'This draft contains an email: alice@example.com and some text. Hello again!', '2025-03-02'),
(3, 'Charlie', 'Drafting is fun. Draft your thoughts, and share your ideas. #inspiration', '2025-03-03'),
(4, 'Alice', 'Another draft: use SQL functions to manipulate text. #SQL', '2025-03-04'),
(5, 'Diana', 'Final draft; testing text manipulation, word count, and pattern matching. #testing #SQL', '2025-03-05');