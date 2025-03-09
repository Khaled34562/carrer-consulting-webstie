BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "user" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "consultant" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "advice_seeker" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "article" DROP CONSTRAINT "article_fk_0";
CREATE INDEX "user_article_idx" ON "article" USING btree ("authorId");
ALTER TABLE ONLY "article"
    ADD CONSTRAINT "article_fk_0"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "article_like" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "articleId" bigint NOT NULL,
    "createdAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "user_article_unique_idx" ON "article_like" USING btree ("userId", "articleId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comment" DROP CONSTRAINT "comment_fk_0";
ALTER TABLE "comment" DROP CONSTRAINT "comment_fk_1";
CREATE INDEX "article_comment_idx" ON "comment" USING btree ("articleId");
CREATE INDEX "user_comment_idx" ON "comment" USING btree ("userId");
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_0"
    FOREIGN KEY("articleId")
    REFERENCES "article"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "fullName" text NOT NULL,
    "nickname" text NOT NULL,
    "dateOfBirth" timestamp without time zone NOT NULL,
    "gender" text NOT NULL,
    "profileImage" text,
    "country" text NOT NULL,
    "languages" json NOT NULL,
    "timezone" text NOT NULL,
    "creditCardInfo" text,
    "educationLevel" text,
    "hourlyRate" double precision
);

-- Indexes
CREATE UNIQUE INDEX "user_unique_idx" ON "user_profile" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "article_like"
    ADD CONSTRAINT "article_like_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "article_like"
    ADD CONSTRAINT "article_like_fk_1"
    FOREIGN KEY("articleId")
    REFERENCES "article"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_profile"
    ADD CONSTRAINT "user_profile_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR authinticationproj
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('authinticationproj', '20250309225137053', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250309225137053', "timestamp" = now();

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
