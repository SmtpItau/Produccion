USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GRABA_GARANTIAS_FALTANTES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GRABA_GARANTIAS_FALTANTES]
AS
BEGIN

	SET NOCOUNT ON
	CREATE TABLE #tmpFaltantesGtia(
		Indice		NUMERIC(10) IDENTITY,
		FolioAsocia	NUMERIC(18),
		RutCliente	NUMERIC(9),
		CodCliente	NUMERIC(5)
				)
	CREATE TABLE #tmpGarantiasFaltantes(
		FolioAsocia	NUMERIC(18),
		NumGarantia	NUMERIC(10),
		RutCliente	NUMERIC(9),
		CodCliente	NUMERIC(5),
		FechaGtia	DATETIME,
		MontoFaltante	NUMERIC(18),
		MontoRequerido	NUMERIC(18) )

	INSERT INTO #tmpFaltantesGtia (FolioAsocia)

	SELECT DISTINCT FolioAsocia
	FROM tbl_gar_AsociacionGtia
	ORDER BY FolioAsocia ASC

	UPDATE #tmpFaltantesGtia
	SET RutCliente = ag.RutCliente,
	CodCliente = ag.CodCliente
	FROM BacParamSuda.dbo.tbl_gar_AsociacionGtia ag,
		#tmpFaltantesGtia fg
	WHERE fg.FolioAsocia = ag.FolioAsocia

	DECLARE	@aCubrir	NUMERIC(21),
	@Cubierto	NUMERIC(21),
	@Folio		NUMERIC(18),
	@RutCliente	NUMERIC(9),
	@CodCliente	NUMERIC(5),
	@contador	NUMERIC(10),
	@totReg		NUMERIC(10),
	@faltante	NUMERIC(21),
	@requerido	NUMERIC(21)

	SELECT 	@contador = 1,
		@totReg = COUNT(FolioAsocia) FROM #tmpFaltantesGtia

	WHILE @contador <= @totReg
	BEGIN
		SELECT @Folio = FolioAsocia,
		@RutCliente = RutCliente,
		@CodCliente = CodCliente
		FROM #tmpFaltantesGtia
		WHERE @contador = Indice	

		EXECUTE SP_GAR_CALCXCUBRIRGTIAS @Folio, @aCubrir OUTPUT, @Cubierto OUTPUT
		IF @Cubierto < @aCubrir
		BEGIN
			SELECT @faltante = @aCubrir - @Cubierto
			SELECT @requerido = ISNULL(MontoRequerido, @faltante)
			FROM BacParamSuda.dbo.tbl_gar_fRedondeo
			WHERE @faltante <= MontoFinal
			AND @faltante >= MontoInicio
		/*
			Agregar a #tmpGarantiasFaltantes la lista de las Garantías con FolioAsocia = @Folio
		*/
			INSERT INTO #tmpGarantiasFaltantes
			SELECT @Folio,
			ag.NumeroGarantia,
			ag.RutCliente,
			ag.CodCliente,
			mv.Fecha,
			@faltante,
			@requerido
			FROM BacParamSuda.dbo.tbl_gar_AsociacionGtia ag,
			BacParamSuda.dbo.tbl_mov_Garantia mv
			WHERE ag.FolioAsocia = @Folio
			AND ag.RutCliente = @RutCliente
			AND ag.CodCliente = @CodCliente
			AND mv.NumeroOperacion = ag.NumeroGarantia
			AND mv.RutCliente = @RutCliente
			AND mv.CodCliente = @CodCliente
		END
		SELECT @contador = @contador + 1
	END  --- ciclo While
	INSERT INTO BacParamsuda.dbo.tbl_Garantias_Faltantes
	SELECT 	RutCliente,
		CodCliente,
		NumGarantia,
		FechaGtia,
		'N',
		MontoFaltante,
		MontoRequerido
	FROM #tmpGarantiasFaltantes

	DROP TABLE #tmpFaltantesGtia
	DROP TABLE #tmpGarantiasFaltantes
	SET NOCOUNT OFF
END
GO
