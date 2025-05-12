
SELECT * 
FROM -- table
(

SELECT 
		ci.city_name,
		p.product_name,
		COUNT(s.sale_id) as total_orders,
		DENSE_RANK() OVER(PARTITION BY ci.city_name ORDER BY COUNT(s.sale_id) DESC) as rank
	FROM sales as s
	JOIN products as p
	ON s.product_id = p.product_id
	JOIN customers as c
	ON c.customer_id = s.customer_id
	JOIN city as ci
	ON ci.city_id = c.city_id
	GROUP BY 1, 2
	-- ORDER BY 1, 3 DESC
) as t1
WHERE rank <= 3

-- Q.7
-- Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?
SELECT 
ci.city_name, 
COUNT(DISTINCT c.customer_id) as unique_cx
FROM city as ci
JOIN customers as c
ON c.city_id = ci.city_id
Join sales as s
ON s.customer_id = c.customer_id
WHERE s. product_id IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14)
GROUP BY 1;

-- -- Q.8
-- Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer
WITH city_table AS (
    SELECT 
        ci.city_name,
        SUM(s.total) AS total_revenue,
        COUNT(DISTINCT s.customer_id) AS total_cx,
        ROUND(SUM(s.total)::numeric / COUNT(DISTINCT s.customer_id)::numeric, 2) AS avg_sale_pr_cx
    FROM sales AS s
    JOIN customers AS c ON s.customer_id = c.customer_id
    JOIN city AS ci ON c.city_id = ci.city_id
    GROUP BY ci.city_name
),
city_rent AS (
    SELECT 
        city_name,
        estimated_rent 
    FROM city
)
SELECT 
    cr.city_name,
    cr.estimated_rent,
    ct.total_cx,
    ct.avg_sale_pr_cx,
    ROUND(cr.estimated_rent::numeric / ct.total_cx::numeric, 2) AS avg_rent_per_cx
FROM city_rent AS cr
JOIN city_table AS ct ON cr.city_name = ct.city_name
ORDER BY avg_sale_pr_cx DESC;

- Q.9
-- Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly)
-- by each city
WITH 
monthly_sales
AS
(
SELECT  
	ci.city_name,
	EXTRACT(month from sale_date) as month,
	EXTRACT(year from sale_date) as year,
	SUM(s.total) as total_sale
	From sales as s 
JOIN customers as c
ON c.customer_id = s.customer_id
JOIN city as ci
ON ci.city_id = c.city_id
GROUP BY 1,2,3
ORDER BY 1,3,2 
), 
growth_ratio
AS(
SELECT 
	city_name,
	month,
	year,
	total_sale as cr_month_sale,
	LAG(total_sale, 1) OVER(PARTITION BY city_name ORDER BY year, month) AS prev_month_sale
FROM monthly_sales
)
SELECT 
	city_name,
	month,
	year,
	cr_month_sale,
	prev_month_sale,
	ROUND(
			(cr_month_sale-prev_month_sale)::numeric/prev_month_sale::numeric*100,2) as growth_ration
FROM growth_ratio
WHERE 
	prev_month_sale IS NOT NULL	;
	
-- Q.10
-- Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer

WITH city_table AS (
    SELECT 
        ci.city_name,
        SUM(s.total) AS total_revenue,
        COUNT(DISTINCT s.customer_id) AS total_cx,
        ROUND(SUM(s.total)::numeric / COUNT(DISTINCT s.customer_id)::numeric, 2) AS avg_sale_pr_cx
    FROM sales AS s
    JOIN customers AS c ON s.customer_id = c.customer_id
    JOIN city AS ci ON c.city_id = ci.city_id
    GROUP BY ci.city_name
),
city_rent AS (
    SELECT 
        city_name,
        estimated_rent,
		ROUND(
		(population * 0.25)/1000000,3) AS estimated_coffee_consumer_in_millions
    FROM city
)
SELECT 
    cr.city_name,
	total_revenue,
    cr.estimated_rent as total_rent,
    ct.total_cx,
	estimated_coffee_consumer_in_millions,
    ct.avg_sale_pr_cx,
    ROUND(cr.estimated_rent::numeric / ct.total_cx::numeric, 2) AS avg_rent_per_cx
FROM city_rent AS cr
JOIN city_table AS ct ON cr.city_name = ct.city_name
ORDER BY 2 DESC;

---- Recomendation
City 1: Pune
	1.Average rent per customer is very low.
	2.Highest total revenue.
	3.Average sales per customer is also high.

City 2: Delhi
	1.Highest estimated coffee consumers at 7.7 million.
	2.Highest total number of customers, which is 68.
	3.Average rent per customer is 330 (still under 500).

City 3: Jaipur
	1.Highest number of customers, which is 69.
	2.Average rent per customer is very low at 156.
	3.Average sales per customer is better at 11.6k.






