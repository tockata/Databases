SELECT FirstName, LastName, Salary 
FROM Employees
WHERE Salary BETWEEN 
(SELECT MIN(Salary) from Employees)	AND (SELECT MIN(Salary) * 1.10 from Employees)
