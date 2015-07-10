CREATE FUNCTION fn_MountainsPeaksJSON() RETURNS nvarchar(max)
AS
BEGIN
	DECLARE @mountainsPeaksJSON nvarchar(max)
	SET @mountainsPeaksJSON = '{"mountains":['
	DECLARE @outerCount int = 0
	DECLARE @mountain nvarchar(50)
	DECLARE mountainsCursor CURSOR READ_ONLY FOR

	WHILE @@FETCH_STATUS = 0
			DECLARE @innerCount int = 0
			IF @outerCount = 0
				BEGIN
					SET @mountainsPeaksJSON = @mountainsPeaksJSON + '{"name":"' + @mountain + '","peaks":['
					SET @outerCount = 1
				END
			ELSE
				BEGIN
					SET @mountainsPeaksJSON = @mountainsPeaksJSON + ',{"name":"' + @mountain + '","peaks":['
				END
			
			DECLARE @peakName nvarchar(50)
			DECLARE @peakElevation int
			DECLARE peaksCursor CURSOR READ_ONLY FOR

			WHILE @@FETCH_STATUS = 0
					IF @innerCount = 0
					BEGIN
						SET @mountainsPeaksJSON = @mountainsPeaksJSON + '{"name":"' + @peakName + '","elevation":' + CAST(@peakElevation as nvarchar(50))
						SET @innerCount = 1
					END
					ELSE
					BEGIN
						SET @mountainsPeaksJSON = @mountainsPeaksJSON + ',{"name":"' + @peakName + '","elevation":' + CAST(@peakElevation as nvarchar(50))
					END
					FETCH NEXT FROM peaksCursor INTO @peakName, @peakElevation

					SET @mountainsPeaksJSON = @mountainsPeaksJSON + '}'
				END

			CLOSE peaksCursor
				
			SET @mountainsPeaksJSON = @mountainsPeaksJSON + ']}'
			FETCH NEXT FROM mountainsCursor INTO @mountain
		END

	CLOSE mountainsCursor

	SET @mountainsPeaksJSON = @mountainsPeaksJSON + ']}'
	RETURN @mountainsPeaksJSON
END
GO

SELECT dbo.fn_MountainsPeaksJSON()