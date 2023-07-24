-- CreateEnum
CREATE TYPE "RoleType" AS ENUM ('USER', 'PROVIDER', 'ADMIN');

-- CreateEnum
CREATE TYPE "PaymentType" AS ENUM ('INSURANCE', 'CASH');

-- CreateEnum
CREATE TYPE "SexType" AS ENUM ('MALE', 'FEMALE', 'INTERSEX');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" VARCHAR(64) NOT NULL,
    "role" "RoleType" NOT NULL DEFAULT 'USER',
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clients" (
    "id" VARCHAR(128) NOT NULL,
    "secret" VARCHAR(128) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "patients" (
    "id" SERIAL NOT NULL,
    "external_patient_id" VARCHAR(11),
    "first_name" VARCHAR(64),
    "last_name" VARCHAR(64),
    "sex" "SexType" NOT NULL DEFAULT 'FEMALE',
    "date_of_birth" DATE NOT NULL,
    "state_code" CHAR(2),
    "email" VARCHAR(64) NOT NULL,
    "phone" VARCHAR(14),
    "address_line_1" VARCHAR(92),
    "address_line_2" VARCHAR(92),
    "city" VARCHAR(50),
    "state" CHAR(2),
    "postal_code" VARCHAR(32),
    "payment_type" "PaymentType" NOT NULL DEFAULT 'CASH',
    "date_of_consent" TIMESTAMPTZ(3),
    "truepill_patient_token" VARCHAR(50),
    "stripe_customer_id" VARCHAR(50),
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "patients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "insurance_policies" (
    "id" SERIAL NOT NULL,
    "member_name" VARCHAR(128),
    "member_id" VARCHAR(64),
    "plan_name" VARCHAR(64),
    "rx_group" VARCHAR(64),
    "rx_bin" VARCHAR(64),
    "pcn" VARCHAR(64),
    "is_medicaid" BOOLEAN DEFAULT false,
    "patient_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "insurance_policies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prescriptions" (
    "id" SERIAL NOT NULL,
    "prescriber_company" VARCHAR(64) NOT NULL DEFAULT 'Simple Health',
    "prescriber_address_line_1" VARCHAR(64) NOT NULL DEFAULT '228 Park Ave S',
    "prescriber_address_line_2" VARCHAR(64) DEFAULT '#20627',
    "prescriber_city" VARCHAR(50) NOT NULL DEFAULT 'New York',
    "prescriber_state" CHAR(2) NOT NULL DEFAULT 'NY',
    "prescriber_postal_code" VARCHAR(32) NOT NULL DEFAULT '10003',
    "prescriber_phone" VARCHAR(14) NOT NULL DEFAULT '(800) 607-9565',
    "prescriber_name" VARCHAR(128),
    "prescriber_license_number" VARCHAR(128),
    "prescriber_signature" VARCHAR(255),
    "dea_number" VARCHAR(9),
    "npi" VARCHAR(32),
    "rx_signature" VARCHAR(68),
    "date_written" TIMESTAMP(6) NOT NULL,
    "ndc" VARCHAR(32),
    "medication" TEXT,
    "quantity" SMALLINT,
    "unit" VARCHAR(64),
    "sig" TEXT,
    "indication" VARCHAR(64),
    "refills" SMALLINT,
    "daw" BOOLEAN,
    "truepill_rx_token" TEXT,
    "patient_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "prescriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "consultations" (
    "id" SERIAL NOT NULL,
    "abdominal_or_pelvic_surgeries" BOOLEAN,
    "alcohol_usage" TEXT,
    "allergies" BOOLEAN,
    "allergies_note" TEXT,
    "average_menstrual_cycle" TEXT,
    "bloating" BOOLEAN,
    "blood_clot" BOOLEAN,
    "blood_clot_note" TEXT,
    "blood_pressure" VARCHAR(41),
    "breast_pain_before_period" BOOLEAN,
    "cervical_dysplasia_or_abnormal_paps" BOOLEAN,
    "cold_sores_frequency" TEXT,
    "consent_to_telehealth" TEXT,
    "current_birth_control" TEXT,
    "current_birth_control_note" TEXT,
    "current_cold_sores_outbreak" BOOLEAN,
    "current_genitial_herpes_outbreak" BOOLEAN,
    "decreased_libido" BOOLEAN,
    "diabetes" BOOLEAN,
    "diabetes_note" TEXT,
    "difficulty_sleeping" BOOLEAN,
    "drospirenone_waiver" BOOLEAN,
    "endometriosis" BOOLEAN,
    "excess_hair_growth" BOOLEAN,
    "exercise_frequency" TEXT,
    "fibroids" BOOLEAN,
    "genital_herpes_frequency" TEXT,
    "given_birth" BOOLEAN,
    "had_period_in_past_year" BOOLEAN,
    "hair_loss" BOOLEAN,
    "heart_conditions" BOOLEAN,
    "heart_conditions_note" TEXT,
    "height" DECIMAL,
    "herpes_consult_conditions" TEXT,
    "herpes_consult_medications" TEXT,
    "high_blood_pressure" BOOLEAN,
    "high_blood_pressure_note" TEXT,
    "high_prolactin_level" BOOLEAN,
    "hiv_or_aids" BOOLEAN,
    "hot_flashes_or_night_sweats" BOOLEAN,
    "irritability_anxiety_depression_or_worsening_pms" BOOLEAN,
    "is_breastfeeding" BOOLEAN,
    "is_generic_ok" BOOLEAN,
    "liver_conditions" BOOLEAN,
    "liver_conditions_note" TEXT,
    "lose_balance_or_trip_easily" BOOLEAN,
    "medications" TEXT,
    "medications_note" TEXT,
    "menstrual_cycle_details" TEXT,
    "migraines" BOOLEAN,
    "monthly_menstrual_cycles" BOOLEAN,
    "other_conditions" BOOLEAN,
    "other_conditions_note" TEXT,
    "ovarian_cysts" BOOLEAN,
    "pain_bowel_movements" BOOLEAN,
    "pain_deep_penetrative_sex" BOOLEAN,
    "pain_pelvic" BOOLEAN,
    "patches_of_thickened_darkened_skin" BOOLEAN,
    "period_preference" TEXT,
    "polycystic_ovarian_syndrome" BOOLEAN,
    "pregnant" BOOLEAN,
    "previous_birth_control_part1" BOOLEAN,
    "previous_brith_control_part1_note" TEXT,
    "previous_birth_control_part2" BOOLEAN,
    "previous_brith_control_part2_note" TEXT,
    "previously_diagnosed_cold_sores" BOOLEAN,
    "previously_diagnosed_genital_herpes" BOOLEAN,
    "primary_reason" TEXT,
    "progestin_only_pill_questions" BOOLEAN,
    "questions_for_doctor" BOOLEAN,
    "questions_for_doctor_note" TEXT,
    "recent_varicella_or_zoster_vaccination" BOOLEAN,
    "regular_menstrual_cycles" TEXT,
    "rheumatologic_or_autoimmune_disorder" BOOLEAN,
    "severe_acne" BOOLEAN,
    "severe_menstrual_cramping" BOOLEAN,
    "sexually_transmitted_infection" BOOLEAN,
    "sexually_transmitted_infection_note" TEXT,
    "side_effect_concerns" BOOLEAN,
    "side_effect_concerns_note" TEXT,
    "state_code" CHAR(2),
    "supplements" TEXT,
    "surgeries" BOOLEAN,
    "surgeries_note" TEXT,
    "thyroid_disorder" BOOLEAN,
    "tobacco" BOOLEAN,
    "tobacco_note" TEXT,
    "tobacco_usage" TEXT,
    "using_hormonal_birth_control" BOOLEAN,
    "uterine_polyps" BOOLEAN,
    "vaginal_dryness_or_pain_with_sex" BOOLEAN,
    "weight" DECIMAL,
    "weight_gain" BOOLEAN,
    "patient_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "consultations_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "clients_id_key" ON "clients"("id");

-- CreateIndex
CREATE UNIQUE INDEX "clients_secret_key" ON "clients"("secret");

-- CreateIndex
CREATE UNIQUE INDEX "patients_id_key" ON "patients"("id");

-- CreateIndex
CREATE UNIQUE INDEX "patients_email_key" ON "patients"("email");

-- CreateIndex
CREATE INDEX "patients_email_date_of_birth_idx" ON "patients"("email", "date_of_birth");

-- CreateIndex
CREATE INDEX "patients_external_patient_id_idx" ON "patients"("external_patient_id");

-- CreateIndex
CREATE UNIQUE INDEX "patients_email_date_of_birth_key" ON "patients"("email", "date_of_birth");

-- CreateIndex
CREATE UNIQUE INDEX "prescriptions_id_key" ON "prescriptions"("id");

-- CreateIndex
CREATE UNIQUE INDEX "consultations_id_key" ON "consultations"("id");

-- AddForeignKey
ALTER TABLE "insurance_policies" ADD CONSTRAINT "insurance_policies_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prescriptions" ADD CONSTRAINT "prescriptions_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "consultations" ADD CONSTRAINT "consultations_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
