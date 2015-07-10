-- Problem 01
SELECT Title
FROM Questions
ORDER BY Title

-- Problem 02
SELECT Content, CreatedOn
FROM Answers
WHERE CreatedOn >= '2012-06-15' AND CreatedOn <= '2013-03-21'
ORDER BY CreatedOn

-- Problem 03
SELECT Username, LastName,
	CASE
	WHEN PhoneNumber IS NULL THEN 0
	ELSE 1
	END AS [Has Phone]
FROM Users
ORDER BY LastName, Id

-- Problem 04
SELECT q.Title AS [Question Title], u.Username AS [Author]
FROM Questions q
INNER JOIN Users u ON q.UserId = u.Id
ORDER BY q.Title

-- Problem 05
SELECT TOP 50 a.Content AS [Answer Content], a.CreatedOn, u.Username AS [Answer Author],
	q.Title AS [Question Title], c.Name AS [Category Name]
FROM Answers a
INNER JOIN Questions q ON a.QuestionId = q.Id
INNER JOIN Users u ON a.UserId = u.Id
INNER JOIN Categories c ON q.CategoryId = c.Id
ORDER BY c.Name, u.Username, a.CreatedOn

-- Problem 06
SELECT c.Name AS [Category], q.Title AS [Question], q.CreatedOn
FROM Categories c
LEFT JOIN Questions q ON c.Id = q.CategoryId
ORDER BY c.Name, q.Title

-- Problem 07
SELECT u.Id, u.Username, u.FirstName, u.PhoneNumber, u.RegistrationDate, u.Email
FROM Users u
LEFT JOIN Questions q ON u.Id = q.UserId
WHERE u.PhoneNumber IS NULL AND u.id NOT IN (SELECT UserId FROM Questions)
ORDER BY u.RegistrationDate

-- Problem 08
SELECT MIN(CreatedOn) AS [MinDate], MAX(CreatedOn) AS [MaxDate]
FROM Answers
WHERE CreatedOn > '2011-12-31' AND CreatedOn < '2015-01-01'

-- Problem 09
SELECT TOP 10 a.Content AS [Answer], CreatedOn, u.Username
FROM Answers a
JOIN Users u ON a.UserId = u.Id
ORDER BY a.CreatedOn DESC

-- Problem 10
SELECT a.Content AS [Answer Content], q.Title AS [Question], c.Name AS [Category]
FROM Answers a
JOIN Questions q ON a.QuestionId = q.Id
JOIN Categories c ON q.CategoryId = c.Id
WHERE a.IsHidden = 1 AND a.CreatedOn IN 
	(SELECT CreatedOn FROM Answers
		WHERE YEAR(CreatedOn) = YEAR((SELECT TOP 1 CreatedOn FROM Answers ORDER BY CreatedOn DESC))
		AND (MONTH(CreatedOn) = '01' OR MONTH(CreatedOn) = '12'))
ORDER BY c.Name

-- Problem 11
SELECT c.Name AS [Category], COUNT(a.Id) AS [Answers Count]
FROM Categories c
LEFT JOIN Questions q ON c.Id = q.CategoryId
LEFT JOIN Answers a ON q.Id = a.QuestionId
GROUP BY c.Name
ORDER BY [Answers Count] DESC

-- Problem 12
SELECT c.Name AS [Category], u.Username,
	(SELECT PhoneNumber FROM Users WHERE Username = u.Username) AS [PhoneNumber],
	COUNT(a.Id) AS [Answers Count]
FROM Categories c
LEFT JOIN Questions q ON c.Id = q.CategoryId
LEFT JOIN Answers a ON q.Id = a.QuestionId
LEFT JOIN Users u ON a.UserId = u.Id
GROUP BY c.Name, u.Username, u.PhoneNumber
HAVING u.PhoneNumber IS NOT NULL
ORDER BY [Answers Count] DESC, u.Username

-- Problem 13
-- 01
CREATE TABLE Towns(
Id INT PRIMARY KEY IDENTITY NOT NULL,
Name nvarchar(100) NOT NULL)
GO

ALTER TABLE Users
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id)
GO

-- 02
INSERT INTO Towns(Name) VALUES ('Sofia'), ('Berlin'), ('Lyon')
UPDATE Users SET TownId = (SELECT Id FROM Towns WHERE Name='Sofia')
INSERT INTO Towns VALUES
('Munich'), ('Frankfurt'), ('Varna'), ('Hamburg'), ('Paris'), ('Lom'), ('Nantes')

