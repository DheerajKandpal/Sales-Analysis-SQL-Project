/*
--------------------------------------------------------------
Title      : Sales Data Analysis Project
Author     : Dheeraj Kandpal
Date       : 2025-05-13
Database   : PostgreSQL
Table Used : sales_data
Purpose    : To analyze key business insights like revenue trends,
             customer behavior, and product performance.
--------------------------------------------------------------
*/


drop table if exists sales_data
CREATE TABLE sales_data (
    Date TEXT,  -- we'll use TEXT here due to the DD/MM/YY format; can convert to DATE later
    Day INTEGER,
    Month TEXT,
    Year INTEGER,
    Customer_Age INTEGER,
    Age_Group TEXT,
    Customer_Gender TEXT,
    Country TEXT,
    State TEXT,
    Product_Category TEXT,
    Sub_Category TEXT,
    Product TEXT,
    Order_Quantity INTEGER,
    Unit_Cost NUMERIC,
    Unit_Price NUMERIC,
    Profit NUMERIC,
    Cost NUMERIC,
    Revenue NUMERIC
);



COPY sales_data(
    Date, Day, Month, Year, Customer_Age, Age_Group, Customer_Gender,
    Country, State, Product_Category, Sub_Category, Product,
    Order_Quantity, Unit_Cost, Unit_Price, Profit, Cost, Revenue
)
FROM '/Users/dheerajkandpal/Downloads/sales_data (1).csv'
DELIMITER ',' 
CSV HEADER;



-- 📊 SALES & BUSINESS ANALYSIS SQL QUERIES
-- Dataset: sales_data (assumed table name)
-- PostgreSQL-compatible syntax

--Explore total units sold and profit for each product
-- This helps us understand the overall performance
SELECT 
    product, 
    SUM(order_quantity) AS total_units_sold,
    SUM(profit) AS total_profit,
    SUM(cost) AS total_cost,
    ROUND(SUM(profit) / NULLIF(SUM(cost), 0), 2) AS profit_margin
FROM sales_data
GROUP BY product
ORDER BY total_units_sold ASC;


/*
------------------------------------------------------------
Question: Top 5 Products by Revenue
Purpose   : Identify the highest earning products.
Insight   : Useful for stock planning and marketing.
------------------------------------------------------------
*/
SELECT 
    product, 
    SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 5;


-- 1. Total Revenue, Profit, and Cost
SELECT 
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit,
    SUM(cost) AS total_cost
FROM sales_data;

-- 2. Monthly and Yearly Revenue/Profit Trend
SELECT 
    year, 
    month, 
    SUM(revenue) AS monthly_revenue,
    SUM(profit) AS monthly_profit
FROM sales_data
GROUP BY year, month
ORDER BY year, month;

-- 3. Average Order Quantity per Product
SELECT 
    product, 
    AVG(order_quantity) AS avg_order_quantity
FROM sales_data
GROUP BY product
ORDER BY avg_order_quantity DESC;

-- 4. Revenue Contribution by Product Category
SELECT 
    product_category, 
    SUM(revenue) AS category_revenue,
    ROUND(100.0 * SUM(revenue) / (SELECT SUM(revenue) FROM sales_data), 2) AS revenue_percentage
FROM sales_data
GROUP BY product_category
ORDER BY category_revenue DESC;

-- 5. Monthly Sales Trend
SELECT 
    CAST(date AS DATE) AS sale_date,
    EXTRACT(MONTH FROM CAST(date AS DATE)) AS month,
    EXTRACT(YEAR FROM CAST(date AS DATE)) AS year,
    SUM(revenue) AS daily_revenue
FROM sales_data
GROUP BY CAST(date AS DATE)
ORDER BY CAST(date AS DATE);




-- 6. Revenue by Age Group
SELECT 
    age_group, 
    SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY age_group
ORDER BY total_revenue DESC;

-- 7. Gender-based Buying Behavior
SELECT 
    customer_gender, 
    COUNT(*) AS total_orders,
    SUM(revenue) AS total_revenue,
    AVG(order_quantity) AS avg_quantity
FROM sales_data
GROUP BY customer_gender;

