USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESPALDOS_GARANTIAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RESPALDOS_GARANTIAS]
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @dFecpro DATETIME
	SELECT @dFecPro = acfecproc 
	FROM Bactradersuda..MDAC

	BEGIN TRANSACTION

	/* Primero, tbl_registro_garantias */
	IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_registro_garantias_his WHERE FechaRespaldo = @dFecPro)
		DELETE Bacparamsuda..tbl_registro_garantias_his WHERE FechaRespaldo = @dFecPro

	INSERT INTO Bacparamsuda..tbl_registro_garantias_his(NumeroOperacion, RutCliente,
				CodCliente, Sistema, OperacionSistema, FechaRespaldo)
	SELECT rg.NumeroOperacion, rg.RutCliente, rg.CodCliente, rg.Sistema, rg.OperacionSistema, @dFecPro
	FROM Bacparamsuda..tbl_registro_garantias rg

	IF @@ERROR <> 0
	BEGIN
		--SELECT 'Error al respaldar tbl_registro_garantias_his'
		ROLLBACK TRANSACTION
		RETURN
	END

	/* Segundo, tbl_cartera_garantia */
	IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_cartera_garantia_his WHERE FechaRespaldo = @dFecPro)
		DELETE Bacparamsuda..tbl_cartera_garantia_his WHERE FechaRespaldo = @dFecPro

	INSERT INTO Bacparamsuda..tbl_cartera_garantia_his(NumeroOperacion, Correlativo, Instrumento, Mascara,
				Nominal, TIR, VPAR, Vpvp, ValorPresente, ValorPresenteAyer, Duration,
				DurationMod, Convexidad, FechaRespaldo)
	SELECT cg.NumeroOperacion, cg.Correlativo, cg.Instrumento, cg.Mascara, cg.Nominal, cg.TIR, cg.VPAR, cg.Vpvp,
		cg.ValorPresente, cg.ValorPresenteAyer, cg.Duration, cg.DurationMod, cg.Convexidad, @dFecPro
	FROM Bacparamsuda..tbl_cartera_garantia cg

	IF @@ERROR <> 0
	BEGIN
		---SELECT 'Error al respaldar tbl_cartera_garantias_his'
		ROLLBACK TRANSACTION
		RETURN
	END

	/*  Tercero, tbl_garantias_otorgadas  */
	IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_garantias_otorgadas_his WHERE FechaRespaldo = @dFecPro)
		DELETE Bacparamsuda..tbl_garantias_otorgadas_his WHERE FechaRespaldo = @dFecPro

	INSERT INTO Bacparamsuda..tbl_garantias_otorgadas_his(Fecha, Folio, RutCliente, CodCliente, TipoGarantia,
					FechaVigencia, FechaRespaldo, FactorAditivo)
	SELECT go.Fecha, go.Folio, go.RutCliente, go.CodCliente, go.TipoGarantia, go.FechaVigencia, @dFecPro, go.FactorAditivo
	FROM Bacparamsuda..tbl_garantias_otorgadas go

	IF @@ERROR <> 0
	BEGIN
		---SELECT 'Error al respaldar tbl_garantias_otorgadas_his'
		ROLLBACK TRANSACTION
		RETURN
	END

	/* Cuarto, tbl_garantias_otorgadas_detalle  */
	IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_garantias_otorgadas_detalle_his WHERE FechaRespaldo = @dFecPro)
		DELETE Bacparamsuda..tbl_garantias_otorgadas_detalle_his WHERE FechaRespaldo = @dFecPro

	INSERT INTO Bacparamsuda..tbl_garantias_otorgadas_detalle_his(Folio, Numdocu, Correlativo, Nemotecnico, Nominal, 
					TIR, VPAR, ValorPresente, TirMercado, ValorMercado, FechaRespaldo, FactorMultiplicativo)
	SELECT god.Folio, god.Numdocu, god.Correlativo, god.Nemotecnico, god.Nominal, god.TIR, god.VPAR, god.ValorPresente,
					god.TirMercado, god.ValorMercado, @dFecPro, god.FactorMultiplicativo
	FROM Bacparamsuda..tbl_garantias_otorgadas_detalle god

	IF @@ERROR <> 0
	BEGIN
		---SELECT 'Error al respaldar tbl_garantias_otorgadas_detalle_his'
		ROLLBACK TRANSACTION
		RETURN
	END

	/* Quinto, tbl_mov_garantias_detalle */

	IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_mov_garantia_detalle_his WHERE FechaRespaldo = @dFecPro)
		DELETE Bacparamsuda..tbl_mov_garantia_detalle_his WHERE FechaRespaldo = @dFecPro

	INSERT INTO Bacparamsuda..tbl_mov_garantia_detalle_his(NumeroOperacion, Correlativo, Instrumento, Mascara, Codigo, 
					Seriado, FechaEmision, FechaVencimiento, MonedaEmision, BaseEmision, RutEmision, 
					Nominal, TIR, VPAR, Vpvp, ValorPresente, ValorPresenteAyer, Duration, DurationMod, 
					Convexidad, FechaRespaldo, FactorMultiplicativo)
	SELECT mgd.NumeroOperacion, mgd.Correlativo, mgd.Instrumento, mgd.Mascara, mgd.Codigo, mgd.Seriado, mgd.FechaEmision, 
					mgd.FechaVencimiento, mgd.MonedaEmision, mgd.BaseEmision, mgd.RutEmision, mgd.Nominal, 
					mgd.TIR, mgd.VPAR, mgd.Vpvp, mgd.ValorPresente, mgd.ValorPresenteAyer, mgd.Duration, 
					mgd.DurationMod, mgd.Convexidad, @dFecPro, mgd.FactorMultiplicativo
	FROM Bacparamsuda..tbl_mov_garantia_detalle mgd

	IF @@ERROR <> 0
	BEGIN
		---SELECT 'Error al respaldar tbl_mov_garantia_detalle_his'
		ROLLBACK TRANSACTION
		RETURN
	END
	
	COMMIT TRANSACTION

	SET NOCOUNT OFF
END
GO
