CREATE VIEW AllAds AS
SELECT TOP 100 PERCENT a.Id, a.Title, u.UserName as Author, a.Date, t.Name as Town, c.Name as Category, s.Status
FROM Ads a
LEFT JOIN AspNetUsers u ON a.OwnerId = u.Id
LEFT JOIN Towns t ON a.TownId = t.Id
LEFT JOIN Categories c ON a.CategoryId = c.Id
LEFT JOIN AdStatuses s ON a.StatusId = s.Id
ORDER BY a.Id
GO

SELECT * FROM AllAds
GO

CREATE FUNCTION fn_ListUsersAds() 
RETURNS @tbl_result TABLE (UserName nvarchar(100), AdDates nvarchar(max)) AS
BEGIN
	DECLARE @tbl_users TABLE(UserName nvarchar(100))
	DECLARE @user nvarchar(100)
	
	
	RETURN
END
GO

SELECT * FROM fn_ListUsersAds()