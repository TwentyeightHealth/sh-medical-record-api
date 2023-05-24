/*
  Warnings:

  - You are about to alter the column `secret` on the `clients` table. The data in that column could be lost. The data in that column will be cast from `VarChar(128)` to `VarChar(64)`.

*/
-- AlterTable
ALTER TABLE "clients" ALTER COLUMN "id" SET DATA TYPE VARCHAR(64),
ALTER COLUMN "secret" SET DATA TYPE VARCHAR(64);
