# 🍕 Pizza Sales Analysis & Business Intelligence Dashboard

![SQL](https://img.shields.io/badge/SQL-PostgreSQL%20%7C%20MySQL%20%7C%20Server-orange?style=for-the-badge&logo=postgresql)
![Power BI](https://img.shields.io/badge/Power_BI-Interactive_Dashboard-yellow?style=for-the-badge&logo=powerbi)
![Data Analytics](https://img.shields.io/badge/Analytics-EDA%20%26%20KPIs-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

An end-to-end data analytics and business intelligence project evaluating annual sales performance, customer ordering behavior, product profitability, and peak demand cycles. Built using **SQL** for relational data querying, aggregation, and performance benchmarking, combined with an interactive **Power BI** dashboard for executive decision-making.

---

## 📌 Executive Summary & Business Objectives

The objective of this project is to analyze restaurant transactional records to uncover operational insights, eliminate inventory waste, and identify revenue-driving menu items.

### Key Business Questions Addressed:
1. What is our overall revenue, average order value, total orders, and average volume per order?
2. Which days of the week and hours of the day generate the highest order volume?
3. How do sales and revenue break down by pizza category and size?
4. What are the Top 5 best-selling pizzas by revenue, quantity sold, and distinct orders?
5. Which Bottom 5 underperforming items represent profit leakage or menu deadweight?

---

## 🛠️ Tech Stack & Skills Demonstrated

- **SQL (PostgreSQL / MySQL / SQLite)**:
  - Database Schema Design, Primary/Foreign Keys, Check Constraints & Indexing.
  - Aggregations (`SUM`, `AVG`, `COUNT(DISTINCT)`), Mathematical calculations.
  - Date & Time Intelligence (`EXTRACT`, `TO_CHAR`, `DATEPART`, `DATENAME`).
  - Subqueries, Window Functions, and `GROUP BY` / `ORDER BY` operations.
- **Power BI Desktop**:
  - Star Schema Modeling & Relationship Configuration.
  - Custom Calculated DAX Measures & Time-Intelligence Functions.
  - Multi-page interactive executive dashboards, dynamic slicers, and drill-through visual filters.

---

## 📊 High-Level KPI Summary (Validated via SQL & Power BI)

| Key Metric | Value | Description |
| :--- | :--- | :--- |
| **Total Revenue** | **$817,860.05** | Cumulative revenue generated across all processed orders |
| **Average Order Value (AOV)** | **$38.31** | Average revenue generated per distinct customer checkout |
| **Total Pizzas Sold** | **49,574** | Aggregate count of individual pizzas prepared and served |
| **Total Orders** | **21,350** | Total distinct customer transactions recorded |
| **Average Pizzas Per Order** | **2.32** | Mean quantity of pizzas included in a single order |

---

## 🔍 Core SQL Analysis & Query Highlights

### 1. Daily Trend for Total Orders
```sql
SELECT 
    TO_CHAR(order_date, 'Day') AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day'), EXTRACT(DOW FROM order_date)
ORDER BY EXTRACT(DOW FROM order_date);
```
> **Insight**: Friday and Saturday evenings exhibit the highest order volume (over 3,500 orders each), suggesting targeted staffing and prep schedules should peak on weekends.

### 2. Percentage of Revenue by Pizza Category
```sql
SELECT 
    pizza_category,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS Pct_Total_Revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Sales DESC;
```
> **Insight**: **Classic** category contributes the highest revenue share (~26.91%), closely followed by **Supreme** (~25.46%) and **Chicken** (~23.96%).

### 3. Top 5 Best-Selling Pizzas by Revenue
```sql
SELECT 
    pizza_name,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;
```
> **Top Revenue Generators**:
> 1. The Thai Chicken Pizza
> 2. The Barbecue Chicken Pizza
> 3. The California Chicken Pizza
> 4. The Classic Deluxe Pizza
> 5. The Spicy Italian Pizza

---

## 📈 Power BI Dashboard Architecture

The Power BI solution is structured into two main operational views:

### Page 1: Home & Executive Overview
- **Header Ribbon**: Real-time KPI indicator cards displaying Revenue, AOV, Total Pizzas, and Total Orders.
- **Bar Chart**: Total Orders by Day of the Week.
- **Area Chart**: Monthly Trend tracking seasonal spikes (peak in July & January).
- **Donut Chart**: Revenue percentage contribution per Category.
- **Funnel Visual**: Sales distribution across Pizza Sizes (Large size drives >45% of total revenue).

### Page 2: Product Performance & Menu Optimization
- **Top 5 Performers**: Dynamic bar chart showing leaders by Revenue, Quantity, and Order Volume.
- **Bottom 5 Underperformers**: Identifying lagging items (e.g., *The Brie Carre Pizza*) to support menu re-engineering or marketing bundle campaigns.
- **Interactive Slicers**: Filterable by Date Range, Quarter, and Product Category.

---

## 💡 Strategic Recommendations

1. **Menu Optimization**: Promote top revenue drivers (*Thai Chicken* and *BBQ Chicken*) through combo deals to boost AOV beyond $40.
2. **Size Rationalization**: Since Large (L) size generates the vast majority of margins, introduce incentives for upgrading Medium orders to Large.
3. **Inventory & Staffing Scheduling**: Align kitchen labor allocation to handle concentrated peak surges on Friday/Saturday between 12:00 PM – 1:30 PM and 5:30 PM – 8:00 PM.

---

## 📁 Repository Structure

```
├── README.md                           <- Executive overview and findings
├── pizza_sales_analysis.sql            <- Full SQL script (Schema + Analytical Queries)
├── dax_measures.md                     <- Reference documentation of all Power BI DAX expressions
└── data/
    └── pizza_sales_sample.csv          <- Sample transactional records for reproduction
```

---

## 👨‍💻 Author

**Tharun Kumar Reddy Challa**  
- **LinkedIn**: [tharun-kumar-reddy-challa](https://www.linkedin.com/in/tharun-kumar-reddy-challa)  
- **GitHub**: [TharunKumar1111](https://github.com/TharunKumar1111)  
- **Email**: [tharunkumarreddychalla@gmail.com](mailto:tharunkumarreddychalla@gmail.com)
