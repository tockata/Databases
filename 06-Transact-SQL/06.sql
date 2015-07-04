-- Create trigger:
CREATE TRIGGER tr_AccountBalanceUpdate ON Accounts FOR UPDATE
AS
	INSERT INTO Logs(AccountId, OldSum, NewSum, ChangeDatetime)
		SELECT i.Id, d.Balance, i.Balance, GETDATE()
		FROM inserted i, deleted d
GO

-- Test trigger:
EXEC dbo.usp_WithdrawMoney 2, 2500
EXEC dbo.usp_DepositMoney 2, 1666