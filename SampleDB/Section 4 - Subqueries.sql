USE SAMPLEDB
GO

SELECT * FROM hcm.employees;

--Self -contained  Subqueries
--SELECT product_id , category, price FROM products where price =(SELECT MAX(price) FROM products);
--SELECT product-id category, price FROM products WHERE pproduct_id IN (SELECT product_id FROM order_details); 

--Corelated Subqueries

--SELECT procuct_id, category, price FROM products P1 WHERE price =(SELECT MAX(price) FROM procucts p2 WHERE p2.category = p1.category)
--SELECT product-id, category, price FROM product p1 where price = (SELECT MAX(price) FROM products p2 where p2.category = 'commodity');
--SELECT p1.product_id, p1.category, p1.price FROM products p1 INNER JOIN (SELECT category, MAX(price) as max_cat_price FROM products GROUP BY category)p2 ON p1.category = p2.category AND p1.price = p2.max_cat_price; 


--EXITS Operator
--Objective: Return all products that have been orderd as given in the order_details table. In other words, return products where the product id exits in the order_details table.

 --SELECT p.product_id, p.category, p.price FROM products p WHERE EXITS(SELECT * FROM  order_details o WHERE o.product_id = p.product_id)

--Window Function

--Type of Function
 --Single row function (and operations): Operate on a single row at a time and returns one output per row.
 --Aggregate functions : Operator on multiple rows at a time and returns a single value per group of rows.
 --Window Function: Operate on multiple rows at a time but returns one output per row.

-- Objective :
  --Return all products which have the highest price fotr their product category.

  --SELECT p1.product_id, p1.category, p1.price FROM products p1 INNER JOIN (SELECT category, MAX(price) as mac_cat_price FROM products GROUP BY category) p2 ON p1.category = p2.category AND p1.price = p2.max_cat_price.

  --SELECT products_id, category, price, RANK() OVER(PARTTION BY category ORDER BY price DESC) AS Rank FROM products 

/*
Common Table Expressions (CTEs)
Common tablr expressions similar to derived tables. which is calls simply the tablur result from a subquery that is given the name common and this is also like as subquery  that are only visible to the statement is which the are define.

Syntax: WITH <CTE_name>
			AS(
			<inner query>
			)
		<Outer Query>;

Example: 
Derived Table:: 
	SELECT s.product_id, s.category, s.price
	FROM(SELECT 
			product_id, category, price,
			RANK()OVER (PARTITION BY category ORDER BY price DESC) AS rank From products
		) s
	WHERE s.rank = 1

Common Table Expression::
	WITH s
	AS(
		SELECT 
			product_id, category, price,
			RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank FROM products
	)
	SELECT s.product_id, s.category, s.price FROM s WHERE s.rank = 1

Example-2:

WITH 
	not_recently_contacted AS
		(
			SELECT contact_name, last_contacted, account_id FROM dbo.account_contacts WHERE last_contacted<'20200101'
		),
	old_order AS
		(
			SELECT order_id, account_id, order_date FROM dbo.orders WHERE order_date <'20200101'
		)
	SELECT  nrc_contact_name, nrc.last_contacted, nrc.account_id FROM not_recently_contacted nrc WHERE EXISTS (SELECT * FROM old_orders oo WHERE nrc.account_id == oo.account_id)

	*/

/*
Avoiding the NOT IN trap

SELECT * FROM depatrment_id NOT IN (SELECT department_id FROM employees WHERE department_id IS NOT NULL);

SELECT * FROM departments d WHERE NOT EXITS (SELECT * FROM employees e WHERE e.department_id = d.department_id);

Using Left outer join
SELECT d.* FROM department d LEFT JOIN employees e ON d.department_id =  e.department_id WHERE e.department_id IS NULL;
SELECT d.department_name, e.department_d FROM departs d LEFT JOIN employees e ON d.department_id = e.department_id; WHERE e.department_id IS NULL;

*/
/*
Challenge-1:
Return the following product details for the cheapest product(s) in the oes.products table:
-product_id
-product_name
-list_price
-category_id
*/
SELECT * FROM oes.products;
SELECT p.product_id, p.product_name, p.list_price, p.category_id FROM oes.products p WHERE p.list_price = (SELECT MIN(mp.list_price) FROM oes.products mp)