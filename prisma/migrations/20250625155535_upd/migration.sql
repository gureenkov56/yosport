-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "RecordDips" INTEGER NOT NULL DEFAULT 0,
    "RecordPullUps" INTEGER NOT NULL DEFAULT 0
);
INSERT INTO "new_User" ("RecordDips", "RecordPullUps", "id", "name") SELECT coalesce("RecordDips", 0) AS "RecordDips", coalesce("RecordPullUps", 0) AS "RecordPullUps", "id", "name" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
