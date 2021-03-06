USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOAD_DATOS_CARTERA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LOAD_DATOS_CARTERA]
   (   @nIndicador      CHAR(1)
   ,   @nNumOperacion   NUMERIC(9)   
   ,   @oTicket         CHAR(1) = 'N'
   ,   @Validacion      INTEGER = 0
   )
AS
BEGIN

   SET NOCOUNT ON
   -- Validacion: Control de HOra del anticipo y aplicar según este bloqueado o no desdepues de la hora limite
   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) )
   -- select fechaliquidacion, * from cartera where fechaLiquidacion = '20150623'   
   -- SP_LOAD_DATOS_CARTERA '', 1181, 'N', 1
   IF @Validacion = 1
   BEGIN
      IF EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA_UNWIND WHERE numero_operacion = @nNumOperacion and FechaAnticipo = @dFechaProceso)
      BEGIN
         SELECT -1, 'Operación ha sido anticipada en el día. Debe anular anticipo anterior para poder anticipar.'
         RETURN
      END

      IF EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nNumOperacion 
	                                                     and FechaLiquidacion = @dFechaProceso	
														 and Estado = ''													 
														 )
       Begin
 			declare @Hora datetime
			declare @SobrePasaLimite varchar(1)
			declare @Bloqueado       varchar(1)
			declare @sHora           varchar(5)
			declare @valor           numeric(5)
			declare @valorSys        numeric(5)
			set @hora =  getdate()
			set @sHora = case when datepart( hour,  @hora ) <= 9 then '0' + convert(varchar(1), datepart( hour,  @hora ) )
							  else convert( varchar(2) , datepart( hour,  @hora ) ) end
						 + ':' + case when datepart( minute,  @hora ) <= 9 then '0' + convert(varchar(1), datepart( minute,  @hora ) )
							  else convert( varchar(2) , datepart( minute,  @hora ) ) end
			set @SobrePasaLimite = 'N'
			set @Bloqueado       = 'N'

			select @SobrePasaLimite = case when TG.tbValor < datepart( hour,  @hora ) * 100 + datepart( minute, @hora ) 
									  then
											  'S'        
									  else 
											  'N'
									  end
				 , 	@Bloqueado = case when Nemo = '1' then 'S' else 'N' end	
				 ,  @valor = TbValor	
				 ,  @valorSys = datepart( hour,  @hora ) * 100 + datepart( minute, @hora ) 			   
			from BacParamSuda.dbo.Tabla_general_detalle TG where tbcateg = 33

			--select '@valor -  @valor / 100' = convert( numeric(2),  @valor -  @valor / 100 * 100 )
	
				set @sHora = case when convert( numeric(2),  @valor / 100 ) < 10 then '0' + convert( varchar(1),  convert( numeric(1),  @valor / 100 ) ) 
															  else convert( varchar(2),  convert( numeric(2),  @valor / 100 ) )  end
								  + ':' +  case when convert(numeric(2), @valor -  @valor / 100 * 100 ) < 10 then '0' + convert( varchar(1), convert( numeric(1), @valor -  @valor / 100 * 100 ) )
															  else convert( varchar(2), convert( numeric(2), @valor - @valor / 100 * 100 ) )  end 
            
			if @SobrePasaLimite = 'S' and @Bloqueado = 'S'
			Begin
				  BEGIN
					 SELECT -1, 'HORA MAX Sobrepasada ' + @sHora + ' Pedir Autorizacion a Control Op. '
					 RETURN
				  END
			end
      End


   END

   DECLARE @FlujoActivo     FLOAT
   DECLARE @FlujoPasivo     FLOAT

   -------------------------------------------
   -->    OPERACIONES TICKET INTRA MESA    <--
   -------------------------------------------

   IF @oTicket = 'S'
   BEGIN
      -->    Retorna la Cabecera de la Operacion
      IF @nIndicador = 'C'
      BEGIN
         DECLARE @nOperEspejo   NUMERIC(9)
             SET @nOperEspejo   = ISNULL((SELECT cart.numero_operacion_relacional 
                                     FROM BacSwapSuda.dbo.TBL_CARTICKETSWAP cart with(nolock)
                                    WHERE cart.numero_operacion = @nNumOperacion), 0)
         IF @nOperEspejo = 0
         BEGIN
            SET @nOperEspejo = ISNULL((SELECT cart.numero_operacion 
                                  FROM BacSwapSuda.dbo.TBL_CARTICKETSWAP cart with(nolock)
                                 WHERE cart.numero_operacion_relacional = @nNumOperacion), 0)
         END

         IF @nOperEspejo IS NULL
            SET @nOperEspejo = 0

         SELECT FechaAnticipo    = CONVERT(CHAR(10), @dFechaProceso, 103)
            ,   NumOperacion     = cart.numero_operacion
            ,   Modalidad        = CASE WHEN cart.Modalidad = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
            ,   Moneda           = 'CLP'
            ,   MarkToMarket     = (activo.AVR - pasivo.AVR)
            ,   CodMoneda        = 999
            --------------------------
            ,   CodModalidad     = cart.Modalidad
            ,   Espejo           = @nOperEspejo
         FROM   BacSwapSuda.dbo.TBL_CARTICKETSWAP cart
                INNER JOIN (SELECT Contrato  = flujo.numero_operacion
                                 ,  AVR       = SUM( ISNULL(flujo.Valor_Mercado_Activo_Mda_Val, 0.0) )
                            FROM   TBL_FLJTICKETSWAP flujo
                            WHERE  flujo.tipo_flujo = 1
                            GROUP BY flujo.numero_operacion) activo on activo.Contrato = numero_operacion
                INNER JOIN (SELECT Contrato  = flujo.numero_operacion
                                 ,  AVR       = SUM( ISNULL(flujo.Valor_Mercado_Pasivo_Mda_Val, 0.0) )
                            FROM   TBL_FLJTICKETSWAP flujo
                            WHERE  flujo.tipo_flujo = 2
                            GROUP BY flujo.numero_operacion) pasivo on pasivo.Contrato = numero_operacion
         WHERE  cart.numero_operacion = @nNumOperacion
      END

      -->    Retorna la Pata Pagamos del Swap
      IF @nIndicador = 'P'
      BEGIN
         SET @FlujoActivo = ISNULL((SELECT SUM( ISNULL(Valor_Mercado_Activo_Mda_Val, 0) ) 
                                      FROM BacSwapSuda.dbo.TBL_FLJTICKETSWAP
                                     WHERE numero_operacion = @nNumOperacion
                                       AND tipo_flujo       = 1), 0)

         IF @FlujoActivo IS NULL
            SET @FlujoActivo = 0

         SELECT /*001*/ Moneda           = mone.mnnemo
         ,      /*002*/ Monto            = cart.valor_nominal_compra
         ,      /*003*/ FrecPago         = pago.glosa
         ,      /*004*/ FrecCapital      = capt.glosa
         ,      /*005*/ Indicador        = Indi.tbglosa
         ,      /*006*/ ValorIndice      = cart.Tasa_Compra
         ,      /*007*/ Spreed           = 0.0
         ,      /*008*/ ConteoDias       = baas.glosa
         ,      /*009*/ Pagamos_Moneda   = paga.mnnemo
         ,      /*010*/ PagamosDocum     = docu.glosa
         ,      /*011*/ FechaInicio      = CONVERT(CHAR(10), cart.Fecha_Inicio_Compra, 103)
         ,      /*012*/ FechaTermino     = CONVERT(CHAR(10), cart.Fecha_Madurez_Compra,103)
         ,      /*013*/ MontoMtm         = @FlujoActivo
         ----------------------------------- -----------------------------------
         ,      /*014*/ CodMoneda        = mone.mncodmon
         ,      /*015*/ CodFrecPago      = pago.codigo
         ,      /*016*/ CodFrecCapital   = capt.codigo
         ,      /*017*/ CodIndicador     = Indi.tbcodigo1
         ,      /*018*/ DiasConteo       = CASE WHEN baas.base = 'A' THEN 365 ELSE baas.base END
         ,      /*019*/ Intercambio      = 0 --> IntercPrinc
         ,      /*020*/ PeriDias         = baas.base
         FROM   BacSwapSuda.dbo.TBL_CARTICKETSWAP                cart with(nolock) 
                LEFT JOIN BacParamSuda.dbo.MONEDA                mone with(nolock) ON mone.mncodmon = cart.moneda_compra
                LEFT JOIN BacParamSuda.dbo.MONEDA                paga with(nolock) ON paga.mncodmon = cart.Moneda_Pago_Compra
                LEFT JOIN bacParamSuda.dbo.FORMA_DE_PAGO         docu with(nolock) ON docu.codigo   = cart.Medio_Pago_Compra
                LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  pago with(nolock) ON pago.Tabla    = 1044 AND pago.codigo    = cart.Frecuencia_Pago_Compra
                LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  capt with(nolock) ON capt.Tabla    = 1043 AND capt.codigo    = cart.Frecuencia_Capital_Compra
                LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Indi with(nolock) ON Indi.tbcateg  = 1042 AND Indi.tbcodigo1 = cart.Indicador_Compra
                LEFT JOIN BacSwapSuda.dbo.BASE                   baas with(nolock) ON baas.codigo   = cart.Conteo_Dias_Compra
         WHERE  cart.numero_operacion    = @nNumOperacion
      END

      -->    Retorna la Pata Recibimos del Swap
      IF @nIndicador = 'R'
      BEGIN 
         SET @FlujoPasivo = ISNULL((SELECT SUM( ISNULL(Valor_Mercado_Pasivo_Mda_Val, 0)) 
                                      FROM BacSwapSuda.dbo.TBL_FLJTICKETSWAP
                                     WHERE numero_operacion = @nNumOperacion
                                       AND tipo_flujo       = 2), 0)
         IF @FlujoPasivo IS NULL
            SET @FlujoPasivo = 0

         SELECT /*001*/ Moneda           = mone.mnnemo
         ,      /*002*/ Monto            = cart.valor_nominal_venta
         ,      /*003*/ FrecPago         = pago.glosa
         ,      /*004*/ FrecCapital      = capt.glosa
         ,      /*005*/ Indicador        = Indi.tbglosa
         ,      /*006*/ ValorIndice      = cart.Tasa_Venta
         ,      /*007*/ Spreed           = 0.0
         ,      /*008*/ ConteoDias       = baas.glosa
         ,      /*009*/ Pagamos_Moneda   = paga.mnnemo
         ,      /*010*/ PagamosDocum     = docu.glosa
         ,      /*011*/ FechaInicio      = CONVERT(CHAR(10), cart.Fecha_Inicio_venta, 103)
         ,      /*012*/ FechaTermino     = CONVERT(CHAR(10), cart.Fecha_Madurez_venta,103)
         ,      /*013*/ MontoMtm         = @FlujoPasivo
         ----------------------------------- -----------------------------------
         ,      /*014*/ CodMoneda        = mone.mncodmon
         ,      /*015*/ CodFrecPago      = pago.codigo
         ,      /*016*/ CodFrecCapital   = capt.codigo
         ,      /*017*/ CodIndicador     = Indi.tbcodigo1
         ,      /*018*/ DiasConteo       = CASE WHEN baas.base = 'A' THEN 365 ELSE baas.base END
         ,      /*019*/ Intercambio      = 0 --> IntercPrinc
         ,      /*020*/ PeriDias         = baas.base
         FROM   BacSwapSuda.dbo.TBL_CARTICKETSWAP                cart with(nolock) 
                LEFT JOIN BacParamSuda.dbo.MONEDA                mone with(nolock) ON mone.mncodmon = cart.moneda_venta
                LEFT JOIN BacParamSuda.dbo.MONEDA                paga with(nolock) ON paga.mncodmon = cart.Moneda_Pago_venta 
                LEFT JOIN bacParamSuda.dbo.FORMA_DE_PAGO         docu with(nolock) ON docu.codigo   = cart.Medio_Pago_venta
                LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  pago with(nolock) ON pago.Tabla    = 1044 AND pago.codigo    = cart.Frecuencia_Pago_venta
                LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  capt with(nolock) ON capt.Tabla    = 1043 AND capt.codigo    = cart.Frecuencia_Capital_venta
                LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Indi with(nolock) ON Indi.tbcateg  = 1042 AND Indi.tbcodigo1 = cart.Indicador_venta
                LEFT JOIN BacSwapSuda.dbo.BASE                   baas with(nolock) ON baas.codigo   = cart.Conteo_Dias_venta
         WHERE  cart.numero_operacion    = @nNumOperacion
      END

      RETURN
   END


   -------------------------------------------
   -->    OPERACIONES NORMALES O CARTERA   <--
   -------------------------------------------

   -->    Retorna la Cabecera de la Operacion
   IF @nIndicador = 'C'
   BEGIN
      SELECT FechaAnticipo    = CONVERT(CHAR(10), @dFechaProceso, 103)
         ,   NumOperacion     = numero_operacion
         ,   Modalidad        = CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
         ,   Moneda           = 'CLP'
         ,   MarkToMarket     = valor_razonableclp
         ,   CodMoneda        = 999
         --------------------------
         ,   CodModalidad     = modalidad_pago
        FROM BacSwapSuda.dbo.CARTERA with(nolock) 
       WHERE numero_operacion = @nNumOperacion
         AND tipo_flujo       = 1
         AND numero_flujo     = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA with(nolock) 
                                                         WHERE numero_operacion  = @nNumOperacion
                                                           AND tipo_flujo        = 1)


         
   END

   -->    Retorna la Pata Pagamos del Swap
   IF @nIndicador = 'P'
   BEGIN
      SET @FlujoActivo = ISNULL((SELECT SUM( ISNULL(Activo_FlujoCLP, 0) ) FROM BacSwapSuda.dbo.CARTERA with(nolock) 
                                                       WHERE numero_operacion  = @nNumOperacion
                                                         AND tipo_flujo        = 1), 0.0)
      IF @FlujoActivo IS NULL
         SET @FlujoActivo = 0

      SELECT /*001*/ Moneda           = mone.mnnemo
         ,   /*002*/ Monto            = cart.compra_capital
         ,   /*003*/ FrecPago         = pago.glosa
         ,   /*004*/ FrecCapital      = capt.glosa
         ,   /*005*/ Indicador        = Indi.tbglosa
         ,   /*006*/ ValorIndice      = cart.compra_valor_tasa
         ,   /*007*/ Spreed           = cart.compra_spread
         ,   /*008*/ ConteoDias       = baas.glosa
         ,   /*009*/ Pagamos_Moneda   = paga.mnnemo
         ,   /*010*/ PagamosDocum     = docu.glosa
         ,   /*011*/ FechaInicio      = CONVERT(CHAR(10), cart.fecha_inicio, 103)
         ,   /*012*/ FechaTermino     = CONVERT(CHAR(10), cart.fecha_termino,103)
         ,   /*013*/ MontoMtm         = @FlujoActivo
         -----------------------------------
         ,   /*014*/ CodMoneda        = mone.mncodmon
         ,   /*015*/ CodFrecPago      = pago.codigo
         ,   /*016*/ CodFrecCapital   = capt.codigo
         ,   /*017*/ CodIndicador     = Indi.tbcodigo1
         ,   /*018*/ DiasConteo       = CASE WHEN baas.base = 'A' THEN 365 ELSE baas.base END
         ,   /*019*/ Intercambio      = IntercPrinc
         ,   /*020*/ PeriDias         = baas.base
        FROM BacSwapSuda.dbo.CARTERA                          cart with(nolock) 
             LEFT JOIN BacParamSuda.dbo.MONEDA                mone with(nolock) ON mone.mncodmon = cart.compra_moneda
             LEFT JOIN BacParamSuda.dbo.MONEDA                paga with(nolock) ON paga.mncodmon = cart.recibimos_moneda
             LEFT JOIN bacParamSuda.dbo.FORMA_DE_PAGO         docu with(nolock) ON docu.codigo   = cart.recibimos_documento
             LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  pago with(nolock) ON pago.Tabla    = 1044 AND pago.codigo    = cart.compra_codamo_interes
             LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  capt with(nolock) ON capt.Tabla    = 1043 AND capt.codigo    = cart.compra_codamo_capital
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Indi with(nolock) ON Indi.tbcateg  = 1042 AND Indi.tbcodigo1 = cart.compra_codigo_tasa
             LEFT JOIN BacSwapSuda.dbo.BASE                   baas with(nolock) ON baas.codigo   = cart.compra_base
       WHERE cart.numero_operacion = @nNumOperacion
         AND cart.tipo_flujo       = 1
         AND cart.numero_flujo     = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA with(nolock) 
                                                              WHERE numero_operacion  = @nNumOperacion
                                                                AND tipo_flujo        = 1)
   END

   -->    Retorna la Pata Recibimos del Swap
   IF @nIndicador = 'R'
   BEGIN 
      SET @FlujoPasivo    = ISNULL((SELECT SUM( ISNULL(Pasivo_FlujoCLP, 0) ) FROM BacSwapSuda.dbo.CARTERA with(nolock) 
                                                              WHERE numero_operacion  = @nNumOperacion
                                                                AND tipo_flujo        = 2), 0.0)
      IF @FlujoPasivo IS NULL
         SET @FlujoPasivo = 0

      SELECT /*001*/ Moneda           = mone.mnnemo
         ,   /*002*/ Monto            = venta_capital
         ,   /*003*/ FrecPago         = pago.glosa
         ,   /*004*/ FrecCapital      = capt.glosa
         ,   /*005*/ Indicador        = Indi.tbglosa
         ,   /*006*/ ValorIndice      = venta_valor_tasa
         ,   /*007*/ Spreed           = venta_spread
         ,   /*008*/ ConteoDias       = baas.glosa
         ,   /*009*/ Pagamos_Moneda   = paga.mnnemo
         ,   /*010*/ PagamosDocum     = docu.glosa
         ,   /*011*/ FechaInicio      = CONVERT(CHAR(10), fecha_inicio, 103)
         ,   /*012*/ FechaTermino     = CONVERT(CHAR(10), fecha_termino,103)
         ,   /*013*/ MontoMtm         = @FlujoPasivo
         -----------------------------------
         ,   /*014*/ CodMoneda        = mone.mncodmon
         ,   /*015*/ CodFrecPago      = pago.codigo
         ,   /*016*/ CodFrecCapital   = capt.codigo
         ,   /*017*/ CodIndicador     = Indi.tbcodigo1
         ,   /*018*/ DiasConteo       = CASE WHEN baas.base = 'A' THEN 365 ELSE baas.base END
         ,   /*019*/ Intercambio      = IntercPrinc
         ,   /*020*/ PeriDias         = baas.base
        FROM BacSwapSuda.dbo.CARTERA                          cart with(nolock) 
             LEFT JOIN BacParamSuda.dbo.MONEDA                mone with(nolock) ON mone.mncodmon = cart.venta_moneda
             LEFT JOIN BacParamSuda.dbo.MONEDA                paga with(nolock) ON paga.mncodmon = cart.pagamos_moneda
             LEFT JOIN bacParamSuda.dbo.FORMA_DE_PAGO         docu with(nolock) ON docu.codigo   = cart.pagamos_documento
             LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  pago with(nolock) ON pago.Tabla    = 1044 AND pago.codigo    = cart.venta_codamo_interes
             LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  capt with(nolock) ON capt.Tabla    = 1043 AND capt.codigo    = cart.venta_codamo_capital
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Indi with(nolock) ON Indi.tbcateg  = 1042 AND Indi.tbcodigo1 = cart.venta_codigo_tasa
             LEFT JOIN BacSwapSuda.dbo.BASE                   baas with(nolock) ON baas.codigo = cart.venta_base
       WHERE cart.numero_operacion = @nNumOperacion
         AND cart.tipo_flujo       = 2
         AND cart.numero_flujo     = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA with(nolock) 
                                                              WHERE numero_operacion  = @nNumOperacion
                                                                AND tipo_flujo        = 2)
   END

END

GO
