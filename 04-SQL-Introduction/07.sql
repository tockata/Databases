SELECT COALESCE(FirstName, '') + ' ' +
 COALESCE(MiddleName, '') + ' '  +
 COALESCE(LastName, '') as [Full name]
FROM Employees