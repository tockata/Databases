CREATE INDEX IX_Date ON Test (Date)

CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Empty the SQL Server cache
GO

SELECT Date
FROM Test
WHERE Date BETWEEN '1990-01-01' AND '1999-12-31'