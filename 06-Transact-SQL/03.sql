CREATE FUNCTION dbo.ufn_CalcInterest 
	(@sum decimal(18, 2), @yearlyInterestRate decimal(18, 2), @months decimal)
	RETURNS decimal(18, 2)
AS
BEGIN
	DECLARE @result decimal(18, 2)
	SET @result = @sum + @sum * ((@yearlyInterestRate / 100) * @months / 12)
	RETURN @result
END
GO

-- function test:
SELECT dbo.ufn_CalcInterest (1000, 10, 12) as [Result]