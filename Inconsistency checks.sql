--Checking for ROW COUNT
SELECT 'departments' AS table_name, COUNT(*) AS row_count FROM departments
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;

--Checkinng for NULL values in columns and across tables

--Department Table

SELECT
  SUM(CASE WHEN department_id IS NULL THEN 1 ELSE 0 END) AS missing_department_id,
  SUM(CASE WHEN department_name IS NULL THEN 1 ELSE 0 END) AS missing_department_name
FROM departments;

--Categories Table

SELECT
  SUM(CASE WHEN category_id IS NULL THEN 1 ELSE 0 END) AS missing_category_id,
  SUM(CASE WHEN category_department_id IS NULL THEN 1 ELSE 0 END) AS missing_category_department_id,
  SUM(CASE WHEN category_name IS NULL THEN 1 ELSE 0 END) AS missing_category_name
FROM categories;

--Products Table

SELECT
  SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
  SUM(CASE WHEN product_category_id IS NULL THEN 1 ELSE 0 END) AS missing_product_category_id,
  SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS missing_product_name,
  SUM(CASE WHEN product_description IS NULL THEN 1 ELSE 0 END) AS missing_product_description,
  SUM(CASE WHEN product_price IS NULL THEN 1 ELSE 0 END) AS missing_product_price,
  SUM(CASE WHEN product_image IS NULL THEN 1 ELSE 0 END) AS missing_product_image
FROM products;

--Orders Table
SELECT
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
  SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
  SUM(CASE WHEN order_customer_id IS NULL THEN 1 ELSE 0 END) AS missing_order_customer_id,
  SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS missing_order_status
FROM orders;


--Order_Items Table
SELECT
  SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS missing_order_item_id,
  SUM(CASE WHEN order_item_order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
  SUM(CASE WHEN order_item_product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
  SUM(CASE WHEN order_item_quantity IS NULL THEN 1 ELSE 0 END) AS missing_quantity,
  SUM(CASE WHEN order_item_subtotal IS NULL THEN 1 ELSE 0 END) AS missing_subtotal,
  SUM(CASE WHEN order_item_product_price IS NULL THEN 1 ELSE 0 END) AS missing_product_price
FROM order_items;



--Checking Unique Distinct Values
SELECT DISTINCT order_status FROM orders;
SELECT DISTINCT category_name FROM categories;
SELECT DISTINCT customer_state FROM customers;



--Duplicate Checks

SELECT department_id, COUNT(*) AS count
FROM departments
GROUP BY department_id
HAVING COUNT(*) > 1;

SELECT category_id, COUNT(*) AS count
FROM categories
GROUP BY category_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


SELECT product_name, COUNT(*) AS count
FROM products
GROUP BY product_name
HAVING COUNT(*) > 1;


SELECT customer_id, COUNT(*) AS count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;



SELECT order_id, COUNT(*) AS count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


SELECT order_item_id, COUNT(*) AS count
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;
