USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_ELIMINAR_PAIS]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_ELIMINAR_PAIS]
				(
				@codigo_pais	INT	,
				@cNombre	CHAR(50)
				)
AS BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	IF NOT EXISTS(SELECT codigo_pais FROM CORRESPONSAL WHERE codigo_pais = @codigo_pais) AND 
	   NOT EXISTS(SELECT codigo_pais FROM RIESGO_PAIS  WHERE codigo_pais = @codigo_pais) AND 
	   NOT EXISTS(SELECT codigo_pais FROM MONEDA	   WHERE codigo_pais = @codigo_pais) AND 
	   NOT EXISTS(SELECT clpais 	 FROM CLIENTE 	   WHERE clpais	     = @codigo_pais) BEGIN

		SELECT region = codigo_region 
		INTO #REGION
		FROM REGION WHERE codigo_pais = 5555

		SELECT Ciudad = codigo_Ciudad 
		INTO #CIUDAD
		FROM CIUDAD , #region 
		WHERE codigo_region = region

		SELECT Comuna = codigo_comuna 
		INTO #COMUNA
		FROM COMUNA , #CIudad
		WHERE codigo_ciudad = Ciudad

		DELETE COMUNA FROM #COMUNA WHERE Codigo_comuna = comuna 
		DELETE CIUDAD FROM #CIUDAD WHERE Codigo_ciudad = ciudad
		DELETE REGION  WHERE Codigo_pais = @codigo_pais
		DELETE PLAZA   WHERE codigo_pais = @codigo_pais
		DELETE FERIADO WHERE pais 	 = @codigo_pais
		DELETE PAIS    WHERE CODIGO_PAIS = @codigo_pais
	END ELSE
	BEGIN
	   SELECT 'RELACIONADA'
	END

END


GO
