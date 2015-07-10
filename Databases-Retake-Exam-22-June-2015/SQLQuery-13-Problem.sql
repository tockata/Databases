-- 01
CREATE TABLE FriendlyMatches(
Id INT PRIMARY KEY IDENTITY NOT NULL,
HomeTeamId INT FOREIGN KEY REFERENCES Teams(Id),
AwayTeamId INT FOREIGN KEY REFERENCES Teams(Id),
MatchDate DATETIME)

-- 02
INSERT INTO Teams(TeamName) VALUES
 ('US All Stars'),
 ('Formula 1 Drivers'),
 ('Actors'),
 ('FIFA Legends'),
 ('UEFA Legends'),
 ('Svetlio & The Legends')
GO

INSERT INTO FriendlyMatches(
  HomeTeamId, AwayTeamId, MatchDate) VALUES
  
((SELECT Id FROM Teams WHERE TeamName='US All Stars'), 
 (SELECT Id FROM Teams WHERE TeamName='Liverpool'),
 '30-Jun-2015 17:00'),
 
((SELECT Id FROM Teams WHERE TeamName='Formula 1 Drivers'), 
 (SELECT Id FROM Teams WHERE TeamName='Porto'),
 '12-May-2015 10:00'),
 
((SELECT Id FROM Teams WHERE TeamName='Actors'), 
 (SELECT Id FROM Teams WHERE TeamName='Manchester United'),
 '30-Jan-2015 17:00'),

((SELECT Id FROM Teams WHERE TeamName='FIFA Legends'), 
 (SELECT Id FROM Teams WHERE TeamName='UEFA Legends'),
 '23-Dec-2015 18:00'),

((SELECT Id FROM Teams WHERE TeamName='Svetlio & The Legends'), 
 (SELECT Id FROM Teams WHERE TeamName='Ludogorets'),
 '22-Jun-2015 21:00')

GO

-- 03
SELECT t1.TeamName AS [Home Team], t2.TeamName AS [Away Team], fm.MatchDate AS [Match Date]
FROM FriendlyMatches fm
LEFT JOIN Teams t1 ON fm.HomeTeamId = t1.Id
LEFT JOIN Teams t2 ON fm.AwayTeamId = t2.Id
UNION
SELECT t1.TeamName AS [Home Team], t2.TeamName AS [Away Team], tm.MatchDate AS [Match Date]
FROM TeamMatches tm
LEFT JOIN Teams t1 ON tm.HomeTeamId = t1.Id
LEFT JOIN Teams t2 ON tm.AwayTeamId = t2.Id
LEFT JOIN Leagues l ON tm.LeagueId = l.Id
ORDER BY [Match Date] DESC