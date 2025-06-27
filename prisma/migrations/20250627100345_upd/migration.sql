/*
  Warnings:

  - You are about to drop the `Dips` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PullUps` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Dips";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "PullUps";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Workout" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dip" TEXT NOT NULL,
    "pullUp" TEXT NOT NULL,
    "dipTotal" INTEGER NOT NULL,
    "pullUpTotal" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Workout_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Total" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstDayOfPeriof" DATETIME NOT NULL,
    "type" TEXT NOT NULL,
    "dip" INTEGER NOT NULL,
    "pullUp" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Total_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
