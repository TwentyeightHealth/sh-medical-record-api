/*
  Warnings:

  - You are about to drop the column `createdAt` on the `consultations` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `consultations` table. All the data in the column will be lost.
  - The `difficulty_sleeping` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `regular_menstrual_cycles` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `thyroid_disorder` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `weight_gain` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `createdAt` on the `insurance_policies` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `insurance_policies` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `patients` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `patients` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `prescriptions` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `prescriptions` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `users` table. All the data in the column will be lost.
  - Added the required column `updated_at` to the `consultations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `insurance_policies` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `patients` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `prescriptions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "consultations" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMPTZ(6) NOT NULL,
DROP COLUMN "difficulty_sleeping",
ADD COLUMN     "difficulty_sleeping" BOOLEAN,
DROP COLUMN "regular_menstrual_cycles",
ADD COLUMN     "regular_menstrual_cycles" BOOLEAN,
DROP COLUMN "thyroid_disorder",
ADD COLUMN     "thyroid_disorder" BOOLEAN,
DROP COLUMN "weight_gain",
ADD COLUMN     "weight_gain" BOOLEAN;

-- AlterTable
ALTER TABLE "insurance_policies" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMPTZ(6) NOT NULL;

-- AlterTable
ALTER TABLE "patients" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMPTZ(6) NOT NULL;

-- AlterTable
ALTER TABLE "prescriptions" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMPTZ(6) NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMPTZ(6) NOT NULL;
