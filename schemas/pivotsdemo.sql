USE classicmodels;

SELECT
	p.productLine,
    SUM(
		CASE WHEN p.productScale = "1:10" THEN p.quantityInStock ELSE 0 END
    ) AS "Scale 1:10 Total Models"
FROM products p
GROUP BY p.productLine;
