USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_LIQUIDACION_FLUJOS_MULTIPLES_MAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------if exists( select (1) from sysobjects where name = 'GENERA_LIQUIDACION_FLUJOS_MULTIPLES' )
------    Drop Procedure GENERA_LIQUIDACION_FLUJOS_MULTIPLES
------GO
CREATE PROCEDURE [dbo].[GENERA_LIQUIDACION_FLUJOS_MULTIPLES_MAP]
   (   @Numero_Operacion    NUMERIC(9)    
   ,   @FechaDesde          DATETIME    
   ,   @FechaHasta          DATETIME    
   )    
AS    
    
BEGIN    
 
 -- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 10776,'20150623','20150623'
 -- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 10776,'20150623','20150623' 
 -- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 10775,'20150623','20150623' 
 -- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 1812,'20150901','20150901' -- select fechaLiquidacion, * from carterahis where numero_operacion = 2512
  -- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 746,'20151120','20151120' -- select fechaLiquidacion, * from carterahis where numero_operacion = 2512
    -- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 11217,'20151030','20151030' -- select fechaLiquidacion, * from carterahis where numero_operacion = 2189
	-- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES_MAP 2189,'20151030','20151030' 
	-- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 2189,'20151030','20151030' 
	-- EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 11696,'20151210','20151210' 
	--  EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 6947,'20151214','20151214' 
	--  EXEC GENERA_LIQUIDACION_FLUJOS_MULTIPLES 11702,'20151215','20151215' 
 -- select estado, recibimos_monto, compra_interes + venta_interes , * from cartera where numero_operacion = 10719 and fechaliquidacion = '20150623'
   -- select * from BacParamSuda.dbo.tbl_caja_derivados where numero_operacion = 10696
    
   SET NOCOUNT ON    
    
   DECLARE @EstadoTasa       VARCHAR(50)    
   DECLARE @EstadoActTasaVar INTEGER    
   DECLARE @FechaProceso     DATETIME    

	 
   SELECT  @EstadoTasa       = CASE WHEN devengo = 0 THEN 'Tasa ICP No Actualizada'    
                                    WHEN devengo = 1 THEN 'Tasa ICP Actualizada'    
                               END    
   ,       @EstadoActTasaVar = ActTasaVarVcto    
   ,       @FechaProceso     = fechaproc    
   FROM    SWAPGENERAL       with(nolock)    

   SELECT	vmfecha, vmcodigo, vmvalor  
   INTO		#Valor_Moneda    
   FROM		BacParamSuda..VALOR_MONEDA  with(nolock) 
   WHERE	vmfecha		between @FechaDesde and @FechaHasta     

   INSERT INTO #Valor_Moneda
   SELECT vmfecha, 999, 1.0
   FROM   #VALOR_MONEDA
   WHERE  vmcodigo = 998
    
   INSERT INTO #Valor_Moneda     
   SELECT vmfecha, 13, vmvalor     
   FROM   #VALOR_MONEDA    
   WHERE  vmcodigo = 994    
   
   delete #Valor_Moneda    
      where vmcodigo = 13 and vmvalor = 0    
    
   DECLARE @FlujoAdicionalActivo float    
   SELECT  @FlujoAdicionalActivo = 0 --560.23    
   DECLARE @FlujoAdicionalPasivo float    
   SELECT  @FlujoAdicionalPasivo = 0 --565.08    

   select *     
   into   #Informe     
   from   cartera   with(nolock)    
   where  (numero_operacion   = @Numero_Operacion or  @Numero_Operacion = 0   )  
     and  FechaLiquidacion   BETWEEN @FechaDesde and @Fechahasta    
--	 and estado <> 'N' 
    
   union    
    
   select *    
   from   carterahis   with(nolock)    
   where  (numero_operacion   = @Numero_Operacion or  @Numero_Operacion = 0   )  
     and  FechaLiquidacion   BETWEEN @FechaDesde and @Fechahasta    
