-- Create WithdrawMoney procedure:
CREATE PROC dbo.usp_WithdrawMoney(@accountId int, @money decimal(18, 2))
AS
BEGIN TRANSACTION
BEGIN TRY
	DECLARE @balance decimal(18, 2)
	SELECT @balance = Balance
		FROM Accounts
		WHERE Id = @accountId

	IF (@money > @balance)
		BEGIN;
			THROW 50000, 'The amount you want to withdraw is more than account balance.', 1;
		END

	UPDATE Accounts
	SET Balance = Balance - @money
	WHERE Id = @accountId

    COMMIT TRANSACTION
	PRINT 'Succesfully withdrawed ' + CONVERT(nvarchar(50), @money) + '.'
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_STATE() AS ErrorState,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH
GO

-- procedure test based on my table data - please use database backup which is in the archive:
-- this will throw error
EXEC dbo.usp_WithdrawMoney 1, 50

--this will execute succesfully:
EXEC dbo.usp_WithdrawMoney 2, 2500
GO

-- Create DepositMoney procedure:
CREATE PROC dbo.usp_DepositMoney(@accountId int, @money decimal(18, 2))
AS
BEGIN TRANSACTION
BEGIN TRY
	IF NOT EXISTS (SELECT 1 FROM Accounts WHERE Id = @accountId)
		BEGIN;
			THROW 50000, 'This account does not exists.', 1;
		END

	UPDATE Accounts
	SET Balance = Balance + @money
	WHERE Id = @accountId

    COMMIT TRANSACTION
	PRINT 'Succesfully deposited ' + CONVERT(nvarchar(50), @money) + '.'
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_STATE() AS ErrorState,
        ERROR_MESSAGE() AS ErrorMessage
    ROLLBACK TRANSACTION
END CATCH
GO

-- procedure test based on my table data - please use database backup which is in the archive:
-- this will execute succesfully:
EXEC dbo.usp_DepositMoney 2, 2500

-- this will throw error because there is no account with Id 22:
EXEC dbo.usp_DepositMoney 22, 2500