CREATE DATABASE IF NOT EXISTS daily_practice_20260504_schema;
USE daily_practice_20260504_schema;

-- This table stores the secret bases of the Rebel Alliance.
CREATE TABLE rebel_bases (
    base_id INT PRIMARY KEY,
    base_name VARCHAR(50),
    planet VARCHAR(50)
);

-- This table logs the defense systems installed at each base.
CREATE TABLE base_defenses (
    installation_id INT PRIMARY KEY AUTO_INCREMENT,
    base_id INT,
    defense_system VARCHAR(50)
);

INSERT INTO rebel_bases (base_id, base_name, planet) VALUES
(1, 'Echo Base', 'Hoth'),
(2, 'Massassi Group', 'Yavin IV'),
(3, 'Dantooine Enclave', 'Dantooine'),
(4, 'Endor Outpost', 'Endor'),
(5, 'Sullust Depot', 'Sullust');

INSERT INTO base_defenses (base_id, defense_system) VALUES
-- Base 1 (Echo Base - Our Target Base) has 4 defenses
(1, 'Deflector Shield'),
(1, 'Ion Cannon'),
(1, 'Turbolaser Battery'),
(1, 'Snowspeeders'),

-- Base 2 (Yavin) is missing Snowspeeders (Subset - Should NOT match)
(2, 'Deflector Shield'),
(2, 'Ion Cannon'),
(2, 'Turbolaser Battery'),

-- Base 3 (Dantooine) has the exact same 4 defenses as Echo Base! (MATCH)
(3, 'Deflector Shield'),
(3, 'Ion Cannon'),
(3, 'Turbolaser Battery'),
(3, 'Snowspeeders'),

-- Base 4 (Endor) has the same 4, PLUS a bunker (Superset - Should NOT match)
(4, 'Deflector Shield'),
(4, 'Ion Cannon'),
(4, 'Turbolaser Battery'),
(4, 'Snowspeeders'),
(4, 'Shield Bunker'),

-- Base 5 (Sullust) has completely different defenses (No Match)
(5, 'Anti-Air Turrets'),
(5, 'Starfighter Squadron');