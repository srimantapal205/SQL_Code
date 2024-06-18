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