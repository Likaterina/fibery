/*
  Warnings:

  - You are about to drop the `Message` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `email` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `slackId` on the `User` table. All the data in the column will be lost.
  - Added the required column `avg` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `channel` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `end` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `max` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `min` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `start` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Message_slackId_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Message";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Response" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "text" TEXT,
    "ts" TEXT NOT NULL,
    "rt" TEXT NOT NULL,
    "user" TEXT NOT NULL,
    "cacheId" INTEGER,
    CONSTRAINT "Response_cacheId_fkey" FOREIGN KEY ("cacheId") REFERENCES "Cache" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Cache" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "key" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Channel" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "emojiName" TEXT NOT NULL,
    "synced" BOOLEAN NOT NULL,
    "type" TEXT,
    "text" TEXT
);

-- CreateTable
CREATE TABLE "CandidateComment" (
    "id" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "candidateId" TEXT NOT NULL,
    "parentTs" TEXT NOT NULL,
    "ts" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "type" TEXT,
    "ref" TEXT
);

-- CreateTable
CREATE TABLE "Candidate" (
    "id" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "position" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "salary" TEXT NOT NULL,
    "assignees" TEXT NOT NULL,
    "channelId" TEXT NOT NULL,
    "ts" TEXT NOT NULL,
    "commentIds" TEXT,
    "ref" TEXT
);

-- CreateTable
CREATE TABLE "FiberyUser" (
    "id" TEXT NOT NULL,
    "fiberyUserId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "user" TEXT NOT NULL,
    "channel" TEXT NOT NULL,
    "min" TEXT NOT NULL,
    "max" TEXT NOT NULL,
    "avg" TEXT NOT NULL,
    "start" TEXT NOT NULL,
    "end" TEXT NOT NULL
);
INSERT INTO "new_User" ("id") SELECT "id" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_user_key" ON "User"("user");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Channel_id_key" ON "Channel"("id");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateComment_id_key" ON "CandidateComment"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Candidate_id_key" ON "Candidate"("id");

-- CreateIndex
CREATE UNIQUE INDEX "FiberyUser_id_key" ON "FiberyUser"("id");
