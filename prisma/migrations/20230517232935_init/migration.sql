/*
  Warnings:

  - The primary key for the `consultations` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `patientId` on the `consultations` table. All the data in the column will be lost.
  - The `id` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `insurance_policies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `patientId` on the `insurance_policies` table. All the data in the column will be lost.
  - The `id` column on the `insurance_policies` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `patients` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `extrenal_patient_id` on the `patients` table. All the data in the column will be lost.
  - The `id` column on the `patients` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `userId` on the `posts` table. All the data in the column will be lost.
  - The primary key for the `prescriptions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `patientId` on the `prescriptions` table. All the data in the column will be lost.
  - The `id` column on the `prescriptions` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[id]` on the table `patients` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[external_patient_id]` on the table `patients` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `patient_id` to the `consultations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `patient_id` to the `insurance_policies` table without a default value. This is not possible if the table is not empty.
  - Added the required column `external_patient_id` to the `patients` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `posts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `patient_id` to the `prescriptions` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "consultations" DROP CONSTRAINT "consultations_patientId_fkey";

-- DropForeignKey
ALTER TABLE "insurance_policies" DROP CONSTRAINT "insurance_policies_patientId_fkey";

-- DropForeignKey
ALTER TABLE "posts" DROP CONSTRAINT "posts_userId_fkey";

-- DropForeignKey
ALTER TABLE "prescriptions" DROP CONSTRAINT "prescriptions_patientId_fkey";

-- DropIndex
DROP INDEX "consultations_patientId_key";

-- DropIndex
DROP INDEX "insurance_policies_patientId_key";

-- DropIndex
DROP INDEX "patients_extrenal_patient_id_idx";

-- DropIndex
DROP INDEX "patients_extrenal_patient_id_key";

-- DropIndex
DROP INDEX "prescriptions_patientId_key";

-- AlterTable
ALTER TABLE "consultations" DROP CONSTRAINT "consultations_pkey",
DROP COLUMN "patientId",
ADD COLUMN     "patient_id" INTEGER NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "consultations_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "insurance_policies" DROP CONSTRAINT "insurance_policies_pkey",
DROP COLUMN "patientId",
ADD COLUMN     "patient_id" INTEGER NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "insurance_policies_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "patients" DROP CONSTRAINT "patients_pkey",
DROP COLUMN "extrenal_patient_id",
ADD COLUMN     "external_patient_id" VARCHAR(11) NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "patients_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "posts" DROP COLUMN "userId",
ADD COLUMN     "user_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "prescriptions" DROP CONSTRAINT "prescriptions_pkey",
DROP COLUMN "patientId",
ADD COLUMN     "patient_id" INTEGER NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "prescriptions_pkey" PRIMARY KEY ("id");

-- CreateIndex
CREATE UNIQUE INDEX "patients_id_key" ON "patients"("id");

-- CreateIndex
CREATE UNIQUE INDEX "patients_external_patient_id_key" ON "patients"("external_patient_id");

-- CreateIndex
CREATE INDEX "patients_external_patient_id_idx" ON "patients"("external_patient_id");

-- AddForeignKey
ALTER TABLE "posts" ADD CONSTRAINT "posts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "insurance_policies" ADD CONSTRAINT "insurance_policies_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prescriptions" ADD CONSTRAINT "prescriptions_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "consultations" ADD CONSTRAINT "consultations_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
