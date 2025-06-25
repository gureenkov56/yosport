/*
  Warnings:

  - You are about to drop the `Records` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Workouts` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN "RecordDips" INTEGER;
ALTER TABLE "User" ADD COLUMN "RecordPullUps" INTEGER;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Records";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Workouts";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "PullUps" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "set" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "PullUps_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Dips" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "set" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Dips_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
