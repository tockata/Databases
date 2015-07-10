-- 01
ALTER TABLE Leagues
ADD IsSeasonal BIT DEFAULT(0)
GO

UPDATE Leagues
SET IsSeasonal = 0

-- 02
INSERT INTO TeamMatches
VALUES(
	(SELECT Id FROM Teams WHERE TeamName = 'Empoli' ),
	(SELECT Id FROM Teams WHERE TeamName = 'Parma' ),
	2,
	2,
	CONVERT(datetime, '19-Apr-2015 16:00'),
	(SELECT Id FROM Leagues WHERE LeagueName = 'Italian Serie A'))

-- 03
INSERT INTO TeamMatches
VALUES(
	(SELECT Id FROM Teams WHERE TeamName = 'Internazionale' ),
	(SELECT Id FROM Teams WHERE TeamName = 'AC Milan' ),
	0,
	0,
	CONVERT(datetime, '19-Apr-2015 21:45'),
	(SELECT Id FROM Leagues WHERE LeagueName = 'Italian Serie A'))

-- 04
UPDATE Leagues
SET IsSeasonal = 1
WHERE Id IN (SELECT tm.LeagueId FROM TeamMatches tm JOIN Leagues l ON l.Id = tm.LeagueId)

-- 05
SELECT t1.TeamName AS [Home Team],
	tm.HomeGoals AS [Home Goals],
	t2.TeamName AS [Away Team],
	tm.AwayGoals AS [Away Goals],
	l.LeagueName AS [League Name]
FROM TeamMatches tm
JOIN Teams t1 ON tm.HomeTeamId = t1.Id
JOIN Teams t2 ON tm.AwayTeamId = t2.Id
JOIN Leagues l ON tm.LeagueId = l.Id
WHERE l.IsSeasonal = 1 AND tm.MatchDate > '10-Apr-2015'
ORDER BY l.LeagueName, tm.HomeGoals DESC, tm.AwayGoals DESC