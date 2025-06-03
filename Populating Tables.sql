--Populating Tables
select * from dim_categories
INSERT INTO dim_customers (customer_id, customer_fname, customer_iname,  customer_street, customer_city, customer_state, customer_zipcode)
SELECT
    customer_id,
    customer_fname,
    customer_lname,
    customer_email,
    customer_city,
    customer_state,
	customer_zipcode
FROM customers;



INSERT INTO dim_products (product_id, product_name, product_category_id, product_description, product_price)
SELECT
    product_id,
    product_name,
    product_category_id,
    product_description,
    product_price
FROM products;


INSERT INTO dim_departments (department_id, department_name)
SELECT DISTINCT department_id, department_name
FROM departments;

select * from dim_categories

INSERT INTO dim_categories (category_id, category_name, category_department_id)
SELECT DISTINCT category_id, category_name, category_department_id
FROM categories;

--Inserting int dim_departments table after an error indicated dim_categories could not match with 8
INSERT INTO dim_departments (department_id, department_name)
VALUES (8, 'Indoors');

INSERT INTO dim_categories (category_id, category_name, category_department_id)
VALUES (59, 'Shoes', 8);

select * from orders

select * from orders
join orders.order_id on order_items.order_items_id

select * from products

SELECT MIN(order_date), MAX(order_date) FROM orders;

INSERT INTO fact_orders (
    order_item_id,
    order_id,
    product_id,
    customer_id,
    date_id,
    quantity,
    product_price,
    subtotal
)
SELECT
    oi.order_item_id,
    oi.order_item_order_id AS order_id,
    oi.order_item_product_id AS product_id,
    o.order_customer_id AS customer_id,
    o.order_date AS date_id,
    oi.order_item_quantity AS quantity,
    oi.order_item_product_price AS product_price,
    oi.order_item_subtotal AS subtotal
FROM order_items AS oi
JOIN orders AS o ON oi.order_item_order_id = o.order_id;

--Changing date range to suit the dim_date table
WITH RECURSIVE date_series AS (
    SELECT DATE '2013-07-25' AS date_id
    UNION ALL
    SELECT (date_id + INTERVAL '1 day')::DATE
    FROM date_series
    WHERE date_id + INTERVAL '1 day' <= DATE '2014-07-24'
)
INSERT INTO dim_date (
    date_id, day, month, month_name, quarter, year, weekday, weekday_name
)
SELECT
    date_id,
    EXTRACT(DAY FROM date_id),
    EXTRACT(MONTH FROM date_id),
    TO_CHAR(date_id, 'Month'),
    EXTRACT(QUARTER FROM date_id),
    EXTRACT(YEAR FROM date_id),
    EXTRACT(DOW FROM date_id),
    TO_CHAR(date_id, 'Day')
FROM date_series
WHERE date_id NOT IN (SELECT date_id FROM dim_date);