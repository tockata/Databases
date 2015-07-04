SELECT m.FirstName, m.LastName, COUNT(*) as [Employees count]
FROM Employees e
JOIN Employees m
ON e.ManagerID = m.EmployeeID
GROUP BY m.FirstName, m.LastName
HAVING COUNT(*) = 5