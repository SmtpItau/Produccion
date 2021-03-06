USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVOLVER_LINEAS_POR_NUMGARANTIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DEVOLVER_LINEAS_POR_NUMGARANTIA]
	(
		@numGar NUMERIC(18)
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	@FechaProc	DATETIME,
		@FechainiOp 	DATETIME,
		@nMonto		NUMERIC(19, 4),
		@FechavctoOp	DATETIME,
		@nRutEmi	NUMERIC(9),
		@nCodigo	NUMERIC(5),
		@i		NUMERIC(9),
		@nReg		NUMERIC(9),
		@resultado	VARCHAR(100)

	SELECT 	@FechaProc = acfecproc FROM BacTraderSuda..MDAC

	SELECT  @resultado ='OK'

	SELECT 	@FechainiOp = Fecha FROM BacParamSuda..tbl_mov_garantia
		WHERE NumeroOperacion = @numGar
		AND Estado = 'V'

	SELECT	@nReg = COUNT(*) FROM BacParamSuda..tbl_mov_garantia_detalle
		WHERE NumeroOperacion = @numGar
		AND RutEmision NOT IN (97023000, 97029000)		--- Excluir al banco y al BCCH
	IF @nReg > 0
	BEGIN
		CREATE TABLE #DetalleGar(indice NUMERIC(9) identity,
					 incodigo NUMERIC(5),
					 FechaIni DATETIME,
					 FechaVen DATETIME,
					 rutEmi NUMERIC(9),
					 nValorPte NUMERIC(19, 4) )
		INSERT INTO #DetalleGar
		SELECT 	Codigo,
		@FechainiOp,
		FechaVencimiento,
		RutEmision,
		ValorPresente
		FROM BacParamSuda..tbl_mov_garantia_detalle
		WHERE NumeroOperacion = @numGar
		AND RutEmision NOT IN (97023000, 97029000)		--- Excluir al banco y al BCCH

		SELECT @i = 1
		WHILE @i <= @nReg
		BEGIN
			SELECT 	@Fechainiop 	= FechaIni,
				@nMonto		= nValorPte,
				@FechavctoOp	= FechaVen,
				@nRutEmi	= rutEmi,
				@nCodigo	= incodigo
			FROM #DetalleGar
			WHERE @i = indice

			EXECUTE BacLineas.dbo.SP_LINEAS_DEVOLVER_GARANTIAS @FechaProc, @nRutEmi, @Fechainiop, @nMonto, @FechavctoOp, @nCodigo, @resultado OUTPUT
			IF SUBSTRING(@resultado, 1, 2) = 'NO'
				SELECT @i = @nReg	--- Salir del ciclo

			SELECT @i = @i + 1
		END
	END
	SELECT @resultado
	SET NOCOUNT OFF
END
GO