-- 8. Order Quantity by Age Group
SELECT 
    age_group, 
    AVG(order_quantity) AS avg_order_quantity
FROM sales_data
GROUP BY age_group
ORDER BY avg_order_quantity DESC;

-- 9. Product Preferences by Younger Customers (<25)
SELECT 
    product_category, 
    COUNT(*) AS total_orders
FROM sales_data
WHERE age_group = 'Youth (<25)'
GROUP BY product_category
ORDER BY total_orders DESC;

-- 10. Customer Demographics by Region
SELECT 
    country, 
    state, 
    customer_gender, 
    COUNT(*) AS order_count
FROM sales_data
GROUP BY country, state, customer_gender
ORDER BY order_count DESC;

-- 11. Most Sold Products (by Quantity)
SELECT 
    product, 
    SUM(order_quantity) AS total_quantity
FROM sales_data
GROUP BY product
ORDER BY total_quantity DESC
LIMIT 10;

-- 12. Profit Margin by Product/Subcategory
SELECT 
    product, 
    ROUND(SUM(profit) / NULLIF(SUM(cost), 0), 2) AS profit_margin_ratio
FROM sales_data
GROUP BY product
ORDER BY profit_margin_ratio DESC;

-- 13. Top Selling Products
SELECT 
    product, 
    COUNT(*) AS order_count, 
    SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 10;

-- 14. Product Performance by Region
SELECT 
    country, 
    state, 
    product_category, 
    SUM(revenue) AS revenue_generated
FROM sales_data
GROUP BY country, state, product_category
ORDER BY revenue_generated DESC;

-- 15. State-wise Revenue and Profit
SELECT 
    state, 
    SUM(revenue) AS total_revenue, 
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY state
ORDER BY total_revenue DESC;

-- 16. Regional Popular Products
SELECT 
    state, 
    product, 
    COUNT(*) AS order_count
FROM sales_data
GROUP BY state, product
ORDER BY state, order_count DESC;

-- 17. Profit-to-Cost Ratio by State
SELECT 
    state, 
    ROUND(SUM(profit)::numeric / NULLIF(SUM(cost), 0), 2) AS profit_to_cost_ratio
FROM sales_data
GROUP BY state
ORDER BY profit_to_cost_ratio DESC;

-- 18. Seasonal Sales Trend
SELECT 
    month, 
    SUM(revenue) AS monthly_revenue
FROM sales_data
GROUP BY month
ORDER BY monthly_revenue DESC;

-- 19. Inventory Planning - High Volume Months
SELECT 
    month, 
    SUM(order_quantity) AS total_order_volume
FROM sales_data
GROUP BY month
ORDER BY total_order_volume DESC;

-- 20. Low Sales but High Profit Margin Products
SELECT 
    product, 
    SUM(order_quantity) AS total_units_sold,
    ROUND(SUM(profit) / NULLIF(SUM(cost), 0), 2) AS profit_margin
FROM sales_data
GROUP BY product
HAVING SUM(order_quantity) < 10 AND SUM(profit) > 0
ORDER BY profit_margin DESC;

-- 21. KPI Calculations
-- a. Gross Profit Margin
SELECT 
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(revenue), 0), 2) AS gross_profit_margin
FROM sales_data;

-- b. Cost per Unit Sold
SELECT 
    ROUND(SUM(cost)::numeric / NULLIF(SUM(order_quantity), 0), 2) AS cost_per_unit
FROM sales_data;

-- c. Average Order Value
SELECT 
    ROUND(SUM(revenue)::numeric / COUNT(*), 2) AS average_order_value
FROM sales_data;


-- Products which made a profit 
SELECT 
    product,
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY product
ORDER BY total_profit DESC;



/*
------------------------------------------------------------
Final Summary: Total Revenue, Profit, and Orders by Year
------------------------------------------------------------
*/
SELECT 
    EXTRACT(YEAR FROM date::DATE) AS year,
    COUNT(*) AS total_orders,
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY EXTRACT(YEAR FROM date::DATE)
ORDER BY year;



/*
----------------------
End of Analysis Script
Author: Dheeraj Kandpal
----------------------
*/










