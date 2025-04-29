BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_message" (
    "id" bigserial PRIMARY KEY,
    "senderId" bigint NOT NULL,
    "receiverId" bigint NOT NULL,
    "text" text NOT NULL,
    "sentAt" timestamp without time zone NOT NULL,
    "isRead" boolean NOT NULL
);

-- Indexes
CREATE INDEX "sender_chat_idx" ON "chat_message" USING btree ("senderId");
CREATE INDEX "receiver_chat_idx" ON "chat_message" USING btree ("receiverId");

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
-- ACTION CREATE TABLE
--
CREATE TABLE "cv_generations" (
    "id" bigserial PRIMARY KEY,
    "cvId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "userProfileSnapshot" json NOT NULL,
    "generatedCV" text,
    "status" text,
    "error" text,
    "createdAt" timestamp without time zone NOT NULL,
    "generatedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "cv_reviews" (
    "id" bigserial PRIMARY KEY,
    "cvId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "originalCV" text NOT NULL,
    "feedback" text,
    "targetLanguage" text,
    "targetCountry" text,
    "status" text,
    "error" text,
    "createdAt" timestamp without time zone NOT NULL,
    "reviewedAt" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "chat_message"
    ADD CONSTRAINT "chat_message_fk_0"
    FOREIGN KEY("senderId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "chat_message"
    ADD CONSTRAINT "chat_message_fk_1"
    FOREIGN KEY("receiverId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "cv_generations"
    ADD CONSTRAINT "cv_generations_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "cv_reviews"
    ADD CONSTRAINT "cv_reviews_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR carrerproj
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('carrerproj', '20250429032100738', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250429032100738', "timestamp" = now();

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
