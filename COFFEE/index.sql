-- %%
-- Active: 1792772116333@@127.0.0.1@5432@sample_data
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