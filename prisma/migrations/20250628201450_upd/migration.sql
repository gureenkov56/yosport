/*
  Warnings:

  - You are about to drop the column `dip` on the `Workout` table. All the data in the column will be lost.
  - You are about to drop the column `dipTotal` on the `Workout` table. All the data in the column will be lost.
  - You are about to drop the column `pullUp` on the `Workout` table. All the data in the column will be lost.
  - You are about to drop the column `pullUpTotal` on the `Workout` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Total" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstDayOfPeriof" DATETIME NOT NULL,
    "type" TEXT NOT NULL DEFAULT 'week',
    "dip" INTEGER,
    "pullUp" INTEGER,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Total_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Total" ("dip", "firstDayOfPeriof", "id", "pullUp", "type", "userId") SELECT "dip", "firstDayOfPeriof", "id", "pullUp", "type", "userId" FROM "Total";
DROP TABLE "Total";
ALTER TABLE "new_Total" RENAME TO "Total";
CREATE TABLE "new_Workout" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "discipline" TEXT NOT NULL DEFAULT 'pullups',
    "setsRepsString" TEXT,
    "total" TEXT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Workout_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Workout" ("date", "id", "userId") SELECT "date", "id", "userId" FROM "Workout";
DROP TABLE "Workout";
ALTER TABLE "new_Workout" RENAME TO "Workout";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
