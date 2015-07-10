CREATE FUNCTION fn_MountainsPeaksJSON() RETURNS nvarchar(max)
AS
BEGIN
	DECLARE @mountainsPeaksJSON nvarchar(max)
	SET @mountainsPeaksJSON = '{"mountains":['
	DECLARE @outerCount int = 0
	DECLARE @mountain nvarchar(50)
	DECLARE mountainsCursor CURSOR READ_ONLY FOR		SELECT MountainRange FROM Mountains --ORDER BY MountainRange		OPEN mountainsCursor	FETCH NEXT FROM mountainsCursor INTO @mountain

	WHILE @@FETCH_STATUS = 0		BEGIN
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
			DECLARE peaksCursor CURSOR READ_ONLY FOR			SELECT p.PeakName, p.Elevation FROM Peaks p				JOIN Mountains m ON p.MountainId = m.Id				WHERE m.MountainRange = @mountain				--ORDER BY p.PeakName								OPEN peaksCursor			FETCH NEXT FROM peaksCursor INTO @peakName, @peakElevation

			WHILE @@FETCH_STATUS = 0				BEGIN
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

			CLOSE peaksCursor			DEALLOCATE peaksCursor
				
			SET @mountainsPeaksJSON = @mountainsPeaksJSON + ']}'
			FETCH NEXT FROM mountainsCursor INTO @mountain
		END

	CLOSE mountainsCursor	DEALLOCATE mountainsCursor

	SET @mountainsPeaksJSON = @mountainsPeaksJSON + ']}'
	RETURN @mountainsPeaksJSON
END
GO

SELECT dbo.fn_MountainsPeaksJSON()