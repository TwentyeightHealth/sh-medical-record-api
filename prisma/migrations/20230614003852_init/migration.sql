/*
  Warnings:

  - The `decreased_libido` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `drospirenone_waiver` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `endometriosis` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `excess_hair_growth` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `fibroids` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `hair_loss` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `high_prolactin_level` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `hiv_or_aids` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `hot_flashes_or_night_sweats` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `irritability_anxiety_depression_or_worsening_pms` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `ovarian_cysts` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `pain_bowel_movements` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `pain_deep_penetrative_sex` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `pain_pelvic` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `patches_of_thickened_darkened_skin` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `polycystic_ovarian_syndrome` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `progestin_only_pill_questions` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `rheumatologic_or_autoimmune_disorder` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `severe_acne` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `severe_menstrual_cramping` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `sexually_transmitted_infection` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `uterine_polyps` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `vaginal_dryness_or_pain_with_sex` column on the `consultations` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "consultations" DROP COLUMN "decreased_libido",
ADD COLUMN     "decreased_libido" BOOLEAN,
DROP COLUMN "drospirenone_waiver",
ADD COLUMN     "drospirenone_waiver" BOOLEAN,
DROP COLUMN "endometriosis",
ADD COLUMN     "endometriosis" BOOLEAN,
DROP COLUMN "excess_hair_growth",
ADD COLUMN     "excess_hair_growth" BOOLEAN,
DROP COLUMN "fibroids",
ADD COLUMN     "fibroids" BOOLEAN,
DROP COLUMN "hair_loss",
ADD COLUMN     "hair_loss" BOOLEAN,
DROP COLUMN "high_prolactin_level",
ADD COLUMN     "high_prolactin_level" BOOLEAN,
DROP COLUMN "hiv_or_aids",
ADD COLUMN     "hiv_or_aids" BOOLEAN,
DROP COLUMN "hot_flashes_or_night_sweats",
ADD COLUMN     "hot_flashes_or_night_sweats" BOOLEAN,
DROP COLUMN "irritability_anxiety_depression_or_worsening_pms",
ADD COLUMN     "irritability_anxiety_depression_or_worsening_pms" BOOLEAN,
DROP COLUMN "ovarian_cysts",
ADD COLUMN     "ovarian_cysts" BOOLEAN,
DROP COLUMN "pain_bowel_movements",
ADD COLUMN     "pain_bowel_movements" BOOLEAN,
DROP COLUMN "pain_deep_penetrative_sex",
ADD COLUMN     "pain_deep_penetrative_sex" BOOLEAN,
DROP COLUMN "pain_pelvic",
ADD COLUMN     "pain_pelvic" BOOLEAN,
DROP COLUMN "patches_of_thickened_darkened_skin",
ADD COLUMN     "patches_of_thickened_darkened_skin" BOOLEAN,
DROP COLUMN "polycystic_ovarian_syndrome",
ADD COLUMN     "polycystic_ovarian_syndrome" BOOLEAN,
DROP COLUMN "progestin_only_pill_questions",
ADD COLUMN     "progestin_only_pill_questions" BOOLEAN,
DROP COLUMN "rheumatologic_or_autoimmune_disorder",
ADD COLUMN     "rheumatologic_or_autoimmune_disorder" BOOLEAN,
DROP COLUMN "severe_acne",
ADD COLUMN     "severe_acne" BOOLEAN,
DROP COLUMN "severe_menstrual_cramping",
ADD COLUMN     "severe_menstrual_cramping" BOOLEAN,
DROP COLUMN "sexually_transmitted_infection",
ADD COLUMN     "sexually_transmitted_infection" BOOLEAN,
DROP COLUMN "uterine_polyps",
ADD COLUMN     "uterine_polyps" BOOLEAN,
DROP COLUMN "vaginal_dryness_or_pain_with_sex",
ADD COLUMN     "vaginal_dryness_or_pain_with_sex" BOOLEAN;
