# *** PROBLEM STATEMENT ***
# Following on from your previous task, a further request has come in to also display the details of who the employee reports to.
# You know not every employee reports to someone.
# Modify the below query to additionally display the following:
# Reporter Full Name, Reporter Job Title and Reporter Email

USE classicmodels;

SELECT 
	CONCAT_WS(' ', e.firstName, e.lastName) AS fullName,
    e.jobTitle,
    e.email AS employeeEmail,
    CONCAT_WS(', ', o.city, o.country) AS basedIn,
    CONCAT_WS(' ', lm.firstName, lm.lastName) AS reportsTo,
    lm.jobTitle AS reporterJobTitle,
    lm.email AS reporterEmail
FROM employees e
INNER JOIN offices o 
USING (officeCode)
LEFT JOIN employees lm
ON e.reportsTo = lm.employeeNumber;