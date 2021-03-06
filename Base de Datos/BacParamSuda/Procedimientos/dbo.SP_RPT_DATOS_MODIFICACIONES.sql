USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_DATOS_MODIFICACIONES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RPT_DATOS_MODIFICACIONES]
		(
			 @FechaProc		VARCHAR(8)
			,@Usuario		VARCHAR(25) 
			,@Modulo		CHAR(3)
			,@NumOper		NUMERIC(10, 0)
			,@antFolio		NUMERIC(10, 0)
			,@selFolio		NUMERIC(10, 0)
			,@FechaIni		VARCHAR(8)
			,@FechaFin		VARCHAR(8)
			,@Origen		CHAR(1)			---> solo lo usa Opciones
			,@antPosicion	NUMERIC(10, 0)	---> solo lo usa Opciones
			,@selPosicion	NUMERIC(10, 0)	---> solo lo usa Opciones
		)

AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @MaxCorr  	NUMERIC(10, 0)
		,	@Contador 	NUMERIC(10, 0)
		,	@FecInicio	DATETIME
		,	@FecFinal	DATETIME
		,	@FecProceso	DATETIME
		,	@FecConsult DATETIME
	,	@fechaRex	DATETIME

	SELECT  @FecInicio = CONVERT(DATETIME, @FechaIni),
			@FecFinal  = CONVERT(DATETIME, @FechaFin),
			@FecProceso= CONVERT(DATETIME, @FechaProc)
				
	CREATE TABLE #TblComparaMods(
		Correlativo		NUMERIC(9,0),
		Item 			VARCHAR(50),
		DatosOriginales VARCHAR(255),
		DatosNuevos 	VARCHAR(255),
		FechaMod 		DATETIME,
		Iguales 		CHAR(1),
		FecProceso 		DATETIME,
		Usuario 		VARCHAR(25),
		FechaInicio 	DATETIME,
		FechaFinal		DATETIME,
		Modulo			CHAR(3)
			)
			
	IF @Modulo = 'BFW'
	BEGIN
		
		---SELECT 	@FecConsult= acfecproc FROM BacFwdsuda.dbo.MFAC
		SELECT @FecConsult = acfecproc FROM BacParamsuda.dbo.VIEW_MDAC with(nolock)	---> La fecha de Control Financiero
		
		IF @antFolio = 0	---> Traer los datos de la operación original y dejarla en campo DatosOriginales
			INSERT INTO #TblComparaMods(Correlativo, Item, DatosOriginales, FechaMod, Iguales, FecProceso, Usuario, FechaInicio, FechaFinal, Modulo)
			SELECT Correlativo,
			Item,
			DatosOriginales,		---> solo para la operacion original
			'19000101',				---> No hay modificacion
			'N',					---> asumo distintos
			@FecProceso,
			@Usuario,
			@FecInicio,
			@FecFinal,
			@Modulo
			FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
			WHERE Modulo = @Modulo
			AND FolioContrato = @NumOper
			AND FolioModificacion = @antFolio
		ELSE
			INSERT INTO #TblComparaMods(Correlativo, Item, DatosOriginales, FechaMod, Iguales, FecProceso, Usuario, FechaInicio, FechaFinal, Modulo)
			SELECT Correlativo,
			Item,
			DatosNuevos,	---> resto de las operaciones
			FechaModificacion,
			'N',			---> asumo distintos
			@FecProceso,
			@Usuario,
			@FecInicio,
			@FecFinal,
			@Modulo
			FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
			WHERE Modulo = @Modulo
			AND FolioContrato = @NumOper
			AND FolioModificacion = @antFolio

		--> Ahora, actualizar el temporal con los datos de @selFolio y dejarla en campo DatosNuevos
		UPDATE #TblComparaMods
		SET #TblComparaMods.DatosNuevos = sel.DatosNuevos
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
	END
	ELSE	---> O P C I O N E S
	BEGIN
		---SELECT 	@FecConsult= fechaproc FROM lnkOpc.CbMdbOpc.dbo.OPCIONESGENERAL
		
		SELECT @FecConsult = acfecproc FROM BacParamsuda.dbo.VIEW_MDAC with(nolock)	---> La fecha de Control Financiero

		--- Mando a grabar las operaciones con folios @antFolio y @selFolio
		EXEC BacParamsuda.dbo.SP_GRABA_OPER_MODIFICADAS_OPT @NumOper, @Origen, @antFolio, @selFolio, @antPosicion, @selPosicion

		/*
			Los Datos ahora están en UN SOLO registro
		*/
	
		INSERT INTO #TblComparaMods(Correlativo, Item, DatosOriginales, DatosNuevos, FechaMod, Iguales, FecProceso, Usuario, FechaInicio, FechaFinal, Modulo)

		SELECT Correlativo,
		Item,
		DatosOriginales,
		DatosNuevos,
		FechaModificacion,
		'N',			---> asumo distintos
		@FecProceso,
		@Usuario,
		@FecInicio,
		@FecFinal,
		@Modulo		
		
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
	END
	
	SELECT @fechaRex = CONVERT(DATETIME, RTRIM(LTRIM(DatosNuevos)),103)
	FROM #TblComparaMods
	WHERE Correlativo = 2

	IF @fechaRex = @FecConsult
	BEGIN
		UPDATE #TblComparaMods
		SET DatosOriginales = '0',
			DatosNuevos = '0'
		WHERE Correlativo = 22
	END

	SELECT * FROM #TblComparaMods
	
	DROP TABLE #TblComparaMods		
	SET NOCOUNT OFF	
	
END
GO
