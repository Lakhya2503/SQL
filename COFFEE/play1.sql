-- Active: 1781180299291@@127.0.0.1@5433@users

-- CREATE DATABASE users;

-- SELECT * FROM "users";

-- ============ XXXXXXXXX ============

-- SELECT "title" FROM books;

-- ============ XXXXXXXXX ============

-- SELECT "title", "author" FROM "books";

-- ============ XXXXXXXXX ============

-- ##############################
--                         LIMIT
-- ##############################

-- SELECT "title" FROM "books" LIMIT 7;

-- ============ XXXXXXXXX ============
-- ##############################
--                         WHERE
-- ##############################

-- ##############################
--                         =
-- ##############################



-- SELECT "title", "author" FROM "books" WHERE "publicationyear" = 2013;

-- SELECT "title", "author","publicationyear" FROM "books" WHERE "publicationyear" = 2013;


-- ============ XXXXXXXXX ============

-- ##############################
--                         !=
-- ##############################

-- SELECT "title", "author","genre" FROM "books" WHERE "genre" != 'Mystery';
-- ============ XXXXXXXXX ============

-- ##############################
--                         <>
-- ##############################

-- SELECT "title", "author","genre" FROM "books" WHERE "genre" <> 'Mystery';


-- ============ XXXXXXXXX ============

-- ##############################
--                         NOT
-- ##############################

-- SELECT "title","author" FROM "books" WHERE NOT "genre" = 'Mystery';
-- SELECT "title","author","genre" FROM "books" WHERE NOT "genre" = 'Mystery';

-- ============ XXXXXXXXX ============
-- ##############################
--                         OR
-- -- ##############################
-- SELECT "title", "author" FROM "books" WHERE "publicationyear" = 2014 OR
-- "publicationyear" = 2013;
-- SELECT "title", "author","publicationyear" FROM "books" WHERE "publicationyear" = 2014 OR
-- "publicationyear" = 2013;


-- ============ XXXXXXXXX ============
-- ##############################
--                         AND
-- ##############################

SELECT "title","author","publicationyear","genre" FROM "books"
WHERE ( "publicationyear" = 2013 OR "publicationyear" = 2014) AND
NOT "genre" = 'Science Fiction';























--
