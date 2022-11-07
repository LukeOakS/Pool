/*
  Warnings:

  - You are about to drop the `Game` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Participant` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Pool` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `gameId` on the `Gues` table. All the data in the column will be lost.
  - You are about to drop the column `participantId` on the `Gues` table. All the data in the column will be lost.
  - Added the required column `gamId` to the `Gues` table without a default value. This is not possible if the table is not empty.
  - Added the required column `participanId` to the `Gues` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Participant_userId_poolId_key";

-- DropIndex
DROP INDEX "Pool_code_key";

-- DropIndex
DROP INDEX "User_googleId_key";

-- DropIndex
DROP INDEX "User_email_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Game";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Participant";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Pool";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "User";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Poo" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ownerId" TEXT,
    CONSTRAINT "Poo_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Use" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Participan" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "useId" TEXT NOT NULL,
    "pooId" TEXT NOT NULL,
    CONSTRAINT "Participan_useId_fkey" FOREIGN KEY ("useId") REFERENCES "Use" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Participan_pooId_fkey" FOREIGN KEY ("pooId") REFERENCES "Poo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Use" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "googleId" TEXT NOT NULL,
    "avatarUrl" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Gam" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL,
    "firstTeamCountryCode" TEXT NOT NULL,
    "secondTeamCountryCode" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Gues" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "firstTeamPoints" INTEGER NOT NULL,
    "secondTeamPoints" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "gamId" TEXT NOT NULL,
    "participanId" TEXT NOT NULL,
    CONSTRAINT "Gues_participanId_fkey" FOREIGN KEY ("participanId") REFERENCES "Participan" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Gues_gamId_fkey" FOREIGN KEY ("gamId") REFERENCES "Gam" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Gues" ("createdAt", "firstTeamPoints", "id", "secondTeamPoints") SELECT "createdAt", "firstTeamPoints", "id", "secondTeamPoints" FROM "Gues";
DROP TABLE "Gues";
ALTER TABLE "new_Gues" RENAME TO "Gues";
CREATE UNIQUE INDEX "Gues_participanId_gamId_key" ON "Gues"("participanId", "gamId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Poo_code_key" ON "Poo"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Participan_useId_pooId_key" ON "Participan"("useId", "pooId");

-- CreateIndex
CREATE UNIQUE INDEX "Use_email_key" ON "Use"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Use_googleId_key" ON "Use"("googleId");
