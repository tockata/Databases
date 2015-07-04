SELECT e.FirstName + ' ' + e.LastName as [Full name], e.Salary, d.Name as [Department]
FROM Employees e JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE Salary =
	(SELECT MIN(Salary) from Employees WHERE DepartmentID = d.DepartmentID)