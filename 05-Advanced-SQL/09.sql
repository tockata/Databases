SELECT AVG(e.Salary)as [Average salary], d.Name
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name