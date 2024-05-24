# Most Frequenlty bought product in a city

USE classicmodels;

WITH productsByCity AS (
	SELECT
		c.city,
		od.productCode,
		p.productName,
		SUM(od.quantityOrdered) AS quantityOrdered,
		ROW_NUMBER() OVER (PARTITION BY c.city ORDER BY SUM(od.quantityOrdered) DESC) AS itemRank
	FROM customers c
	INNER JOIN orders o USING(customerNumber)
	INNER JOIN orderdetails od USING(orderNumber)
	INNER JOIN products p USING(productCode)
	GROUP BY c.city, od.productCode
)
SELECT 
	city,
	productCode,
	productName,
	quantityOrdered
FROM productsByCity
WHERE itemRank = 1;