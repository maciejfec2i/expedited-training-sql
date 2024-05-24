# *** PROBLEM STATEMENT ***
# The sales team has requested data on current payments per customer.
# Modify the below query to additionally display the following:
# Customer number, Customer Name and total payments made.

USE classicmodels;

SELECT
	ROUND(AVG(p.amount), 2) AS average,
    MAX(p.amount) AS maximum,
    MIN(p.amount) AS minimum,
    SUM(p.amount) AS total
FROM payments p;