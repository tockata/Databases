DECLARE @FromDate date = '1970-01-01'
DECLARE @ToDate date = '2015-12-31'
DECLARE @count int = 0

WHILE (@count <= 9999999)
BEGIN
	INSERT INTO Test 
		VALUES((SELECT dateadd(day, rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), @FromDate)),
			'text' + CONVERT(nvarchar(10), @count))

	SET @count = @count + 1
END
GO

CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Empty the SQL Server cache
GO

SELECT Date
FROM Test
WHERE Date BETWEEN '1990-01-01' AND '1999-12-31'