--	 and estado <> 'N' 


   update #Informe  set modalidad_pago = case when estado = 'N' then 'C' else modalidad_pago end

   select 'debug', * from #informe

	declare @iChile	int
		set @iChile	= 1
	select	@iChile	= case when clpais = 6 then 1 else 0 end
	from	#Informe 
			inner join BacParamSuda.dbo.Cliente On clrut = rut_cliente and clcodigo = codigo_cliente
    where	numero_operacion = @Numero_Operacion

	
    
   DECLARE @iTipoSwap        INTEGER    
   SELECT  @iTipoSwap        = Tipo_Swap    
   FROM    #Informe           with (nolock)     

	--		CONTROL DE FIJACION		--
	declare	@iStatusIndAct		int
		set @iStatusIndAct		= 0

	select	@iStatusIndAct		= 1
	from	#Informe
	where	tipo_flujo			= 1
	and		compra_codigo_tasa	not in(0, 13, 21)
	and		fecha_cierre	   <> FechaLiquidacion
	and		compra_zcr			= 1

	declare	@iStatusIndPas		int
		set @iStatusIndPas		= 0

	select	@iStatusIndPas		= 1
	from	#Informe
	where	tipo_flujo			= 2
	and		venta_codigo_tasa	not in(0, 13, 21)
	and		fecha_cierre	   <> FechaLiquidacion
	and		venta_zcr			= 1
	--		CONTROL DE FIJACION		--
	


	SELECT DISTINCT    
          'Entidad'           = LTRIM(RTRIM(nombre))    
   ,      'Cliente'           = substring( ltrim(rtrim( clnombre )), 1, 30)
						/*		CASE WHEN @iStatusIndAct = 1 or @iStatusIndPas = 1 then ' [ ¡¡¡ OPERACION TINE FLUJOS SIN FIJAR !!! ]'
									 ELSE substring( ltrim(rtrim( clnombre )), 1, 30)
								END	*/

   ,      'RutCliente'        = LTRIM(RTRIM(clrut)) + '-' + LTRIM(RTRIM( cldv ))     
								--> CONVERT(CHAR(12),REPLICATE(' ', 10 - LEN(LTRIM(RTRIM(c.Rut_Cliente)))) + LTRIM(RTRIM(c.Rut_Cliente)) + '-' + LTRIM(RTRIM(c.codigo_cliente)))     
   ,      'FlujoMonedaPago'   = CONVERT(NUMERIC(21,4),0)    
   ,      'MonedaFinalPago'   = CONVERT(CHAR(3),'---')    
   ,      'ValorMonedaPago'   = CONVERT(NUMERIC(21,4),0)    
   ,      'FormaPago'         = CONVERT(CHAR(25),'---')    
   ,      'AFavordeCliente'   = CONVERT(CHAR(1),'-')    
   ,      'TipoProducto'      = c.Tipo_Swap    
   ,      'EstadoICP'         = CASE WHEN c.Tipo_Swap = 4 THEN @EstadoTasa ELSE @EstadoTasa END    
   ,      'MaxFlujoCompra'    = (SELECT MAX(fc.Numero_Flujo) FROM #Informe fc WHERE  fc.Tipo_Flujo = 1 )    
   ,      'MaxFlujoVenta'     = (SELECT MAX(fv.Numero_Flujo) FROM #Informe fv WHERE  fv.Tipo_Flujo = 2 )    
   ,      'FechaCierre'       = CASE WHEN DATEPART(dw,c.Fecha_Cierre) = 2 THEN 'Lunes '    
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 3 THEN 'Martes '    
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 4 THEN 'Miércoles '    
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 5 THEN 'Jueves '    
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 6 THEN 'Viernes '    
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 7 THEN 'Sábado '    
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 1 THEN 'Domingo '    
                                END    
                              + ' ' + LTRIM(RTRIM(DATEPART(DAY,c.Fecha_Cierre)))    
                              + ' de '    
                              + CASE WHEN DATEPART(MONTH,c.Fecha_Cierre) = 1  THEN 'Enero '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 2  THEN 'Febrero '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 3  THEN 'Marzo '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 4  THEN 'Abril '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 5  THEN 'Mayo '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 6  THEN 'Junio '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 7  THEN 'Julio '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 8  THEN 'Agosto '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 9  THEN 'Septiembre '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 10 THEN 'Octubre '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 11 THEN 'Noviembre '    
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 12 THEN 'Diciembre '    
                                 END    
                             +   ' del ' + LTRIM(RTRIM(DATEPART(YEAR,c.Fecha_Cierre)))
   ,		Modalidad_Pago 
   ,		numero_operacion    = c.numero_operacion
   INTO		#GENERAL
   FROM		#Informe c
			LEFT JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = c.rut_cliente AND clcodigo = c.codigo_cliente
   ,		SWAPGENERAL                     with (nolock)
   WHERE	FechaLiquidacion BETWEEN  @FechaDesde 
			and @Fechahasta
			AND		Estado <> 'C'

--------------------------------------------------------------FLUJO 1
   SELECT 'iOperacion'        = c.Numero_Operacion    
   ,      'iFlujo'            = c.Numero_Flujo    
   ,      'iMoneda'           = c.Compra_Moneda    
   ,      'cNemoMonOpe'       = mon.mnnemo    
   ,      'iMonedaPago'       = c.Recibimos_Moneda    
   ,      'cNemoMonPag'       = pag.mnnemo    
   ,      'iFormaPago'        = c.Recibimos_Documento    
   ,      'cGlosaDocumento'   = fpa.glosa    
   ,      'vCapitalInicial'   = c.Compra_Saldo + c.Compra_Amortiza    
   ,      'vCapitalVigente'   = c.Compra_Saldo    
   ,      'dFechaInicio'   = c.Fecha_Inicio_Flujo    
   ,      'dFechaVctoFlujo'   = c.Fecha_Vence_Flujo     
   ,      'iPlazo'            = DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)    
   ,      'iTasa'             = c.Compra_Codigo_Tasa    
   ,      'vValorTasa'        = c.Compra_Valor_Tasa    
   ,      'cGlosaTasa'        = ISNULL(t.tbglosa,'')    
   ,      'iBase'             = c.Compra_Base    
   ,      'cGlosaBase'        = ISNULL(b.glosa,'')    
   ,      'vInteres'          = CASE WHEN @iTipoSwap = 3   THEN 
   c.Compra_interes / ( 1 + DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)/ 360.0 * compra_mercado_tasa / 100.0 )    
                                     WHEN Estado     = 'N' THEN c.Recibimos_Monto -- MAP 20071227 Anticipo    
                                     ELSE                       c.Compra_Interes     
                                END    
   ,      'vAmortizacion'     = c.Compra_Amortiza    
   ,      'vFlujoAdicional'   = c.Compra_Flujo_Adicional    
   ,      'vFlujo'            = (CASE WHEN @iTipoSwap = 3   THEN c.Compra_interes / ( 1 + DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)/ 360.0 * compra_mercado_tasa / 100.0 )    
                                      WHEN c.Estado   = 'N' THEN c.Recibimos_Monto    
                                      ELSE c.Compra_Interes + c.Compra_Amortiza * c.intercprinc + c.Compra_Flujo_Adicional    
                                 END) ------- Cambios realizados para PRD_21657    
   ,      'MsgActualizacion'  = CASE WHEN t.nemo <> 'S' THEN ' '    
                                     ELSE 'Tasa ' + CONVERT(CHAR(08),t.tbglosa) + CASE WHEN @EstadoActTasaVar = 1 THEN ' Actualizada.'     
                                               ELSE          ' No Actualizada'     
                                                                                   END + ' (Mon. Rel. ' + ltrim(rtrim(mon.mnnemo)) + ')'    
                                END    
   ,      'bMarca'            = '-'    
   ,      'Spread'            = c.compra_spread    
   ,	  'TipoFlujo'         = c.Tipo_Flujo    
   ,      'IntercambioNoc'    = c.IntercPrinc    
   ,      'FechaLiquidacion'  = c.FechaLiquidacion
   ,	  'uf'				  = 0.0
   ,	  'usd'				  = 0.0
   ,	   'Mex'			  = 0.0
   ,	  'Montoflow'		  = 0.0 
   ,	  'mex2'			  = 0.0
   ,      'fechaFijacion'     = case when c.compra_codigo_Tasa in ( 13, 22, 0 ) then '19000101' else c.Fecha_Fijacion_Tasa end

   -- Total por Pata solo para EF
   ,      'TotalMtoPtaMPag' = isnull( case when Caja.Modalidad_Pago = 'C' then CajaDet.MontoM1  
                                    else 
									    CajaDet.MontoM1 -- case when Caja.MontoM1 >  0 then Caja.MontoM1 else Caja.MontoM2  end -- MAP 20151211
                                    end, 0 )

   -- Total General MPago solo para Compensado 
   ,      'TotalMontoMPag'     = isnull(  case when c.modalidad_pago = 'C' then Caja.MontoM1 
                                 else 0.0 end, 0 )
   ,      'TotalMontoClp'     =  isnull( Caja.MontoM1Local + Caja.MontoM2Local, 0 )
   -- Total por Pata solo para EF 
   ,      'TotalMtoPtaClp' = isnull( case when Caja.Modalidad_Pago = 'C' then  CajaDet.MontoM1Local 
                                    else 
									    CajaDet.MontoM1Local -- case when Caja.MontoM1Local >  0 then Caja.MontoM1Local else Caja.MontoM2Local  end -- MAP 20151211
                                    end, 0 )
                                 
   , c.modalidad_pago   
  , Detalle_Conversiones = convert( varchar(100), 'Par.Cap:' + convert( varchar(10), CajaDet.ParidadMdaPata )
                                                 + ' - Par.Pag:' + convert( varchar(10), CajaDet.ParidadMdaPago )
												 + ' - TCM Cap:' + convert( varchar(10), CajaDet.ValorMdaPataCLP  )
												 + ' - TCM Pag:' + convert( varchar(10), CajaDet.ValorMdaPagoCLP  )
												 + ' - USD:' +  convert( varchar(10), CajaDet.ValorUSDCLP  )
                                      )
   INTO   #LiquidaciónCompra  
   FROM   #Informe                                       c     
          LEFT JOIN BASE                                b with(nolock)	ON b.Codigo     = c.Compra_Base    
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE t with(nolock)	ON t.tbcateg    = 1042 AND t.tbcodigo1 = c.Compra_Codigo_Tasa    
          LEFT JOIN BacParamSuda..MONEDA              mon with(nolock)	ON mon.mncodmon = c.Compra_Moneda    
          LEFT JOIN BacParamSuda..MONEDA              pag with(nolock)	ON pag.mncodmon = c.Recibimos_Moneda    
		  LEFT JOIN BacParamSuda..FORMA_DE_PAGO       fpa with(nolock)	ON fpa.codigo   = c.Recibimos_Documento    
		  LEFT JOIN BacParamSuda.dbo.TBL_CAJA_DERIVADOS Caja with(nolock) ON Caja.Modulo = 'PCS' 
		                                                                 and Caja.Numero_Operacion = c.numero_operacion 
																		 and Caja.fechaLiquidacion = c.FechaLiquidacion
																		 and Caja.Modalidad_Pago = c.modalidad_pago 
																		-- and caja.VctoNatural_anticipo = 'VCTO_NAT'      
	      LEFT JOIN BacParamSuda.dbo.TBL_CAJA_DERIVADOS_DETALLE CajaDet with(nolock) ON CajaDet.Modulo = 'PCS' 
		                                                                 and CajaDet.Numero_Operacion = c.numero_operacion 
																		 and CajaDet.fechaLiquidacion = c.FechaLiquidacion																		 
																		 and CajaDet.tipo_Flujo = 1
																		-- and CajaDet.VctoNatural_anticipo = 'VCTO_NAT'

   WHERE  c.Tipo_Flujo        = 1    
   AND    c.FechaLiquidacion  BETWEEN  @FechaDesde 
   and @Fechahasta
   

   -- select 'debug', * from #LiquidaciónCompra where iOperacion = 10713
