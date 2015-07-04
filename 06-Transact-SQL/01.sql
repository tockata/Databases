CREATE PROC dbo.usp_SelectPersonsFullNames
AS
	SELECT FirstName + ' ' + LastName as [Full name]
	FROM Persons

GO

EXEC dbo.usp_SelectPersonsFullNames
