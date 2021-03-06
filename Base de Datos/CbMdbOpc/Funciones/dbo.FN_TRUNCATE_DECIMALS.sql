USE [CbMdbOpc]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TRUNCATE_DECIMALS]    Script Date: 16-05-2022 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[FN_TRUNCATE_DECIMALS] (@value float, @decimales INT)
RETURNS FLOAT
AS
BEGIN
	
    DECLARE @result   FLOAT

    IF (@value > 0)
    BEGIN
    	SET @result = FLOOR(@value * POWER(10, @decimales ) ) / POWER(10, @decimales)

    END ELSE
    BEGIN
    	SET @result = -FLOOR(-@value * POWER(10, @decimales ) ) / POWER(10, @decimales)

    END

    RETURN @result
	
END



GO
