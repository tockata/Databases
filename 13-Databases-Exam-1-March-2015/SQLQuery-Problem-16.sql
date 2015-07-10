-- 01
UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'

-- 02
INSERT INTO Monasteries VALUES('Hanga Abbey', 
	(SELECT CountryCode FROM Countries WHERE CountryName = 'Tanzania'))

-- 03
INSERT INTO Monasteries VALUES('Myin-Tin-Daik', 
	(SELECT CountryCode FROM Countries WHERE CountryName = 'Myanmar'))

-- 04
SELECT ct.ContinentName, c.CountryName, COUNT(m.Id) AS MonasteriesCount
FROM Monasteries m
FULL JOIN Countries c ON m.CountryCode = c.CountryCode
JOIN Continents ct ON c.ContinentCode = ct.ContinentCode
GROUP BY ct.ContinentName, c.CountryName, c.IsDeleted
HAVING c.IsDeleted = 0
ORDER BY MonasteriesCount DESC, c.CountryName