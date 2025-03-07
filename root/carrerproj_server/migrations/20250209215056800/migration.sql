BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "advice_seeker" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "imagePath" text NOT NULL,
    "careerLevel" text NOT NULL,
    "educationBackground" text NOT NULL,
    "jobInterest" text NOT NULL,
    "resumeLink" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "advice_seeker_user_unique_idx" ON "advice_seeker" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "consultant" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "imagePath" text NOT NULL,
    "availabilityStart" timestamp without time zone NOT NULL,
    "availabilityEnd" timestamp without time zone NOT NULL,
    "specializationField" text NOT NULL,
    "degree" text NOT NULL,
    "yearsOfExperience" bigint NOT NULL,
    "consultationType" text NOT NULL,
    "bio" text NOT NULL,
    "rating" double precision NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "consultant_user_unique_idx" ON "consultant" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "advice_seeker"
    ADD CONSTRAINT "advice_seeker_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "consultant"
    ADD CONSTRAINT "consultant_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR authinticationproj
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('authinticationproj', '20250209215056800', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250209215056800', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
