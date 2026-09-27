-- ==============================================================================
-- PIZZA SALES DATA ANALYSIS & BUSINESS INTELLIGENCE PROJECT
-- Author: Tharun Kumar Reddy Challa
-- Stack: SQL (PostgreSQL / MySQL / MS SQL Server / SQLite) & Power BI
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. TABLE CREATION & SCHEMA DESIGN
-- ------------------------------------------------------------------------------
DROP TABLE IF EXISTS pizza_sales;

CREATE TABLE pizza_sales (
    pizza_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_name_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    pizza_size VARCHAR(10) NOT NULL,
    pizza_category VARCHAR(50) NOT NULL,
    pizza_ingredients TEXT NOT NULL,
    pizza_name VARCHAR(100) NOT NULL
);

-- Indexing for performance optimization on frequent filter & join keys
CREATE INDEX idx_order_date ON pizza_sales(order_date);
CREATE INDEX idx_pizza_category ON pizza_sales(pizza_category);
CREATE INDEX idx_pizza_size ON pizza_sales(pizza_size);

-- ------------------------------------------------------------------------------
-- 2. KEY PERFORMANCE INDICATOR (KPI) METRICS
-- ------------------------------------------------------------------------------

-- KPI 1: Total Revenue Generated
SELECT 
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales;

-- KPI 2: Average Order Value (AOV)
SELECT 
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS Avg_Order_Value
FROM pizza_sales;

-- KPI 3: Total Pizzas Sold
SELECT 
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

-- KPI 4: Total Distinct Orders Placed
SELECT 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- KPI 5: Average Pizzas Per Order
SELECT 
    ROUND(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)), 2) AS Avg_Pizzas_Per_Order
FROM pizza_sales;

-- ------------------------------------------------------------------------------
-- 3. TEMPORAL & TREND ANALYSIS
-- ------------------------------------------------------------------------------

-- Trend 1: Daily Trend for Total Orders (Day-of-Week distribution)
SELECT 
    TO_CHAR(order_date, 'Day') AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day'), EXTRACT(DOW FROM order_date)
ORDER BY EXTRACT(DOW FROM order_date);

-- Trend 2: Monthly Trend for Total Orders (Seasonality breakdown)
SELECT 
    TO_CHAR(order_date, 'Month') AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Month'), EXTRACT(MONTH FROM order_date)
ORDER BY EXTRACT(MONTH FROM order_date);

-- Trend 3: Hourly Order Volume (Peak kitchen hours)
SELECT 
    EXTRACT(HOUR FROM order_time) AS Order_Hour,
    COUNT(DISTINCT order_id) AS Total_Orders,
    SUM(quantity) AS Pizzas_Sold
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY Order_Hour;

-- ------------------------------------------------------------------------------
-- 4. SALES BREAKDOWN BY CATEGORY & SIZE
-- ------------------------------------------------------------------------------

-- Breakdown 1: Percentage of Sales by Pizza Category
SELECT 
    pizza_category,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS Pct_Total_Revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Sales DESC;

-- Breakdown 2: Percentage of Sales by Pizza Size
SELECT 
    pizza_size,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS Pct_Total_Revenue
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Total_Sales DESC;

-- Breakdown 3: Quantity Sold by Pizza Category
SELECT 
    pizza_category,
    SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- ------------------------------------------------------------------------------
-- 5. TOP & BOTTOM PERFORMERS (PRODUCT-LEVEL INSIGHTS)
-- ------------------------------------------------------------------------------

-- Top 5 Pizzas by Revenue
SELECT 
    pizza_name,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Bottom 5 Pizzas by Revenue (Underperformers)
SELECT 
    pizza_name,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

-- Top 5 Pizzas by Total Quantity Sold
SELECT 
    pizza_name,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC
LIMIT 5;

-- Bottom 5 Pizzas by Total Quantity Sold
SELECT 
    pizza_name,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC
LIMIT 5;

-- Top 5 Pizzas by Distinct Order Placements
SELECT 
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;
