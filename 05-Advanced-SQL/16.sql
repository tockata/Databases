CREATE VIEW [Users have been logged in today] AS
SELECT Username, FullName
FROM Users
WHERE CAST(LastLoginTime AS DATE) = CAST(GETDATE() as DATE)