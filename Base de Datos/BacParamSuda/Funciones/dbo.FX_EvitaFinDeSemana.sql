USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FX_EvitaFinDeSemana]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[FX_EvitaFinDeSemana] (@Fecha DATETIME)

RETURNS DATETIME
AS
BEGIN
	
	/*
	SELECT dbo.FX_EvitaFinDeSemana ('20141010')
	*/
	
	DECLARE @FERIADO CHAR(1) = 'N'
		   ,@Hoy INT
	
	SET @Hoy = (SELECT DATEPART(WEEKDAY, @Fecha))
			
	IF @Hoy in (7, 1) SET @FERIADO = 'S'
	
	IF @FERIADO = 'S'
	BEGIN		
		WHILE @FERIADO = 'S'
		BEGIN
			SET @Hoy = (SELECT DATEPART(WEEKDAY, @Fecha))
			IF @Hoy in (7, 1)
			BEGIN
				SET @Fecha = DATEADD(DAY,1,@Fecha)	
			END 
			ELSE
				BEGIN 
					SET @FERIADO = 'N'
				END
		END
	END		
	
	RETURN (@Fecha)     
	
END/*
delete BacParamSuda.dbo.TBL_FestivosFijos where Fer_nemo = 'LM-11' and  Fer_Origen_Pais = 225
INSERT into BacParamSuda.dbo.TBL_FestivosFijos
 select  Fer_Origen_Pais = 225, Fer_Nemo = 'LM-11', 'Dia Elecciones', 0, 11, 'Martes despues primer Lunes', 3, 'Activo'
 */

GO
