BEGIN;


--
-- MIGRATION VERSION FOR carrer_consilting_website
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carrer_consilting_website', '20250211054947898', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250211054947898', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
