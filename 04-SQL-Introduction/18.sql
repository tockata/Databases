SELECT e.FirstName, e.LastName, a.AddressText AS Address, t.Name AS Town
 FROM Employees e 
 INNER JOIN Addresses a
 ON e.AddressID = a.AddressID
 INNER JOIN Towns t
 ON a.TownID = t.TownID