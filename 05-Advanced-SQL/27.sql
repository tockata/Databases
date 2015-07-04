SELECT TOP 1 t.name as [Town name], COUNT(*) as [Number of employees]
FROM Employees e
JOIN Addresses a
ON e.AddressID = a.AddressID
JOIN Towns t
ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY [Number of employees] DESC