--------------------------------------------------------------- FLUJO 2

   SELECT 'iOperacion'        = c.Numero_Operacion    
   ,      'iFlujo'            = c.Numero_Flujo    
   ,      'iMoneda'           = c.Venta_Moneda    
   ,      'cNemoMonOpe'       = mon.mnnemo    
   ,      'iMonedaPago'       = c.Pagamos_Moneda    
   ,      'cNemoMonPag'       = pag.mnnemo    
   ,      'iFormaPago'        = c.Pagamos_Documento    
   ,      'cGlosaDocumento'   = fpa.glosa    
   ,      'vCapitalInicial'   = c.Venta_Saldo + c.Venta_Amortiza    
   ,      'vCapitalVigente'   = c.Venta_Saldo     
   ,      'dFechaInicio'      = c.Fecha_Inicio_Flujo    
   ,      'dFechaVctoFlujo'   = c.Fecha_Vence_Flujo     
  ,      'iPlazo'            = DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)    
   ,      'iTasa'             = c.Venta_Codigo_Tasa    
   ,      'vValorTasa'        = c.Venta_Valor_Tasa    
   ,      'cGlosaTasa'        = ISNULL(t.tbglosa,'')    
   ,      'iBase'             = c.Venta_Base    
   ,      'cGlosaBase'        = ISNULL(b.glosa,'')    
   ,      'vInteres'          = CASE WHEN @iTipoSwap = 3   THEN c.Venta_interes / ( 1 + DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)/ 360.0 * Venta_mercado_tasa / 100.0 )      
                                     WHEN Estado     = 'N' THEN 0.0    
                                     ELSE                       c.Venta_Interes     
                                END    
   ,      'vAmortizacion'     = c.Venta_Amortiza    
   ,      'vFlujoAdicional'   = c.Venta_Flujo_Adicional    
    
   ,      'vFlujo'            = (CASE	WHEN @iTipoSwap = 3   THEN c.Venta_interes / ( 1 + DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)/ 360.0 * Venta_mercado_tasa / 100.0 )     
										WHEN c.Estado   = 'N' THEN c.pagamos_monto --> 0.0     
										ELSE c.Venta_Interes + c.Venta_Amortiza * c.intercprinc + c.Venta_Flujo_Adicional            -- Flujo Adicional MAP 20090211    
 
                                 END) ------- Cambios realizados para PRD_21657    
   ,      'MsgActualizacion'  = CASE WHEN t.nemo <> 'S' THEN ' '    
                                     ELSE 'Tasa ' + CONVERT(CHAR(08),t.tbglosa) + CASE WHEN @EstadoActTasaVar = 1 THEN ' Actualizada.' ELSE ' No Actualizada' END + ' (Mon. Rel. ' + ltrim(rtrim(mon.mnnemo)) + ')'    
                                END    
   ,      'bMarca'            = '-'    
   ,      'Spread'            = c.venta_spread    
   ,	  'TipoFlujo'         = c.Tipo_Flujo    
   ,      'IntercambioNoc'    = c.IntercPrinc    
   ,      'FechaLiquidacion'  = c.FechaLiquidacion  


   ,	  'uf'				  = 0.0
   ,	  'usd'				  = 0.0
   ,	   'Mex'			  = 0.0
   ,	  'Montoflow'		  = 0.0 
   ,	  'mex2'			  = 0.0

   ,      'fechaFijacion'     = case when c.venta_codigo_Tasa in ( 13, 22, 0 ) then '19000101' else c.Fecha_Fijacion_Tasa end

   -- Total por Pata solo para EF
   ,      'TotalMtoPtaMPag' = isnull( case when Caja.Modalidad_Pago = 'C' then CajaDet.MontoM1 -- abs( CajaDet.MontoM1 ) 
                                    else 
									    CajaDet.MontoM1 --  case when Caja.MontoM1 <  0 then Caja.MontoM1 else Caja.MontoM2  end -- MAP 20151211
                                    end, 0 )

   -- Total General MPago solo para Compensado 
   ,      'TotalMontoMPag'     = isnull( case when c.modalidad_pago = 'C' then  
                                     Caja.MontoM1
                                 else 0.0 end, 0 )
   ,      'TotalMontoClp'     =  isnull( Caja.MontoM1Local + Caja.MontoM2Local, 0 )
   ,      'TotalMtoPtaClp' = isnull( case when Caja.Modalidad_Pago = 'C' then CajaDet.MontoM1Local -- abs( CajaDet.MontoM1Local )
                                    else 
									    CajaDet.MontoM1Local -- case when Caja.MontoM1Local <  0 then Caja.MontoM1Local else Caja.MontoM2Local  end -- MAP 20151211
                                    end, 0 )
   , c.modalidad_pago   
   , Detalle_Conversiones = convert( varchar(100), 'Par.Cap:' + convert( varchar(10), CajaDet.ParidadMdaPata )
                                                 + ' - Par.Pag:' + convert( varchar(10), CajaDet.ParidadMdaPago )
												 + ' - TCM Cap:' + convert( varchar(10), CajaDet.ValorMdaPataCLP  )
												 + ' - TCM Pag:' + convert( varchar(10), CajaDet.ValorMdaPagoCLP  )
												 + ' - USD:'  + convert( varchar(10), CajaDet.ValorUSDCLP  )
                                      )

   INTO   #LiquidaciónVenta    
   FROM   #Informe                                      c    
          LEFT JOIN BASE                                b with(nolock) ON b.Codigo  = c.Venta_Base    
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE t with(nolock) ON t.tbcateg = 1042 AND t.tbcodigo1 = c.Venta_Codigo_Tasa    
          LEFT JOIN BacParamSuda..MONEDA              mon with(nolock) ON mon.mncodmon = c.Venta_Moneda    
          LEFT JOIN BacParamSuda..MONEDA              pag with(nolock) ON pag.mncodmon = c.Pagamos_Moneda    
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO       fpa with(nolock) ON fpa.codigo   = c.Pagamos_Documento    
		  		  LEFT JOIN BacParamSuda.dbo.TBL_CAJA_DERIVADOS Caja with(nolock) ON Caja.Modulo = 'PCS' 
		                                                                 and Caja.Numero_Operacion = c.numero_operacion 
																		 and Caja.fechaLiquidacion = c.FechaLiquidacion
																		 and Caja.Modalidad_Pago = c.modalidad_pago 
																		-- and caja.VctoNatural_anticipo = 'VCTO_NAT'   
   	      LEFT JOIN BacParamSuda.dbo.TBL_CAJA_DERIVADOS_DETALLE CajaDet with(nolock) ON CajaDet.Modulo = 'PCS' 
		                                                                 and CajaDet.Numero_Operacion = c.numero_operacion 
																		 and CajaDet.fechaLiquidacion = c.FechaLiquidacion																		 
																		 and CajaDet.tipo_Flujo = 2
																		-- and cajaDet.VctoNatural_anticipo = 'VCTO_NAT'   
   WHERE c.Tipo_Flujo        = 2    
   and   c.FechaLiquidacion BETWEEN  @FechaDesde 
   and  @FechaHasta
   
  --select 'debug' , * from #LiquidaciónVenta where iOperacion = 10713
  
