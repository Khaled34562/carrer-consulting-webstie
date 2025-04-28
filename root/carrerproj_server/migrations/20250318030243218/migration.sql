BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "credentials" DROP COLUMN "fileUrl";
ALTER TABLE "credentials" ADD COLUMN "fileData" bytea;
ALTER TABLE "credentials" ADD COLUMN "fileName" text;
ALTER TABLE "credentials" ADD COLUMN "fileType" text;

--
-- MIGRATION VERSION FOR carrerproj
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carrerproj', '20250318030243218', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250318030243218', "timestamp" = now();

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
