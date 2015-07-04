SELECT t.Name as [Town], COUNT(*) as [Manager count]
FROM Towns t
JOIN Addresses a
ON a.TownID = t.TownID
JOIN Employees e
ON e.AddressID = a.AddressID
WHERE e.EmployeeID in (SELECT m.ManagerID FROM Employees m)
GROUP BY t.Name