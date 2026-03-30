# Stored Procedures, Functions, and Triggers

SQL isn't just about reading data; it has its own imperative programming capabilities. Instead of executing hundreds of separate SQL scripts from your backend application (like Python or Java), you can pre-compile that logic directly into the database.

## 1. Stored Procedures

A Stored Procedure is a prepared SQL code block that you save, so the code can be reused continuously. If you have a query (or a mix of DML queries) you write over and over, save it as a stored procedure. 

### Benefits
1. **Network Efficiency:** Instead of sending massive query strings over the network, you just send the procedure name.
2. **Security:** You can grant users permission to execute the procedure without granting them underlying `SELECT/UPDATE` permissions on the core tables.
3. **Encapsulation:** Put complex business logic centrally in the database.

### Syntax Example (PostgreSQL / SQL Server)
*(Note: SP syntax varies wildly between RDBMS flavors. Below is a generic Pl/pgSQL-like approach).*

```sql
-- Creating a procedure to handle employee transfers
CREATE OR REPLACE PROCEDURE TransferEmployee(
    emp_id INT, 
    new_department VARCHAR(50)
) 
LANGUAGE plpgsql
AS $$
BEGIN
    -- Update the old department count (pseudo logic)
    -- UPDATE departments SET count = count - 1 WHERE...
    
    -- Update the employee's new department
    UPDATE employees
    SET department = new_department, 
        last_transferred = CURRENT_DATE
    WHERE employee_id = emp_id;
    
    -- Commit is implicit if it's successful in most modern procedures, 
    -- but you can do explicit commit/rollback here!
    COMMIT;
END;
$$;

-- Executing it:
CALL TransferEmployee(104, 'Engineering');
```

## 2. User-Defined Functions (UDFs)

While stored procedures are for executing actions (Updates/Inserts), **Functions** are intended to compute and return a value. 
*   Functions *must* return a value. 
*   Functions can be used inside standard `SELECT` statements (Unlike Procedures).

```sql
-- Function to calculate an employee's annual bonus based on ranking
CREATE FUNCTION CalculateBonus(salary NUMERIC, performance_rating INT) 
RETURNS NUMERIC 
LANGUAGE plpgsql
AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    IF performance_rating >= 9 THEN
        bonus := salary * 0.20; -- 20% bonus
    ELSEIF performance_rating >= 7 THEN
        bonus := salary * 0.10; -- 10% bonus
    ELSE
        bonus := 0;
    END IF;
    
    RETURN bonus;
END;
$$;

-- You can use the function directly inline:
SELECT first_name, CalculateBonus(salary, rating) as expected_bonus FROM employees;
```

## 3. Triggers

A Trigger is a special kind of Stored Procedure that executes automatically (it "fires") whenever a specific event occurs in the database server.
You assign triggers to listen for `INSERT`, `UPDATE`, or `DELETE` commands on a specific table.

### Use Cases:
1. **Auditing/Logging:** Automatically keeping track of exactly who changed what row and when (creating an audit history).
2. **Complex Constraints:** Enforcing business rules that a simple `CHECK Constraint` cannot handle.

### Syntax Example
First, you create the function that executes the logic. Then, you link it to the table via a Trigger.

```sql
-- 1. Create the Audit Function
CREATE FUNCTION LogSalaryChange() 
RETURNS trigger 
AS $$
BEGIN
    -- Check if the salary actually changed during this UPDATE
    IF NEW.salary <> OLD.salary THEN
        INSERT INTO salary_audit_log(employee_id, old_salary, new_salary, changed_on)
        VALUES(OLD.employee_id, OLD.salary, NEW.salary, clock_timestamp());
    END IF;

    RETURN NEW; -- Important: must return NEW for BEFORE triggers or INSTEAD OF.
END;
$$ LANGUAGE plpgsql;

-- 2. Create the Trigger on the Table
CREATE TRIGGER trigger_log_salary
AFTER UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION LogSalaryChange();
```
Now, anytime someone runs `UPDATE employees SET salary = 90000 WHERE id = 5`, the database automatically—invisibly—records the change in `salary_audit_log`.
