
# 🛒 Retail Sales Data Engineering Project

## 📌 Overview

This project demonstrates the development of a **Data Warehouse** for a retail business using PostgreSQL. It showcases key **data engineering concepts**, including:

- Data cleaning and quality checks  
- Dimensional modeling (Star Schema)  
- ETL pipeline development  
- Data loading into fact and dimension tables  

The data includes **orders**, **customers**, **products**, **departments**, and **dates**, and is structured for use in downstream analytics tools like Power BI or Tableau.

---

## 🧱 Project Structure

```
retail-data-warehouse/
│
├── schema_design/
│   ├── create_tables.sql
│
├── data_preparation/
│   ├── dim_population.sql
│   └── fact_population.sql
│
└── README.md
```

---

## 🧠 Objectives

- Apply data engineering techniques to structure raw retail data
- Design and implement a **star schema** in PostgreSQL
- Populate **dimension** and **fact** tables from source data
- Prepare the dataset for use in BI tools

---

## 🗂️ Schema Design

We implemented a **Star Schema** with the following tables:

### 🟩 Dimension Tables:
| Table            | Description                        |
|------------------|------------------------------------|
| `dim_customers`  | Customer details (excluding PII)   |
| `dim_products`   | Product, category, and department  |
| `dim_categories` | Product categories and departments |
| `dim_departments`| Product departments                |
| `dim_date`       | Calendar breakdown by day/month    |

### 🔶 Fact Table:
| Table         | Description                              |
|---------------|------------------------------------------|
| `fact_orders` | Records each product-level sale          |
|               | Contains foreign keys to all dim tables  |

---

## 🧹 Data Cleaning & Checks

- Checked for NULLs in key columns (e.g., `customer_email`)
- Checked for duplicate records across tables
- Ensured referential integrity before loading into fact tables

---

## 🛠️ Data Loading Strategy

### 1. **Populate Dimension Tables**
- `dim_departments` and `dim_categories`: based on existing product metadata
- `dim_products`: joined to categories and departments
- `dim_customers`: stripped of sensitive information (no passwords)
- `dim_date`: generated using a recursive CTE for full date range (`2013-07-25` to `2014-07-24`)

### 2. **Populate Fact Table**
- `fact_orders` was built by joining `order_items`, `orders`, and dimension tables
- Ensured all foreign keys matched dimension tables

---

## 📊 BI Integration

The star schema was designed to be compatible with BI tools such as:

- **Power BI**
- **Tableau**
- **Metabase**



---

## ✅ Technologies Used

- **PostgreSQL** (SQL, constraints, recursive queries)
- **SQL joins, foreign keys, constraints**
   **pgAdmin**

---

## 📌 Key Learnings

- How to design and implement a **star schema**
- Importance of foreign key relationships
- Recursive SQL to generate a date dimension
- Data cleaning best practices

---

## 📁 Sample Query

```sql
-- Total revenue by category
SELECT 
    c.category_name,
    SUM(f.subtotal) AS total_revenue
FROM fact_orders f
JOIN dim_products p ON f.product_id = p.product_id
JOIN dim_categories c ON p.product_category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;
