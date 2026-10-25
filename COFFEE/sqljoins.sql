-- %%
-- ! Give me all orders including employee details of the employee who processes that order
-- ! only include orders punched by employees

SELECT * FROM orders;

-- %%
SELECT * FROM orders AS o
JOIN employees  AS e ON e.employee_id = o.employee_id;

-- %%
-- ! GIve me all orders and include employee details of employee who processed that order and 
-- ! if it is directly coming from customer keep employee details empty

SELECT o.status, o.order_id, e.email, e.first_name FROM orders as o LEFT JOIN employees as e ON o.employee_id = e.employee_id;

-- %%
SELECT o.status, o.order_id, e.email, e.first_name FROM orders as o RIGHT JOIN employees as e ON o.employee_id = e.employee_id;

-- %%
SELECT o.status, o.order_id, e.email, e.first_name FROM orders as o FULL OUTER JOIN employees as e ON o.employee_id = e.employee_id;

-- %%
SELECT * FROM departments CROSS JOIN categories;