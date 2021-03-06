USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_BisiestosAcumulados]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Fx_BisiestosAcumulados]( @f1 DATETIME, @F2 DATETIME)
RETURNS numeric(10)
BEGIN
    -- Para querytear
	-- declare @f1 datetime = '20170919' , @f2 datetime = '20240724'
	DECLARE @ano numeric(4)
	DECLARE @CntBisietos numeric(4) = 0
    DECLARE @fecha_i datetime =  @f1 
	DECLARE @fecha   datetime
	DECLARE @fecha2  datetime
	WHILE @fecha_i <= @F2
	BEGIN
	    SELECT @fecha = DATEADD( DD, 1, CONVERT( DATETIME, CONVERT( VARCHAR(4), YEAR(@fecha_i) ) + '0228' ) )
		IF MONTH( @fecha ) = 2 -- Es biciesto
		BEGIN
			IF @fecha >= @f1 and @fecha < @f2
			BEGIN
				SELECT @CntBisietos = @CntBisietos + 1
			END
		END
		SELECT @fecha_i = CONVERT( DATETIME, CONVERT( VARCHAR(4), YEAR(@fecha_i) + 1 ) + '0228' )
	END

	RETURN(@CntBisietos)
END
GO
