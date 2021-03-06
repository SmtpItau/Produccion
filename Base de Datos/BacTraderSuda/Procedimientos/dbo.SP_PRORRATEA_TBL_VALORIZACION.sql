USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRORRATEA_TBL_VALORIZACION]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PRORRATEA_TBL_VALORIZACION]
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @nFactor	FLOAT
	DECLARE @nNominal	NUMERIC(21,4)
	DECLARE @tNominal	NUMERIC(21,4)
	DECLARE @nRegistro	NUMERIC(9)
	DECLARE @nFolioGar	NUMERIC(9)
	DECLARE @nCarreGar	NUMERIC(9)
	DECLARE @nFolioBac	NUMERIC(9)
	DECLARE @nCorreBac	NUMERIC(9)

	DECLARE @vCompra	NUMERIC(21,4)

	DECLARE Cursor_Actualizacion_Tbl_Valorizacion	SCROLL CURSOR FOR
	SELECT	Garantia_Numero
		,	Garantia_Correlativo
		,	NumeroDocumento
		,	CorrelativoDocumento
		,	Nominal
	FROM	bdbomesa.Garantia.Tbl_Valorizacion_Instrumento
	WHERE	Nominal				<> 0
	ORDER
	BY		NumeroDocumento
		,	CorrelativoDocumento

	OPEN Cursor_Actualizacion_Tbl_Valorizacion

	FETCH FIRST FROM Cursor_Actualizacion_Tbl_Valorizacion
	INTO 	@nFolioGar
		,	@nCarreGar
		,	@nFolioBac
		,	@nCorreBac
		,	@nNominal

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT	@tNominal				= Nominal
			,	@vCompra				= valorcompraum
		FROM	Tbl_Valorizacion_Instrumento_Agrupada
		WHERE	Garantia_Numero			= @nFolioGar
		AND		NumeroDocumento			= @nFolioBac
		AND		CorrelativoDocumento	= @nCorreBac

		SET		@nFactor				= (@nNominal / @tNominal)

		--------------------------------------------------------------------
		UPDATE	bdbomesa.Garantia.Tbl_Valorizacion_Instrumento
			SET	ValorProceso			= ROUND(@nFactor * GRUPO.VP,		0)
			,	ValorProxProceso		= ROUND(@nFactor * GRUPO.VPX,		0)
			,	CapitalCompra			= ROUND(@nFactor * GRUPO.KCompra,	0)
			,	InteresCompra			= ROUND(@nFactor * GRUPO.IntCompra, 0)
			,	ReajusteCompra			= ROUND(@nFactor * GRUPO.ReaCompra, 0)
			,	InteresAcumCp			= ROUND(@nFactor * GRUPO.IntAcumCp, 0)
			,	ReajusteAcumCp			= ROUND(@nFactor * GRUPO.ReaAcumCp, 0)
			,	ValorCompra				= ROUND(@nFactor * GRUPO.ValCompra, 0)
			,	ValorCompraUm			= ROUND(@nFactor * GRUPO.ValCompraUm, 4)     -- Respetar los decimales
			,	ValorCompraUm100		= ROUND(@nFactor * GRUPO.ValCompraUm100, 4)  -- Respetar los decimales
			,	ValorVencimiento		= ROUND(@nFactor * GRUPO.ValVencimiento, 0)
			,	Capital					= ROUND(@nFactor * GRUPO.KPTAL, 0)
			,	Interes					= ROUND(@nFactor * GRUPO.INTE, 0)
			,	Reajuste				= ROUND(@nFactor * GRUPO.REA, 0)
			,	Interes_Mes				= ROUND(@nFactor * GRUPO.INT_Mes, 0)
			,	Reajuste_Mes			= ROUND(@nFactor * GRUPO.REA_Mes, 0)
			,	Interes_Acum			= ROUND(@nFactor * GRUPO.INT_Acum, 0)
			,	Reajuste_Acum			= ROUND(@nFactor * GRUPO.REA_Acum, 0)
			,	Amortizacion			= ROUND(@nFactor * GRUPO.AMORTIZA, 0)
			,	InteresCupon			= ROUND(@nFactor * GRUPO.INTCupon, 0)
			,	ReajusteCupon			= ROUND(@nFactor * GRUPO.REACupon, 0)
			,	Flujo					= ROUND(@nFactor * GRUPO.FLJO, 0)
			,	PrimaDescuento			= ROUND(@nFactor * GRUPO.Prima, 0)
			,	ValorTasaEmision		= ROUND(@nFactor * GRUPO.ValTasEmi, 0)
			,	Valorcompraum_original	= ROUND(@nFactor * GRUPO.ValCompraum_org, 0)
			,	Valorcompraoriginal		= ROUND(@nFactor * GRUPO.ValCompraOrig, 0)
			,	ValorMercado			= ROUND(@nFactor * GRUPO.ValMerc, 0)
			,	DiferenciaMercado		= ROUND(@nFactor * GRUPO.DifMerc, 0)
		FROM	
			(	SELECT	FolioGar				= Garantia_Numero
					,	NumDocu					= NumeroDocumento
					,	Correlativo				= CorrelativoDocumento
					,	NOM						= Nominal
					,	VP						= ValorProceso
					,	VPX						= ValorProxProceso
					,	KCompra					= CapitalCompra
					,	IntCompra				= InteresCompra
					,	ReaCompra				= ReajusteCompra
					,	IntAcumCp				= InteresAcumCp
					,	ReaAcumCp				= ReajusteAcumCp
					,	ValCompra				= ValorCompra
					,	ValCompraUm				= ValorCompraUm
					,	ValCompraUm100			= ValorCompraUm100
					,	ValVencimiento			= ValorVencimiento
					,	KPTAL					= Capital
					,	INTE					= Interes
					,	REA						= Reajuste
					,	INT_Mes					= Interes_Mes
					,	REA_Mes					= Reajuste_Mes
					,	INT_Acum				= Interes_Acum
					,	REA_Acum				= Reajuste_Acum
					,	AMORTIZA				= Amortizacion
					,	INTCupon				= InteresCupon
					,	REACupon				= ReajusteCupon
					,	FLJO					= Flujo
					,	Prima					= PrimaDescuento
					,	ValTasEmi				= ValorTasaEmision
					,	ValCompraum_org			= Valorcompraum_original
					,	ValCompraOrig			= Valorcompraoriginal
					,	ValMerc					= ValorMercado
					,	DifMerc					= DiferenciaMercado
				FROM	Tbl_Valorizacion_Instrumento_Agrupada
				WHERE	Garantia_Numero			= @nFolioGar
				AND		NumeroDocumento			= @nFolioBac
				AND		CorrelativoDocumento	= @nCorreBac
			)	GRUPO
		WHERE	Garantia_Numero			= @nFolioGar
		AND		Garantia_Correlativo	= @nCarreGar
		AND		NumeroDocumento			= @nFolioBac
		AND		CorrelativoDocumento	= @nCorreBac

		AND		GRUPO.FolioGar			= Garantia_Numero
		AND		GRUPO.NumDocu			= NumeroDocumento
		AND		GRUPO.Correlativo		= CorrelativoDocumento

		FETCH NEXT FROM Cursor_Actualizacion_Tbl_Valorizacion
		INTO 	@nFolioGar
			,	@nCarreGar
			,	@nFolioBac
			,	@nCorreBac
			,	@nNominal
	END

	CLOSE Cursor_Actualizacion_Tbl_Valorizacion
	DEALLOCATE Cursor_Actualizacion_Tbl_Valorizacion

END

GO
