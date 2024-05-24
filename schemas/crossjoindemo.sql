# *** PROBLEM STATEMENT ***
# You are tasked with retrieving every product line offered by the store
# and display all scales a model from each product line could have.
# Write a SQL query to display the following:
# Product Line and Scale

USE classicmodels;

# Product Lines Could Come in These Scales
SELECT
	pl.productLine,
    p.productScale
FROM productlines pl
CROSS JOIN products p
GROUP BY pl.productLine, p.productScale
ORDER BY pl.productLine, p.productScale;

# Currently Available Scales per Product Line
SELECT
	pl.productLine,
    p.productScale,
    SUM(p.quantityInStock) as qtyInStockForScale
FROM productlines pl
CROSS JOIN products p
WHERE pl.productLine = p.productLine
GROUP BY pl.productLine, p.productScale
ORDER BY pl.productLine, p.productScale;

# Pivoted Currently Available Scales per Product Line
SELECT
	pl.productLine,
    SUM(CASE WHEN p.productScale = "1:10" THEN p.quantityInStock ELSE 0 END) as "qtyInStockFor1:10",
    SUM(CASE WHEN p.productScale = "1:12" THEN p.quantityInStock ELSE 0 END) as "qtyInStockFor1:12",
    SUM(CASE WHEN p.productScale = "1:18" THEN p.quantityInStock ELSE 0 END) as "qtyInStockFor1:18",
    SUM(CASE WHEN p.productScale = "1:24" THEN p.quantityInStock ELSE 0 END) as "qtyInStockFor1:24",
    SUM(CASE WHEN p.productScale = "1:32" THEN p.quantityInStock ELSE 0 END) as "qtyInStockFor1:32",
    SUM(CASE WHEN p.productScale = "1:50" THEN p.quantityInStock ELSE 0 END) as "qtyInStockFor1:50",
    SUM(CASE WHEN p.productScale = "1:72" THEN p.quantityInStock ELSE 0 END) as "qtyInStockFor1:72",
    SUM(CASE WHEN p.productScale = "1:700" THEN p.quantityInStock ELSE 0 END) as "qtyInStockFor1:700"
FROM productlines pl
CROSS JOIN products p
WHERE pl.productLine = p.productLine
GROUP BY pl.productLine
ORDER BY pl.productLine;
