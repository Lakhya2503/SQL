-- Active: 1782647658205@@127.0.0.1@5432@review
Active: 1782647658205@@127.0.0.1@5432@review

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

-- SELECT "title","author","publicationyear","genre" FROM "books"
-- WHERE ( "publicationyear" = 2013 OR "publicationyear" = 2014) AND
-- NOT "genre" = 'Science Fiction';

-- ============ XXXXXXXXX ============
-- ##############################
--                         asignment operators
-- ##############################

-- Q. I wan't books which is publicationyear is before 2019 and after 2022 also the year included
-- SELECT "title", "genre" ,"publicationyear" FROM "books" 
-- WHERE "publicationyear" >= 2019 AND "publicationyear" <= 2022;























--
