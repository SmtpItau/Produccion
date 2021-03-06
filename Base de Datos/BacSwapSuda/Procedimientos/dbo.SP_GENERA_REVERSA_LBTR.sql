USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_REVERSA_LBTR]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GENERA_REVERSA_LBTR]
(   
     @dFechaHoy   DATETIME  
 )
AS
BEGIN
-- truncate table bac_cnt_Contabiliza
-- delete   bac_cnt_Contabiliza where tipo_Movimiento = 'REV' -- tenia 24
-- select * from bac_cnt_Contabiliza where tipo_Movimiento = 'REV'
-- SP_GENERA_REVERSA_LBTR '20150623' -- select * from SwapGeneral
   SET NOCOUNT ON

   --> Se aplican cambio s Proyecto Mejoras Swap Etapa 1 Abril-Mayo 2008


   --> 1.- Obtiene la Major Valuta
   DECLARE @iMaxDiasValor INTEGER
   SELECT  @iMaxDiasValor = MAX(diasvalor)
   FROM    BacparamSuda..FORMA_DE_PAGO

   --> 2.- Define Fecha Desde
   DECLARE @dFechaDesde   DATETIME
   SET @dFechaDesde = DATEADD(DAY, (@iMaxDiasValor *-1), @dFechaHoy)
   select TOP (@iMaxDiasValor) @dFechaDesde = fechaProc 
      from BacSwapSUda.dbo.SwapGeneralHis 
	  where fechaProc <= @dFechaHoy
	  order by fechaProc desc

   --> 3.- Define Fecha Hasta
   DECLARE @dFechaHasta   DATETIME
   SET @dFechaHasta = DATEADD(DAY, @iMaxDiasValor, @dFechaDesde)
   select TOP (@iMaxDiasValor) @dFechaHasta = fechaProc 
      from BacSwapSUda.dbo.SwapGeneralHis 
	         where fechaProc >= @dFechaDesde
	  order by fechaProc Asc

	  --select  'DEBUG', '@dFechaDesde' = @dFechaDesde, '@dFechaHasta' = @dFechaHasta

	  declare @UltimaFechaSinCaja datetime
	  select  @UltimaFechaSinCaja = @dFechaDesde 
	  select @UltimaFechaSinCaja = Tbfecha from bacParamSuda.dbo.Tabla_General_detalle where tbcateg = 31

    /*********************************
           Yase utilizará este 
		   código por contar con 
		   un proceso de liquidacion
		   solamente hasta la fecha 
		   de pasos a producción: */
    
	    --> 15.- Inserta el Movimiento Contable de TRN que requieren 
		--       reverso.	  
		select Caj.* , fecha_Vcto_Valuta = BacParamSuda.dbo.fx_AGREGA_N_DIAS_HABILES( fechaliquidacion , DiasValor, ';6;' )
					, Pais = Cli.ClPais
		into #TMPCaja
		from BacParamSuda.dbo.TBL_CAJA_DERIVADOS Caj  -- select * from BacParamSuda.dbo.TBL_CAJA_DERIVADOS
			left join BacParamSuda.dbo.Cliente Cli on cli.ClRut = Caj.Rut_Contraparte and cli.Clcodigo = Caj.Codigo_Contraparte 
			left join BacParamSuda.dbo.FORMA_DE_PAGO fp on fp.codigo  = Caj.FormaPago1 
		where fechaLiquidacion between @dFechaDesde and @dFechaHasta 
			and Caj.Modalidad_Pago = 'C'
			and fp.diasvalor > 0
		-- Borra todo lo que no cumple valuta hoy
		delete #TMPCaja where fecha_Vcto_Valuta <> @dFechaHoy

       if @UltimaFechaSinCaja >= @dFechaDesde 
    Begin
	   --> 4.- Rescata Operaciones Entre las Fechas Desde y Hasta
	   SELECT id          = identity(INT)
	   ,      Operacion   = Numero_Operacion
	   ,      Flujo       = Numero_Flujo
	   ,      Tipo        = Tipo_Flujo
	   ,      Pago        = CASE WHEN Tipo_Flujo = 1 THEN recibimos_documento ELSE pagamos_documento END
	   ,      Liquidacion = FechaLiquidacion -- fecha_vence_flujo -- MAP 20080429
	   ,      Dias        = Diasvalor
	   ,      Swap        = Tipo_Swap
	   ,      Moneda      = CASE WHEN Tipo_Flujo = 1 THEN Recibimos_Moneda ELSE Pagamos_moneda END
	   ,      MonedaCap   = CASE WHEN Tipo_Flujo = 1 THEN Compra_Moneda ELSE Venta_moneda END
	   ,      Pais        = clpais
	   ,      Inversion   = Cartera_Inversion
	   ,      Monto       = case when Estado = 'N' then Recibimos_Monto + pagamos_monto  -- PRD XXXX REV no contempla Anticipo
							else 
								Case when Tipo_flujo = 1 
							Then  Compra_Amortiza * IntercPrinc
								+ Compra_Interes 
								+ Compra_Flujo_Adicional 
							Else  Venta_Amortiza * IntercPrinc
								+ Venta_Interes 
								+ Venta_Flujo_Adicional 
							End
							end
	   ,	  Estado
			   ,      LiquidacionOriginal = FechaLiquidacion                       
	   INTO   #MiniCartera
	   FROM   CARTERAHIS
			  LEFT JOIN BacParamSuda..FORMA_DE_PAGO ON codigo = CASE WHEN Tipo_Flujo = 1 THEN recibimos_documento ELSE pagamos_documento END
			  LEFT JOIN BacParamSuda..CLIENTE       ON clrut  = rut_cliente AND clcodigo = codigo_cliente
	   WHERE  FechaLiquidacion BETWEEN @dFechaDesde AND @dFechaHasta
	   AND    Diasvalor  >= 1 
	   AND    Codigo     <> 5 --> Para que no Reverse el Vale Vista (Solicitado por: C. Mascareño)
	   AND    Estado     <> 'C'
	   AND    Modalidad_Pago = 'C' --> Solo para conversación
	   ORDER BY Numero_Operacion , Numero_Flujo , Tipo_Flujo , Diasvalor



	   --> 4.5 .- Convertir a moneda de pago
   
	   UPDATE #MiniCartera   
		  SET Monto = case when Estado <> 'N' then
							  Monto * Case when Moneda <> MonedaCap then -- Convierte cuando es necesario
								isnull(( select vmvalor from BacParamSuda..Valor_Moneda 
								  where     vmcodigo = (case when MonedaCap = 13 then 994 else MonedaCap end )  
										and vmfecha = Liquidacion ),1.0)   					-- 20081119 Se agrega isnull, ya que para MonedaCap 999  no existe valor, por lo cual debe ser 1
							  / isnull(( select vmvalor from BacParamSuda..Valor_Moneda 
								  where     vmcodigo = (case when Moneda = 13 then 994 else Moneda end )  
										and vmfecha = Liquidacion ),1.0)					-- 20081119 Se agrega isnull, ya que para Moneda 999  no existe valor, por lo cual debe ser 1
							  else 1.0 end
					   else
							  Monto
					   end
   

	   --> 5.- Genera Indices para Mejorar Rendimiento 
	   CREATE INDEX #ix_MiniCartera_1 ON #MiniCartera (id)
	   CREATE INDEX #ix_MiniCartera_2 ON #MiniCartera (Operacion, Flujo, Tipo)
	   CREATE INDEX #ix_MiniCartera_3 ON #MiniCartera (Liquidacion)
	   CREATE INDEX #ix_MiniCartera_4 ON #MiniCartera (Tipo)


	   --> 6.- Inicializa Variable
	   DECLARE @Aux_Id        INTEGER
			   declare @op            NUMERIC(10)
	   SELECT  @Aux_Id        = MIN(Id)
	   FROM    #MiniCartera

	   DECLARE @Liquidacion   DATETIME
	   DECLARE @iDias         INTEGER

	   --> 7.- Proceso de Regeneración de Fecha en Base a los Dias Feriados.
	   WHILE (1=1)
	   BEGIN
		  SELECT @Liquidacion  = Liquidacion
		  ,      @iDias        = Dias
				  ,      @op           = Operacion
		  FROM   #MiniCartera
	   WHERE  Id            = @Aux_Id
      
		  IF @@ROWCOUNT = 0
	   BEGIN
			 BREAK
		  END
				  -- EXECUTE BacTraderSuda..SP_BUSCA_FECHA_HABIL @Liquidacion , @iDias , @Liquidacion OUTPUT
				  -- Esto calcula mal las fechas !!!
				  select @Liquidacion = BacParamSuda.dbo.fx_AGREGA_N_DIAS_HABILES( @Liquidacion ,  @iDias, ';6;' )

		  UPDATE #MiniCartera
		  SET    Liquidacion   = @Liquidacion
		  WHERE  Id            = @Aux_Id

		  SET @Aux_Id = @Aux_Id + 1
	   END

	   --> 8.- Elimina las Operaciones que no deben ser Reversadas por Valuta
	   DELETE #MiniCartera 
		WHERE Liquidacion <> @dFechaHoy

	   DELETE #MiniCartera
		WHERE Monto = 0

			   delete #MiniCartera where #MiniCartera.Operacion in ( select Numero_Operacion from #TMPCaja) 

			   -- select 'debug 01', * from #MiniCartera

	   --> 9.- Obtiene Los Flujos de Compra Entre las Fechas Desde y Hasta
	   DECLARE @iCantCompras    INTEGER
	   SELECT  @iCantCompras = COUNT(1) FROM #MiniCartera compra WHERE (Tipo = 1)

	   --> 10.- Obtiene Los Flujos de Venta  Entre las Fechas Desde y Hasta
	   DECLARE @iCantVentas     INTEGER
	   SELECT  @iCantVentas  = COUNT(1) FROM #MiniCartera venta  WHERE (Tipo = 2)

	   --> 11.- Genéra Tabla solo con Operacion y Monto para Realizar la Compensación 
	   SELECT Operacion AS OperacionC , Monto AS MontoC INTO #Compra FROM #MiniCartera WHERE Tipo = 1
	   SELECT Operacion AS OperacionV , Monto AS MontoV INTO #Venta  FROM #MiniCartera WHERE Tipo = 2

	   --> 12.- Genera indices de Obtimización de Rendimiento
	   CREATE INDEX #ix_#Compra_1 ON #Compra (OperacionC)
	   CREATE INDEX #ix_#Compra_1 ON #Venta  (OperacionV)


	   --> 13.- Identifica Que Tipo de Flujo Manda, Por los Vencimientos Disparejos de Flujos.
	   -- este criterio es incorrecto ya que nodistingue operaciones.
	   -- el 20131126 se ve que en las compras queda la operacion 1072 y en las ventas la 1073 
	   -- la cantidad de compras y ventas queda igual pero son distintas operaciones
	   --IF @iCantCompras >= @iCantVentas
	   --BEGIN

		  --> 14.- Realiza la Compensación
		  -- MAP DJ
		  UPDATE #Venta
			 SET MontoV     = - MontoV

		  UPDATE #Compra
			 SET MontoC     = MontoC + MontoV   -- MAP DJ
			FROM #Venta
		   WHERE OperacionC = OperacionV

		  --> 15.- Inserta el Movimiento Contable	  
				    
		  INSERT INTO BAC_CNT_CONTABILIZA
		  (   id_sistema      , tipo_movimiento, tipo_operacion, operacion, correlativo, codigo_instrumento, moneda_instrumento, tipo_cliente, cartera_inversion
		  ,   Devengo_Utilidad, Devengo_Perdida, Documento_Pago, Documento_Recibo
		  ,   TipOper
		  ) 
		  SELECT  'id_Sistema'         = 'PCS'
		  ,       'Tipo_Movimiento'    = 'REV'
		  ,       'Tipo_Operacion'     = CONVERT(VARCHAR(5),'R' + RTRIM(LTRIM(Swap)) ) -- + CASE WHEN Tipo = 1 THEN 'C' ELSE 'V' END)
		  ,       'Operacion'          = Operacion
		  ,       'Correlativo'        = 1
		  ,       'Codigo_Instrumento' = case when Swap = '4' then convert(char(3), MonedaCap ) else '' end -- MAP 20081003 Para permitir distingir según moneda capital
		  ,       'Moneda_Instrumento' = LTRIM(Moneda)
		  ,       'Tipo_Cliente'       = CASE WHEN Pais = 6 THEN '1' ELSE '2' END
		  ,       'Cartera_Inversion'  = Inversion
		  ,       'Devengo_Utilidad'   = ABS(CASE WHEN MontoC >= 0 THEN MontoC ELSE 0 END)
	 ,       'Devengo_Perdida'    = ABS(CASE WHEN MontoC  < 0 THEN MontoC ELSE 0 END)
		  ,       'Documento_Pago'     = Pago -- ABS(CASE WHEN MontoC >= 0 THEN Pago   ELSE 0 END)
		  ,       'Documento_Recibo'   = Pago -- ABS(CASE WHEN MontoC  < 0 THEN Pago   ELSE 0 END)
		  ,       'TipOper'            = 'N'
		  FROM    #MiniCartera
				  INNER JOIN #Compra ON OperacionC = Operacion
		  WHERE   Tipo                 = 1

	--   END ELSE
	--   BEGIN
	--      --> 14.- Realiza la Compensación
	--      UPDATE #Venta
	--         SET MontoV     = MontoC - MontoV
	--        FROM #Compra
	--       WHERE OperacionC = OperacionV
	--      --> 15.- Inserta el Movimiento Contable
	--      INSERT INTO BAC_CNT_CONTABILIZA
	--      (   id_sistema      , tipo_movimiento, tipo_operacion, operacion, correlativo, codigo_instrumento, moneda_instrumento, tipo_cliente, cartera_inversion
	--      ,   Devengo_Utilidad, Devengo_Perdida, Documento_Pago, Documento_Recibo
	--      ,   TipOper
	--      )
		  UNION
		  SELECT  'id_Sistema'         = 'PCS'
		  ,       'Tipo_Movimiento'    = 'REV'
		  ,       'Tipo_Operacion'     = CONVERT(VARCHAR(5),'R' + RTRIM(LTRIM(Swap)) ) -- + CASE WHEN Tipo = 1 THEN 'C' ELSE 'V' END)
		  ,       'Operacion'          = Operacion
		  ,       'Correlativo'        = 1
		  ,       'Codigo_Instrumento' = case when Swap = '4' then convert(char(3),MonedaCap ) else '' end -- MAP 20081003 Para permitir distingir según moneda capital
		  ,       'Moneda_Instrumento' = Moneda
		  ,       'Tipo_Cliente'       = CASE WHEN Pais = 6 THEN '1' ELSE '2' END
		  ,       'Cartera_Inversion'  = Inversion
		  ,       'Devengo_Utilidad'   = ABS(CASE WHEN MontoV >= 0 THEN MontoV ELSE 0 END)
		  ,       'Devengo_Perdida'    = ABS(CASE WHEN MontoV  < 0 THEN MontoV ELSE 0 END)
		  ,       'Documento_Pago'     = Pago -- ABS(CASE WHEN MontoV >= 0 THEN Pago   ELSE 0 END)
		  ,       'Documento_Recibo'   = Pago -- ABS(CASE WHEN MontoV  < 0 THEN Pago   ELSE 0 END)
		  ,       'TipOper'            = 'N'
		  FROM    #MiniCartera
				  INNER JOIN #Venta ON OperacionV = Operacion
		  WHERE   Tipo                 = 2
					  and operacion not in ( select OperacionC from #Compra )
	--   END
			/**********************************

			   se utilizará este 
			   código hasta la fecha de paso a 
			   producción inclusive    
		   ************************************************/
     end
		 -- fechas Sin Caja


		  INSERT INTO BAC_CNT_CONTABILIZA
		  (   id_sistema      , tipo_movimiento, tipo_operacion, operacion, correlativo, codigo_instrumento, moneda_instrumento, tipo_cliente, cartera_inversion
		  ,   Devengo_Utilidad, Devengo_Perdida, Documento_Pago, Documento_Recibo
		  ,   TipOper
		  ) 
		  SELECT  'id_Sistema'         = 'PCS'
		  ,       'Tipo_Movimiento'    = 'REV'
		  ,       'Tipo_Operacion'     = CONVERT(VARCHAR(5),'R' + RTRIM(LTRIM(Tbl.Producto )) ) 
		  ,       'Operacion'          = Tbl.Numero_Operacion 
		  ,       'Correlativo'        = 1
		  ,       'Codigo_Instrumento' = case when tbl.Producto = '4' then convert(char(3), 
																						 Compra_moneda 
																					  + venta_moneda * (case when Compra_moneda <> 0 
																										then 0 else 1 end )
																					   ) else '' end 
		  ,       'Moneda_Instrumento' = LTRIM(tbl.MonedaM1 )
		  ,       'Tipo_Cliente'       = CASE WHEN Pais = 6 THEN '1' ELSE '2' END
		  ,       'Cartera_Inversion'  = 0 -- Inversion
		  ,       'Devengo_Utilidad'   = ABS(CASE WHEN tbl.MontoM1Local   >= 0 THEN tbl.MontoM1Local   ELSE 0 END)
		  ,       'Devengo_Perdida'    = ABS(CASE WHEN tbl.MontoM1Local    < 0 THEN tbl.MontoM1Local   ELSE 0 END)
		  ,       'Documento_Pago'     = tbl.FormaPago1  -- ABS(CASE WHEN MontoC >= 0 THEN Pago   ELSE 0 END)
		  ,       'Documento_Recibo'   = tbl.FormaPago1  -- ABS(CASE WHEN MontoC  < 0 THEN Pago   ELSE 0 END)
		  ,       'TipOper'            = 'N'
		  FROM    #TMPCaja Tbl


		BEGIN TRY
			drop table #TMPCaja
			drop table #MiniCartera
			drop table #Compra
			drop table #Venta    
		END TRY      
		BEGIN CATCH
			
		END CATCH

END
GO
