CREATE DATABASE IF NOT EXISTS daily_practice_20251015_schema;
USE daily_practice_20251015_schema;

-- This table logs the inventory of players in a fantasy RPG.
CREATE TABLE player_inventory (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    item_name VARCHAR(50),
    item_type ENUM('Weapon', 'Armor', 'Potion', 'Quest Item'),
    quantity INT,
    last_updated DATETIME
);

-- This table stores information about guilds.
CREATE TABLE guilds (
    guild_id INT PRIMARY KEY,
    guild_name VARCHAR(50),
    realm VARCHAR(50)
);

-- This table links players to guilds.
CREATE TABLE guild_members (
    player_id INT,
    guild_id INT,
    member_rank VARCHAR(50),
    PRIMARY KEY (player_id, guild_id)
);

INSERT INTO guilds (guild_id, guild_name, realm) VALUES
(1, 'The Silver Hand', 'Stormwind'),
(2, 'Horde Vanguard', 'Orgrimmar'),
(3, 'Circle of Magi', 'Dalaran'),
(4, 'The Silent Blades', 'Ravenholdt');

INSERT INTO guild_members (player_id, guild_id, member_rank) VALUES
(101, 1, 'Knight-Captain'),
(102, 1, 'Knight'),
(103, 1, 'Squire'),
(201, 2, 'Legionnaire'),
(202, 2, 'Blood Guard'),
(301, 3, 'Archmage'),
-- Guild 4 has no members yet.
(401, 2, 'Scout'); -- Player 401 is also in Horde Vanguard

INSERT INTO player_inventory (player_id, item_name, item_type, quantity, last_updated) VALUES
-- Silver Hand Members
(101, 'Grand Marshal\'s Claymore', 'Weapon', 1, '2023-10-15 08:00:00'),
(101, 'Lionheart Helm', 'Armor', 1, '2023-10-15 08:00:00'),
(102, 'Imperial Plate Armor', 'Armor', 5, '2023-10-15 09:00:00'),
(102, 'Major Healing Potion', 'Potion', 20, '2023-10-15 09:00:00'),
(103, 'Enchanted Dagger', 'Weapon', 2, '2023-10-15 10:00:00'),

-- Horde Vanguard Members
(201, 'Arcanite Reaper', 'Weapon', 1, '2023-10-15 11:00:00'),
(201, 'Warlord\'s Plate', 'Armor', 1, '2023-10-15 11:00:00'),
(202, 'Major Mana Potion', 'Potion', 50, '2023-10-15 12:00:00'),
(401, 'Sturdy Iron Shield', 'Armor', 1, '2023-10-15 13:00:00'),
(401, 'Elixir of Giants', 'Potion', 10, '2023-10-15 13:00:00'),

-- Circle of Magi Member
(301, 'Staff of Dominance', 'Weapon', 1, '2023-10-15 14:00:00'),
(301, 'Robes of the Archmage', 'Armor', 1, '2023-10-15 14:00:00'),
(301, 'Atiesh, Greatstaff of the Guardian', 'Quest Item', 1, '2023-10-15 14:00:00'),

-- Unaffiliated Player
(501, 'Broken Sword', 'Weapon', 1, '2023-10-15 15:00:00');
