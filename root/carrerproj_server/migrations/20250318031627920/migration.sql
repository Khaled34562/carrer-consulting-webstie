BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "credentials" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "credentials" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "version" text NOT NULL,
    "fileUrl" text NOT NULL,
    "filePath" text NOT NULL,
    "description" text,
    "issuer" text,
    "expirationDate" timestamp without time zone,
    "status" text
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "credentials"
    ADD CONSTRAINT "credentials_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR carrerproj
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carrerproj', '20250318031627920', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250318031627920', "timestamp" = now();

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
