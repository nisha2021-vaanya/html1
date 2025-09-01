# Coffee Sales & Market Analysis Project

## 📚 Project Overview
This project analyzes coffee sales data across multiple cities, performing customer segmentation, sales growth analysis, and market potential assessment. It leverages SQL (PostgreSQL) queries for advanced analytics and insights.

The main objectives of the project include:
- Identifying the **top-selling products** by city.
- Segmenting **unique customers** who purchased coffee products.
- Calculating **average sales and rent per customer** in each city.
- Analyzing **monthly sales growth** trends.
- Performing **market potential analysis** to identify cities with high sales opportunities.

---
## 🗄 Database Structure

### Tables
1. **sales** – Records each sale with `sale_id`, `customer_id`, `product_id`, `sale_date`, and `total`.
2. **customers** – Stores customer information: `customer_id`, `city_id`, and other details.
3. **products** – Contains product details: `product_id`, `product_name`.
4. **city** – Stores city-level data: `city_id`, `city_name`, `estimated_rent`, `population`.

---

## 📝 Key SQL Queries

### 1. Top 3 Products by City
```sql`
-- Returns the top 3 most ordered products in each city

2.Customer Segmentation by City
sql-- Counts unique customers per city who purchased coffee products

## 3. Average Sale vs Rent
-- Computes average sale per customer and average rent per customer by city
4. Monthly Sales Growth
-- Calculates month-over-month sales growth percentage per city
5. Market Potential Analysis
-- Identifies top cities based on sales, customers, rent, and estimated coffee consumers
---
## Key Insights & Recommendations

Top Cities for Market Potential:
Pune
Lowest average rent per customer
Highest total revenue
High average sales per customer
Delhi

Highest estimated coffee consumers (~7.7 million)
Largest number of customers (68)
Average rent per customer is manageable (~330)
Jaipur

Highest number of customers (69)
Low average rent per customer (156)
Strong average sales per customer (~11.6k)

🔗


## Technologies Used
PostgreSQL for data storage and query analysis
SQL window functions for ranking and trend analysis

Aggregation and segmentation queries for business insights
-- Computes average sale per customer and average rent per customer by city.
