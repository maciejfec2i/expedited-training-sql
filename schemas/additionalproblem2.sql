# Top 5 purchased products between 2 dates

USE classicmodels;

SELECT
	p.productCode,
    p.productName,
    SUM(od.quantityOrdered) AS totalSold
FROM orders o
INNER JOIN orderdetails od USING(orderNumber)
INNER JOIN products p USING(productCode)
WHERE o.orderDate BETWEEN "2003-01-06" AND "2003-01-13"
GROUP BY productCode
ORDER BY totalSold DESC
LIMIT 5;

# Worst selling product of all time for specific product line
SELECT
	p.productCode,
    p.productName,
    p.productLine,
    SUM(od.quantityOrdered) AS totalSold
FROM orders o
INNER JOIN orderdetails od USING(orderNumber)
INNER JOIN products p USING(productCode)
WHERE p.productLine = "Vintage Cars"
GROUP BY productCode
ORDER BY totalSold ASC
LIMIT 1;
