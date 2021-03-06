USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RET_DATOS_MODIFICACIONES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RET_DATOS_MODIFICACIONES]
		(
			 @Modulo	CHAR(3)
			,@NumOper	NUMERIC(10, 0)
			,@antFolio	NUMERIC(10, 0)
			,@selFolio	NUMERIC(10, 0)	
		)
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @MaxCorr  NUMERIC(10, 0)
		,	@Contador NUMERIC(10, 0)

	CREATE TABLE #TblComparaMods(
		Correlativo	NUMERIC(9,0),
		Item VARCHAR(50),
		DatosOriginales VARCHAR(255),
		DatosNuevos VARCHAR(255),
		FechaMod DATETIME,
		Iguales CHAR(1) )

	IF @antFolio = 0	---> Traer los datos de la operación original y dejarla en campo DatosOriginales
		INSERT INTO #TblComparaMods(Correlativo, Item, DatosOriginales, FechaMod, Iguales)
		SELECT Correlativo,
		Item,
		DatosOriginales,		---> solo para la operacion original
		'19000101',				---> No hay modificacion
		'N'						---> asumo distintos
		FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
		WHERE Modulo = @Modulo
		AND FolioContrato = @NumOper
		AND FolioModificacion = @antFolio
	ELSE
		INSERT INTO #TblComparaMods(Correlativo, Item, DatosOriginales, FechaMod, Iguales)
		SELECT Correlativo,
		Item,
		DatosNuevos,	---> resto de las operaciones
		FechaModificacion,
		'N'				---> asumo distintos
		FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
		WHERE Modulo = @Modulo
		AND FolioContrato = @NumOper
		AND FolioModificacion = @antFolio

	--> Ahora, actualizar el temporal con los datos de @selFolio y dejarla en campo DatosNuevos
	UPDATE #TblComparaMods
	SET #TblComparaMods.DatosNuevos = sel.DatosNuevos,
		#TblComparaMods.FechaMod = sel.FechaModificacion	---> La fecha de modif. que cuenta es la de la op. sel.
	FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES sel
	WHERE sel.Modulo = @Modulo
	AND sel.FolioContrato = @NumOper
	AND sel.Correlativo = #TblComparaMods.Correlativo
	AND sel.Item = #TblComparaMods.Item
	AND sel.FolioModificacion = @selFolio

	SELECT @MaxCorr = MAX(Correlativo) FROM #TblComparaMods

	SELECT @Contador = 1
	WHILE @Contador <= @MaxCorr
	BEGIN
		UPDATE #TblComparaMods
		SET Iguales = 'S'
		WHERE DatosOriginales = DatosNuevos
		AND Correlativo = @Contador
		
		SELECT @Contador = @Contador + 1
	END

	SELECT * FROM #TblComparaMods

	DROP TABLE #TblComparaMods

	SET NOCOUNT OFF	
	
END
GO
