-- Problem 1
SELECT Title
FROM Ads
ORDER BY Title

-- Problem 2
SELECT Title, Date
FROM Ads
WHERE Date BETWEEN '2014-12-26' AND '2015-01-02'
ORDER BY Date

-- Problem 3
SELECT 
	Title,
	Date,
	CASE
		WHEN ImageDataURL IS NULL THEN 'no'
		ELSE 'yes'
	END as [Has Image]
FROM Ads
ORDER BY Id

-- Problem 4
SELECT *
FROM Ads
WHERE TownId IS NULL OR CategoryId IS NULL OR ImageDataURL IS NULL

-- Problem 5
SELECT a.Title, t.Name as Town
FROM Ads a
LEFT JOIN Towns t
ON a.TownId = t.Id
ORDER BY a.Id

-- Problem 6
SELECT a.Title, c.Name as CategoryName, t.Name as TownName, s.Status
FROM Ads a
LEFT JOIN Categories c
ON a.CategoryId = c.Id
LEFT JOIN Towns t
ON a.TownId = t.Id
LEFT JOIN AdStatuses s
ON a.StatusId = s.Id
ORDER BY a.Id

-- Problem 7
SELECT a.Title, c.Name as CategoryName, t.Name as TownName, s.Status
FROM Ads a
LEFT JOIN Categories c
ON a.CategoryId = c.Id
LEFT JOIN Towns t
ON a.TownId = t.Id
LEFT JOIN AdStatuses s
ON a.StatusId = s.Id
WHERE t.Name IN ('Sofia', 'Blagoevgrad', 'Stara Zagora') AND s.Status = 'Published'
ORDER BY a.Title

-- Problem 8
SELECT MIN(Date) as MinDate, MAX(Date) as MaxDate
FROM Ads

-- Problem 9
SELECT TOP 10 a.Title, a.Date, s.Status
FROM Ads a
LEFT JOIN AdStatuses s
ON a.StatusId = s.Id
ORDER BY a.Date DESC

-- Problem 10
SELECT a.Id, a.Title, a.Date, s.Status
FROM Ads a
LEFT JOIN AdStatuses s
ON a.StatusId = s.Id
WHERE 
	MONTH(a.Date) = MONTH((SELECT MIN(Date) FROM Ads)) AND 
	YEAR(a.Date) = YEAR((SELECT MIN(Date) FROM Ads)) AND
	s.Status <> 'Published'
ORDER BY a.Id

-- Problem 11
SELECT s.Status, COUNT(a.Id) as Count
FROM Ads a
INNER JOIN AdStatuses s
ON a.StatusId = s.Id
GROUP BY s.Status
ORDER BY s.Status

-- Problem 12
SELECT t.Name as [Town Name], s.Status, COUNT(a.Id) as Count
FROM Ads a
INNER JOIN Towns t
ON a.TownId = t.Id
INNER JOIN AdStatuses s
ON a.StatusId = s.Id
GROUP BY t.Name, s.Status
HAVING COUNT(a.Id) > 0
ORDER BY t.Name, s.Status

-- Problem 13
SELECT u.UserName as [UserName], COUNT(a.Id) as AdsCount,
	CASE
		WHEN u.UserName IN (
			SELECT u.UserName
			FROM AspNetUsers u
			LEFT JOIN AspNetUserRoles ur ON u.Id = ur.UserId
			LEFT JOIN AspNetRoles r ON ur.RoleId = r.Id
			WHERE r.Name = 'Administrator'
			) THEN 'yes'
		ELSE 'no'
	END
	AS IsAdministrator
FROM AspNetUsers u
LEFT JOIN Ads a ON u.Id = a.OwnerId
GROUP BY u.UserName
ORDER BY u.UserName

-- Problem 14
SELECT COUNT(a.Id) as AdsCount, 
	CASE
		WHEN t.Name IS NULL THEN '(no town)'
		ELSE t.Name
	END
	AS Town
FROM Ads a
LEFT JOIN Towns t ON a.TownId = t.Id
GROUP BY t.Name
HAVING COUNT(a.Id) BETWEEN 2 AND 3
ORDER BY t.Name

-- Problem 15
SELECT a.Date as FirstDate, b.Date as SecondDate
FROM Ads a
JOIN Ads b ON a.Date <> b.Date
WHERE a.Date < b.Date AND DATEDIFF(HOUR, a.Date, b.Date) < 12
ORDER BY a.Date, b.Date

