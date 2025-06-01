SELECT * FROM customers

CREATE TABLE dim_departments(
            department_id INT PRIMARY KEY,
			department_name VARCHAR(100)

);


CREATE TABLE dim_categories(
             category_id INT PRIMARY KEY,
			 category_name VARCHAR(100),
			 category_department_id INT,
			 FOREIGN KEY (category_department_id) REFERENCES dim_departments(department_id)
);



CREATE TABLE dim_products(
             product_id INT PRIMARY KEY,
			 product_name VARCHAR(100),
			 product_description TEXT,
			 product_price FLOAT,
			 product_category_id INT,
			 FOREIGN KEY (product_category_id) REFERENCES dim_categories(category_id)


);


CREATE TABLE dim_customers(
             customer_id INT PRIMARY KEY,
			 customer_fname VARCHAR(50),
			 customer_Iname VARCHAR(50),
			 customer_street VARCHAR(255),
			 customer_city VARCHAR(100),
			 customer_state VARCHAR(100),
			 customer_zipcode VARCHAR(100)
			 
);



CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    day INT,
    month INT,
    month_name VARCHAR(20),
    quarter INT,
    year INT,
    weekday INT,
    weekday_name VARCHAR(20)
);


WITH RECURSIVE date_series AS (
    SELECT CAST('2021-01-01' AS DATE) AS date_id
    UNION ALL
    SELECT (date_id + INTERVAL '1 day')::DATE
    FROM date_series
    WHERE date_id + INTERVAL '1 day' <= DATE '2023-12-31'
)
INSERT INTO dim_date (date_id, day, month, month_name, quarter, year, weekday, weekday_name)
SELECT 
    date_id,
    EXTRACT(DAY FROM date_id)::INT,
    EXTRACT(MONTH FROM date_id)::INT,
    TO_CHAR(date_id, 'Month') AS month_name,
    EXTRACT(QUARTER FROM date_id)::INT,
    EXTRACT(YEAR FROM date_id)::INT,
    EXTRACT(DOW FROM date_id)::INT,
    TO_CHAR(date_id, 'Day') AS weekday_name
FROM date_series;



CREATE TABLE fact_orders (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    customer_id INT,
    date_id DATE,
    quantity INT,
    product_price FLOAT,
    subtotal FLOAT,
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

DROP TABLE IF EXISTS fact_orders;