-- 03
UPDATE Users
SET TownId = (SELECT Id FROM Towns WHERE Name = 'Paris')
WHERE DATENAME(DW, RegistrationDate) = 'Friday'

-- 04
UPDATE Answers
SET QuestionId = (SELECT Id FROM Questions WHERE Title = 'Java += operator')
WHERE (DATENAME(DW, CreatedOn) = 'Monday' OR DATENAME(DW, CreatedOn) = 'Sunday') AND
	DATENAME(M, CreatedOn) = 'February'

-- 05
--DELETE FROM Answers
--WHERE Id IN(
--	SELECT a.Id 
--	FROM Answers a 
--	JOIN Votes v ON a.Id = v.AnswerId 
--	GROUP BY v.AnswerId, a.Id
--	HAVING SUM(v.Value) < 0)

CREATE TABLE #AnswersId(Id INT)
GO 

INSERT INTO #AnswersId (Id)
SELECT a.Id 
	FROM Answers a 
	JOIN Votes v ON a.Id = v.AnswerId 
	GROUP BY v.AnswerId, a.Id
	HAVING SUM(v.Value) < 0

DELETE FROM Votes
WHERE Id IN(
	SELECT v.Id 
	FROM Votes v 
	JOIN #AnswersId ans ON v.AnswerId = ans.Id)

DELETE FROM Answers
WHERE Id IN(
	SELECT Id 
	FROM #AnswersId)

DROP TABLE #AnswersId

-- 06
INSERT INTO Questions(Title, Content, CategoryId, UserId, CreatedOn)
VALUES(
	'Fetch NULL values in PDO query',
	'When I run the snippet, NULL values are converted to empty strings. How can fetch NULL values?',
	(SELECT Id FROM Categories WHERE Name = 'Databases'),
	(SELECT Id FROM Users WHERE Username = 'darkcat'),
	GETDATE())

-- 07
SELECT t.Name AS [Town], u.Username, COUNT(a.Id) AS [AnswersCount]
FROM Towns t
LEFT JOIN Users u ON t.Id = u.TownId
LEFT JOIN Answers a ON u.Id = a.UserId
GROUP BY t.Name, u.Username
ORDER BY [AnswersCount] DESC, u.Username
GO

-- Problem 14
-- 01
CREATE VIEW AllQuestions AS
SELECT u.id AS [UId], u.Username, u.FirstName, u.LastName, u.Email, u.PhoneNumber, 
	FORMAT(u.RegistrationDate, 'yyyy-MM-dd') AS [RegistrationDate],
	q.Id AS [QId], q.Title, q.Content, q.CategoryId, q.UserId, q.CreatedOn
FROM Questions q
RIGHT OUTER JOIN Users u ON q.UserId = u.Id
GO 

SELECT * FROM AllQuestions
GO

-- 02
CREATE FUNCTION fn_ListUsersQuestions()
RETURNS @table_UsersQuestions TABLE
	(UserName nvarchar(max),
	Questions nvarchar(max))
AS
BEGIN 
	DECLARE @username nvarchar(max)
	DECLARE userNameCursor CURSOR READ_ONLY FOR
		SELECT Username FROM AllQuestions GROUP BY Username ORDER BY Username
	
	OPEN userNameCursor
	FETCH NEXT FROM userNameCursor INTO @username

	WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @allQuestions nvarchar(max) = ''
			DECLARE @question nvarchar(max)
			DECLARE @count int = 0
			DECLARE questionCursor CURSOR READ_ONLY FOR
				SELECT Title FROM AllQuestions WHERE Username = @username GROUP BY Title ORDER BY Title DESC
	
			OPEN questionCursor
			FETCH NEXT FROM questionCursor INTO @question

			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF @count = 0
				BEGIN
					SET @allQuestions = @allQuestions + @question
				END
				ELSE
				BEGIN
					SET @allQuestions = @allQuestions + ', ' + @question
				END
				
				FETCH NEXT FROM questionCursor INTO @question
				SET @count = 1
			END

			CLOSE questionCursor
			DEALLOCATE questionCursor
			
			INSERT INTO @table_UsersQuestions(UserName, Questions)
				VALUES(@username, 
					(CASE 
					WHEN @allQuestions = ''	THEN NULL
					ELSE @allQuestions
					END))

			FETCH NEXT FROM userNameCursor INTO @username
		END

		CLOSE userNameCursor
		DEALLOCATE userNameCursor
RETURN
END
GO

SELECT * FROM fn_ListUsersQuestions()