-- %%
-- Active: 1792772116333@@127.0.0.1@5432@sample_data
-- ! INSERT < UPDATE < DELETE are called as DML DATA MANIPULATION LANGUAGE;
SELECT
    *
FROM
    products;

-- %%
-- UPDATE QUERY
UPDATE products
SET
    is_active = FALSE
UPDATE products
SET
    stock_quantity = 135
WHERE
    product_id = 3;


-- Update substract from other columns
UPDATE products
SET
    stock_quantity = stock_quantity - 15;


SELECT
    *
FROM
    departments;

-- %%
-- DELETE
DELETE FROM departments
WHERE
    department_id = 4;

-- %%
SELECT
    product_name,
    product_id
FROM
    products
LIMIT
    3;

-- %%
SELECT
    category_name AS c_name,
    category_id
FROM
    categories
LIMIT
    30;

-- %%
SELECT
    product_name AS "product Name" ,
    product_id
FROM
    products;

-- %%
-- DISTINCT mean unique
SELECT DISTINCT
    country
FROM
    customers;

-- %%
SELECT
    *
FROM
    products
WHERE
    price > 100;

-- %%
SELECT
    *
FROM
    products
WHERE
    stock_quantity > 0
    AND price < 150;

-- %%
SELECT
    *
FROM
    products
WHERE
    stock_quantity = 0
    OR price < 150;

-- %%
SELECT
    *
FROM
    products
WHERE
    NOT is_active;

-- %%
SELECT
    *
FROM
    products
WHERE
    price BETWEEN 50 AND 200;

-- %%
SELECT * FROM products WHERE category_id IN (1,2,3);

-- %%
SELECT * FROM products;

-- %%
SELECT * FROM products WHERE product_name LIKE 'Wireless%';

-- %%
INSERT INTO
    products (
        category_id,
        product_name,
        price,
        stock_quantity
    )
VALUES
    (1, 'Wireless Watch', 3000, 5),
    (1, 'Wireless Joystick', 50000, 5),
    (1, 'Wireless Light', 2000, 5),
    (1, 'Wireless Headphones', 3200, 5);

-- %%
SELECT
    *
FROM
    products;


SELECT
    *
FROM
    categories;


SELECT
    *
FROM
    customers;

-- %%
-- give me customers who does not have phone ROW_NUMBER(
SELECT
    *
FROM
    customers
WHERE
    phone IS NULL;

-- %%


-- %%


-- %%


-- %%


-- %%


-- %%


-- %%


-- %%


-- %%
