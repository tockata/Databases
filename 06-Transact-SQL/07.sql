USE SoftUni
GO

CREATE FUNCTION dbo.ufn_SearchEmployeeAndTownNamesByGivenLettersSet(@letters nvarchar(10))
RETURNS @results TABLE (Results nvarchar(50), ColumnType nvarchar(50) NOT NULL)
AS
BEGIN

DECLARE @lettersExistsInSearchString bit = 1
DECLARE @length int

-- search in first names:
DECLARE empFirstNameCursor CURSOR READ_ONLY FOR  SELECT FirstName FROM EmployeesOPEN empFirstNameCursorDECLARE @fname nvarchar(50)FETCH NEXT FROM empFirstNameCursor INTO @fnameWHILE @@FETCH_STATUS = 0  BEGIN    SET @length = LEN(@fname)	WHILE (@length > 0)	BEGIN		IF (CHARINDEX(SUBSTRING(@fname, @length, 1), @letters) <= 0)		BEGIN			SET @lettersExistsInSearchString = 0		END		SET @length = @length - 1	END	IF (@lettersExistsInSearchString <> 0 AND @fname IS NOT NULL)	BEGIN		INSERT @results SELECT @fname, 'First name'	END	SET @lettersExistsInSearchString = 1    FETCH NEXT FROM empFirstNameCursor     INTO @fname  ENDCLOSE empFirstNameCursorDEALLOCATE empFirstNameCursor-- search in middle names:DECLARE empMiddleNameCursor CURSOR READ_ONLY FOR  SELECT MiddleName FROM EmployeesOPEN empMiddleNameCursorDECLARE @mname nvarchar(50)FETCH NEXT FROM empMiddleNameCursor INTO @mnameWHILE @@FETCH_STATUS = 0  BEGIN    SET @length = LEN(@mname)	WHILE (@length > 0)	BEGIN		IF (CHARINDEX(SUBSTRING(@mname, @length, 1), @letters) <= 0)		BEGIN			SET @lettersExistsInSearchString = 0		END		SET @length = @length - 1	END	IF (@lettersExistsInSearchString <> 0 AND @mname IS NOT NULL)	BEGIN		INSERT @results SELECT @mname, 'Middle name'	END	SET @lettersExistsInSearchString = 1    FETCH NEXT FROM empMiddleNameCursor     INTO @mname  ENDCLOSE empMiddleNameCursorDEALLOCATE empMiddleNameCursor-- search in last names:DECLARE empLastNameCursor CURSOR READ_ONLY FOR  SELECT LastName FROM EmployeesOPEN empLastNameCursorDECLARE @lname nvarchar(50)FETCH NEXT FROM empLastNameCursor INTO @lnameWHILE @@FETCH_STATUS = 0  BEGIN    SET @length = LEN(@lname)	WHILE (@length > 0)	BEGIN		IF (CHARINDEX(SUBSTRING(@lname, @length, 1), @letters) <= 0)		BEGIN			SET @lettersExistsInSearchString = 0		END		SET @length = @length - 1	END	IF (@lettersExistsInSearchString <> 0 AND @lname IS NOT NULL)	BEGIN		INSERT @results SELECT @lname, 'Last name'	END	SET @lettersExistsInSearchString = 1    FETCH NEXT FROM empLastNameCursor     INTO @lname  ENDCLOSE empLastNameCursorDEALLOCATE empLastNameCursor-- search in town names:DECLARE townNameCursor CURSOR READ_ONLY FOR  SELECT Name FROM TownsOPEN townNameCursorDECLARE @tname nvarchar(50)FETCH NEXT FROM townNameCursor INTO @tnameWHILE @@FETCH_STATUS = 0  BEGIN    SET @length = LEN(@tname)	WHILE (@length > 0)	BEGIN		IF (CHARINDEX(SUBSTRING(@tname, @length, 1), @letters) <= 0)		BEGIN			SET @lettersExistsInSearchString = 0		END		SET @length = @length - 1	END	IF (@lettersExistsInSearchString <> 0 AND @tname IS NOT NULL)	BEGIN		INSERT @results SELECT @tname, 'Town name'	END	SET @lettersExistsInSearchString = 1    FETCH NEXT FROM townNameCursor     INTO @tname  ENDCLOSE townNameCursorDEALLOCATE townNameCursor

RETURN
END

-- test function:
SELECT * FROM dbo.ufn_SearchEmployeeAndTownNamesByGivenLettersSet('oistmiahf')