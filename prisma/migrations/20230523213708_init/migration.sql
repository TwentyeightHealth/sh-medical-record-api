-- CreateTable
CREATE TABLE "clients" (
    "id" UUID NOT NULL,
    "secret" VARCHAR(128) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "clients_id_key" ON "clients"("id");

-- CreateIndex
CREATE UNIQUE INDEX "clients_secret_key" ON "clients"("secret");
