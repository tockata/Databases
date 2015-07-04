CREATE PROC dbo.usp_CalcInterestForOneMonth(@accountId int, @interestRate decimal(18, 2))
AS
SELECT Balance as [Current Balance],
	@interestRate as [Interest rate],
	dbo.ufn_CalcInterest(Balance, @interestRate, 1) as [Balance with interest for 1 month]
FROM Accounts
WHERE Id = @accountId
GO

-- procedure test:
EXEC dbo.usp_CalcInterestForOneMonth 3, 10