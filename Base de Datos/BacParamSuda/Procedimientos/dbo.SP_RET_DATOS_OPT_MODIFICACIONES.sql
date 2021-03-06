USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RET_DATOS_OPT_MODIFICACIONES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RET_DATOS_OPT_MODIFICACIONES]
		(
			 @Modulo		CHAR(3)
			,@NumOper		NUMERIC(10, 0)	---> Número de la Operación
			,@Origen		CHAR(1)			---> M:Movimientos / H: Historicos
			,@antFolio		NUMERIC(10, 0)	---> folio real anterior
			,@selFolio		NUMERIC(10, 0)	---> folio real actual
			,@antPosicion	NUMERIC(10, 0)	---> posicion anterior en la combo
			,@selPosicion	NUMERIC(10, 0)	---> posicion actual en la combo
		)
AS 
BEGIN
	SET NOCOUNT ON

	DECLARE		@MaxCorr 	NUMERIC(10, 0)
		,		@FecConsult	DATETIME

	--- Mando a grabar las operaciones con folios @antFolio y @selFolio
	EXEC BacParamsuda.dbo.SP_GRABA_OPER_MODIFICADAS_OPT @NumOper, @Origen, @antFolio, @selFolio, @antPosicion, @selPosicion

	DECLARE 	@Contador NUMERIC(10, 0)

	---SELECT @FecConsult = fechaproc FROM lnkOpc.CbMdbOpc.dbo.OPCIONESGENERAL
	SELECT @FecConsult = acfecproc FROM BacParamsuda.dbo.VIEW_MDAC with(nolock)	--->  La de Control Financiero
	
	CREATE TABLE #TblComparaMods(
		Correlativo	NUMERIC(9,0),
		Item VARCHAR(50),
		DatosOriginales VARCHAR(255),
		DatosNuevos VARCHAR(255),
		FechaMod DATETIME,
		Iguales CHAR(1) )
/*
	Los Datos ahora están en UN SOLO registro
*/
		
	INSERT INTO #TblComparaMods(Correlativo, Item, DatosOriginales, DatosNuevos, FechaMod, Iguales)
	SELECT Correlativo,
	Item,
	DatosOriginales,
	DatosNuevos,
	FechaModificacion,
	'N'				---> asumo distintos
	FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT
	WHERE Modulo = @Modulo
	AND FolioContrato = @NumOper
	AND FolioModificacion = @selPosicion

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

	UPDATE #TblComparaMods
	SET DatosOriginales = '0',
		DatosNuevos = '0'
	WHERE FechaMod = @FecConsult
	AND Correlativo = 22
	
	SELECT * FROM #TblComparaMods

	DROP TABLE #TblComparaMods
	
END
GO
