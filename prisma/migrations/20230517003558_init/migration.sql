-- CreateEnum
CREATE TYPE "RoleType" AS ENUM ('USER', 'PROVIDER', 'ADMIN');

-- CreateEnum
CREATE TYPE "PaymentType" AS ENUM ('INSURANCE', 'CASH');

-- CreateEnum
CREATE TYPE "SexType" AS ENUM ('MALE', 'FEMALE', 'INTERSEX');

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL,
    "email" VARCHAR(64) NOT NULL,
    "role" "RoleType" NOT NULL DEFAULT 'USER',
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "patients" (
    "id" UUID NOT NULL,
    "extrenal_patient_id" VARCHAR(11) NOT NULL,
    "first_name" VARCHAR(64) NOT NULL,
    "last_name" VARCHAR(64) NOT NULL,
    "sex" "SexType" NOT NULL DEFAULT 'FEMALE',
    "date_of_birth" DATE NOT NULL,
    "state_code" CHAR(2) NOT NULL,
    "email" VARCHAR(64) NOT NULL,
    "phone" VARCHAR(14) NOT NULL,
    "address_line_1" VARCHAR(46) NOT NULL,
    "address_line_2" VARCHAR(46),
    "city" VARCHAR(50) NOT NULL,
    "state" CHAR(2) NOT NULL,
    "postal_code" VARCHAR(10) NOT NULL,
    "payment_type" "PaymentType" NOT NULL,
    "date_of_consent" TIMESTAMPTZ(3) NOT NULL,
    "truepill_patient_token" VARCHAR(50),
    "stripe_customer_id" VARCHAR(50),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "patients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "insurance_policies" (
    "id" UUID NOT NULL,
    "member_name" VARCHAR(128) NOT NULL,
    "member_id" VARCHAR(64) NOT NULL,
    "plan_name" VARCHAR(64) NOT NULL,
    "rx_group" VARCHAR(64) NOT NULL,
    "rx_bin" VARCHAR(64) NOT NULL,
    "pcn" VARCHAR(64) NOT NULL,
    "is_medicaid" BOOLEAN NOT NULL DEFAULT false,
    "patientId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "insurance_policies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prescriptions" (
    "id" UUID NOT NULL,
    "prescriber_company" VARCHAR(64) NOT NULL,
    "prescriber_address_line_1" VARCHAR(64) NOT NULL,
    "prescriber_address_line_2" VARCHAR(64),
    "prescriber_city" VARCHAR(50) NOT NULL,
    "prescriber_state" CHAR(2) NOT NULL,
    "prescriber_postal_code" VARCHAR(10) NOT NULL,
    "prescriber_phone" VARCHAR(14) NOT NULL,
    "prescriber_license_number" VARCHAR(128) NOT NULL,
    "prescriber_signature" VARCHAR(255),
    "dea_number" VARCHAR(9),
    "npi" VARCHAR(10) NOT NULL,
    "rx_signature" VARCHAR(68) NOT NULL,
    "date_written" TIMESTAMP(6) NOT NULL,
    "ndc" VARCHAR(12) NOT NULL,
    "medication" VARCHAR(128) NOT NULL,
    "quantity" SMALLINT NOT NULL,
    "unit" VARCHAR(64) NOT NULL,
    "sig" VARCHAR(128) NOT NULL,
    "indication" VARCHAR(64) NOT NULL,
    "refills" SMALLINT NOT NULL,
    "daw" BOOLEAN NOT NULL,
    "truepill_rx_token" TEXT,
    "patientId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "prescriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "consultations" (
    "id" TEXT NOT NULL,
    "abdominal_or_pelvic_surgeries" BOOLEAN,
    "alcohol_usage" VARCHAR(26),
    "allergies" BOOLEAN,
    "allergies_note" TEXT,
    "average_menstrual_cycle" VARCHAR(43),
    "bloating" BOOLEAN,
    "blood_clot" BOOLEAN,
    "blood_clot_note" TEXT,
    "blood_pressure" VARCHAR(41),
    "breast_pain_before_period" BOOLEAN,
    "cervical_dysplasia_or_abnormal_paps" BOOLEAN,
    "cold_sores_frequency" VARCHAR(21),
    "consent_to_telehealth" VARCHAR(18),
    "current_birth_control" TEXT,
    "current_birth_control_note" TEXT,
    "current_cold_sores_outbreak" BOOLEAN,
    "current_genitial_herpes_outbreak" BOOLEAN,
    "decreased_libido" VARCHAR(16),
    "diabetes" BOOLEAN,
    "diabetes_note" TEXT,
    "difficulty_sleeping" VARCHAR(19),
    "drospirenone_waiver" VARCHAR(146),
    "endometriosis" VARCHAR(13),
    "excess_hair_growth" VARCHAR(63),
    "exercise_frequency" VARCHAR(19),
    "fibroids" VARCHAR(8),
    "genital_herpes_frequency" VARCHAR(21),
    "given_birth" BOOLEAN,
    "had_period_in_past_year" BOOLEAN,
    "hair_loss" VARCHAR(26),
    "heart_conditions" BOOLEAN,
    "heart_conditions_note" TEXT,
    "height" DECIMAL NOT NULL,
    "herpes_consult_conditions" VARCHAR(54),
    "herpes_consult_medications" VARCHAR(137),
    "high_blood_pressure" BOOLEAN,
    "high_blood_pressure_note" TEXT,
    "high_prolactin_level" VARCHAR(22),
    "hiv_or_aids" VARCHAR(8),
    "hot_flashes_or_night_sweats" VARCHAR(27),
    "irritability_anxiety_depression_or_worsening_pms" VARCHAR(63),
    "is_breastfeeding" BOOLEAN,
    "is_generic_ok" BOOLEAN,
    "liver_conditions" BOOLEAN,
    "liver_conditions_note" TEXT,
    "lose_balance_or_trip_easily" BOOLEAN,
    "medications" VARCHAR(43),
    "medications_note" TEXT,
    "menstrual_cycle_details" VARCHAR(63),
    "migraines" BOOLEAN,
    "monthly_menstrual_cycles" BOOLEAN,
    "other_conditions" BOOLEAN,
    "other_conditions_note" TEXT,
    "ovarian_cysts" VARCHAR(14),
    "pain_bowel_movements" VARCHAR(25),
    "pain_deep_penetrative_sex" VARCHAR(30),
    "pain_pelvic" VARCHAR(62),
    "patches_of_thickened_darkened_skin" VARCHAR(44),
    "period_preference" VARCHAR(15),
    "polycystic_ovarian_syndrome" VARCHAR(33),
    "pregnant" BOOLEAN,
    "previous_birth_control_part1" BOOLEAN,
    "previous_birth_control_part2" BOOLEAN,
    "previous_brith_control_part2_note" TEXT,
    "previously_diagnosed_cold_sores" BOOLEAN,
    "previously_diagnosed_genital_herpes" BOOLEAN,
    "primary_reason" VARCHAR(29),
    "progestin_only_pill_questions" TEXT,
    "questions_for_doctor" BOOLEAN,
    "questions_for_doctor_note" TEXT,
    "recent_varicella_or_zoster_vaccination" BOOLEAN,
    "regular_menstrual_cycles" VARCHAR(38),
    "rheumatologic_or_autoimmune_disorder" VARCHAR(90),
    "severe_acne" VARCHAR(11),
    "severe_menstrual_cramping" VARCHAR(87),
    "sexually_transmitted_infection" VARCHAR(69),
    "side_effect_concerns" BOOLEAN,
    "side_effect_concerns_note" TEXT,
    "state_code" CHAR(2),
    "supplements" VARCHAR(19),
    "surgeries" BOOLEAN,
    "surgeries_note" TEXT,
    "thyroid_disorder" VARCHAR(18),
    "tobacco" BOOLEAN,
    "tobacco_note" TEXT,
    "tobacco_usage" VARCHAR(19),
    "using_hormonal_birth_control" BOOLEAN,
    "uterine_polyps" VARCHAR(14),
    "vaginal_dryness_or_pain_with_sex" VARCHAR(32),
    "weight" DECIMAL,
    "weight_gain" VARCHAR(14),
    "patientId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "consultations_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "patients_extrenal_patient_id_key" ON "patients"("extrenal_patient_id");

-- CreateIndex
CREATE UNIQUE INDEX "patients_email_key" ON "patients"("email");

-- CreateIndex
CREATE INDEX "patients_email_date_of_birth_idx" ON "patients"("email", "date_of_birth");

-- CreateIndex
CREATE INDEX "patients_extrenal_patient_id_idx" ON "patients"("extrenal_patient_id");

-- CreateIndex
CREATE UNIQUE INDEX "patients_email_date_of_birth_key" ON "patients"("email", "date_of_birth");

-- CreateIndex
CREATE UNIQUE INDEX "insurance_policies_patientId_key" ON "insurance_policies"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "prescriptions_patientId_key" ON "prescriptions"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "consultations_patientId_key" ON "consultations"("patientId");

-- AddForeignKey
ALTER TABLE "insurance_policies" ADD CONSTRAINT "insurance_policies_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prescriptions" ADD CONSTRAINT "prescriptions_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "consultations" ADD CONSTRAINT "consultations_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
