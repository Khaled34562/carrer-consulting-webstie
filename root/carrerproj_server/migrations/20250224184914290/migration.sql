BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "article" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "content" text NOT NULL,
    "authorId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone,
    "likes" bigint NOT NULL,
    "shares" bigint NOT NULL,
    "isArchived" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment" (
    "id" bigserial PRIMARY KEY,
    "articleId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "comment" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
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
CREATE UNIQUE INDEX "user_unique_idx" ON "user" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "article"
    ADD CONSTRAINT "article_fk_0"
    FOREIGN KEY("authorId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_0"
    FOREIGN KEY("articleId")
    REFERENCES "article"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user"
    ADD CONSTRAINT "user_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR authinticationproj
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('authinticationproj', '20250224184914290', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250224184914290', "timestamp" = now();

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
