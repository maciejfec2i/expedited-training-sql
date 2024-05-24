# *** PROBLEM STATEMENT ***
# You are tasked with retrieving information about orders which have exclusively products with a scale of 1:12
# Write an SQL query to retrieve the following:
# Count of orders, Average quanitity sold, total quantity sold, and the total monetary Sum

USE classicmodels; 

SELECT 
	COUNT(DISTINCT orderNumber) AS totalOrders,
    ROUND(AVG(quantityOrdered), 0) AS avgQuantitySold,
    SUM(quantityOrdered) AS totalQuantitySold,
    SUM(quantityOrdered * priceEach) AS totalMonetarySum,
    MAX(quantityOrdered) AS maxQuanitytSold,
    MIN(quantityOrdered) AS minQuanitytSold
FROM (
	SELECT 
		o.orderNumber, od.quantityOrdered, od.priceEach
	FROM orders o
	JOIN orderdetails od USING(orderNumber)
	JOIN products p USING(productCode)
	WHERE o.orderNumber IN (
		SELECT o.orderNumber
		FROM orders o
		JOIN orderdetails od USING(orderNumber)
		JOIN products p USING(productCode)
		GROUP BY od.orderNumber
		HAVING COUNT(DISTINCT p.productScale) = 1
		ORDER BY od.orderNumber
	)
	AND p.productScale = "1:12"
	ORDER BY o.orderNumber
) AS result;