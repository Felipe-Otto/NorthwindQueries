-- 1. Select the Customers table
-- a) Create a filter to display only customers with contact_title = 'Owner'.
SELECT 
	*
FROM
	customers
WHERE	
	contact_title = 'Owner';

-- b) Create a filter to display only customers from France.
SELECT 
	*	
FROM 
	customers 
WHERE 
	country = 'France';

-- 2. Select the Products table
-- a) Create a filter to display products with zero stock.
SELECT
	*
FROM
	products
WHERE
	units_in_stock = 0;

-- b) Create a filter to display products with a unit price greater than or equal to 50.
SELECT
	*
FROM
	products
WHERE
	unit_price >= 50;

-- 3. Select the Orders table
-- Create a filter to display only orders made after January 1, 1998.
SELECT
	*
FROM
	orders
WHERE
	order_date > '1998-01-01';

-- 4. Select the Customers table
-- a) Create a filter to display only customers with contact_title = 'Owner' and from the country France.
SELECT
	*
FROM
	customers
WHERE
	contact_title = 'Owner'
AND
	country = 'France';
	
-- b) Create a filter to display only customers from Mexico or France.
SELECT
	*
FROM	
	customers
WHERE
	country = 'France'
OR
	country = 'Mexico';

-- 5. Select the Products table
-- a) What are the products measured in boxes?
SELECT
	*
FROM
	products
WHERE
	quantity_per_unit LIKE '%boxes%';
	
-- b) What are the products measured in ml?
SELECT
	*
FROM
	products
WHERE
	quantity_per_unit LIKE '%ml%';

-- 6. Select the Products table
-- a) What products have a unit price between 50 and 100 (using AND)?
SELECT
	*
FROM
	products
WHERE
	unit_price >= 50
AND
	unit_price <= 100;
-- b) What products have a unit price between 50 and 100 (using BETWEEN)?
SELECT 
	*
FROM
	products
WHERE
	unit_price BETWEEN 50 AND 100

-- 7. Select the Orders table
-- a) What orders were made between 01/01/1997 and 12/31/1997 (using AND)?
SELECT
	*
FROM
	orders
WHERE
	order_date >= '1997-01-01'
AND
	order_date <= '1997-12-31';

-- b) What orders were made between 01/01/1997 and 12/31/1997 (using BETWEEN)?
SELECT
	*
FROM
	orders
WHERE
	order_date BETWEEN '1997-01-01' AND '1997-12-31';

-- 8. 
-- a) Find out the number of customers.
SELECT 
	COUNT(*) AS total_customers
FROM
	customers;

-- b) Find out the number of products.
SELECT
	COUNT(*) AS total_products
FROM
	products;

-- 9. 
-- a) What is the sum of the product stock.
SELECT
	SUM(units_in_stock) AS total_products_stock
FROM
	products;
	
-- b) What is the sum of product sales.
SELECT
	SUM(quantity) AS total_products_saled
FROM
	order_details;
	
-- 10. Find the minimum, maximum, and average values of the unit price of products.
SELECT
	MIN(unit_price) AS minimum_price,
	MAX(unit_price) AS maximum_price,
	AVG(unit_price) AS average_price
FROM
	products;

-- 11. Discover the total quantity of customers per country.
SELECT
	country,
	COUNT(*) AS total_customers
FROM
	customers
GROUP BY
	country
ORDER BY
	2 DESC;

-- 12. Discover the total quantity of customers per title.
SELECT
	contact_title,
	COUNT(*) AS total_customers
FROM
	customers
GROUP BY
	contact_title
ORDER BY
	2 DESC;

-- 13. Discover the total quantity of stock per supplier.
SELECT
	S.company_name,
	SUM(P.units_in_stock) AS total_stock
FROM
	products P
INNER JOIN
	suppliers S
ON
	P.supplier_id = S.supplier_id
GROUP BY
	S.company_name
ORDER BY
	2 DESC;

-- 14. Discover the average price of products per supplier.
SELECT
	S.company_name,
	AVG(P.unit_price) AS average_price
