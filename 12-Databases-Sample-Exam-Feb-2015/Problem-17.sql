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
		INSERT @tbl_users SELECT UserName FROM AspNetUsers	DECLARE userCursor CURSOR READ_ONLY FOR		SELECT UserName FROM @tbl_users ORDER BY UserName DESC		OPEN userCursor	FETCH NEXT FROM userCursor INTO @user		WHILE @@FETCH_STATUS = 0		BEGIN			DECLARE allAdsCursor CURSOR READ_ONLY FOR			SELECT Date FROM AllAds WHERE Author = @user ORDER BY Date			DECLARE @adDate datetime, @dateString nvarchar(MAX) = ''			OPEN allAdsCursor			FETCH NEXT FROM allAdsCursor INTO @adDate			WHILE @@FETCH_STATUS = 0				BEGIN					IF(LEN(@dateString) < 1)						BEGIN							SET @dateString = @dateString + FORMAT(@adDate, 'yyyyMMdd')						END					ELSE						BEGIN							SET @dateString = @dateString + '; ' + FORMAT(@adDate, 'yyyyMMdd')						END					FETCH NEXT FROM allAdsCursor INTO @adDate				END						IF (LEN(@dateString) < 1)				BEGIN					SET @dateString = NULL				END			INSERT @tbl_result SELECT @user, @dateString			CLOSE allAdsCursor			DEALLOCATE allAdsCursor			FETCH NEXT FROM userCursor INTO @user		END	CLOSE userCursor	DEALLOCATE userCursor
	
	RETURN
END
GO

SELECT * FROM fn_ListUsersAds()