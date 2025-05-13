# 📊 Sales Analysis SQL Project

> A complete SQL case study analyzing retail sales data to derive meaningful business insights.  
> Built using PostgreSQL | Author: [Dheeraj Kandpal](https://github.com/DheerajKandpal)

---

## 🚀 Project Overview

This project involves deep-diving into a retail sales dataset to uncover insights around revenue trends, product profitability, customer behavior, and time-based performance. The goal is to simulate a real-world data analyst/business analyst task using structured SQL queries and document each insight clearly.

---

## 🧠 Objectives

- Understand overall business performance
- Track revenue, profit, and cost patterns over time
- Identify best-selling products and those with low sales but high profitability
- Analyze time-based trends (monthly/yearly revenue)
- Spot data anomalies or inconsistencies (e.g., date formatting issues)
- Practice clean, documented SQL queries

---

## 📁 Dataset Info

- 📄 File: `sales_data (1).csv`
- 🎯 Contains data on:
  - Order Dates
  - Product Names
  - Cost, Revenue, Profit
  - Order Quantity

---

## 📌 Tools Used

| Tool          | Purpose                            |
|---------------|------------------------------------|
| **PostgreSQL** | Writing and executing SQL queries |
| **pgAdmin**    | Query editor and DB manager       |
| **Excel**      | Pre-cleaning / cross-verification |

---

## 🧾 Key Insights Extracted

| # | Insight Area                     | Summary |
|--:|----------------------------------|---------|
| 1 | Monthly/Yearly Revenue Trends     | Identified best-performing months and years |
| 2 | Product Profitability             | Products with high margins vs low sales |
| 3 | Low Sales but Profitable Products | Niche opportunities for marketing |
| 4 | Revenue vs Cost Analysis          | Detected profit spikes and losses |
| 5 | Invalid/Corrupt Date Detection    | Cleaned inconsistent date values |

---

## 📜 SQL Query Highlights

Each query in this project includes:
- **Purpose Aim Questions**
- **Clean, readable SQL code**
- **Comments explaining logic**
- **Grouped logically into thematic sections**

> See full SQL script: [`sales-analyse-in-sql.sql`](sales-analyse-in-sql.sql)

---

## 📊 Sample Query Structure

```sql
-- 1. Total Revenue, Profit, and Cost
SELECT 
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit,
    SUM(cost) AS total_cost
FROM sales_data;