FROM
	products P
INNER JOIN
	suppliers S
ON
	P.supplier_id = S.supplier_id
GROUP BY
	S.company_name
ORDER BY
	2 DESC;

-- 15. Discover the total quantity of customers per country, considering only customers with contact_title = 'Owner'.
SELECT
	country,
	COUNT(*) AS total_customers
FROM
	customers
WHERE
	contact_title = 'Owner'
GROUP BY
	country
ORDER BY
	2 DESC;
	
-- 16. Discover the total quantity of customers per country, considering only countries with more than 10 customers.
SELECT
	country,
	COUNT(*) AS total_customers
FROM
	customers
GROUP BY
	country
HAVING 
	COUNT(*) > 10
ORDER BY
	2 DESC;

-- 17. Execute a query that returns the following fields: product_name, unit_price, and category_name.
SELECT
	P.product_name,
	P.unit_price,
	C.category_name
FROM
	products P
INNER JOIN 
	categories C
ON 
	P.category_id = C.category_id;

-- 18. Execute a query that returns the following fields: order_id, customer_id, order_date, contact_name.
SELECT
	O.order_id, 
	O.customer_id, 
	O.order_date, 
	C.contact_name
FROM
	orders O
INNER JOIN
	customers C
ON
	O.customer_id = C.customer_id;

-- 19. Execute a query that returns the total quantity of orders per product. Order the result in descending order.
SELECT
	P.product_name,
	SUM(O.quantity) AS quantity_ordered
FROM
	products P
INNER JOIN
	order_details O
ON 
	O.product_id = P.product_id 
GROUP BY
	P.product_name
ORDER BY
	2 DESC;

-- 20. Execute a query that returns the total quantity of orders per product. Order the result in descending order. 
--     Consider only luxury products (with a unit price greater than $80).
SELECT
	P.product_name,
	SUM(O.quantity) AS quantity_ordered
FROM
	products P
INNER JOIN
	order_details O
ON
	O.product_id = P.product_id
WHERE
	P.unit_price >= 80
GROUP BY
	P.product_name
ORDER BY
	2 DESC;

-- 20. 
-- a) Create a view with the id, name, and price of the products.
CREATE OR REPLACE VIEW vwproducts AS
	SELECT
		product_id, 
		product_name, 
		unit_price
	FROM
		products;

-- b) Select the created view.
SELECT 
	*
FROM
	vwproducts;

-- c) Add to the same view the available units in stock.
CREATE OR REPLACE VIEW vwproducts AS
	SELECT
		product_id, 
		product_name, 
		unit_price,
		units_in_stock
	FROM
		products;
	

-- d) Select the view again.
SELECT 
	*
FROM
	vwproducts;

-- e) Alter its name.
ALTER VIEW vwproducts RENAME TO vw_prod;

-- f) Delete the view.
DROP VIEW vw_prod;

-- 21. 
-- a) Retrieve the average unit price of each product category using the following functions (Using CEILING).
SELECT
	C.category_name,
	CEILING(AVG(P.unit_price)) AS average_price
FROM
	products P
INNER JOIN
	categories C
ON
	P.category_id = C.category_id
GROUP BY
	C.category_name
ORDER BY
	2 DESC;

-- b) Retrieve the average unit price of each product category using the following functions (Using FLOOR).
SELECT
	C.category_name,
	FLOOR(AVG(unit_price)) AS average_price	
FROM
	products P
INNER JOIN
	categories C
ON
	P.category_id = C.category_id
GROUP BY
	C.category_name 
ORDER BY
	2 DESC;

-- c) Retrieve the average unit price of each product category using the following functions (Using ROUND).
SELECT
	C.category_name,
	ROUND(CAST(AVG(P.unit_price) AS NUMERIC), 3) AS average_price
FROM
	products P
INNER JOIN 
	categories C
ON
	P.category_id = C.category_id
GROUP BY
	C.category_name
ORDER BY
	2 DESC;