-------------------------------------------------------------ACTUALIZACIONES
   UPDATE #LiquidaciónCompra    
   SET    bMarca                       = 'x'    
   FROM   #LiquidaciónVenta    
   WHERE  #LiquidaciónVenta.iOperacion = #LiquidaciónCompra.iOperacion    
    
   UPDATE #LiquidaciónVenta    
   SET    bMarca                       = 'x'    
   FROM   #LiquidaciónCompra    
   WHERE  #LiquidaciónVenta.iOperacion = #LiquidaciónCompra.iOperacion              
    
   UPDATE #GENERAL    
   SET    FlujoMonedaPago   = (c.vFlujo - v.vFlujo)     
   ,      MonedaFinalPago   = CASE WHEN c.vFlujo >= v.vFlujo THEN c.cNemoMonPag     ELSE v.cNemoMonPag     END -----------------   
   ,      ValorMonedaPago   = ISNULL(vmv.vmvalor,0.0)    
   ,      FormaPago         = CASE WHEN c.vFlujo >= v.vFlujo THEN c.cGlosaDocumento ELSE v.cGlosaDocumento END    
   ,      AFavordeCliente   = CASE WHEN c.vFlujo >= v.vFlujo THEN 'E'               ELSE 'C'               END    
   FROM   #LiquidaciónCompra           c    
          INNER JOIN #LiquidaciónVenta v ON v.iOperacion = c.iOperacion              
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = CASE WHEN c.vFlujo >= v.vFlujo THEN c.iMonedaPago ELSE v.iMonedaPago END and vmv.vmfecha = c.fechaliquidacion     
   WHERE  c.bMarca         = 'x'    
    
   UPDATE #GENERAL    
   SET    FlujoMonedaPago   = c.vFlujo     
   ,      MonedaFinalPago   = c.cNemoMonPag    
   ,      ValorMonedaPago   = ISNULL(vmv.vmvalor,0.0)    
   ,      FormaPago         = c.cGlosaDocumento    
   ,      AFavordeCliente   = 'E'    
   FROM   #LiquidaciónCompra           c    
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = c.iMonedaPago and vmv.vmfecha = c.fechaliquidacion     
   WHERE  c.bMarca    = '-'    
    
   UPDATE #GENERAL    
 SET    FlujoMonedaPago   = v.vFlujo     
   ,      MonedaFinalPago   = v.cNemoMonPag    
   ,      ValorMonedaPago   = ISNULL(vmv.vmvalor,0.0)    
   ,      FormaPago         = v.cGlosaDocumento    
   ,      AFavordeCliente   = 'C'    
   FROM   #LiquidaciónVenta            v    
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = v.iMonedaPago and vmv.vmfecha = v.fechaliquidacion     
   WHERE  v.bMarca          = '-'    
    
 --   select 'debug', * from #liquidaciónVenta
