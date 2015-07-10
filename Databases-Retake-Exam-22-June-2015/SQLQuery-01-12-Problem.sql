-- Problem 01
SELECT TeamName
FROM Teams
ORDER BY TeamName

-- Problem 02
SELECT TOP 50 CountryName, Population
FROM Countries
ORDER BY Population DESC, CountryName

-- Problem 03
SELECT CountryName, CountryCode,
	CASE
		WHEN CurrencyCode = 'EUR' THEN 'Inside'
		ELSE 'Outside'
	END AS Eurozone
FROM Countries
ORDER BY CountryName

-- Problem 04
SELECT TeamName AS [Team Name], CountryCode AS [Country Code]
FROM Teams
WHERE TeamName LIKE '%[0-9]%'
ORDER BY CountryCode

-- Problem 05
SELECT hc.CountryName AS [Home Team], ac.CountryName AS [Away Team], im.MatchDate AS [Match Date]
FROM InternationalMatches im
JOIN Countries hc ON im.HomeCountryCode = hc.CountryCode
JOIN Countries ac ON im.AwayCountryCode = ac.CountryCode
ORDER BY im.MatchDate DESC

-- Problem 06
SELECT t.TeamName AS [Team Name], l.LeagueName AS League, 
	CASE
	WHEN c.CountryName IS NULL THEN 'International'
	ELSE c.CountryName
	END AS [League Country]
FROM Teams t
LEFT JOIN Leagues_Teams lt ON t.Id = lt.TeamId
LEFT JOIN Leagues l ON lt.LeagueId = l.Id
LEFT JOIN Countries c ON l.CountryCode = c.CountryCode
ORDER BY t.TeamName, l.LeagueName

-- Problem 07
SELECT t.TeamName AS [Team], COUNT(DISTINCT htm.Id) + COUNT(DISTINCT atm.Id) AS [Matches Count]
FROM Teams t
LEFT JOIN TeamMatches htm ON t.Id = htm.HomeTeamId
LEFT JOIN TeamMatches atm ON t.Id = atm.AwayTeamId
GROUP BY t.TeamName, htm.LeagueId
HAVING COUNT(DISTINCT htm.Id) + COUNT(DISTINCT atm.Id) > 1
ORDER BY t.TeamName

-- Problem 08
SELECT l.LeagueName AS [League Name], COUNT(DISTINCT lt.TeamId) AS [Teams],
	COUNT(DISTINCT tm.Id) AS [Matches], 
	ISNULL(AVG(tm.AwayGoals + tm.HomeGoals), 0) AS [Average Goals]
FROM Leagues l
LEFT JOIN Leagues_Teams lt ON l.Id = lt.LeagueId
LEFT JOIN TeamMatches tm ON l.Id = tm.LeagueId
GROUP BY l.LeagueName
ORDER BY [Teams] DESC, [Matches] DESC

-- Problem 09
--SELECT t.TeamName, ISNULL(SUM(htm.HomeGoals), 0) + ISNULL(SUM(atm.AwayGoals), 0) AS [Total Goals]
--FROM Teams t
--LEFT JOIN TeamMatches htm ON t.Id = htm.HomeTeamId
--LEFT JOIN TeamMatches atm ON t.Id = atm.AwayTeamId
--GROUP BY t.TeamName
--ORDER BY [Total Goals] DESC, t.TeamName

SELECT
    t.TeamName,
    (SELECT ISNULL(SUM(tm.HomeGoals), 0) 
     FROM TeamMatches AS tm 
     WHERE tm.HomeTeamId = t.Id) +
    (SELECT ISNULL(SUM(tm.AwayGoals), 0) 
     FROM TeamMatches AS tm 
     WHERE tm.AwayTeamId = t.Id) AS [Total Goals]
FROM Teams AS t
GROUP BY t.Id, t.TeamName
ORDER BY [Total Goals] DESC, t.TeamName ASC

-- Problem 10
SELECT tm1.MatchDate AS [First Date], tm2.MatchDate AS [Second Date]
FROM TeamMatches tm1
JOIN TeamMatches tm2 ON tm1.Id <> tm2.Id
WHERE CAST(tm1.MatchDate AS DATE) = CAST(tm2.MatchDate AS DATE) AND tm1.MatchDate < tm2.MatchDate
ORDER BY tm1.MatchDate DESC, tm2.MatchDate DESC

-- Problem 11
SELECT LOWER(t1.TeamName + SUBSTRING(REVERSE(t2.TeamName), 2, 500)) AS Mix
FROM Teams t1, Teams t2
WHERE RIGHT(t1.TeamName, 1) = RIGHT(t2.TeamName, 1)
ORDER BY Mix

-- Problem 12
SELECT c.CountryName AS [Country Name], 
	COUNT(DISTINCT im1.Id) + COUNT(DISTINCT im2.Id) AS [International Matches],
	COUNT(DISTINCT tm.Id) AS [Team Matches]
FROM Countries c
LEFT JOIN InternationalMatches im1 ON c.CountryCode = im1.HomeCountryCode
LEFT JOIN InternationalMatches im2 ON c.CountryCode = im2.AwayCountryCode
LEFT JOIN Leagues l ON c.CountryCode = l.CountryCode
LEFT JOIN TeamMatches tm ON l.id = tm.LeagueId
GROUP BY c.CountryName
HAVING COUNT(DISTINCT im1.Id) + COUNT(DISTINCT im2.Id) > 0 OR COUNT(DISTINCT tm.LeagueId) > 0
ORDER BY [International Matches] DESC, [Team Matches] DESC, c.CountryName