/*<<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>>
Transactions Locking Stored Procedures and PLSQL Functions Assignment
INFO 2640 
Written by Lisa Thoendel
Last Updated Fall 2023

Objectives:
A. Create a procedure using a cursor.
B. Use functions.
C. Create and execute a procedure.

Scoring:
Each query or answer is worth 10 points. 

Completed by: Corbin Rix


<<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>>*/

/*
#1
In the HR schema, write a script that uses an anonymous block to include two SQL statements coded as a transaction. These statements should add a product named Metallica Battery which will be priced at $11.99 and Rick Astley Never Gonna Give You Up priced at the default price. Code your block so that the output if successful is 'New Products Added.' or if it fails, 'Product Add Failed.'
*/

BEGIN 
	INSERT INTO products (product_id, product_name, product_price)
	VALUES (product_id_seq.NEXTVAL, 'Metallica Battery', 11.99);

	INSERT INTO products (product_id, product_name)
	VALUES (product_id_seq.NEXTVAL, 'Rick Astley Never Gonna Give You Up');

	COMMIT;
	DBMS_OUTPUT.PUT_LINE('New Products Added.');
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('Product Add Failed.');
END;
/


/*
#2
In the HR schema, write a script that creates a new Stored Procedure that updates the products table with new products. (Hint: You do not need to declare parameters for product_id since it has a sequence but you must have a variable for it. You do not need to declare a parameter for add_date since it uses SYSDATE but you must still insert it.)
*/

CREATE OR REPLACE PROCEDURE add_new_product (
    product_name_param  IN VARCHAR2,
    product_price_param IN NUMBER DEFAULT 9.99
) AS
    product_id_var NUMBER; 
BEGIN
    product_id_var := product_id_seq.NEXTVAL;

    INSERT INTO products (product_id, product_name, product_price)
    VALUES (product_id_var, product_name_param, product_price_param);
END;
/



/*
#3
In the HR schema, write a script that calls your new stored procedure to add these two new products:
Product 1: Motley Crue Home Sweet Home	
Price 1: 10.99
Product 2: Lynyrd Skynyrd Freebird	
Price 2: 12.99
*/

BEGIN

    add_new_product('Motley Crue Home Sweet Home', 10.99);
    
    add_new_product('Lynyrd Skynyrd Freebird', 12.99);

END;
/


/*
#4
In the HR schema, write a script that creates a new Function called get_employee_id that will allow you to pass an employee's email address to lookup their employe ID number.
*/

CREATE OR REPLACE PROCEDURE get_employee_id
(
	employee_email_param VARCHAR2
)
RETURN NUMBER 
AS
	employee_id_var NUMBER;
BEGIN
	SELECT employee_id
	INTO employee_id_var
	FROM employees
	WHERE email = employee_email_param;
    
    RETURN employee_id_var;
END;
/
