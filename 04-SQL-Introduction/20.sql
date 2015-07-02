SELECT e.FirstName, e.LastName, m.FirstName + ' ' + m.LastName as [Manager]
 FROM Employees e
 INNER JOIN Employees m
 ON e.ManagerID = m.EmployeeID
 