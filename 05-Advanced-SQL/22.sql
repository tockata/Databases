INSERT INTO Users(Username, Password, FullName, LastLoginTime)
SELECT LOWER(LEFT(FirstName, 1) + LastName) + CONVERT(nvarchar(50), EmployeeID),
	LOWER(LEFT(FirstName, 1) + LastName) + '123', 
	FirstName + ' ' + LastName,
	NULL
FROM SoftUni.dbo.Employees