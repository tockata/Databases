SELECT d.Name as Department, 
e.JobTitle,
e.FirstName + e.LastName as [Full name],
Salary as [Minimal Salary]
FROM Employees e
JOIN Departments d
on e.DepartmentID = d.DepartmentID
	WHERE Salary =
	(SELECT MIN(Salary) FROM Employees
	 WHERE DepartmentID = e.DepartmentID)
GROUP BY d.Name, e.JobTitle, FirstName, LastName, Salary