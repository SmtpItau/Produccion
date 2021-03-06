USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETA_TICKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_PAPELETA_TICKET]
	( @iNumeroOperacion   NUMERIC(9)
	, @cUsuario           VARCHAR(15) )
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @iInvierte      INTEGER
	SELECT  @iInvierte      = 0

	DECLARE	@FechaProceso   CHAR(10)
		, @FechaEmision   CHAR(10)
		, @HoraEmision    CHAR(10)

	SELECT	@FechaProceso	= CONVERT(CHAR(10),fechaproc,103)
		, @FechaEmision	= CONVERT(CHAR(10),GetDate(),103)
		, @HoraEmision	= CONVERT(CHAR(10),GetDate(),108)
	FROM	SWAPGENERAL

	DECLARE @FlujoAdicionalActivo float

	DECLARE @FlujoAdicionalPasivo float,
		@sFormaPagoCompra	char(50),
		@sFormaPagoVenta	char(50),
		@sCarteraOrigen		char(50),
		@sCarteraDestino	char(50),
		@sMesaOrigen		char(50),
		@sMesaDestino		char(50),
		@Ticker			varchar,
		@Moneda_Pago_compra	char(50),
		@Moneda_Pago_Venta	char(50)

	SELECT  @FlujoAdicionalActivo = 560.23
	SELECT  @FlujoAdicionalPasivo = 565.08

	select	@sFormaPagoCompra = (SELECT glosa FROM BacParamSuda..FORMA_DE_PAGO WHERE codigo = Medio_Pago_Compra) ,
		@sFormaPagoVenta  = (SELECT glosa FROM BacParamSuda..FORMA_DE_PAGO WHERE codigo = Medio_Pago_Venta) ,
		@Moneda_Pago_compra	= (SELECT LTRIM(RTRIM(mnnemo)) + ' - ' + LTRIM(RTRIM(mnglosa)) 
					FROM BacParamSuda..MONEDA               WHERE  mncodmon = Moneda_Pago_compra),
		@Moneda_Pago_Venta	=(SELECT LTRIM(RTRIM(mnnemo)) + ' - ' + LTRIM(RTRIM(mnglosa)) 
					FROM BacParamSuda..MONEDA               WHERE  mncodmon = Moneda_Pago_venta) ,
		@sCarteraOrigen		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
							WHERE 	rcsistema		= 'PCS'
							AND	RCCODPRO		= 'FR'
					and	rcrut			=a.CodCarteraOrigen),'No Especificado')),
		@sMesaOrigen		= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
							  WHERE 	tbcodigo1=a.CodMesaOrigen),'No Especificado')),
		@sCarteraDestino	= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
							WHERE 	rcsistema		= 'PCS'
							AND	RCCODPRO		= 'FR'
								and	rcrut			=a.CodCarteraDestino),'No Especificado')),
		@sMesaDestino		= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
					  WHERE 	tbcodigo1=a.CodMesaDestino),'No Especificado')),
		@Ticker			= a.ticker

	FROM	TBL_CARTICKETSWAP a
	WHERE	numero_operacion = @iNumeroOperacion

	SELECT	* 
	INTO	#Cartera
	FROM	TBL_FLJTICKETSWAP
	WHERE	numero_operacion = @iNumeroOperacion 

	SELECT DISTINCT 
			 'MonedaCompra'			= LTRIM(RTRIM(m.mnnemo)) + ' - ' + LTRIM(RTRIM(m.mnglosa))
			, 'NocionalesCompra'		= CONVERT(NUMERIC(21,4),compra_capital)
			, 'IndicadorCompra'		= CONVERT(CHAR(10),tbglosa)
			, 'TasaCompra'			= CONVERT(NUMERIC(21,5),compra_valor_tasa)
			, 'SpreadCompra'		= CONVERT(NUMERIC(21,5),compra_spread)
			, 'FrecPagoCompra'		= CONVERT(CHAR(10),i.glosa)
			, 'FrecCapitalCompra'		= CONVERT(CHAR(10),ii.glosa)
			, 'ConteoDiasCompra'		= CONVERT(CHAR(10),b.glosa)
			, 'FecEfectivaCompra'		= CONVERT(CHAR(10),FechaEfectiva,103)
			, 'FecPrimerPagoCompra'		= CONVERT(CHAR(10),FechaPrimerPago,103)
			, 'FecPenultimoPagoCompra'	= CONVERT(CHAR(10),FechaPenultimoPago,103)
			, 'FecMadurezCompra'		= CONVERT(CHAR(10),FechaMadurez,103)
			, 'MonedaPagoCompra'		= @Moneda_Pago_compra
			, 'MedioPagoCompra'		= @sFormaPagoCompra
			, 'FeriadoVctoCompra'		= CASE WHEN FeriadoFlujoChile  = 1 THEN '- CHI ' ELSE '' END
							+ CASE WHEN FeriadoFlujoEEUU   = 1 THEN '- USA ' ELSE '' END
							+ CASE WHEN FeriadoFlujoEnglan = 1 THEN '- ING ' ELSE '' END
			, 'FeriadoLiquCompra'		= CASE WHEN FeriadoLiquiChile  = 1 THEN '- CHI ' ELSE '' END
							+ CASE WHEN FeriadoLiquiEEUU   = 1 THEN '- USA ' ELSE '' END
							+ CASE WHEN FeriadoLiquiEnglan = 1 THEN '- ING ' ELSE '' END
			, 'DiasResetCompra'        = DiasReset
	INTO	#Compras
	FROM	#CARTERA
		LEFT JOIN BacParamSuda..MONEDA               m  ON m.mncodmon = compra_moneda 
	        LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE   ON tbcateg    = 1042  AND tbcodigo1 = compra_codigo_tasa
        	LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION i  ON i.sistema  = 'PCS' AND i.tabla   = 1044 AND i.codigo  = compra_codamo_interes
		LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION ii ON ii.sistema = 'PCS' AND ii.tabla  = 1043 AND ii.codigo = compra_codamo_capital
		LEFT JOIN BASE                               b  ON b.codigo   = compra_base
		LEFT JOIN BacParamSuda..MONEDA               p  ON p.mncodmon = compra_moneda
	WHERE	numero_operacion       = @iNumeroOperacion
	AND	tipo_flujo             = 1
	AND	numero_flujo           = (SELECT MIN(numero_flujo) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion and tipo_Flujo = 1)

	SELECT DISTINCT 
			'MonedaVenta'           = LTRIM(RTRIM(m.mnnemo)) + ' - ' + LTRIM(RTRIM(m.mnglosa))
			, 'NocionalesVenta'       = CONVERT(NUMERIC(21,4),venta_capital)
			, 'IndicadorVenta'        = CONVERT(CHAR(10),tbglosa)
			, 'TasaVenta'             = CONVERT(NUMERIC(21,5),venta_valor_tasa)
			, 'SpreadVenta'           = CONVERT(NUMERIC(21,5),venta_spread)
			, 'FrecPagoVenta'         = CONVERT(CHAR(10),i.glosa)
			, 'FrecCapitalVenta'      = CONVERT(CHAR(10),ii.glosa)
			, 'ConteoDiasVenta'       = CONVERT(CHAR(10),b.glosa)
			, 'FecEfectivaVenta'      = CONVERT(CHAR(10),FechaEfectiva,103)
			, 'FecPrimerPagoVenta'    = CONVERT(CHAR(10),FechaPrimerPago,103)
			, 'FecPenultimoPagoVenta' = CONVERT(CHAR(10),FechaPenultimoPago,103)
			, 'FecMadurezVenta'       = CONVERT(CHAR(10),FechaMadurez,103)
			, 'MonedaPagoVenta'       = @Moneda_Pago_Venta
			, 'MedioPagoVenta'        = @sFormaPagoVenta
			, 'FeriadoVctoVenta'      = CASE WHEN FeriadoFlujoChile  = 1 THEN '- CHI ' ELSE '' END
                        			    + CASE WHEN FeriadoFlujoEEUU   = 1 THEN '- USA ' ELSE '' END
		                                    + CASE WHEN FeriadoFlujoEnglan = 1 THEN '- ING ' ELSE '' END
			, 'FeriadoLiquVenta'      = CASE WHEN FeriadoLiquiChile  = 1 THEN '- CHI ' ELSE '' END
                 	       			    + CASE WHEN FeriadoLiquiEEUU   = 1 THEN '- USA ' ELSE '' END
		                                    + CASE WHEN FeriadoLiquiEnglan = 1 THEN '- ING ' ELSE '' END
			, 'DiasResetVenta'        = DiasReset
		INTO	#Ventas
		FROM	#CARTERA
		LEFT JOIN BacParamSuda..MONEDA               m  ON m.mncodmon = venta_moneda 
		LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE   ON tbcateg    = 1042  AND tbcodigo1 = venta_codigo_tasa
		LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION i  ON i.sistema  = 'PCS' AND i.tabla   = 1044 AND i.codigo  = venta_codamo_interes
		LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION ii ON ii.sistema = 'PCS' AND ii.tabla  = 1043 AND ii.codigo = venta_codamo_capital
		LEFT JOIN BASE                               b  ON b.codigo   = venta_base
		LEFT JOIN BacParamSuda..MONEDA               p  ON p.mncodmon = venta_moneda
		WHERE	numero_operacion       = @iNumeroOperacion
		AND	tipo_flujo             = 2
		AND	 numero_flujo           = (SELECT MIN(numero_flujo) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion and tipo_Flujo = 2)
