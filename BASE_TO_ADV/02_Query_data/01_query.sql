-- Active: 1784287945862@@127.0.0.1@5432



-- ---------------- xx ----------------
-- SELECT & FROM
-- ---------------- xx ----------------

-- SELECT * FROM customers;

-- "*" means all the data

-- SELECT * FROM orders;

-- Select specific columns only

-- SELECT 
--     first_name, 
--     country, 
--     score 
-- FROM customers;



-- ---------------- xx ----------------
-- WHERE
-- ---------------- xx ----------------

SELECT * FROM customers;

-- WHERE is condition

-- SELECT * FROM customers WHERE score > 0;
-- SELECT * FROM customers WHERE score != 0;

-- i wan't users only from country = Germany
-- SELECT * FROM customers WHERE country = 'Germany';

-- SELECT first_name, country FROM customers WHERE country = 'Germany';

-- ---------------- xx ----------------
