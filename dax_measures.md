# Power BI DAX Measures & Architecture Reference

This document outlines the calculated DAX measures used across the interactive Power BI dashboard pages.

---

### Core KPI Measures

#### 1. Total Revenue
```dax
Total Revenue = SUM(pizza_sales[total_price])
```

#### 2. Total Orders
```dax
Total Orders = DISTINCTCOUNT(pizza_sales[order_id])
```

#### 3. Total Pizzas Sold
```dax
Total Pizzas Sold = SUM(pizza_sales[quantity])
```

#### 4. Average Order Value (AOV)
```dax
Average Order Value = [Total Revenue] / [Total Orders]
```

#### 5. Average Pizzas Per Order
```dax
Avg Pizzas Per Order = [Total Pizzas Sold] / [Total Orders]
```

---

### Time Intelligence & Dynamic Trend Measures

#### 6. Order Day Name
```dax
Order Day = FORMAT(pizza_sales[order_date], "dddd")
```

#### 7. Order Day Number (For sorting Day of Week)
```dax
Day Number = WEEKDAY(pizza_sales[order_date], 2)
```

#### 8. Order Month Name
```dax
Order Month = FORMAT(pizza_sales[order_date], "mmmm")
```

#### 9. Order Month Number (For sorting Chronological Months)
```dax
Month Number = MONTH(pizza_sales[order_date])
```

---

### Ratio & Percentage Analysis

#### 10. Percentage of Category Revenue
```dax
Pct Category Revenue = 
DIVIDE(
    [Total Revenue],
    CALCULATE([Total Revenue], ALL(pizza_sales[pizza_category])),
    0
)
```

#### 11. Percentage of Size Revenue
```dax
Pct Size Revenue = 
DIVIDE(
    [Total Revenue],
    CALCULATE([Total Revenue], ALL(pizza_sales[pizza_size])),
    0
)
```

---

### Dashboard Visual Mapping

- **KPI Ribbon**: Card visuals for `Total Revenue`, `Average Order Value`, `Total Pizzas Sold`, `Total Orders`, and `Avg Pizzas Per Order`.
- **Daily Trend Bar Chart**: X-axis = `Order Day`, Y-axis = `Total Orders` (Sorted by `Day Number`).
- **Monthly Trend Area Chart**: X-axis = `Order Month`, Y-axis = `Total Orders` (Sorted by `Month Number`).
- **Category Contribution Donut Chart**: Legend = `pizza_category`, Values = `Total Revenue` (Formatted as %).
- **Size Distribution Funnel / Column Chart**: Legend = `pizza_size`, Values = `Total Revenue`.
- **Top 5 & Bottom 5 Bar Charts**: Visual level filters with `Top N` by `Total Revenue` and `Total Pizzas Sold`.
- **Dynamic Slicers**: Date Range Slicer, Category Slicer (Classic, Supreme, Chicken, Veggie).
