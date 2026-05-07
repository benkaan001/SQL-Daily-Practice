CREATE DATABASE IF NOT EXISTS daily_practice_20260508_schema;
USE daily_practice_20260508_schema;

-- This table logs weekly performance metrics for songs on a streaming platform.
CREATE TABLE weekly_music_stats (
    stat_id INT PRIMARY KEY AUTO_INCREMENT,
    week_date DATE,
    song_name VARCHAR(50),
    streams INT,
    downloads INT
);

INSERT INTO weekly_music_stats (week_date, song_name, streams, downloads) VALUES
-- Week 1: May 1st
('2026-05-01', 'Galactic Groove', 100000, 500), 
('2026-05-01', 'Neon Nights', 50000, 800),    
('2026-05-01', 'Solar Flare', 40000, 200),    
('2026-05-01', 'Lunar Lullaby', 20000, 100),  
('2026-05-01', 'Asteroid Anthem', 10000, 50), 

-- Week 2: May 8th
('2026-05-08', 'Neon Nights', 60000, 900),    
('2026-05-08', 'Lunar Lullaby', 110000, 300), 
('2026-05-08', 'Galactic Groove', 80000, 400),
('2026-05-08', 'Asteroid Anthem', 50000, 400),
('2026-05-08', 'Solar Flare', 10000, 50),     

-- Week 3: May 15th
('2026-05-15', 'Asteroid Anthem', 120000, 1000), 
('2026-05-15', 'Lunar Lullaby', 90000, 800),     
('2026-05-15', 'Neon Nights', 70000, 600),       
('2026-05-15', 'Supernova Sonata', 50000, 500),  -- New Entry this week!
('2026-05-15', 'Galactic Groove', 50000, 200);