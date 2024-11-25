INSERT INTO "Factions" ("Name", "Alignment") VALUES
('Alliance', 'Good'),
('Horde', 'Neutral'),
('Neutral', 'Neutral'),
('Burning Legion', 'Evil');

INSERT INTO "Races" ("Name", "FactionID") VALUES
('Human', 1),
('Orc', 2),
('Night Elf', 1),
('Undead', 2),
('Dwarf', 1),
('Tauren', 2),
('Gnome', 1),
('Troll', 2),
('Blood Elf', 2),
('Draenei', 1);

INSERT INTO "Classes" ("Name") VALUES
('Warrior'),
('Paladin'),
('Hunter'),
('Rogue'),
('Priest'),
('Death Knight'),
('Shaman'),
('Mage'),
('Warlock'),
('Monk'),
('Druid');

INSERT INTO "Users" ("Username", "Email", "PasswordHash") VALUES
('ArthasMenethil', 'arthas@northrend.com', 'hash1'),
('ThrallOakHeart', 'thrall@orgrimmar.com', 'hash2'),
('JainaProudmoore', 'jaina@dalaran.com', 'hash3'),
('SylvanasWindrunner', 'sylvanas@undercity.com', 'hash4');

INSERT INTO "Characters" ("Name", "UserID", "RaceID", "ClassID", "Level") VALUES
('Frostmourne', 1, 1, 6, 80),
('Doomhammer', 2, 2, 7, 70),
('Proudmage', 3, 3, 8, 75),
('Banshee', 4, 4, 5, 65);

INSERT INTO "Zones" ("Name", "FactionID") VALUES
('Stormwind', 1),
('Orgrimmar', 2),
('Dalaran', 3),
('Icecrown', 4);

INSERT INTO "Guilds" ("Name", "LeaderID", "FactionID") VALUES
('Knights of the Frozen Throne', 1, 1),
('Orgrimmar Elite', 2, 2);

INSERT INTO "GuildMembers" ("GuildID", "CharacterID", "Role") VALUES
(1, 1, 'Leader'),
(1, 3, 'Member'),
(2, 2, 'Leader'),
(2, 4, 'Member');

INSERT INTO "ItemTypes" ("TypeName") VALUES
('Weapon'),
('Armor'),
('Consumable'),
('Quest Item');

INSERT INTO "Items" ("Name", "ItemTypeID", "Stats") VALUES
('Frostmourne', 1, '{"damage": 500, "type": "Legendary Sword"}'),
('Doomhammer', 1, '{"damage": 450, "type": "Legendary Mace"}'),
('Hearthstone', 3, '{"use": "Teleport to home location"}'),
('Lich King''s Armor', 2, '{"defense": 1000, "type": "Legendary Plate"}');

INSERT INTO "Inventories" ("CharacterID", "ItemID", "Quantity") VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 5),
(4, 4, 1);

INSERT INTO "Quests" ("Name", "ZoneID", "Reward") VALUES
('Fall of the Lich King', 4, '{"exp": 100000, "gold": 5000}'),
('Siege of Orgrimmar', 2, '{"exp": 50000, "gold": 2500}');

INSERT INTO "QuestStatus" ("CharacterID", "QuestID", "Status", "Progress") VALUES
(1, 1, 'Completed', '{"boss_kills": 1, "objectives_complete": true}'),
(2, 2, 'In Progress', '{"boss_kills": 0, "objectives_complete": false}');

INSERT INTO "Achievements" ("CharacterID", "Title", "Description") VALUES
(1, 'Kingslayer', 'Defeated the Lich King'),
(2, 'Warchief', 'Leader of the Horde');

INSERT INTO "Battles" ("ZoneID", "Participants", "WinnerID") VALUES
(4, '[1, 3]', 1),
(2, '[2, 4]', 2);