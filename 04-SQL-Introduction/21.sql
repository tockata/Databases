SELECT e.FirstName, e.LastName, m.FirstName + ' ' + m.LastName as [Manager], 
	a.AddressText AS Address, t.Name AS Town
 FROM Employees e
 INNER JOIN Employees m
 ON e.ManagerID = m.EmployeeID
 INNER JOIN Addresses a
 ON e.AddressID = a.AddressID
 INNER JOIN Towns t
 ON a.TownID = t.TownID