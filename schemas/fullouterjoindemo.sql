# *** PROBLEM STATEMENT ***
# You are tasked with retrieving information about employees and the customers they are assigned to.
# You know that not all of the employees are assigned to a customer, and not each customer has an employee assigned to them.
# Write an SQL query to retrieve the following: 
# Employee number, employe full name, employe job title, customer number, customer name, customer contact full name, customer phone number

USE classicmodels;

SELECT
	e.employeeNumber,
    CONCAT_WS(' ', e.firstName, e.lastName) AS employeeName,
    e.jobTitle,
    c.customerNumber,
    c.customerName,
    CONCAT_WS(' ', c.contactFirstName, c.contactLastName) AS customerContactName,
    c.phone AS customerPhoneNumber
FROM employees e
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber;
