SELECT e.FirstName + ' ' + e.LastName as [Employee Full name], 
ISNULL((m.FirstName + ' ' + m.LastName), 'No manager') as [Manager Full name]
FROM Employees e
LEFT OUTER JOIN Employees m
ON e.ManagerID = m.EmployeeID
