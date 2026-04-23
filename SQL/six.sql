
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

-- SELECT CONCAT_WS(' ', fname, lname) AS FullName FROM employees;


-- as you can see the speration on this field of fname and lname then he will shows firsName lastName like that

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-- SELECT SUBSTR('Hello buddy', 1, 6)

-- this will cut the words from firstly give a word then from starting index to ending index

-- SELECT substr(fname, 1, 2) FROM employees -- real life example

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-- SELECT length(fname) FROM employees;
--  ex.
--  SELECT * FROM employees WHERE length (fname) > 5;

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX




































--
