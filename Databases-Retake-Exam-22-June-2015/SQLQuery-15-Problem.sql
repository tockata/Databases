CREATE FUNCTION fn_TeamsJSON() RETURNS nvarchar(max)
AS
BEGIN
	DECLARE @TeamsJSON nvarchar(max)
	SET @TeamsJSON = '{"teams":['
	DECLARE @outerCount int = 0
	DECLARE @team nvarchar(max)
	DECLARE @teamId int
	DECLARE teamCursor CURSOR READ_ONLY FOR		SELECT TeamName, Id FROM Teams WHERE CountryCode = 'BG' ORDER BY TeamName		OPEN teamCursor	FETCH NEXT FROM teamCursor INTO @team, @teamId

	WHILE @@FETCH_STATUS = 0		BEGIN
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
			DECLARE teamMatchCursor CURSOR READ_ONLY FOR			SELECT t1.TeamName, tm.HomeGoals, t2.TeamName, tm.AwayGoals, tm.MatchDate FROM TeamMatches tm				JOIN Teams t1 ON tm.HomeTeamId = t1.Id				JOIN Teams t2 ON tm.AwayTeamId = t2.Id				WHERE tm.HomeTeamId = @teamId OR tm.AwayTeamId = @teamId				ORDER BY tm.MatchDate DESC								OPEN teamMatchCursor			FETCH NEXT FROM teamMatchCursor INTO @homeTeamName, @homeGoals, @awayTeamName, @awayGoals, @matchDate

			WHILE @@FETCH_STATUS = 0				BEGIN
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

			CLOSE teamMatchCursor			DEALLOCATE teamMatchCursor
				
			SET @TeamsJSON = @TeamsJSON + ']}'
			FETCH NEXT FROM teamCursor INTO @team, @teamId
		END

	CLOSE teamCursor	DEALLOCATE teamCursor

	SET @TeamsJSON = @TeamsJSON + ']}'
	RETURN @TeamsJSON
END
GO

SELECT dbo. fn_TeamsJSON()