-- d) Retrieve the average unit price of each product category using the following functions (Using TRUNC).
SELECT
	C.category_name,
	TRUNC(CAST(AVG(P.unit_price) AS NUMERIC), 3)
FROM
	products P
INNER JOIN
	categories C
ON
	C.category_id = P.category_id
GROUP BY
	C.category_name
ORDER BY
	2 DESC;

-- 22. 
-- a) Retrieve the formatted product names (Using UPPER).
SELECT
	UPPER(product_name) AS product_name
FROM
	products;
	
-- b) Retrieve the formatted product names (Using LOWER).
SELECT
	LOWER(product_name)
FROM
	products;

-- c) Retrieve the formatted product names (Using INITCAP).
SELECT
	INITCAP(product_name)
FROM
	products;

-- d) Retrieve the product names along with the character count for each.
SELECT
	product_name,
	LENGTH(product_name) As number_characters
FROM
	products;

-- e) Retrieve the customer name along with the title, but replace 'Owner' with 'CEO'.
SELECT
	contact_name,
	contact_title AS old_contact_title,
	REPLACE(contact_title, 'Owner', 'CEO') AS new_contact_title
FROM
	customers;

-- 23.
-- a) Select the company name of the customers along with the first 3 characters of their respective unique identifiers (Using LEFT)
SELECT
	company_name,
	LEFT(customer_id, 3) AS short_customer_id
FROM
	customers;
	
-- b) Select the company name of the customers along with the first 3 characters of their respective unique identifiers (Using SUBSTRING)
SELECT
	company_name,
	SUBSTRING(customer_id, 1, 3) AS short_customer_id
FROM
	customers;
	
-- c) Select the company name of the customers along with the last 3 characters of their respective unique identifiers (Using RIGHT)
SELECT
	company_name,
	RIGHT(customer_id, 3) AS short_customer_id
FROM
	customers;
	
-- d) Select the company name of the customers along with the last 3 characters of their respective unique identifiers (Using SUBSTRING)
SELECT
	company_name,
	SUBSTRING(customer_id, 3, 3) AS short_customer_id
FROM
	customers;
	
-- 24.
-- a) Return the company names of customers that have a hyphen in their composition along with their respective position in the character.
SELECT
	company_name,
	STRPOS(company_name, '-') AS "position"
	
FROM
	customers
WHERE
	company_name LIKE '%-%';

-- b) Return the company names of customers that have a hyphen in their composition along with the characters preceding it.
SELECT
	company_name,
	SUBSTRING(company_name, 1, STRPOS(company_name, '-') -1)
FROM
	customers
WHERE
	company_name LIKE '%-%';

-- c) Return the company names of customers that have a hyphen in their composition along with the characters that follow it.
SELECT
	company_name,
	SUBSTRING(company_name, STRPOS(company_name, '-') + 1, 100)
FROM
	customers
WHERE
	company_name LIKE '%-%';

-- 25. 
-- a) Select the names of employees along with their respective birth dates and ages.
SELECT
	first_name || ' ' || last_name AS employee_name,
	birth_date,
	AGE(birth_date) AS employee_age
FROM
	employees
	
-- b) Select the names of the customers and, separately, their day, month, and year of birth.
SELECT
	first_name || ' ' || last_name AS employee_name,
	birth_date,
	DATE_PART('DAY', birth_date) AS "day",
	DATE_PART('MONTH', birth_date) AS "month",
	DATE_PART('YEAR', birth_date) AS "year"
FROM
	employees;
	
-- 26. Identify products with a price above the average.
SELECT
	product_name,
	unit_price
FROM
	products
WHERE
	unit_price > (SELECT
				      AVG(unit_price)
				  FROM
				      products);
	
-- 27. Identify orders with a quantity sold above the average quantity sold.
SELECT
	D.order_id,
	O.order_date,
	C.contact_name,
	SUM(D.quantity) AS quantity
FROM
	order_details D
INNER JOIN
	orders O
ON
	O.order_id = D.order_id
INNER JOIN
	customers C
ON
	O.customer_id = C.customer_id	
