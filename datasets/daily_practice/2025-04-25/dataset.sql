CREATE DATABASE IF NOT EXISTS daily_practice_20250425_schema;
USE daily_practice_20250425_schema;

CREATE TABLE friend_requests (
    user_id_sender VARCHAR(20),
    user_id_receiver VARCHAR(20),
    date DATE,
    action VARCHAR(10)
);

INSERT INTO friend_requests VALUES
('ad4943sdz', '948ksx123d', '2020-01-04', 'sent'),
('ad4943sdz', '948ksx123d', '2020-01-06', 'accepted'),
('dfdfxf9483', '9djjjd9283', '2020-01-04', 'sent'),
('dfdfxf9483', '9djjjd9283', '2020-01-15', 'accepted'),
('ffdfff4234234', 'lpjzjdi4949', '2020-01-06', 'sent'),
('fffkfld9499', '993lsldidif', '2020-01-06', 'sent'),
('fffkfld9499', '993lsldidif', '2020-01-10', 'accepted'),
('fg503kdsdd', 'ofp049dkd', '2020-01-04', 'sent'),
('fg503kdsdd', 'ofp049dkd', '2020-01-10', 'accepted'),
('hh643dfert', '847jfkf203', '2020-01-04', 'sent'),
('r4gfgf2344', '234ddr4545', '2020-01-06', 'sent'),
('r4gfgf2344', '234ddr4545', '2020-01-11', 'accepted');