-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT
);

-- CreateTable
CREATE TABLE "Workouts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pullUps" TEXT,
    "pullUpsTotal" INTEGER,
    "dips" TEXT,
    "dipsTotal" INTEGER,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Workouts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Records" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "pullUps" INTEGER,
    "dips" INTEGER,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Records_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Records_userId_key" ON "Records"("userId");
