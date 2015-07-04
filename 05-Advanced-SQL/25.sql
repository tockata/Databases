SELECT d.Name as Department, e.JobTitle, AVG(Salary) as [Average Salary]
FROM Employees e
JOIN Departments d
on e.DepartmentID = d.DepartmentID
GROUP BY e.JobTitle, d.Name