-- 01
CREATE TABLE Monasteries(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	Name NVARCHAR(100),
	CountryCode CHAR(2) FOREIGN KEY REFERENCES Countries(CountryCode))

-- 02
INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')

-- 03
ALTER TABLE Countries
ADD IsDeleted BIT DEFAULT(0)

UPDATE Countries
SET IsDeleted = 0

-- 04
UPDATE Countries
SET IsDeleted = 1
WHERE CountryName IN (
	SELECT CountryName 
	FROM Countries c
	INNER JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
	INNER JOIN Rivers r ON cr.RiverId = r.Id
	GROUP BY c.CountryName
	HAVING COUNT(r.Id) > 3)

-- 05
SELECT m.Name AS Monastery, c.CountryName AS Country
FROM Monasteries m
JOIN Countries c ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted <> 1
ORDER BY m.Name