--select * from #ventas

		SELECT	'NumeroOperacion'	= @iNumeroOperacion
			, 'tikker'	= @Ticker
			, #Compras.*
			, #Ventas.*
			, 'TipoFlujo'           = Tipo_Flujo
			, 'NumeroFlujo'         = numero_flujo
			, 'Fijacion'            = CONVERT(CHAR(10),fecha_fijacion_tasa,103)
			, 'Vencimiento'         = CONVERT(CHAR(10),fecha_vence_flujo,103)
			, 'Liquidacion'         = CONVERT(CHAR(10),FechaLiquidacion,103)
			, 'Interes'             = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_interes) 
						  WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_interes)
                        		          END
			, 'Amortizacion'        = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_amortiza)
						  WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_amortiza)
		                                  END
			, 'Saldo'               = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_saldo + compra_Amortiza)
						  WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_saldo + venta_Amortiza)
		                                  END
			, 'FechaProceso'        = @FechaProceso
			, 'FechaEmision'        = @FechaEmision
			, 'HoraEmision'         = @HoraEmision
			, 'Usuario'             = @cUsuario
			, 'TipoSwao'            = CASE WHEN tipo_swap = 1 THEN 'SWAP DE TASAS         '
						  WHEN tipo_swap = 2 THEN 'SWAP DE MONEDAS       '
						  WHEN tipo_swap = 3 THEN 'FORWARD RATE AGREEMENT'
		                                  WHEN tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA  '
                			          END
			, 'Modalidad'           = CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
			, 'CarteraOrigen'	= @sCarteraOrigen
			, 'MesaOrigen'		= @sMesaOrigen
			, 'CarteraDestino'	= @sCarteraDestino
			, 'MesaDestino'		= @sMesaDestino
			, 'tipoSwap'            = tipo_swap
			, 'tipo_operacion'      = CASE WHEN tipo_swap  = 3 AND tipo_operacion = 'P' THEN 'PRESTAMISTA'
						  WHEN tipo_swap  = 3 AND tipo_operacion = 'T' THEN 'TOMADOR'
						  WHEN tipo_swap <> 3 AND tipo_operacion = 'C' THEN 'COMPRA'
						  WHEN tipo_swap <> 3 AND tipo_operacion = 'V' THEN 'VENTA'
						  END
			,'modalidad_pago'      = CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION'
						 WHEN modalidad_pago = 'E' THEN 'ENTREGA FISICA'
						 END
			, 'Dias'                = datediff(day,FechaEfectiva,FechaMadurez)
			, 'FechaCierre'         = fecha_cierre
			, 'GuardadaComo'        = Estado
			, 'FlujoAdicional'      = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_Flujo_Adicional ) 
						  WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4), venta_Flujo_Adicional )
						  END
			,'Observaciones'	= Observaciones
		FROM	#CARTERA
			, #Compras
			, #Ventas
		WHERE  numero_operacion      = @iNumeroOperacion
		ORDER BY tipo_Flujo , numero_flujo
END
GO
