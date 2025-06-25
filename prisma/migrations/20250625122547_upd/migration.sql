-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Dips" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "set" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Dips_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Dips" ("date", "id", "set", "userId") SELECT "date", "id", "set", "userId" FROM "Dips";
DROP TABLE "Dips";
ALTER TABLE "new_Dips" RENAME TO "Dips";
CREATE TABLE "new_PullUps" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "set" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "PullUps_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_PullUps" ("date", "id", "set", "userId") SELECT "date", "id", "set", "userId" FROM "PullUps";
DROP TABLE "PullUps";
ALTER TABLE "new_PullUps" RENAME TO "PullUps";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
