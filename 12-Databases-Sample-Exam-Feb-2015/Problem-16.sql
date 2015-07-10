-- Problem 1
CREATE TABLE Countries(
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name nvarchar(100))
GO

ALTER TABLE Towns
ADD CountryId int NULL
GO

ALTER TABLE Towns
ADD CONSTRAINT FK_Towns_Countries FOREIGN KEY(CountryId) REFERENCES Countries(Id)
GO

-- Problem 2
INSERT INTO Countries(Name) VALUES ('Bulgaria'), ('Germany'), ('France')
UPDATE Towns SET CountryId = (SELECT Id FROM Countries WHERE Name='Bulgaria')
INSERT INTO Towns VALUES
('Munich', (SELECT Id FROM Countries WHERE Name='Germany')),
('Frankfurt', (SELECT Id FROM Countries WHERE Name='Germany')),
('Berlin', (SELECT Id FROM Countries WHERE Name='Germany')),
('Hamburg', (SELECT Id FROM Countries WHERE Name='Germany')),
('Paris', (SELECT Id FROM Countries WHERE Name='France')),
('Lyon', (SELECT Id FROM Countries WHERE Name='France')),
('Nantes', (SELECT Id FROM Countries WHERE Name='France'))

-- Problem 3
UPDATE Ads
SET TownId = (SELECT Id FROM Towns WHERE Name = 'Paris')
WHERE datename(dw, Date) = 'Friday'

--Problem 4
UPDATE Ads
SET TownId = (SELECT Id FROM Towns WHERE Name = 'Hamburg')
WHERE datename(dw, Date) = 'Thursday'

--Problem 5
DELETE FROM Ads
WHERE OwnerId IN (SELECT u.Id FROM AspNetUsers u
	INNER JOIN AspNetUserRoles ur ON u.Id = ur.UserId
	INNER JOIN AspNetRoles r ON ur.RoleId = r.Id
	WHERE r.Name = 'Partner')

-- Problem 6
INSERT INTO Ads(Title, Text, Date, OwnerId, StatusId)
VALUES(
	'Free Book',
	'Free C# Book',
	GETDATE(),
	(SELECT Id FROM AspNetUsers
		WHERE UserName = 'nakov'),
	(SELECT Id FROM AdStatuses
		WHERE Status = 'Waiting Approval'))

-- Problem 7
SELECT t.Name as Town, c.Name as Country, COUNT(a.Id) AS AdsCount
FROM Ads a
FULL JOIN Towns t ON a.TownId = t.Id
FULL JOIN Countries c ON t.CountryId = c.Id
GROUP BY t.Name, c.Name
ORDER BY t.Name, c.Name