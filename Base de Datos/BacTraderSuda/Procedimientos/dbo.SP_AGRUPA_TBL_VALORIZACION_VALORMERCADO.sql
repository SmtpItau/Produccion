USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AGRUPA_TBL_VALORIZACION_VALORMERCADO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AGRUPA_TBL_VALORIZACION_VALORMERCADO]
	(	@Serie		CHAR(12)
	,   @Emisor		CHAR(10)
	)
AS
BEGIN

	DELETE FROM Tbl_Valorizacion_Instrumento_Agrupada

	INSERT INTO Tbl_Valorizacion_Instrumento_Agrupada
	SELECT	Garantia_Numero			= val.Garantia_Numero
		,	NumeroDocumento			= val.NumeroDocumento
		,	CorrelativoDocumento	= val.CorrelativoDocumento
		,	Serie					= val.Serie
		,	Mascara					= val.Mascara
		,	Codigo					= val.Codigo
		,	Seriado					= val.Seriado
		,	Nominal					= SUM(val.Nominal )
		,	Tir						= val.Tir
		,	ValorProceso			= SUM( val.ValorProceso )
		,	ValorProxProceso		= SUM( val.ValorProxProceso )
		,	CapitalCompra			= SUM( val.CapitalCompra )
		,	InteresCompra			= SUM( val.InteresCompra )
		,	ReajusteCompra			= SUM( val.ReajusteCompra )
		,	InteresAcumCp			= SUM( val.InteresAcumCp )
		,	ReajusteAcumCp			= SUM( val.ReajusteAcumCp )
		,	ValorCompra				= SUM( val.ValorCompra )
		,	ValorCompraUm			= SUM( val.ValorCompraUm )
		,	ValorCompraUm100		= SUM( val.ValorCompraUm100 )
		,	ValorVencimiento		= SUM( val.ValorVencimiento )
		,	Capital					= SUM( val.Capital )
		,	Interes					= SUM( val.Interes )
		,	Reajuste				= SUM( val.Reajuste )
		,	Interes_Mes				= SUM( val.Interes_Mes )
		,	Reajuste_Mes			= SUM( val.Reajuste_Mes )
		,	Interes_Acum			= SUM( val.Interes_Acum )
		,	Reajuste_Acum			= SUM( val.Reajuste_Acum )
		,	Amortizacion			= SUM( val.Amortizacion )
		,	InteresCupon			= SUM( val.InteresCupon )
		,	ReajusteCupon			= SUM( val.ReajusteCupon )
		,	Flujo					= SUM( val.Flujo )
		,	PrimaDescuento			= SUM( val.PrimaDescuento )
		,	ValorTasaEmision		= SUM( val.ValorTasaEmision )
		,	Valorcompraum_original	= SUM( val.Valorcompraum_original )
		,	Valorcompraoriginal		= SUM( val.Valorcompraoriginal )
		,	TasaMercado				= 0.0	-->	val.TasaMercado
		,	ValorMercado			= SUM( val.ValorMercado )
		,	DiferenciaMercado		= SUM( val.DiferenciaMercado )
	FROM	bdbomesa.Garantia.TBL_CarteraGarantia						enc with(nolock)
			inner join bdbomesa.Garantia.TBL_DetalleCarteraGarantia		det with(nolock) On det.NumeroGarantia		 = enc.NumeroGarantia
			inner join bdbomesa.Garantia.Tbl_Valorizacion_Instrumento	val with(nolock) On val.Garantia_Numero		 = det.NumeroGarantia
																						and val.Garantia_Correlativo = det.CorrelativoGarantia
			inner join	
			(	select	cpnumdocu, cpcorrela, cpnominal, codigo_carterasuper, Fecha_PagoMañana
					,	genemi = Disp.digenemi
				from	BacTraderSuda.dbo.mdcp with(nolock)
						inner join 
						(	select	dinumdocu, dicorrela, digenemi
							from	BacTraderSuda.dbo.mddi with(nolock)
						)	Disp	On	Disp.dinumdocu	= cpnumdocu
									and	Disp.dicorrela	= cpcorrela
			)	cpBAC	On	cpBAC.cpnumdocu = NumeroDocumento
						and	cpBAC.cpcorrela	= CorrelativoDocumento

	WHERE	(		enc.TipoMovimiento	= '23'
	and		not (	det.Instrumento		= 'EFECTIVO'	)
			)
	and		det.Nominal					> 0		--> Indica que aun tene Instrumentos Vigenetes en Garantias
	and	(	val.Serie = @Serie and cpBAC.genemi = @Emisor	)
	GROUP 
	BY		val.Garantia_Numero
		,	val.NumeroDocumento
		,	val.CorrelativoDocumento
		,	val.Serie
		,	val.Mascara
		,	val.Codigo
		,	val.Seriado
		,	val.Tir
--		,	val.TasaMercado

END
GO
