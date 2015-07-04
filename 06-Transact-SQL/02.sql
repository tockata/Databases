CREATE PROC dbo.usp_SelectPersonsWithBalanceMoreThanGivenValue(@minBalance money = 0)
AS
	SELECT p.FirstName + ' ' + p.LastName as [Full name], a.Balance
	FROM Persons p
	INNER JOIN Accounts a
	ON p.Id = a.PersonId
	WHERE a.Balance > @minBalance

GO

EXEC dbo.usp_SelectPersonsWithBalanceMoreThanGivenValue 500
