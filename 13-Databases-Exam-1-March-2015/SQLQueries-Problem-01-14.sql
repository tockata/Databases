-- Problem 01
SELECT PeakName
FROM Peaks
ORDER BY PeakName

-- Problem 02
SELECT TOP 30 country.CountryName, country.Population
FROM Countries country
JOIN Continents continent ON country.ContinentCode = continent.ContinentCode
WHERE continent.ContinentName = 'Europe'
ORDER BY Population DESC, CountryName ASC

-- Problem 03
SELECT country.CountryName, country.CountryCode,
	CASE
		WHEN currencies.CurrencyCode = 'EUR' THEN 'Euro'
		ELSE 'Not Euro'
	END AS Currency
FROM Countries country
LEFT JOIN Currencies currencies ON country.CurrencyCode = currencies.CurrencyCode
ORDER BY country.CountryName ASC

-- Problem 04
SELECT CountryName as [Country Name], IsoCode as [ISO Code]
FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

-- Problem 05
SELECT p.PeakName, m.MountainRange AS Mountain, p.Elevation
FROM Peaks p
JOIN Mountains m ON p.MountainId = m.Id
ORDER BY p.Elevation DESC

-- Problem 06
SELECT p.PeakName, m.MountainRange AS Mountain, c.CountryName, cc.ContinentName
FROM Peaks p
JOIN Mountains m ON p.MountainId = m.Id
JOIN MountainsCountries mc ON m.Id = mc.MountainId
JOIN Countries c ON mc.CountryCode = c.CountryCode
JOIN Continents cc ON c.ContinentCode = cc.ContinentCode
ORDER BY p.PeakName, c.CountryName

-- Problem 07
SELECT r.RiverName as River, COUNT(cr.CountryCode) AS [Countries Count]
FROM Rivers r
JOIN CountriesRivers cr ON r.Id = cr.RiverId
GROUP BY r.Id, r.RiverName
HAVING COUNT(cr.CountryCode) >= 3
ORDER BY r.RiverName

-- Problem 08
SELECT MAX(Elevation) as MaxElevation, MIN(Elevation) as MinElevation, AVG(Elevation) as AverageElevation
FROM Peaks

-- Problem 09
SELECT c.CountryName, ct.ContinentName,
	CASE
	WHEN COUNT(cr.CountryCode) = 0 THEN 0
	ELSE COUNT(cr.CountryCode)
	END AS RiversCount,
	CASE
	WHEN COUNT(cr.CountryCode) = 0 THEN 0
	ELSE SUM(r.Length)
	END AS TotalLength
FROM Countries c
FULL JOIN Continents ct ON c.ContinentCode = ct.ContinentCode
FULL JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
FULL JOIN Rivers r on r.Id = cr.RiverId
GROUP BY c.CountryName, ct.ContinentName
ORDER BY COUNT(cr.CountryCode) DESC, SUM(r.Length) DESC, c.CountryName

-- Problem 10
SELECT cr.CurrencyCode, cr.Description as Currency, COUNT(c.CountryCode) AS NumberOfCountries
FROM Countries c
RIGHT JOIN Currencies cr ON c.CurrencyCode = cr.CurrencyCode
GROUP BY cr.CurrencyCode, cr.Description
ORDER BY COUNT(c.CountryCode) DESC, cr.Description

-- Problem 11
SELECT ct.ContinentName, SUM(c.AreaInSqKm) as CountriesArea, SUM(CAST(c.Population AS bigint)) as CountriesPopulation
FROM Countries c
RIGHT JOIN Continents ct ON c.ContinentCode = ct.ContinentCode
GROUP BY ct.ContinentName
ORDER BY SUM(CAST(c.Population AS bigint)) DESC

-- Problem 12
SELECT c.CountryName, MAX(p.Elevation) as HighestPeakElevation, MAX(r.Length) as LongestRiverLength
FROM Countries c
LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers r ON cr.RiverId = r.Id
LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Mountains m ON mc.MountainId = m.Id
LEFT JOIN Peaks p ON m.Id = p.MountainId
GROUP BY c.CountryName
ORDER BY MAX(p.Elevation) DESC, MAX(r.Length) DESC, c.CountryName

-- Problem 13
SELECT p.PeakName, r.RiverName, LOWER(p.PeakName + SUBSTRING(r.RiverName,2, 50)) AS Mix
FROM Peaks p, Rivers r
WHERE RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
ORDER BY Mix

-- Problem 14
SELECT c.CountryName AS Country, 
	ISNULL((select p2.PeakName from Peaks p2 where p2.Elevation = max(p.Elevation)), '(no highest peak)') AS [Highest Peak Name],
	ISNULL(MAX(p.Elevation), 0) AS [Highest Peak Elevation],
	ISNULL((select m2.MountainRange from Mountains m2 
		join Peaks p3 ON m2.Id = p3.MountainId
		where p3.Elevation = max(p.Elevation)), '(no mountain)') AS Mountain
FROM Countries c
LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Mountains m ON mc.MountainId = m.Id
LEFT JOIN Peaks p ON m.Id = p.MountainId
GROUP BY c.CountryName
ORDER BY c.CountryName, [Highest Peak Elevation]