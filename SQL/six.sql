
-- ---------------- STRING FUNCTIONS -------------------
---------------- ----------------
                 --  CONCAT --
---------------- ----------------

-- SELECT concat('hello', 'word');  // combine the firstWord and secondWord just like ( ** hello word )

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-- SELECT * FROM employees;

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-- SELECT CONCAT(fname,lname) FROM employees

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-- ALIASE ( ** Temporary name )

-- SELECT CONCAT(fname,lname) AS FullName FROM employees;

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-- you can also add centeral changes

-- SELECT emp_id, CONCAT(fname,lname) AS FullName, dept FROM employees;

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

SELECT CONCAT_WS(' ', fname, lname) AS FullName FROM employees;


-- as you can see the speration on this field of fname and lname then he will shows firsName lastName like that


-- 01:56:40











































--
