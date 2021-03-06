USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_BaseActualModAnual]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_BaseActualModAnual]( @f1 datetime, @F2 datetime)
	RETURNS NUMERIC(10)
BEGIN
    -- Si hay un 29 de Febrero anterior 
	-- a @f2 y que sea mayor a @f1
	-- se retorna 366.
	-- si no 365

	DECLARE @ano		NUMERIC(4)
	DECLARE @Retornar	NUMERIC(4) 
    DECLARE @fecha_i	DATETIME =  @f1 
	DECLARE @fecha		DATETIME
	DECLARE @fecha2		DATETIME

    SELECT @fecha = DATEADD( DD, 1, CONVERT( DATETIME, CONVERT( VARCHAR(4), YEAR(@F2) ) + '0228' ) ) -- '20160330', '20160731'
	IF MONTH( @fecha ) = 2 -- Bisiesto
		IF @fecha <= @F2 and @fecha >= @f1
		BEGIN
			SELECT @retornar = 366
		END
		ELSE
		    SELECT @retornar = 365
	ELSE
		IF @fecha > @f2
		BEGIN
			SELECT @fecha = DATEADD( DD, 1, CONVERT( DATETIME, CONVERT( VARCHAR(4), YEAR(@F2) - 1 ) + '0228' ) ) 
			IF MONTH( @fecha ) = 2 -- Bisiesto
			IF @fecha <= @F2 and @fecha >= @F1
				SELECT @retornar = 366
			ELSE
				 SELECT @retornar = 365
			ELSE
				 SELECT @retornar = 365
		END
		ELSE
		   SELECT @retornar = 365
	RETURN(@retornar)
END
GO