GROUP BY
	D.order_id,
	O.order_date,
	C.contact_name
HAVING
	SUM(quantity) > (SELECT
					     AVG(total_quantity)
					 FROM (SELECT
						       order_id,
						       sum(quantity) AS total_quantity
					       FROM
						       order_details
						   GROUP BY
						       order_id) T);

-- 28. Determine the average number of customers according to their job title.
SELECT
	AVG(total_customers) customers_average
FROM
	(SELECT
	 	 contact_title,
	 	 COUNT(*) total_customers
	 FROM
	 	 customers
	 GROUP BY
	     contact_title
	 ORDER BY
	 	 2 DESC) t;

-- 29. Perform a query on the products table and add a column containing the overall average of the products.
SELECT
	product_name,
	unit_price,
	(SELECT
	     TRUNC(CAST(AVG(unit_price) AS NUMERIC), 2) AS average_price
	 FROM
	     products)
FROM
	products;
	
-- 30. Create a simple sales value calculator. Use the variables 'quantity', 'price', 'sales_value', and 'salesperson'.
DO $$
DECLARE
	quantity NUMERIC (3, 0) := 100;
	price NUMERIC (5, 2) := 200.50;
	salesperson VARCHAR (200):= 'Otto';
	sales_value NUMERIC (7, 2);
BEGIN
	sales_value = price * quantity;
	RAISE NOTICE 'The salesperson % sold a total of $%', salesperson, price;
END $$;

-- 31. How many products have a price above the average price?
DO $$
DECLARE
	average_price NUMERIC (4, 2);
	products_over_average NUMERIC(2, 0);
BEGIN
	average_price := (SELECT 
	                      AVG(unit_price)
					  FROM
						  products);
	products_over_average := (SELECT 
							      COUNT(*)
							  FROM
							      products
							  WHERE
							      unit_price > average_price);
	RAISE NOTICE 'There is a total of % products with a price above the average', products_over_average;
								
END $$;

-- 32. Create a function that analyzes the product stock. This function should return the total number of products that have a total stock between a user-defined minimum and maximum stock.
CREATE OR REPLACE FUNCTION calculateStockInRange(min_stock INTEGER, max_stock INTEGER)
	RETURNS NUMERIC(3, 0)
	LANGUAGE PLPGSQL
AS $$
DECLARE
	stock_count NUMERIC(3, 0);
BEGIN
	stock_count = (SELECT
					   COUNT(*)
				   FROM
					   products
				   WHERE
					   units_in_stock BETWEEN min_stock AND max_stock);
	RETURN stock_count;
END $$;

-- a) Call the created function using positional notation.
SELECT calculateStockInRange(10, 50) AS total_stock;

-- b) Call the created function using parameter name notation.
SELECT calculateStockInRange(min_stock := 20, max_stock := 50) AS total_stock;

-- c) Call the function using mixed notation.
SELECT calculateStockInRange(30, max_stock := 50) AS total_stock;

-- d) Delete the function.
DROP FUNCTION IF EXISTS calculateStockInRange;

-- 33. Create a function that returns a table containing the list of customers with a specific job title provided by the user.
CREATE OR REPLACE FUNCTION RetrieveOwners(title VARCHAR)
	RETURNS TABLE (customer_id customers.customer_id%TYPE,
				   contact_name customers.contact_name%TYPE,
				   phone customers.phone%TYPE,
				   contact_title customers.contact_title%TYPE)
	LANGUAGE PLPGSQL
AS $$
BEGIN
	RETURN QUERY SELECT
				     C.customer_id,
				     C.contact_name,
				     C.phone,
				     C.contact_title
				 FROM
				     customers C
				 WHERE
				     C.contact_title = title;
END $$;

-- a) Call the created function using positional notation.
SELECT 
	*
FROM
	RetrieveOwners('Owner');
	
-- b) Call the created function using parameter name notation.
SELECT 
	*
FROM 
	RetrieveOwners(title := 'Sales Representative');

-- d) Delete the function.
DROP FUNCTION IF EXISTS RetrieveOwners;

