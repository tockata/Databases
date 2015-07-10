CREATE FUNCTION fn_TeamsJSON() RETURNS nvarchar(max)
AS
BEGIN
	DECLARE @TeamsJSON nvarchar(max)
	SET @TeamsJSON = '{"teams":['
	DECLARE @outerCount int = 0
	DECLARE @team nvarchar(max)
	DECLARE @teamId int
	DECLARE teamCursor CURSOR READ_ONLY FOR

	WHILE @@FETCH_STATUS = 0
			DECLARE @innerCount int = 0
			IF @outerCount = 0
				BEGIN
					SET @TeamsJSON = @TeamsJSON + '{"name":"' + @team + '","matches":['
					SET @outerCount = 1
				END
			ELSE
				BEGIN
					SET @TeamsJSON = @TeamsJSON + ',{"name":"' + @team + '","matches":['
				END
			
			DECLARE @homeTeamName nvarchar(max)
			DECLARE @awayTeamName nvarchar(max)
			DECLARE @homeGoals int
			DECLARE @awayGoals int
			DECLARE @matchDate DATETIME
			DECLARE teamMatchCursor CURSOR READ_ONLY FOR

			WHILE @@FETCH_STATUS = 0
					IF @innerCount = 0
					BEGIN
						SET @TeamsJSON = @TeamsJSON + '{"' + @homeTeamName + '":' + CAST(@homeGoals as nvarchar(max)) + ',"' + @awayTeamName + '":' + CAST(@awayGoals as nvarchar(max)) + ',"date":' + CONVERT(nvarchar(max), @matchDate, 103)
						SET @innerCount = 1
					END
					ELSE
					BEGIN
						SET @TeamsJSON = @TeamsJSON + ',{"' + @homeTeamName + '":' + CAST(@homeGoals as nvarchar(max)) + ',"' + @awayTeamName + '":' + CAST(@awayGoals as nvarchar(max)) + ',"date":' + CONVERT(nvarchar(max), @matchDate, 103)
					END
					FETCH NEXT FROM teamMatchCursor INTO @homeTeamName, @homeGoals, @awayTeamName, @awayGoals, @matchDate

					SET @TeamsJSON = @TeamsJSON + '}'
				END

			CLOSE teamMatchCursor
				
			SET @TeamsJSON = @TeamsJSON + ']}'
			FETCH NEXT FROM teamCursor INTO @team, @teamId
		END

	CLOSE teamCursor

	SET @TeamsJSON = @TeamsJSON + ']}'
	RETURN @TeamsJSON
END
GO

SELECT dbo. fn_TeamsJSON()