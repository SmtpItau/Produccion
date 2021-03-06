USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONFIRMA_SWAP_ICP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_CONFIRMA_SWAP_ICP]      

   (   @iNumeroOperacion   NUMERIC(9)          

   ,   @cUsuario           VARCHAR(15)          

   )          

AS          

BEGIN          

   -- Swap: Mejora Confirmación          

   SET NOCOUNT ON          

          

   DECLARE @Entidad        CHAR(70)          

          ,@FAX            CHAR(20)           

          ,@Devengo        int  

          ,@fechaproc      datetime          

          

   DECLARE @iInvierte      INT  

   SELECT  @iInvierte      = 0          

          

   DECLARE @FechaProceso   CHAR(10)          

   ,       @FechaEmision   CHAR(10)          

   ,       @HoraEmision    CHAR(10)          

          

   SELECT  @FechaProceso   = CONVERT(CHAR(10),fechaproc,103)          

   ,       @fechaproc      = fechaproc          

   ,       @FechaEmision   = CONVERT(CHAR(10),GetDate(),103)          

   ,       @HoraEmision    = CONVERT(CHAR(10),GetDate(),108)          

   ,       @Entidad        = nombre          

   ,       @Fax            = fax          

   ,       @Devengo        = Devengo           

   FROM    SWAPGENERAL  
   
   select	@Entidad = razonsocial
   
   from		BacParamSuda.dbo.Contratos_ParametrosGenerales        

          

   DECLARE @FlujoAdicionalActivo float          

   select  @FlujoAdicionalActivo = 0.0 --> 560.23  

   DECLARE @FlujoAdicionalPasivo float          

   select  @FlujoAdicionalPasivo = 0.0 --> 565.08  

          

   select *           

   into #Cartera from cartera  where numero_operacion = @iNumeroOperacion           

          

   INSERT INTO #Cartera        

   select * from carterahis  where numero_operacion = @iNumeroOperacion         

        

   UPDATE #Cartera        

 SET #Cartera.car_Cartera_Normativa  = his.chi_Cartera_Normativa,        

  #Cartera.car_Libro     = his.chi_Libro,        

  #Cartera.car_area_Responsable  = his.chi_area_Responsable,        

  #Cartera.car_SubCartera_Normativa = his.chi_SubCartera_Normativa        

 FROM carterahis his        

 WHERE #Cartera.numero_operacion = his.numero_operacion        

          

   CREATE TABLE #Cabecera          

   (   NumOperacion      NUMERIC(9)          

   ,   RutCliente        VARCHAR(12)          

   ,   NomCliente        VARCHAR(60)      

   ,   Tikker            VARCHAR(20)          

   ,   vMercadoUsd       NUMERIC(21,4)          

   ,   vMercadoMx        NUMERIC(21,4)          

   ,   vRazAjusDo        NUMERIC(21,4)          

   ,   vRazAjusMn        NUMERIC(21,4)          

   ,   Fax_Cliente       VARCHAR(20)          

   )          

          

   SELECT @iInvierte       = 1          

   FROM   #CARTERA          

   WHERE  numero_operacion = @iNumeroOperacion          

   AND    tipo_operacion   = 'T'          

          

   INSERT INTO #Cabecera          

   SELECT DISTINCT          

          'NumOperacion' = Numero_Operacion          

   ,      'RutCliente'   = CONVERT(CHAR(12),REPLICATE(' ', 10 - LEN(LTRIM(RTRIM(Rut_Cliente)))) + LTRIM(RTRIM(Rut_Cliente)) + '-' + LTRIM(RTRIM(cldv)))          

   ,      'NomCliente'   = CONVERT(CHAR(60),clnombre)      

   ,      'Tikker'       = CONVERT(CHAR(20),LTRIM(RTRIM(Tikker)))          

   ,      'vMercadoUSD'  = (SELECT SUM(activo_usd_c08) - SUM(pasivo_usd_c08) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion)          

   ,      'vMercadoMx'   = (SELECT SUM(activo_clp_c08) - SUM(pasivo_clp_c08) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion)          

   ,      'vRazAdjusDo'  = Valor_RazonableUSD           

   ,      'vRazAdjusMn'  = Valor_RazonableCLP          

   ,      'Fax_Cliente'  = Clfax        

   FROM   #CARTERA          

          LEFT JOIN BacParamSuda..CLIENTE   ON clrut = rut_cliente AND clcodigo = codigo_cliente          

   LEFT JOIN BacParamSuda..MONEDA  m ON m.mncodmon = compra_moneda          

   WHERE  numero_operacion       = @iNumeroOperacion          

   AND    estado_flujo <> 2 --- Excluir los flujos vencidos cuyos Valores Razonables son distintos y duplican los movimientos        

          

   SELECT DISTINCT           

          'MonedaCompra'           = LTRIM(RTRIM(m.mnnemo)) + ' - ' + LTRIM(RTRIM(m.mnglosa))          

   ,      'NocionalesCompra'       = CONVERT(NUMERIC(21,4),  compra_capital           

           + case when @Devengo = 0 and fecha_Cierre = @fechaproc then compra_Flujo_Adicional else 0.0 end)  

   ,      'IndicadorCompra'        = ltrim( rtrim( CONVERT(CHAR(10),tbglosa) ) ) + case when compra_codigo_tasa <> 0 then ' + ' + convert( char(9) , Compra_Spread )  + ' %' else '' end          

   ,      'TasaCompra'             = CONVERT(NUMERIC(21,5),compra_valor_tasa)          

   ,      'SpreadCompra'           = CONVERT(NUMERIC(21,5),compra_spread)          

   ,      'FrecPagoCompra'         = CONVERT(CHAR(10),i.glosa)          

   ,      'FrecCapitalCompra'      = CONVERT(CHAR(10),ii.glosa)          

   ,      'ConteoDiasCompra'       = CONVERT(CHAR(10),b.glosa)          

   ,      'FecEfectivaCompra'      = CONVERT(CHAR(10),FechaEfectiva,103)          

   ,      'FecPrimerPagoCompra'    = CONVERT(CHAR(10),PrimerPago,103)          

   ,      'FecPenultimoPagoCompra' = CONVERT(CHAR(10),PenultimoPago,103)          

   ,      'FecMadurezCompra'       = CONVERT(CHAR(10),Madurez,103)          

   ,      'MonedaPagoCompra'       = LTRIM(RTRIM(p.mnnemo)) + ' - ' + LTRIM(RTRIM(p.mnglosa))          

   ,      'MedioPagoCompra'        = LTRIM(RTRIM(f.glosa))          

   ,      'FeriadoVctoCompra'      = CASE WHEN FeriadoFlujoChile  = 1 THEN '- CHI ' ELSE '' END          

                                   + CASE WHEN FeriadoFlujoEEUU   = 1 THEN '- USA ' ELSE '' END          

                                   + CASE WHEN FeriadoFlujoEnglan = 1 THEN '- ING ' ELSE '' END          

   ,      'FeriadoLiquCompra'      = CASE WHEN FeriadoLiquiChile  = 1 THEN '- CHI ' ELSE '' END          

                                   + CASE WHEN FeriadoLiquiEEUU   = 1 THEN '- USA ' ELSE '' END          

                                   + CASE WHEN FeriadoLiquiEnglan = 1 THEN '- ING ' ELSE '' END          

   ,      'AjustHabilesCompra'     = Convencion          

   ,      'ConvencionCompra'       = 'Normal - Adelante'          

   ,      'DiasResetCompra'        = DiasReset          

   ,      'MacaulayCompra'         = vDurMacaulActivo          

   ,      'ModificadaCompra'       = vDurModifiActivo          

   ,      'ConvexidadCompra'       = vDurConvexActivo          

   ,      'Pagador_Compra'         = tbglosa           

   ,      'EsFS_Activa'            = case when   fecha_fijacion_tasa > @fechaproc then 1 else 0 end           

   INTO   #Compras          

   FROM   #CARTERA          

  LEFT JOIN BacParamSuda..MONEDA               m  ON m.mncodmon = compra_moneda           

          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE   ON tbcateg    = 1042  AND tbcodigo1 = compra_codigo_tasa          

          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION i  ON i.sistema  = 'PCS' AND i.tabla   = 1044 AND i.codigo  = compra_codamo_interes          

          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION ii ON ii.sistema = 'PCS' AND ii.tabla  = 1043 AND ii.codigo = compra_codamo_capital          

          LEFT JOIN BASE                               b  ON b.codigo   = compra_base          

          LEFT JOIN BacParamSuda..MONEDA               p  ON p.mncodmon = recibimos_moneda          

          LEFT JOIN BacParamSuda..FORMA_DE_PAGO        f  ON f.codigo   = recibimos_documento          

   WHERE  numero_operacion       = @iNumeroOperacion          

   AND    tipo_flujo             = 1          

   AND    numero_flujo           = (SELECT MIN(numero_flujo) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion and tipo_Flujo = 1)          

          

   SELECT DISTINCT           

          'MonedaVenta'           = LTRIM(RTRIM(m.mnnemo)) + ' - ' + LTRIM(RTRIM(m.mnglosa))          

   ,      'NocionalesVenta'       = CONVERT(NUMERIC(21,4),venta_capital           

                                  + case when @Devengo = 0 and fecha_Cierre = @fechaproc then venta_Flujo_Adicional else 0.0 END )  

   ,      'IndicadorVenta'        = ltrim( rtrim( CONVERT(CHAR(10),tbglosa) ) ) + case when Venta_codigo_tasa <> 0 then  ' + ' + convert( char(9), Venta_Spread ) + ' %' else ' ' end           

   ,      'TasaVenta'             = CONVERT(NUMERIC(21,5),venta_valor_tasa)          

   ,      'SpreadVenta'           = CONVERT(NUMERIC(21,5),venta_spread)          

   ,      'FrecPagoVenta'         = CONVERT(CHAR(10),i.glosa)          

   ,      'FrecCapitalVenta'      = CONVERT(CHAR(10),ii.glosa)          

   ,      'ConteoDiasVenta'       = CONVERT(CHAR(10),b.glosa)          

   ,      'FecEfectivaVenta'      = CONVERT(CHAR(10),FechaEfectiva,103)          

   ,      'FecPrimerPagoVenta'    = CONVERT(CHAR(10),PrimerPago,103)          

   ,      'FecPenultimoPagoVenta' = CONVERT(CHAR(10),PenultimoPago,103)          

   ,      'FecMadurezVenta'       = CONVERT(CHAR(10),Madurez,103)          

   ,      'MonedaPagoVenta'       = LTRIM(RTRIM(p.mnnemo)) + ' - ' + LTRIM(RTRIM(p.mnglosa))          

   ,      'MedioPagoVenta'        = LTRIM(RTRIM(f.glosa))          

   ,      'FeriadoVctoVenta'      = CASE WHEN FeriadoFlujoChile  = 1 THEN '- CHI ' ELSE '' END          

                                  + CASE WHEN FeriadoFlujoEEUU   = 1 THEN '- USA ' ELSE '' END          

             + CASE WHEN FeriadoFlujoEnglan = 1 THEN '- ING ' ELSE '' END          

   ,      'FeriadoLiquVenta'      = CASE WHEN FeriadoLiquiChile  = 1 THEN '- CHI ' ELSE '' END          

                                  + CASE WHEN FeriadoLiquiEEUU   = 1 THEN '- USA ' ELSE '' END          

                                  + CASE WHEN FeriadoLiquiEnglan = 1 THEN '- ING ' ELSE '' END          

   ,      'AjustHabilesVenta'     = Convencion          

   ,      'ConvencionVenta'       = 'Normal - Adelante'          

   ,      'DiasResetVenta'        = DiasReset          

   ,      'MacaulayVenta'         = vDurMacaulPasivo          

   ,      'ModificadaVenta'       = vDurModifiPasivo          

   ,      'ConvexidadVenta'       = vDurConvexPasivo          

   ,      'Pagador_Venta'         = tbglosa           

   ,      'EsFS_Pasiva'           = case when   fecha_fijacion_tasa > @fechaproc then 1 else 0 end      

   INTO   #Ventas          

   FROM   #CARTERA          

          LEFT JOIN BacParamSuda..MONEDA               m  ON m.mncodmon = venta_moneda           

          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE   ON tbcateg    = 1042  AND tbcodigo1 = venta_codigo_tasa          

          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION i  ON i.sistema  = 'PCS' AND i.tabla   = 1044 AND i.codigo  = venta_codamo_interes          

          LEFT JOIN BacParamSuda..PERIODO_AMORTIZACION ii ON ii.sistema = 'PCS' AND ii.tabla  = 1043 AND ii.codigo = venta_codamo_capital          

          LEFT JOIN BASE                               b  ON b.codigo   = venta_base          

          LEFT JOIN BacParamSuda..MONEDA               p  ON p.mncodmon = pagamos_moneda          

          LEFT JOIN BacParamSuda..FORMA_DE_PAGO f  ON f.codigo   = pagamos_documento          

   WHERE  numero_operacion       = @iNumeroOperacion          

   AND    tipo_flujo             = 2          

   AND    numero_flujo           = (SELECT MIN(numero_flujo) FROM #CARTERA WHERE numero_operacion = @iNumeroOperacion and tipo_Flujo = 2)          

          

   IF @iInvierte = 1      

   BEGIN          

      SELECT * INTO #TEMP FROM #Compras          

          

      DELETE #Compras          

      INSERT INTO #Compras SELECT * FROM #Ventas          

                

      DELETE #Ventas          

      INSERT INTO #Ventas  SELECT * FROM #TEMP          

  END          

          

   DECLARE @Supervisor1     VARCHAR(20)          

   ,       @Supervisor2     VARCHAR(20)          

          

   SELECT  @Supervisor1     = ISNULL(Firma1,'')          

   ,       @Supervisor2     = ISNULL(Firma2,'')          

   FROM    BacLineas..DETALLE_APROBACIONES          

   WHERE   Numero_Operacion =  @iNumeroOperacion          

   AND     Id_Sistema       = 'PCS'            

          

    --> PRD 12712			

			

    DECLARE @ET_Periodicidad	CHAR(50)

    DECLARE @ContOper			INT

    DECLARE @IntNocionalesIni   CHAR(2)

    DECLARE @IntNocionalesFin   CHAR(2)



	SELECT @ET_Periodicidad     = CASE WHEN Periodicidad = 0 THEN 'NA' ELSE gd.tbglosa  END  

	  FROM cartera

	INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE gd ON Periodicidad = gd.tbcodigo1

	 WHERE numero_operacion     = @iNumeroOperacion   

	   AND gd.tbcateg           = 9920



	SELECT	@IntNocionalesIni = CASE WHEN InterNocIni = 0 THEN 'NO'

									 WHEN InterNocIni = 1 THEN 'SI'

								END

	,		@IntNocionalesFin = CASE WHEN InterNocFin = 0 THEN 'NO'

									 WHEN InterNocFin = 1 THEN 'SI'

								END

	  FROM	Cartera 

	 WHERE	numero_operacion = @iNumeroOperacion 

	   AND	numero_flujo     > 1 

	   AND	IntercPrinc      = 1

	

	

	--> Fin PRD 12712   

          

   SELECT #Cabecera.*          

   ,      #Compras.*          

   ,      #Ventas.*      

   ,      'TipoFlujo'           = Tipo_Flujo          

   ,      'NumeroFlujo'         = numero_flujo          

   ,      'Fijacion'            = CONVERT(CHAR(10),fecha_fijacion_tasa,103)          

   ,      'Vencimiento'   = CONVERT(CHAR(10),fecha_vence_flujo,103)          

   ,      'Liquidacion'         = CONVERT(CHAR(10),FechaLiquidacion,103)          

   ,      'Interes'             = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_interes)           

                                       WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_interes)          

                                  END  *           

                      Case when compra_codigo_tasa + venta_codigo_tasa <> 0  then 0          

                                       else 1 end           

   ,      'Amortizacion'        = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_amortiza)          

                                       WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_amortiza)          

                                  END          

   ,      'FlujoAdicional'      = Case when tipo_Flujo = 1 THEN compra_Flujo_Adicional else venta_Flujo_Adicional end           

   ,      'Saldo'               = CASE WHEN Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4),compra_saldo + compra_Amortiza)          

                                       WHEN Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4),venta_saldo + venta_Amortiza)          

                                  END          

   ,      'FechaProceso'        = @FechaProceso          

   ,      'FechaEmision'        = @FechaEmision          

   ,      'HoraEmision'         = @HoraEmision          

   ,      'Usuario' = @cUsuario          

   ,      'Estado'              = Estado_oper_lineas          

   ,      'TipoSwao'            = CASE WHEN tipo_swap = 1 THEN 'SWAP DE TASAS         '          

                                       WHEN tipo_swap = 2 THEN 'SWAP DE MONEDAS       '          

                                       WHEN tipo_swap = 3 THEN 'FORWARD RATE AGREEMENT'          

                                       WHEN tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA  '          

                                  END          

   ,      'Modalidad'           = CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END          

   ,      'CarteraFinanciera'   = Financiera.tbglosa          

   ,      'CarteraNormativa'    = Normativa.tbglosa          

   ,      'LibroNegociacion'    = Negociacion.tbglosa          

   ,      'AreaResponsalble'    = Responsable.tbglosa          

   ,      'SubCarteraNormativa' = SubCartera.tbglosa          

   ,      'Lineas'              = Observacion_Lineas          

   ,     'Limites'             = Observacion_Limites          

   ,      'Observaciones'       = CASE WHEN IntercPrinc = 1 THEN 'Operación afecta a Intercambio de Capital' + CHAR(10) + CHAR(13)           

                                       ELSE                      ''           

                                  END  + observaciones          

   ,      'Operador'            = ISNULL((SELECT Nombre FROM view_usuario WHERE operador = Usuario), '')          

   ,      'Supervisor1'         = @Supervisor1          

   ,      'Supervisor2'         = @Supervisor2          

   ,      'tipoSwap'            = tipo_swap          

   ,      'tipo_operacion'      = CASE WHEN tipo_swap  = 3 AND tipo_operacion = 'P' THEN 'PRESTAMISTA'          

                                       WHEN tipo_swap  = 3 AND tipo_operacion = 'T' THEN 'TOMADOR'          

                              WHEN tipo_swap <> 3 AND tipo_operacion = 'C' THEN 'COMPRA'          

                                       WHEN tipo_swap <> 3 AND tipo_operacion = 'V' THEN 'VENTA'          

                                  END          

  ,      'modalidad_pago'      = CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION'          

                                       WHEN modalidad_pago = 'E' THEN 'ENTREGA FISICA'          

           END          

   ,      'Dias'                = PlazoFlujo -- datediff(day,fecha_inicio_Flujo,Fecha_vence_Flujo)  -- PENDIENTE 30/...          

   ,      'FechaCierre'         = #CARTERA.FechaEfectiva -- fecha_cierre        

   ,      'Nombre_Entidad'      = @Entidad          

   ,      'Numero_FAX'          = @Fax          

   ,      Fecha_Proceso         = fechaproc          

   ,      PlazoOperacion        = DATEDIFF(DAY, FechaEfectiva, fecha_termino) --> DATEDIFF(DAY,fecha_Cierre, fecha_termino )  

   ,      IntercPrinc          

   ,      EsFS_Pasiva                     

   ,      EsFS_Activa            

   

      ,   'firmabanco'   = (select firma from bacparamsuda..reportes_firma where nombre_usuario = @cUsuario)  



   ,	'Usuario_Banco'		= (SELECT rtrim(ltrim(nombre)) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @cUsuario)

   --PRD 12712

   ,      'ET_Marca'            = bEarlyTermination

   ,      'ET_IdPeriodicidad'   = Periodicidad

   ,      'ET_Periodicidad'     = @ET_Periodicidad

   ,      'ET_FechaInicio'      = FechaInicio

   ,      'Plaza'               = 'Chile'  

   ,      'Inter_Noc_Ini'		= @IntNocionalesIni

   ,      'Inter_Noc_Fin'		= @IntNocionalesFin

   ,	  'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)

   --PRD 12712

   

            

   FROM   SwapGeneral, #CARTERA          

          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg  = 204  AND convert(int,Financiera.tbcodigo1)  = cartera_inversion          

          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg   = 1111 AND Normativa.tbcodigo1   = car_Cartera_Normativa          

          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Negociacion ON Negociacion.tbcateg = 1552 AND Negociacion.tbcodigo1 = car_Libro          

          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg = 1553 AND Responsable.tbcodigo1 = car_area_Responsable           

          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg  = 1554 AND SubCartera.tbcodigo1  = car_SubCartera_Normativa           

   ,      #Cabecera , #Compras , #Ventas          

   WHERE  #CARTERA.numero_operacion      = @iNumeroOperacion          

   AND    #CARTERA.numero_flujo > 1 

   ORDER BY tipo_Flujo , numero_flujo          

          

END


GO
