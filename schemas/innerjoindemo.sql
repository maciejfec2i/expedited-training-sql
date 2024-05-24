# *** PROBLEM STATEMENT ***
# You are tasked with retrieving information about employees and the offices they are assigned to.
# You know that each employee is assigned to an office.
# Write an SQL query to retrieve the following: 
# Employee Full Name, Employee Job Title, Employee Email, and the City and Country the office is based in.

USE classicmodels;

SELECT
	CONCAT_WS(' ', e.firstName, e.lastName) AS fullName,
    e.jobTitle,
    e.email AS employeeEmail
FROM employees e;
