CREATE TABLE "Users" (
  "UserID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Username" VARCHAR UNIQUE NOT NULL,
  "Email" VARCHAR UNIQUE NOT NULL,
  "PasswordHash" VARCHAR NOT NULL,
  "CreatedAt" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "DeletedAt" TIMESTAMP,
  "UpdatedBy" INT,
  "UpdatedAt" TIMESTAMP
);

CREATE TABLE "Characters" (
  "CharacterID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Name" VARCHAR NOT NULL,
  "UserID" INT NOT NULL,
  "RaceID" INT NOT NULL,
  "ClassID" INT NOT NULL,
  "Level" INT DEFAULT 1,
  "CreatedAt" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "DeletedAt" TIMESTAMP,
  "UpdatedBy" INT,
  "UpdatedAt" TIMESTAMP
);

CREATE TABLE "Races" (
  "RaceID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Name" VARCHAR NOT NULL,
  "FactionID" INT
);

CREATE TABLE "Classes" (
  "ClassID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Name" VARCHAR NOT NULL
);

CREATE TABLE "Guilds" (
  "GuildID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Name" VARCHAR NOT NULL,
  "LeaderID" INT NOT NULL,
  "FactionID" INT,
  "CreatedAt" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "DeletedAt" TIMESTAMP,
  "UpdatedBy" INT,
  "UpdatedAt" TIMESTAMP
);

CREATE TABLE "GuildMembers" (
  "GuildID" INT,
  "CharacterID" INT,
  "JoinedAt" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "Role" VARCHAR NOT NULL,
  PRIMARY KEY ("GuildID", "CharacterID")
);

CREATE TABLE "Items" (
  "ItemID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Name" VARCHAR NOT NULL,
  "ItemTypeID" INT NOT NULL,
  "Stats" JSON
);

CREATE TABLE "ItemTypes" (
  "ItemTypeID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "TypeName" VARCHAR NOT NULL
);

CREATE TABLE "Inventories" (
  "InventoryID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "CharacterID" INT NOT NULL,
  "ItemID" INT NOT NULL,
  "Quantity" INT DEFAULT 1
);

CREATE TABLE "Quests" (
  "QuestID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Name" VARCHAR NOT NULL,
  "ZoneID" INT NOT NULL,
  "Reward" JSON
);

CREATE TABLE "QuestStatus" (
  "QuestStatusID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "CharacterID" INT NOT NULL,
  "QuestID" INT NOT NULL,
  "Status" VARCHAR NOT NULL,
  "Progress" JSON
);

CREATE TABLE "Achievements" (
  "AchievementID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "CharacterID" INT NOT NULL,
  "Title" VARCHAR NOT NULL,
  "Description" VARCHAR,
  "AchievedAt" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "Zones" (
  "ZoneID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Name" VARCHAR NOT NULL,
  "FactionID" INT
);

CREATE TABLE "Factions" (
  "FactionID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "Name" VARCHAR NOT NULL,
  "Alignment" VARCHAR NOT NULL
);

CREATE TABLE "Battles" (
  "BattleID" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "ZoneID" INT NOT NULL,
  "Participants" JSON NOT NULL,
  "WinnerID" INT
);

ALTER TABLE "Users" ADD FOREIGN KEY ("UpdatedBy") REFERENCES "Users" ("UserID");

ALTER TABLE "Characters" ADD FOREIGN KEY ("UserID") REFERENCES "Users" ("UserID");

ALTER TABLE "Characters" ADD FOREIGN KEY ("RaceID") REFERENCES "Races" ("RaceID");

ALTER TABLE "Characters" ADD FOREIGN KEY ("ClassID") REFERENCES "Classes" ("ClassID");

ALTER TABLE "Characters" ADD FOREIGN KEY ("UpdatedBy") REFERENCES "Users" ("UserID");

ALTER TABLE "Races" ADD FOREIGN KEY ("FactionID") REFERENCES "Factions" ("FactionID");

ALTER TABLE "Guilds" ADD FOREIGN KEY ("LeaderID") REFERENCES "Characters" ("CharacterID");

ALTER TABLE "Guilds" ADD FOREIGN KEY ("FactionID") REFERENCES "Factions" ("FactionID");

ALTER TABLE "Guilds" ADD FOREIGN KEY ("UpdatedBy") REFERENCES "Users" ("UserID");

ALTER TABLE "GuildMembers" ADD FOREIGN KEY ("GuildID") REFERENCES "Guilds" ("GuildID");

ALTER TABLE "GuildMembers" ADD FOREIGN KEY ("CharacterID") REFERENCES "Characters" ("CharacterID");

ALTER TABLE "Items" ADD FOREIGN KEY ("ItemTypeID") REFERENCES "ItemTypes" ("ItemTypeID");

ALTER TABLE "Inventories" ADD FOREIGN KEY ("CharacterID") REFERENCES "Characters" ("CharacterID");

ALTER TABLE "Inventories" ADD FOREIGN KEY ("ItemID") REFERENCES "Items" ("ItemID");

ALTER TABLE "Quests" ADD FOREIGN KEY ("ZoneID") REFERENCES "Zones" ("ZoneID");

ALTER TABLE "QuestStatus" ADD FOREIGN KEY ("CharacterID") REFERENCES "Characters" ("CharacterID");

ALTER TABLE "QuestStatus" ADD FOREIGN KEY ("QuestID") REFERENCES "Quests" ("QuestID");

ALTER TABLE "Achievements" ADD FOREIGN KEY ("CharacterID") REFERENCES "Characters" ("CharacterID");

ALTER TABLE "Zones" ADD FOREIGN KEY ("FactionID") REFERENCES "Factions" ("FactionID");

ALTER TABLE "Battles" ADD FOREIGN KEY ("ZoneID") REFERENCES "Zones" ("ZoneID");

ALTER TABLE "Battles" ADD FOREIGN KEY ("WinnerID") REFERENCES "Characters" ("CharacterID");