--	select 'debug', * from #liquidaciónCompra

   IF @Numero_Operacion > 0     
   BEGIN    
      DECLARE @iMontoFlujo   FLOAT    
          SET @iMontoFlujo   = 0.0    
    
      DECLARE @iFlujoPago    FLOAT    
          SET @iFlujoPago    = 0.0    
    
      DECLARE @iFlujoRecibo  FLOAT    
      SET @iFlujoRecibo  = 0.0    
     /*
      IF EXISTS(SELECT 1 FROM CARTERA_UNWIND WHERE numero_operacion = @Numero_Operacion AND fecha_termino = FechaAnticipo    
                                               AND FechaAnticipo    BETWEEN @FechaDesde AND @Fechahasta)    
      BEGIN    
    
         SELECT @iFlujoPago    = Pagamos_Monto    
          ,     @iFlujoRecibo  = Recibimos_Monto    
         FROM   #Informe     
         WHERE (Pagamos_Monto  + Recibimos_Monto) > 0    
    
         SELECT @iMontoFlujo   = CASE WHEN (Pagamos_Moneda + Recibimos_Moneda)  = 999 THEN (Recibimos_Monto_CLP - Pagamos_Monto_CLP)    
                                      WHEN (Pagamos_Moneda + Recibimos_Moneda) <> 999 THEN (Recibimos_Monto_USD - Pagamos_Monto_USD)    
                                      ELSE                                                 (Recibimos_Monto     - Pagamos_Monto)    
                                 END    
         FROM   #Informe     
         WHERE (Pagamos_Monto + Recibimos_Monto) > 0    
    
         UPDATE #LiquidaciónCompra   SET vFlujo = @iFlujoRecibo    
         UPDATE #LiquidaciónVenta    SET vFlujo = @iFlujoPago    
      END    
	  */
   END    
    
    
   SELECT iOperacion    
         ,iFlujo    
         ,iMoneda    
         ,cNemoMonOpe    
         ,iMonedaPago    
         ,cNemoMonPag    
         ,iFormaPago    
         ,cGlosaDocumento    
         ,vCapitalInicial    
         ,vCapitalVigente    
         ,dFechaInicio    
         ,dFechaVctoFlujo    
         ,iPlazo    
   ,iTasa    
         ,vValorTasa    
         ,cGlosaTasa    
         ,iBase    
         ,cGlosaBase    
         ,vInteres    
         ,vAmortizacion    
         ,vFlujoAdicional    
         ,vFlujo    
         ,MsgActualizacion    
         ,bMarca    
         ,Spread    
         ,TipoFlujo    
         ,IntercambioNoc    
         ,FechaLiquidacion    
         ,'Anticipo'         = 'N'    
         ,'AntTotalParcial'  = 'N/A      '
		 ,uf
		 ,usd
		 ,Mex
		 ,Montoflow
		 ,mex2

         ,fechaFijacion
         ,TotalMtoPtaMPag
         ,TotalMontoMPag
         ,TotalMontoClp
		 ,TotalMtoPtaClp
		 , Detalle_Conversiones

   INTO  #RETORNO       
   FROM   #LiquidaciónCompra    
   UNION    
   SELECT iOperacion    
         ,iFlujo    
         ,iMoneda    
         ,cNemoMonOpe    
         ,iMonedaPago    
         ,cNemoMonPag    
         ,iFormaPago    
         ,cGlosaDocumento    
       ,vCapitalInicial    
         ,vCapitalVigente    
         ,dFechaInicio    
         ,dFechaVctoFlujo    
         ,iPlazo    
         ,iTasa    
         ,vValorTasa    
         ,cGlosaTasa    
         ,iBase    
         ,cGlosaBase    
         ,vInteres    
         ,vAmortizacion    
         ,vFlujoAdicional    
         ,vFlujo    
         ,MsgActualizacion    
         ,bMarca    
         ,Spread    
         ,TipoFlujo    
         ,IntercambioNoc    
         ,FechaLiquidacion    
         ,'Anticipo'         = 'N'    
         ,'AntTotalParcial'  = 'N/A '
		 ,uf
		 ,usd
		 ,Mex
		 ,Montoflow
		 ,mex2
         ,fechaFijacion
         ,TotalMtoPtaMPag
         ,TotalMontoMPag
         ,TotalMontoClp
		 ,TotalMtoPtaClp
		 ,Detalle_Conversiones
   FROM  #LiquidaciónVenta           
    
   UPDATE #RETORNO    
      SET Anticipo        = isnull( ( select max('S')       from #Informe c where  c.Estado  = 'N' ) , 'N' )    
        , AntTotalParcial = isnull( ( select max('PARCIAL') from #Informe c where  c.Estado <> 'N') , 'TOTAL' )    
    

SELECT iOperacion  
         ,iFlujo    
         ,iMoneda    
         ,cNemoMonOpe    
         ,iMonedaPago    
         ,cNemoMonPag    
  ,iFormaPago    
         ,cGlosaDocumento    
         ,vCapitalInicial    
         ,vCapitalVigente    
         ,dFechaInicio    
         ,dFechaVctoFlujo    
         ,iPlazo    
         ,iTasa    
         ,vValorTasa    
         ,cGlosaTasa    
         ,iBase    
         ,cGlosaBase    
         ,vInteres    
         ,vAmortizacion    
         ,vFlujoAdicional    
         ,vFlujo    
         ,MsgActualizacion    
         ,bMarca    
         ,Spread    
         ,TipoFlujo    
         ,IntercambioNoc    
         ,FechaLiquidacion    
         ,Anticipo    
         ,AntTotalParcial    
         ,Entidad    
  ,Cliente    
         ,RutCliente    
  ,FlujoMonedaPago    
  ,MonedaFinalPago    
  ,ValorMonedaPago    
  ,cGlosaDocumento as FormaPago --> FormaPago -->    
  ,AFavordeCliente    
  ,TipoProducto    
  ,EstadoICP    
  ,MaxFlujoCompra    
  ,MaxFlujoVenta    
  ,FechaCierre    
  ,Modalidad_Pago   
         ,'GlosaMonPago' = (SELECT mnglosa FROM BacParamSuda..MONEDA  WHERE  mnnemo = MonedaFinalPago )    
         ,'Ciudad'       = 'Santiago, '    
         ,'Fecha'        = CASE WHEN DATEPART(dw,@FechaProceso) = 2 THEN 'Lunes ' + ' '  -- MAP 20080405    
                                    WHEN DATEPART(dw,@FechaProceso) = 3 THEN 'Martes  '    
                                    WHEN DATEPART(dw,@FechaProceso) = 4 THEN 'Miércoles '    
                                    WHEN DATEPART(dw,@FechaProceso) = 5 THEN 'Jueves '    
									WHEN DATEPART(dw,@FechaProceso) = 6 THEN 'Viernes '    
                                    WHEN DATEPART(dw,@FechaProceso) = 7 THEN 'Sábado '    
                                    WHEN DATEPART(dw,@FechaProceso) = 1 THEN 'Domingo '    
                         END    
      + ' ' + LTRIM(RTRIM(DATEPART(DAY,@FechaProceso)))    
                             +  ' de '    
                             +  CASE WHEN DATEPART(MONTH,@FechaProceso) = 1  THEN 'Enero '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 2  THEN 'Febrero '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 3  THEN 'Marzo '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 4  THEN 'Abril '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 5  THEN 'Mayo '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 6  THEN 'Junio '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 7  THEN 'Julio '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 8  THEN 'Agosto '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 9  THEN 'Septiembre '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 10 THEN 'Octubre '    
               WHEN DATEPART(MONTH,@FechaProceso) = 11 THEN 'Noviembre '    
                                     WHEN DATEPART(MONTH,@FechaProceso) = 12 THEN 'Diciembre '    
                                END    
                             +   ' del ' + LTRIM(RTRIM(DATEPART(YEAR,@FechaProceso)))    
    
         ,'ParamOper'   = CASE WHEN @Numero_Operacion =0 THEN 0 ELSE  @Numero_Operacion END    
         ,'Grupo'     = MonedaFinalPago + ' ' +  cliente     
         ,'FlujoSuma'   = CASE WHEN TipoFlujo =1 THEN vFlujo  ELSE - vFlujo  END    
         ,'FechaDesde'  = @FechaDesde    
         ,'FechaHasta'  = @Fechahasta    
		 ,'NoHabil'		='-' -- iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(@FechaDesde,';6;')=FechaLiquidacion,'-','X') 
		 ,uf
		 ,usd
		 ,Mex
		 , Montoflow
		 ,mex2
          ,fechaFijacion
         ,TotalMtoPtaMPag = round( TotalMtoPtaMPag, case when iMonedaPago = 999 then 0 else 4 end )
         ,TotalMontoMPag  = round( TotalMontoMPag , case when iMonedaPago = 999 then 0 else 4 end )
         ,TotalMontoClp   = round( TotalMontoClp, 0 )
		 ,TotalMtoPtaClp  = round( TotalMtoPtaClp, 0 )
		 , Detalle_Conversiones
   INTO #RESULTADO     
   FROM #RETORNO, #GENERAL       
   WHERE iOperacion = Numero_Operacion        
   
   if @Numero_Operacion <> 0 -- Solo para liquidaciones Aisladas
   Begin
       declare @HayCaja datetime
	   select @HayCaja = tbfecha from bacparamsuda.dbo.tabla_general_detalle where tbcateg = 31
       if @FechaDesde < @HayCaja 
	   begin
	     update #RESULTADO 
		     set   TotalMtoPtaMPag = FlujoSuma * isnull( ( select vmvalor from BacParamSuda.dbo.Valor_moneda 
				                                   where Vmcodigo = case when iMoneda = 13 then 994 else iMoneda end 
												     and vmfecha = @FechaDesde ), 1.0 )
													 / isnull( ( select vmvalor from BacParamSuda.dbo.Valor_moneda 
				                                   where Vmcodigo = case when iMonedaPago = 13 then 994 else iMonedaPago end 
												     and vmfecha = @FechaDesde ), 1.0 )

			     , TotalMtoPtaClp  = FlujoSuma * isnull( ( select vmvalor from BacParamSuda.dbo.Valor_moneda 
				                                   where Vmcodigo = case when iMoneda = 13 then 994 else iMoneda end 
												     and vmfecha = @FechaDesde ), 1.0 ) 
		 where iOperacion = @Numero_Operacion 
		 declare @TotalAux float
		 select  @TotalAux = sum( TotalMtoPtaMPag ) from #resultado where iOperacion = @Numero_Operacion 	
		 update #resultado
		     Set TotalMontoMPag = case when Modalidad_Pago = 'E' then 0.0 else @TotalAux end
			  ,  TotalMontoClp  = case when  Modalidad_Pago = 'E' then 0.0 else @TotalAux * isnull( ( select vmvalor from BacParamSuda.dbo.Valor_moneda 
				                                                                where Vmcodigo = case when iMonedaPago = 13 then 994 else iMonedaPago end 
			  									                                             and vmfecha = @FechaDesde ), 1.0 )
																			end
			 , Detalle_Conversiones = ''
		 where iOperacion = @Numero_Operacion 	  

       end
   end 
---------------------------------------------------ENVÍO DE DATOS A SISTEMA

  IF EXISTS(SELECT  *  FROM #RESULTADO)
  BEGIN    
     SELECT * FROM #RESULTADO  ORDER BY Cliente, iOperacion,   TipoFlujo, iFlujo ,  cNemoMonPag    
	  
  END ELSE   
     select iOperacion   = 0    
       , iFlujo       = 0    
       , iMoneda         = 0     
       , cNemoMonOpe     = ''     
       , iMonedaPago     = 0    
       , cNemoMonPag    = ''    
       , iFormaPago      = 0     
       , cGlosaDocumento        = ''            
       , vCapitalInicial        = 0    
       , vCapitalVigente        = 0    
       , dFechaInicio           = ''         
       , dFechaVctoFlujo        = ''        
       , iPlazo                 = 0    
       , iTasa                  = 0    
       , vValorTasa             = 0.0    
       , cGlosaTasa             = ''                                
       , iBase    = 0    
       , cGlosaBase        = ''             
       , vInteres               = 0                                    
       , vAmortizacion          = 0    
       , vFlujoAdicional        = 0.0                                   
       , vFlujo                 = 0.0                       
       , MsgActualizacion       = ''                              
       , bMarca       = ''    
       , Spread                 = 0.0    
       , TipoFlujo              = 0     
       , IntercambioNoc         = 0    
       , FechaLiquidacion  = ''     
       , Anticipo               = ''      
       , AntTotalParcial        = ''    
     , Entidad                = ''                           
       , Cliente      = ''                    
       , RutCliente   = ''                                    
       , FlujoMonedaPago    = 0.0     
       , MonedaFinalPago        = ''    
       , ValorMonedaPago        = 0.0     
       , FormaPago              = ''       
       , AFavordeCliente        = ''    
       , TipoProducto       = 0     
       , EstadoICP              = ''    
       , MaxFlujoCompra         = 0    
       , MaxFlujoVenta          = 0    
       , FechaCierre            = ''    
       , Intercprinc            = 0  
       , Modalidad_Pago         = ''  
       , GlosaMonPago           = ''    
       , Ciudad                 = ''    
       , Fecha                  = ''    
       , ParamOper              = 0     
       , Grupo                  = ''    
       , FlujoSuma              = 0.0    
       , FechaDesde             = ''    
       , FechaHasta             = ''    
	   , NoHabil				=''
		 
		 ,uf = 0
		 ,usd = 0
		 ,Mex = 0
		 , Montoflow = 0
		 ,mex2 = 0
          ,fechaFijacion = '19000101'
         ,TotalMtoPtaMPag = 0
         ,TotalMontoMPag  = 0
         ,TotalMontoClp   = 0
		 ,TotalMtoPtaClp = 0
		 , Detalle_Conversiones = ''
	   order by TipoFlujo
END

-- select fecha_Fijacion_Tasa, compra_codigo_tasa , venta_codigo_tasa , * from cartera where numero_operacion = 1509 and fechaLiquidacion = '20150623'

/*

Par. Mda Cap:1.1386 - Par. Mda Pag:1.1386 - Valor CLP Mda Cap:718.0400 - Valor CLP Mda Pag:718.0400
Par. Mda Cap:0.0253 - Par. Mda Pag:630.6400 - Valor CLP Mda Cap:24971.3100 - Valor CLP Mda Pag:1.000

Par. Mda Cap:632.3100 - Par. Mda Pag:1.1200 - Valor CLP Mda Cap:1.0000 - Valor CLP Mda Pag:708.1872
Par. Mda Cap:632.3100 - Par. Mda Pag:1.1200 - Valor CLP Mda Cap:1.0000 - Valor CLP Mda Pag:708.1872

Par. Mda Cap:1.138589 - Par. Mda Pag:630.640000 - Valor CLP Mda Cap:718.0398 - Valor CLP Mda Pag:1.0
Par. Cap:1.138589 - Par. Pag:630.640000 - Valor CLP Cap:718.0398 - Valor CLP Pag:1.0000 - USD:630.64
Par. Cap:0.025255 - Par. Pag:630.640000 - Valor CLP Cap:24971.3100 - Valor CLP Pag:1.0000 - Valor US
Par.Cap:1.138589 - Par.Pag:1.138589 - Valor CLP Cap:718.0398 - Valor CLP Pag:553.8785 - USD:630.6400
Par.Cap:0.025255 - Par.Pag:630.640000 - Valor CLP Cap:24971.3100 - Valor CLP Pag:1.0000 - USD:630.64
*/

GO
