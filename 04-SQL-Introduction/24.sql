SELECT e.FirstName, e.LastName, d.Name, e.HireDate
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE (d.Name = 'Sales' OR d.Name = 'Finance') AND (e.HireDate BETWEEN '1995-01-01' AND '2005-12-31')