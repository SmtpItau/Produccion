USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_RCM_CCS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REPORTES_RCM_CCS]
	(	@Fecha			DATETIME = NULL
	)
AS
DECLARE @FechaDesde	    DATETIME	     
DECLARE @FechaHasta	    DATETIME
DECLARE @Fecha_anterior DATETIME	 
DECLARE @PCS		    CHAR(3)
  
BEGIN   

	SET NOCOUNT ON	

	IF(@Fecha IS NULL OR @Fecha = '')
	   BEGIN

		  SET @PCS = 'PCS'
			 	
		  EXEC SP_FECHAPROC_RCM @PCS,NULL,@Fecha OUTPUT
		  
		  SET @FechaDesde = @Fecha	  
		  SET @FechaHasta = @Fecha
		  
		  SELECT @Fecha_anterior = sg.fechaant 
		  FROM BacSwapSuda.dbo.SwapGeneral sg		  		  
	   END
	ELSE 
	   BEGIN
	   	  SET @FechaDesde = @Fecha	  
		  SET @FechaHasta = @Fecha
		  
		  SELECT @Fecha_anterior = sg.fechaant 
		  FROM BacSwapSuda.dbo.SwapGeneralHis sg
		  WHERE sg.fechaproc = @Fecha
	   END
	 select  numero_operacion
			,  compra_capital
			,  compra_moneda
			,  compra_valor_tasa
			,  compra_codigo_tasa
			,  compra_spread
			,  compra_amortiza
			,  numero_flujo
			,  tipo_flujo
			,  venta_capital
			,  venta_moneda
			,  venta_valor_tasa
			,  venta_codigo_tasa
			,  venta_spread
			,  Venta_Amortiza  
			,  fecha_termino
			,  fecha_vence_flujo
			,  estado
			,  Estado_oper_lineas
			,  IntercPrinc
			,  fecha_inicio_flujo
			,  tipo_swap
			,  operador
			,  fecha_cierre
			,  fecha_inicio
			,  rut_cliente
			,  codigo_cliente
			,  tipo_operacion
	 into #CARTERA
			from BacSwapSuda.dbo.cartera where 1 = 2

	 select    numero_operacion
			,  compra_capital
			,  compra_moneda
			,  compra_valor_tasa
			,  compra_codigo_tasa
			,  compra_spread
			,  compra_amortiza
			,  numero_flujo
			,  tipo_flujo
			,  venta_capital
			,  venta_moneda
			,  venta_valor_tasa
			,  venta_codigo_tasa
			,  venta_spread
			,  Venta_Amortiza  
			,  fecha_termino
			,  fecha_vence_flujo
			,  estado
			,  Estado_oper_lineas
			,  IntercPrinc
			,  fecha_inicio_flujo
			,  tipo_swap
			,  operador
			,  fecha_cierre
			,  fecha_inicio
			,  rut_cliente
			,  codigo_cliente
			,  tipo_operacion
	 into #CARTERANY
			from BacSwapNY.dbo.cartera where 1 = 2

	-- Cartera
	if @fecha = ( select fechaProc from BacSwapSuda.dbo.SwapGeneral )
	Begin
	insert into #CARTERA
	   select   numero_operacion
			,  compra_capital
			,  compra_moneda
			,  compra_valor_tasa
			,  compra_codigo_tasa
			,  compra_spread
			,  compra_amortiza
			,  numero_flujo
			,  tipo_flujo
			,  venta_capital
			,  venta_moneda
			,  venta_valor_tasa
			,  venta_codigo_tasa
			,  venta_spread
			,  Venta_Amortiza  
			,  fecha_termino
			,  fecha_vence_flujo
			,  estado
			,  Estado_oper_lineas
			,  IntercPrinc
			,  fecha_inicio_flujo
			,  tipo_swap
			,  operador
			,  fecha_cierre
			,  fecha_inicio
			,  rut_cliente
			,  codigo_cliente
			,  tipo_operacion
			from BacSwapSuda.dbo.cartera
	End 
	Else
	Begin
	   insert into #CARTERA
	   select   numero_operacion
			,  compra_capital
			,  compra_moneda
			,  compra_valor_tasa
			,  compra_codigo_tasa
			,  compra_spread
			,  compra_amortiza
			,  numero_flujo
			,  tipo_flujo
			,  venta_capital
			,  venta_moneda
			,  venta_valor_tasa
			,  venta_codigo_tasa
			,  venta_spread
			,  Venta_Amortiza  
			,  fecha_termino
			,  fecha_vence_flujo
			,  estado
			,  Estado_oper_lineas
			,  IntercPrinc
			,  fecha_inicio_flujo
			,  tipo_swap
			,  operador
			,  fecha_cierre
			,  fecha_inicio
			,  rut_cliente
			,  codigo_cliente
			,  tipo_operacion
			from BacSwapSuda.dbo.carteraRES where fecha_proceso = @fecha
	End   

	if @fecha = ( select fechaProc from BacSwapNY.dbo.SwapGeneral )
	Begin
	insert into #CARTERANY
	   select   numero_operacion
			,  compra_capital
			,  compra_moneda
			,  compra_valor_tasa
			,  compra_codigo_tasa
			,  compra_spread
			,  compra_amortiza
			,  numero_flujo
			,  tipo_flujo
			,  venta_capital
			,  venta_moneda
			,  venta_valor_tasa
			,  venta_codigo_tasa
			,  venta_spread
			,  Venta_Amortiza  
			,  fecha_termino
			,  fecha_vence_flujo
			,  estado
			,  Estado_oper_lineas
			,  IntercPrinc
			,  fecha_inicio_flujo
			,  tipo_swap
			,  operador
			,  fecha_cierre
			,  fecha_inicio
			,  rut_cliente
			,  codigo_cliente
			,  tipo_operacion
			from BacSwapNY.dbo.cartera
	End 
	Else
	Begin
	   insert into #CARTERANY
	   select   numero_operacion
			,  compra_capital
			,  compra_moneda
			,  compra_valor_tasa
			,  compra_codigo_tasa
			,  compra_spread
			,  compra_amortiza
			,  numero_flujo
			,  tipo_flujo
			,  venta_capital
			,  venta_moneda
			,  venta_valor_tasa
			,  venta_codigo_tasa
			,  venta_spread
			,  Venta_Amortiza  
			,  fecha_termino
			,  fecha_vence_flujo
			,  estado
			,  Estado_oper_lineas
			,  IntercPrinc
			,  fecha_inicio_flujo
			,  tipo_swap
			,  operador
			,  fecha_cierre
			,  fecha_inicio
			,  rut_cliente
			,  codigo_cliente
			,  tipo_operacion
			from BacSwapNY.dbo.carteraRES where fecha_proceso = @fecha
	End

	-- MAP 20170411
	-- Datos de la operación vigente al dia anterior 
	select distinct CarRes.numero_operacion, CarRes.fecha_cierre, CarRes.fecha_termino, CarRes.fecha_inicio
	into #CarteraRESAnt
	from BacSwapSuda.dbo.carteraRES CarRes
	where CarRes.Estado not in ( 'N' )
	  and CarRes.Fecha_Proceso = @Fecha_anterior
	  and CarRes.tipo_Swap = 2


	CREATE TABLE #RESULTADOS_CCS
	(  [Type] varchar(250)
	   ,[Contract Update Reason] varchar(250)
	   ,[Part Account] varchar(250)
	   ,[Part Position] varchar(250)
	   ,[Part Code] varchar(250)
	   ,[Part CPF/CNPJ] varchar(250)
	   ,[Part] varchar(250)
	   ,[Counterpart Indentified] varchar(250)
	   ,[Counterpart Position] varchar(250)
	   ,[Counterpart Code] varchar(250)
	   ,[Counterpart CPF/CNPJ] varchar(250)
	   ,[Counterpart] varchar(250)
	   ,[Derivative Type] varchar(250)
	   ,[Trading Place] varchar(250)
	   ,[Contract Number] varchar(250)
	   ,[Notional Amount] varchar(250)
	   ,[Reference Currency] varchar(3)
	   ,[Settlement Reference Currency] varchar(3)
	   ,[Underlying asset] varchar(250)
	   ,[Trade Date] varchar(250)
	   ,[Effective Date] varchar(250)
	   ,[Settlement Date] varchar(250)
	   ,[Asset Index] varchar(250)
	   ,[Liability Index] varchar(250)
	   ,[Asset Rate Percent] varchar(250)
	   ,[Liability Rate Percent] varchar(250)
	   ,[Asset Notional Amount] varchar(250)
	   ,[Asset Referency Currency] varchar(3)
	   ,[Liability Notional Amount] varchar(250)
	   ,[Liability Referency Currency] varchar(3)
	   ,[Asset Spread] varchar(250)
	   ,[Liability Spread] varchar(250)
	   ,[Cash-Flow] varchar(250)
	   ,[Cash Flow Number] varchar(250)
	   ,[Country Origin] varchar(250)
	   ,[Registration] varchar(250)
	   ,[Derivative Master Agreement] varchar(250)
	   ,[Barrier] varchar(250)
	   ,[Settlement Rate Type] varchar(250)
	   ,[Addicional information] varchar(250)
	   ,[DCE Contract] varchar(250)
	   ,[US Person] varchar(250)
	   ,[OTC] varchar(250)
	   ,[Dealing Activity] varchar(250)
	   ,[IntraGroup] varchar(250)
	   ,[Unwind] varchar(250)
	   ,[Trade Done In Brazil] varchar(250)
	   ,[USD Notional] varchar(250)
	   , [Numero_Operacion] numeric(15)  -- Numero de Contrato BAC
	   , [Origen] varchar(20)            -- Chile o NY
	   , [Compra_Moneda] numeric(5)      -- Para alimentar funcion de 
	                                     -- conversión en anticipos 
										 -- parciales
	   , [Effective Date Como Fecha] datetime
	)

		--> Ingresos CCS	
		---------------------------------------------------------------			 
		  INSERT INTO #RESULTADOS_CCS
		  SELECT --dbo.Fx_Convalida_Tipos(9,1,1,(dbo.fx_RetornaEstadoSwap(Swap.numero_operacion,@FechaDesde,@Fechahasta,Swap.origen)),0) AS [Type]
			 'I' AS [Type]
			 --,CASE WHEN dbo.Fx_Convalida_Tipos(9,1,1,(dbo.fx_RetornaEstadoSwap(Swap.numero_operacion,@FechaDesde,@Fechahasta,Swap.origen)),0) = 'U' THEN 'Unwind' ELSE '' END AS [Contract Update Reason] 
			 ,'' AS [Contract Update Reason] 
			 ,'N/A' AS [Part Account] 
			 ,dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Swap.tipo_operacion),1) AS [Part Position] 
			 ,CASE WHEN Swap.origen = 'TR-' then dbo.Fx_Convalida_Tipos(35,1,1,'',1) ELSE dbo.Fx_Convalida_Tipos(38,1,1,'',1) end AS [Part Code]
			 ,'N/A' AS [Part CPF/CNPJ] 
			 ,case when Swap.origen = 'TR-' then dbo.Fx_Convalida_Tipos(34,1,1,'',1) else dbo.Fx_Convalida_Tipos(37,1,1,'',1) end AS [Part] 
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
					   FROM TBL_CONTRATOUSD_PASO cp 
					   WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
					   AND cp.id = (SELECT max(cp2.id) 
								 FROM TBL_CONTRATOUSD_PASO cp2 
								 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 'Yes'
			  ELSE 'No' END AS [Counterpart Indentified]
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Swap.tipo_operacion),1) = 'SELLER' THEN 'BUYER' ELSE 'SELLER' END AS [Counterpart Position] 
			 ,'' AS [Counterpart Code] 
			 ,'N/A' AS [Counterpart CPF/CNPJ] 
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
						 FROM TBL_CONTRATOUSD_PASO cp 
						 WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
						 AND cp.id = (SELECT max(cp2.id) 
									  FROM TBL_CONTRATOUSD_PASO cp2 
									  WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 
								(SELECT cp.nombre_cliente FROM TBL_CONTRATOUSD_PASO cp 
								 WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
								 AND cp.id = (SELECT max(cp2.id) 
											 FROM TBL_CONTRATOUSD_PASO cp2 
											 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')))
			  ELSE '' END AS [Counterpart]
			 ,'CCS' AS [Derivative Type] 
			 ,'OTC' AS [Trading Place] 
			 ,Swap.origen + CONVERT(varchar(50),Swap.numero_operacion) AS [Contract Number] 
			 ,CONVERT(numeric(32,2),ROUND(Swap.compra_capital,2)) AS [Notional Amount] 
			 ,(CASE WHEN Swap.compra_moneda = 'UF' THEN 'CLF' ELSE Swap.compra_moneda END) AS [Reference Currency] 
			 ,(CASE WHEN Swap.venta_moneda = 'UF' THEN 'CLF' ELSE Swap.venta_moneda END) AS [Settlement Reference Currency] 
			 ,'N/A' AS [Underlying asset] 
			 ,CONVERT(varchar,Swap.fecha_cierre,3) AS [Trade Date] 
			 ,CONVERT(varchar,Swap.fecha_inicio,3) AS [Effective Date] 
			 ,CONVERT(varchar,Swap.fecha_termino,3) AS [Settlement Date]
			 ,dbo.Fx_Tasas_Moneda(Swap.compra_cod_tasa,(CASE WHEN Swap.compra_moneda = 'UF' THEN 'CLF' ELSE Swap.compra_moneda END)) AS [Asset Index] 
			 ,dbo.Fx_Tasas_Moneda(Swap.venta_cod_tasa,(CASE WHEN Swap.venta_moneda = 'UF' THEN 'CLF' ELSE Swap.venta_moneda END)) AS [Liability Index] 			  
			 ,format(Swap.compra_valor_tasa,N'0.00') AS [Asset Rate Percent] 
			 ,format(Swap.venta_valor_tasa,N'0.00') AS [Liability Rate Percent] 
			 ,convert(numeric(32,2),round(Swap.compra_capital,2)) AS [Asset Notional Amount] 
			 ,(CASE WHEN Swap.compra_moneda = 'UF' THEN 'CLF' ELSE Swap.compra_moneda END) AS [Asset Referency Currency] 
			 ,convert(numeric(32,2),round(Swap.venta_capital,2)) AS [Liability Notional Amount] 
			 ,(CASE WHEN Swap.venta_moneda = 'UF' THEN 'CLF' ELSE Swap.venta_moneda END) AS [Liability Referency Currency] 
			 ,convert(numeric(32,2),round(Swap.compra_spread,2)) AS [Asset Spread] 
			 ,convert(numeric(32,2),round(Swap.venta_spread,2)) AS [Liability Spread] 
			 ,case when Swap.number_cash_flow > 1 OR Swap.number_cash_flow_p > 1 then 'Yes' else 'No' end AS [Cash-Flow] 	   
			 ,CASE WHEN Swap.number_cash_flow > 1 OR Swap.number_cash_flow_p > 1 then 
		  		    CASE WHEN Swap.number_cash_flow >= Swap.number_cash_flow_p THEN convert(varchar,Swap.number_cash_flow)
				    else convert(varchar,Swap.number_cash_flow_p) END				    
			 ELSE '' end AS [Cash Flow Number] 
			 ,'CHILE' AS [Country Origin] 
			 ,'' AS [Registration] 
			 ,case when (select top 1 tipo_contrato from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')) = 'ISDA'
			 then 'ISDA' else 'CGD' end AS [Derivative Master Agreement]	
			 ,'N.A.' AS [Barrier] 
			 ,'Final' AS [Settlement Rate Type] 
			 ,'Asset Notional Amount: ' + convert(varchar,format(convert(numeric(32,2),round(Swap.compra_capital,2)),N'N')) + 
			 ' / Asset Referency Currency: '  + LTRIM(RTRIM((CASE WHEN Swap.compra_moneda = 'UF' THEN 'CLF' ELSE Swap.compra_moneda END))) + 
			 ' / Asset Rate Percent: ' + convert(varchar,format(Swap.compra_valor_tasa,N'0.00')) + 
			 ' / Liability Notional Amount: ' + convert(varchar,format(convert(numeric(32,2),round(Swap.venta_capital,2)),N'N')) + 
			 ' / Liability Referency Currency: ' + LTRIM(RTRIM((CASE WHEN Swap.venta_moneda = 'UF' THEN 'CLF' ELSE Swap.venta_moneda END))) + 
			 ' / Asset Rate Percent: ' + convert(varchar,format(Swap.venta_valor_tasa,N'0.00'))  AS [Addicional information] 			
			 ,ISNULL(dbo.Fx_DCE_contract(Swap.origen + CONVERT(varchar(50),Swap.numero_operacion),'CCS'),'')AS [DCE Contract] 
			 ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')),0) = 0 
			  then 'No' else 'Yes' end AS [US Person] 
			 ,'Yes' AS [OTC] 
			 ,'No' AS [Dealing Activity] 
			 ,'No' AS [IntraGroup] 
			 ,'No' AS [Unwind] 
			 ,'No' AS [Trade Done In Brazil] 
			 --,convert(numeric(36,2),round(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,swap.compra_codmoneda,Swap.compra_capital,13),2)) AS [USD Notional] 		
			 ,CONVERT(NUMERIC(36,2),ROUND(CASE WHEN Swap.compra_moneda = 'USD' THEN Swap.compra_capital
									   WHEN Swap.venta_moneda = 'USD' THEN Swap.venta_capital
			  ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,swap.compra_codmoneda,Swap.compra_capital,13) END,2)) AS [USD Notional]		 			 
			 , [Numero_Operacion] = swap.numero_operacion  -- MAP 20170411
			 , [Origen]            = swap.origen
			 , [Compra_Moneda]     = Swap.compra_codmoneda
			 , [Effective Date Como Fecha] = Swap.fecha_inicio
		   from	(	select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa, Compra.Tasa_Transfer
					   ,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador,		Compra.Res_Mesa_Dist_CLP, Compra.fecha_cierre
					   ,		Venta_Moneda	= Venta.Venta_Moneda
					   ,		venta_codmoneda = Venta.venta_codmoneda
					   ,		Compra_Moneda	= Mon.mnnemo
					   ,		compra_codmoneda = Mon.mncodmon
					   ,		compra.Rut_Cliente, compra.codigo_cliente
					   ,		Compra.fecha_termino
					   ,		compra.tipo_operacion
					   ,		Venta.venta_spread
					   ,		compra.compra_spread
					   ,      compra.fecha_inicio
					   ,		number_cash_flow = (select count(compra1.numero_flujo)
										     from BacSwapSuda.dbo.MovDiario compra1 
										     where compra1.numero_operacion = Compra.numero_operacion 
										     and compra1.tipo_flujo = 1
											and compra1.compra_amortiza <> 0)
					   ,		compra_amortiza = (select compra1.compra_amortiza
										    from BacSwapSuda.dbo.MovDiario compra1  
										    where compra1.numero_operacion = Compra.numero_operacion  
										    and compra1.tipo_flujo = 1
										    and compra1.numero_flujo = (select max(numero_flujo)
																  from BacSwapSuda.dbo.MovDiario
																  where numero_operacion = Compra.numero_operacion  
																  and tipo_flujo = 1)
										    and compra1.compra_amortiza <> 0)
					   ,			origen  = 'TR-'
					   ,		number_cash_flow_p = (select count(compra1.numero_flujo)
											    from BacSwapSuda.dbo.MovDiario compra1 
											    where compra1.numero_operacion = Compra.numero_operacion 
											    and compra1.tipo_flujo = 2
											    and compra1.venta_amortiza <> 0)
					   ,		compra_amortiza_p = (select compra1.venta_amortiza
											   from BacSwapSuda.dbo.MovDiario compra1  
											   where compra1.numero_operacion = Compra.numero_operacion  
											   and compra1.tipo_flujo = 2
											   and compra1.numero_flujo = (select max(numero_flujo)
																	 from BacSwapSuda.dbo.MovDiario
																	 where numero_operacion = Compra.numero_operacion  
																	 and tipo_flujo = 2)
											   and compra1.venta_amortiza <> 0)	
					   ,		compra_cod_tasa  = compra_codigo_tasa
					   ,		venta_cod_tasa	  = Venta.venta_codigo_tasa										   									    
								   									    
					   from	BacSwapSuda.dbo.MovDiario Compra with(nolock)
							   inner join (	select Contrato		= md.numero_operacion
											       , Flujo_act	= Min(md.numero_flujo)
											       , Flujo_pas	= (SELECT MIN(md2.numero_flujo)
											       				   FROM BacSwapSuda.dbo.MovDiario MD2 WITH(NOLOCK) 
											       				   WHERE md2.Estado 		  = ''
											       				   AND 	 md2.tipo_flujo 	  = 2
											       				   AND 	 md2.numero_operacion = md.numero_operacion)
											       from	BacSwapSuda.dbo.MovDiario md with(nolock)
											       where md.Estado 		= '' 
											       and 	 md.tipo_flujo 	= 1
											       group by md.numero_operacion
										   )	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
													   and	GrpSwap.Flujo_act	= Compra.numero_flujo

							   inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo, venta_spread,
											 venta_codmoneda = Mon.mncodmon, venta_codigo_tasa
											   from	BacSwapSuda.dbo.MovDiario	with(nolock)
													   inner join (	select	mncodmon, mnnemo 
																	   from	BacParamSuda.dbo.Moneda with(nolock)
																   )	Mon On	Mon.mncodmon	= Venta_Moneda
											   where	Estado		= ''
											   and		tipo_flujo		= 2
										   )	Venta	On	Venta.numero_operacion	= GrpSwap.Contrato
													   and	Venta.numero_flujo		= GrpSwap.flujo_pas
													   
							   inner join (	select	mncodmon, mnnemo
											   from	BacParamSuda.dbo.Moneda with(nolock)
										   )	Mon On	Mon.mncodmon	= Compra.compra_Moneda
					   where	Estado_oper_lineas 	NOT IN ('P')
					   and 		Estado 			= ''
					   and		tipo_flujo		= 1

					   union

					   select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa, Compra.Tasa_Transfer
					   ,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador,		Compra.Res_Mesa_Dist_CLP, Compra.fecha_cierre
					   ,		Venta_Moneda	= Venta.Venta_Moneda
					   ,		venta_codmoneda = Venta.venta_codmoneda
					   ,		Compra_Moneda	= Mon.mnnemo
					   ,		compra_codmoneda = Mon.mncodmon
					   ,		compra.Rut_Cliente, compra.codigo_cliente
					   ,		fecha_termino	= Compra.fecha_termino
					   ,		tipo_operacion = compra.tipo_operacion
					   ,		Venta.venta_spread 
					   ,		compra.compra_spread
					   ,      compra.fecha_inicio
					   ,		number_cash_flow = (select count(compra1.numero_flujo)
										     from BacSwapSuda.dbo.MovHistorico compra1 
										     where compra1.numero_operacion = Compra.numero_operacion 
										     and compra1.tipo_flujo = 1
											 and compra1.compra_amortiza <> 0)
					   ,		compra_amortiza = (select compra1.compra_amortiza
										    from BacSwapSuda.dbo.MovHistorico compra1  
										    where compra1.numero_operacion = Compra.numero_operacion  
										    and compra1.tipo_flujo = 1
										    and compra1.numero_flujo = (select max(numero_flujo)
																  from BacSwapSuda.dbo.MovHistorico
																  where numero_operacion = Compra.numero_operacion  
																  and tipo_flujo = 1)
											and compra1.compra_amortiza <> 0)
					   ,			origen  = 'TR-'
					   ,		number_cash_flow_p = (select count(compra1.numero_flujo)
											    from BacSwapSuda.dbo.MovHistorico compra1 
											    where compra1.numero_operacion = Compra.numero_operacion 
											    and compra1.tipo_flujo = 2
											    and compra1.venta_amortiza <> 0)
					   ,		compra_amortiza_p = (select compra1.venta_amortiza
											   from BacSwapSuda.dbo.MovHistorico compra1  
											   where compra1.numero_operacion = Compra.numero_operacion  
											   and compra1.tipo_flujo = 2
											   and compra1.numero_flujo = (select max(numero_flujo)
																	 from BacSwapSuda.dbo.MovHistorico
																	 where numero_operacion = Compra.numero_operacion  
																	 and tipo_flujo = 2)
											   and compra1.venta_amortiza <> 0)
					   ,		compra_cod_tasa  = compra_codigo_tasa
					   ,		venta_cod_tasa	  = Venta.venta_codigo_tasa											   													
										   													
					   from	BacSwapSuda.dbo.MovHistorico	Compra	with(nolock)

							   inner join (	select  Contrato	= mh.numero_operacion
												,   Flujo_act	= Min(mh.numero_flujo)
												,   Flujo_pas	= (SELECT MIN(mh2.numero_flujo) 
																   FROM BacSwapSuda.dbo.MovHistorico mh2 WITH(NOLOCK) 
																   WHERE mh2.Estado			  = ''
																   AND   mh2.tipo_flujo		  = 2
																   AND   mh2.numero_operacion = mh.numero_operacion)
											from   BacSwapSuda.dbo.MovHistorico mh with(nolock)
											WHERE  mh.fecha_cierre		  BETWEEN @FechaDesde AND @FechaHasta  
											and	   mh.Estado			  = '' 
											and	   mh.tipo_flujo		  = 1
											group by mh.numero_operacion
										   )	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
													   and	GrpSwap.Flujo_act	= Compra.numero_flujo

							   inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo, venta_spread,
											 venta_codmoneda = Mon.mncodmon, venta_codigo_tasa
											   from	BacSwapSuda.dbo.MovHistorico	with(nolock)
													   inner join (	select	mncodmon, mnnemo 
																	   from	BacParamSuda.dbo.Moneda with(nolock)
																   )	Mon On	Mon.mncodmon	= Venta_Moneda
											   where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
											   and		Estado			= ''
											   and		tipo_flujo		= 2
										   )	Venta	On	Venta.numero_operacion	= GrpSwap.Contrato
													   and	Venta.numero_flujo		= GrpSwap.Flujo_pas

							   inner join (	select	mncodmon, mnnemo
											   from	BacParamSuda.dbo.Moneda with(nolock)
										   )	Mon On	Mon.mncodmon	= Compra.compra_Moneda

					   where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
					   and		Estado_oper_lineas 	NOT IN ('P')
					   and 		Estado 			= ''
					   and		tipo_flujo		= 1
					   /*SWAP NY*/
					   UNION	 
					   select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa, Compra.Tasa_Transfer
					   ,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador,		Compra.Res_Mesa_Dist_CLP, Compra.fecha_cierre
					   ,		Venta_Moneda	= Venta.Venta_Moneda
					   ,		venta_codmoneda = Venta.venta_codmoneda
					   ,		Compra_Moneda	= Mon.mnnemo
					   ,		compra_codmoneda = Mon.mncodmon
					   ,		compra.Rut_Cliente, compra.codigo_cliente
					   ,		Compra.fecha_termino
					   ,		compra.tipo_operacion
					   ,		Venta.venta_spread
					   ,		compra.compra_spread
					   ,      compra.fecha_inicio
					   ,		number_cash_flow = (select count(compra1.numero_flujo)
										     from BacSwapNY.dbo.MovDiario compra1 
										     where compra1.numero_operacion = Compra.numero_operacion 
										     and compra1.tipo_flujo = 1
											and compra1.compra_amortiza <> 0)
					   ,		compra_amortiza = (select compra1.compra_amortiza
										    from BacSwapNY.dbo.MovDiario compra1  
										    where compra1.numero_operacion = Compra.numero_operacion  
										    and compra1.tipo_flujo = 1
										    and compra1.numero_flujo = (select max(numero_flujo)
																  from BacSwapNY.dbo.MovDiario
																  where numero_operacion = Compra.numero_operacion  
																  and tipo_flujo = 1)
										    and compra1.compra_amortiza <> 0)
					   ,			origen  = 'TR-NY-'
					   ,		number_cash_flow_p = (select count(compra1.numero_flujo)
											    from BacSwapNY.dbo.MovDiario compra1 
											    where compra1.numero_operacion = Compra.numero_operacion 
											    and compra1.tipo_flujo = 2
											    and compra1.venta_amortiza <> 0)
					   ,		compra_amortiza_p = (select compra1.venta_amortiza
											   from BacSwapNY.dbo.MovDiario compra1  
											   where compra1.numero_operacion = Compra.numero_operacion  
											   and compra1.tipo_flujo = 2
											   and compra1.numero_flujo = (select max(numero_flujo)
																	 from BacSwapNY.dbo.MovDiario
																	 where numero_operacion = Compra.numero_operacion  
																	 and tipo_flujo = 2)
											   and compra1.venta_amortiza <> 0)
					   ,		compra_cod_tasa  = compra_codigo_tasa
					   ,		venta_cod_tasa	  = Venta.venta_codigo_tasa											   				   										    
											   				   										    
					   from	BacSwapNY.dbo.MovDiario Compra with(nolock)
							   inner join (	select Contrato		= md.numero_operacion
											       , Flujo_act	= Min(md.numero_flujo)
											       , Flujo_pas	= (SELECT MIN(md2.numero_flujo)
											       				   FROM BacSwapNY.dbo.MovDiario MD2 WITH(NOLOCK) 
											       				   WHERE md2.Estado 		  = ''
											       				   AND 	 md2.tipo_flujo 	  = 2
											       				   AND 	 md2.numero_operacion = md.numero_operacion)
											       from	BacSwapNY.dbo.MovDiario md with(nolock)
											       where md.Estado 		= '' 
											       and 	 md.tipo_flujo 	= 1
											       group by md.numero_operacion
										   )	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
													   and	GrpSwap.Flujo_act	= Compra.numero_flujo

							   inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo, venta_spread,
											 venta_codmoneda = Mon.mncodmon, venta_codigo_tasa
											   from	BacSwapNY.dbo.MovDiario	with(nolock)
													   inner join (	select	mncodmon, mnnemo 
																	   from	BacParamSuda.dbo.Moneda with(nolock)
																   )	Mon On	Mon.mncodmon	= Venta_Moneda
											   where		Estado		= ''
											   and		tipo_flujo		= 2
										   )	Venta	On	Venta.numero_operacion	= GrpSwap.Contrato
													   and	Venta.numero_flujo		= GrpSwap.flujo_pas
													   
							   inner join (	select	mncodmon, mnnemo
											   from	BacParamSuda.dbo.Moneda with(nolock)
										   )	Mon On	Mon.mncodmon	= Compra.compra_Moneda
					   where	Estado_oper_lineas 	NOT IN ('P')
					   and 		Estado 			= ''
					   and		tipo_flujo		= 1

					   union

					   select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa, Compra.Tasa_Transfer
					   ,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador,		Compra.Res_Mesa_Dist_CLP, Compra.fecha_cierre
					   ,		Venta_Moneda	= Venta.Venta_Moneda
					   ,		venta_codmoneda = Venta.venta_codmoneda
					   ,		Compra_Moneda	= Mon.mnnemo
					   ,		compra_codmoneda = Mon.mncodmon
					   ,		compra.Rut_Cliente, compra.codigo_cliente
					   ,		fecha_termino	= Compra.fecha_termino
					   ,		tipo_operacion = compra.tipo_operacion
					   ,		Venta.venta_spread 
					   ,		compra.compra_spread
					   ,      compra.fecha_inicio
					   ,		number_cash_flow = (select count(compra1.numero_flujo)
										     from BacSwapNY.dbo.MovHistorico compra1 
										     where compra1.numero_operacion = Compra.numero_operacion 
										     and compra1.tipo_flujo = 1
											 and compra1.compra_amortiza <> 0)
					   ,		compra_amortiza = (select compra1.compra_amortiza
										    from BacSwapNY.dbo.MovHistorico compra1  
										    where compra1.numero_operacion = Compra.numero_operacion  
										    and compra1.tipo_flujo = 1
										    and compra1.numero_flujo = (select max(numero_flujo)
																  from BacSwapNY.dbo.MovHistorico
																  where numero_operacion = Compra.numero_operacion  
																  and tipo_flujo = 1)
											and compra1.compra_amortiza <> 0)
					   ,			origen  = 'TR-NY-'
					   ,		number_cash_flow_p = (select count(compra1.numero_flujo)
											    from BacSwapNY.dbo.MovHistorico compra1 
											    where compra1.numero_operacion = Compra.numero_operacion 
											    and compra1.tipo_flujo = 2
											    and compra1.venta_amortiza <> 0)
					   ,		compra_amortiza_p = (select compra1.venta_amortiza
											   from BacSwapNY.dbo.MovHistorico compra1  
											   where compra1.numero_operacion = Compra.numero_operacion  
											   and compra1.tipo_flujo = 2
											   and compra1.numero_flujo = (select max(numero_flujo)
																	 from BacSwapNY.dbo.MovHistorico
																	 where numero_operacion = Compra.numero_operacion  
																	 and tipo_flujo = 2)
											   and compra1.venta_amortiza <> 0)
					   ,		compra_cod_tasa  = compra_codigo_tasa
					   ,		venta_cod_tasa	  = Venta.venta_codigo_tasa											   						   
										   						   
					   from	BacSwapNY.dbo.MovHistorico	Compra	with(nolock)

							   inner join (	select  Contrato	= mh.numero_operacion
												,   Flujo_act	= Min(mh.numero_flujo)
												,   Flujo_pas	= (SELECT MIN(mh2.numero_flujo) 
																   FROM BacSwapNY.dbo.MovHistorico mh2 WITH(NOLOCK) 
																   WHERE mh2.Estado			  = ''
																   AND   mh2.tipo_flujo		  = 2
																   AND   mh2.numero_operacion = mh.numero_operacion)
											from   BacSwapNY.dbo.MovHistorico mh with(nolock)
											WHERE  mh.fecha_cierre		  BETWEEN @FechaDesde AND @FechaHasta  
											and	   mh.Estado			  = '' 
											and	   mh.tipo_flujo		  = 1
											group by mh.numero_operacion
										   )	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												   and	GrpSwap.Flujo_act	= Compra.numero_flujo

							   inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo, venta_spread,
											 venta_codmoneda = Mon.mncodmon, venta_codigo_tasa
											   from	BacSwapNY.dbo.MovHistorico	with(nolock)
													   inner join (	select	mncodmon, mnnemo 
																	   from	BacParamSuda.dbo.Moneda with(nolock)
																   )	Mon On	Mon.mncodmon	= Venta_Moneda
											   where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
											   and		Estado			= ''
											   and		tipo_flujo		= 2
										   )	Venta	On	Venta.numero_operacion	= GrpSwap.Contrato
													   and	Venta.numero_flujo		= GrpSwap.flujo_pas

							   inner join (	select	mncodmon, mnnemo
											   from	BacParamSuda.dbo.Moneda with(nolock)
										   )	Mon On	Mon.mncodmon	= Compra.compra_Moneda

					   where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
					   and		Estado_oper_lineas 	NOT IN ('P')
					   and 		Estado 			= ''
					   and		tipo_flujo		= 1					   
					   /*FIN SWAP NY*/   
				   )	Swap

				   inner join
				   (	select	clrut = clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
					   from	BacParamSuda.dbo.cliente with(nolock)
				   )	Clie	On	Clie.clrut		= Swap.Rut_Cliente
							   and Clie.clcodigo	= Swap.codigo_cliente
				
				where Swap.tipo_swap in (2)

		   -->	   Anticipos Swap 
		   ---------------------------------
			 INSERT INTO #RESULTADOS_CCS
			 select distinct 
			 --CASE WHEN Unwind.FechaCierre < '20140317' THEN 
			 --(CASE WHEN dbo.fx_RetornaEstadoSwap(Unwind.folio,@FechaDesde,@Fechahasta,Unwind.Origen) = 'Anticipo' AND Unwind.FechaTermino = @Fecha THEN 'E'
				--WHEN dbo.fx_RetornaEstadoSwap(Unwind.folio,@FechaDesde,@Fechahasta,Unwind.Origen) = 'Anticipo' AND Unwind.FechaTermino <> @Fecha THEN 'A'
				--WHEN dbo.fx_RetornaEstadoSwap(Unwind.folio,@FechaDesde,@Fechahasta,Unwind.Origen) = 'Modificacion' THEN 'A'
				--ELSE '' END)
			 --ELSE 
				--(CASE WHEN dbo.fx_RetornaEstadoSwap(Unwind.folio,@FechaDesde,@Fechahasta,Unwind.Origen) = 'Anticipo' AND Unwind.FechaTermino = @Fecha THEN 'U'
				--    WHEN dbo.fx_RetornaEstadoSwap(Unwind.folio,@FechaDesde,@Fechahasta,Unwind.Origen) = 'Anticipo' AND Unwind.FechaTermino <> @Fecha THEN 'U'
				--    WHEN dbo.fx_RetornaEstadoSwap(Unwind.folio,@FechaDesde,@Fechahasta,Unwind.Origen) = 'Modificacion' THEN 'A'
				-- ELSE '' END) AS [Type]
				  'U' AS [Type]                         -- Se asume anticipo parcial
				-- ,CASE WHEN dbo.fx_RetornaEstadoSwap(Unwind.folio,@FechaDesde,@Fechahasta,Unwind.Origen) = 'Anticipo' THEN 'Unwind' ELSE '' END AS [Contract Update Reason]
				, 'Parcial' As [Contract Update Reason]  -- Se asume anticipo parcial
			 ,'N/A' AS [Part Account] 
			 ,dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Unwind.TipoOperacion),1) AS [Part Position] 
			 ,CASE WHEN Unwind.origen = 'TR-' then dbo.Fx_Convalida_Tipos(35,1,1,'',1) ELSE dbo.Fx_Convalida_Tipos(38,1,1,'',1) end AS [Part Code]
			 ,'N/A' AS [Part CPF/CNPJ] 
			 ,case when Unwind.Origen = 'TR-' then dbo.Fx_Convalida_Tipos(34,1,1,'',1) else dbo.Fx_Convalida_Tipos(37,1,1,'',1) end AS [Part] 
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
					   FROM TBL_CONTRATOUSD_PASO cp 
					   WHERE cp.rut_cliente LIKE concat(convert(varchar(20),Unwind.Rut),'%')
					   AND cp.id = (SELECT max(cp2.id) 
								    FROM TBL_CONTRATOUSD_PASO cp2 
								    WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),Unwind.Rut),'%'))) = 1 THEN 'Yes'
				ELSE 'No' END AS [Counterpart Indentified]
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Unwind.TipoOperacion),1) = 'SELLER' THEN 'BUYER' ELSE 'SELLER' END AS [Counterpart Position] 
			 ,'' AS [Counterpart Code] 
			 ,'N/A' AS [Counterpart CPF/CNPJ] 
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
						  FROM TBL_CONTRATOUSD_PASO cp 
						  WHERE cp.rut_cliente LIKE concat(convert(varchar(20),Unwind.Rut),'%')
						  AND cp.id = (SELECT max(cp2.id) 
									   FROM TBL_CONTRATOUSD_PASO cp2 
									   WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),Unwind.Rut),'%'))) = 1 THEN 
								(SELECT cp.nombre_cliente FROM TBL_CONTRATOUSD_PASO cp 
								    WHERE cp.rut_cliente LIKE concat(convert(varchar(20),Unwind.Rut),'%')
								    AND cp.id = (SELECT max(cp2.id) 
											 FROM TBL_CONTRATOUSD_PASO cp2 
											 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),Unwind.Rut),'%')))
				ELSE '' END AS [Counterpart]
			 ,'CCS' AS [Derivative Type] 
			 ,'OTC' AS [Trading Place] 
			 ,Unwind.Origen + CONVERT(varchar(50),Unwind.folio) AS [Contract Number] 
			 ,CONVERT(numeric(32,2),ROUND(Act.Capital,2)) AS [Notional Amount] 
			 ,(CASE WHEN Act.nemo = 'UF' THEN 'CLF' ELSE Act.nemo END) AS [Reference Currency] 
			 ,(CASE WHEN Pas.nemo = 'UF' THEN 'CLF' ELSE Pas.nemo END) AS [Settlement Reference Currency] 
			 ,'N/A' AS [Underlying asset] 
			 ,CONVERT(varchar,Unwind.FechaCierre,3) AS [Trade Date] 
			 ,CONVERT(varchar,Unwind.FechaInicio,3) AS [Effective Date] 
			   -- MAP 20170411
			 , CONVERT(varchar,Unwind.FechaTermino,3) AS [Settlement Date] -- CONVERT(varchar,Unwind.FechaAnticipo,3) AS [Settlement Date]
			 ,dbo.Fx_Tasas_Moneda(Act.vCodTasa,(CASE WHEN Act.nemo = 'UF' THEN 'CLF' ELSE Act.nemo END)) AS [Asset Index] 
			 ,dbo.Fx_Tasas_Moneda(Pas.vCodTasa,(CASE WHEN Pas.nemo = 'UF' THEN 'CLF' ELSE Pas.nemo END)) AS [Liability Index] 	 
			 ,format(Act.vTasa,N'0.00') AS [Asset Rate Percent] 
			 ,format(Pas.vTasa,N'0.00') AS [Liability Rate Percent] 
			 ,convert(numeric(32,2),round(Act.Capital,2)) AS [Asset Notional Amount] 
			 ,(CASE WHEN Act.nemo = 'UF' THEN 'CLF' ELSE Act.nemo END) AS [Asset Referency Currency] 
			 ,convert(numeric(32,2),round(Pas.Capital,2)) AS [Liability Notional Amount] 
			 ,(CASE WHEN Pas.nemo = 'UF' THEN 'CLF' ELSE Pas.nemo END) AS [Liability Referency Currency] 
			 ,convert(numeric(32,2),round(Act.vSpread,2)) AS [Asset Spread] 
			 ,convert(numeric(32,2),round(Pas.vSpread,2)) AS [Liability Spread] 
			 ,case when Act.number_cash_flow > 1 OR Pas.number_cash_flow > 1 then 'Yes' else 'No' end AS [Cash-Flow] 	   
			 ,CASE WHEN Act.number_cash_flow > 1 OR Pas.number_cash_flow > 1 then 
				    CASE WHEN Act.number_cash_flow >= Pas.number_cash_flow THEN convert(varchar,Act.number_cash_flow)
				    else convert(varchar,Pas.number_cash_flow) END				    
				ELSE '' end AS [Cash Flow Number]
			 ,'CHILE' AS [Country Origin] 
			 ,'' AS [Registration] 
			 ,case when (select top 1 tipo_contrato from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),Unwind.Rut),'%')) = 'ISDA'
			 then 'ISDA' else 'CGD' end AS [Derivative Master Agreement]
			 ,'N.A.' AS [Barrier] 
			 ,'Final' AS [Settlement Rate Type] 
			 ,'Asset Notional Amount: ' + convert(varchar,format(convert(numeric(32,2),round(Act.Capital,2)),N'N')) + 
			 ' / Asset Referency Currency: '  + LTRIM(RTRIM((CASE WHEN Act.nemo = 'UF' THEN 'CLF' ELSE Act.nemo END))) + 
			 ' / Asset Rate Percent: ' + convert(varchar,format(Act.vTasa,N'0.00')) + 
			 ' / Liability Notional Amount: ' + convert(varchar,format(convert(numeric(32,2),round(Pas.Capital,2)),N'N')) + 
			 ' / Liability Referency Currency: ' + LTRIM(RTRIM((CASE WHEN Pas.nemo = 'UF' THEN 'CLF' ELSE Pas.nemo END))) + 
			 ' / Asset Rate Percent: ' + convert(varchar,format(Pas.vTasa,N'0.00'))  AS [Addicional information] 
			 ,ISNULL(dbo.Fx_DCE_contract(Unwind.Origen + CONVERT(varchar(50),Unwind.folio),'CCS'),'') AS [DCE Contract] 
			 ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),Unwind.Rut),'%')),0) = 0 
				then 'No' else 'Yes' end AS [US Person] 
			 ,'Yes' AS [OTC] 
			 ,'No' AS [Dealing Activity] 
			 ,'No' AS [IntraGroup] 
			 ,'No' AS [Unwind]  -- Se corregirá depués para anticipos totales
			 ,'No' AS [Trade Done In Brazil] 
			 --,convert(numeric(36,2),round(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,Act.IdNemo,Act.Capital,13),2)) AS [USD Notional]
			 ,CONVERT(NUMERIC(36,2),ROUND(CASE WHEN Act.nemo = 'USD' THEN Act.Capital
									   WHEN Pas.nemo = 'USD' THEN Pas.Capital
			  ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,Act.IdNemo,Act.Capital,13) END,2)) AS [USD Notional]
			  , [Numero_Operacion] = Unwind.numero_operacion -- MAP 20170411
			  , [Origen]            = Unwind.origen          -- MAP 20170411
			  , [Compra_Moneda]     = Act.IdNemo             -- MAP 20170411
			  , [Effective Date Como Fecha] = Unwind.FechaInicio
			  --Modulo				= 'PCS'
			  --,		Producto			= 'ANT ' + prod.Producto
			  --,		Numero_Operacion	= Unwind.folio
			  --,		Documento			= 0
			  --,		Correlativo			= 0
			  --,		Serie				= ''
			  --,		RutCliente			= Unwind.Rut
			  --,		CodCliente			= Unwind.Codigo
			  --,		DvCliente			= Unwind.Dv
			  --,		NombreCliente		= Unwind.Nombre
			  --,		TipoOperacion		= 'C'
			  --,		Monto				= isnull(Act.Capital, 0.0)
			  --,		MonTransada			= isnull(Act.nemo, '')
			  --,		MonConversion		= isnull(Pas.nemo, '')
			  --,		TCCierre			= isnull(Act.vTasa, 0.0)
			  --,		TCCosto				= 0.0
			  --,		ParidadCierre		= isnull(Pas.vTasa, 0.0)
			  --,		ParidadCosto		= 0.0
			  --,		MontoPesos			= isnull(Pas.Capital, 0.0)
			  --,		Operador			= Unwind.operador			--> his.operador
			  --,		MontoDolares		= isnull(Act.Capital, 0.0)
			  --,		ResultadoMesa		= Unwind.Monto
			  --,		Fecha				= Unwind.FechaAnticipo --> his.fecha_cierre
			  --,		Relacionado			= '--'
			  --,		FolioRelacionado	= 0
			  --,		FechaEmision		= Unwind.FechaAnticipo
			  --,		FechaVcto			= Unwind.FechaAnticipo
				 from	
						 -->		cartera anticipada
					 (	select	Fecha			= unw.FechaAnticipo
							 ,	FechaAnticipo		= unw.FechaAnticipo
							 ,	FechaInicio	     = OpOriginal.fecha_inicio  -- unw.fecha_inicio  MAP 20170411
							 ,	FechaCierre	     = OpOriginal.fecha_cierre  -- unw.fecha_cierre  MAP 20170411
							 ,  FechaTermino	 = OpOriginal.fecha_termino -- unw.fecha_termino MAP 20170411
							 ,	Folio			= unw.numero_operacion
							 ,	Monto			= Min( unw.Devengo_Recibido_Mda_Val )
							 ,	Operador			= Min( unw.operador )
							 ,	Rut				= cli.Rut
							 ,	Codigo			= cli.Codigo
							 ,	Dv				= cli.Dv
							 ,	Nombre			= cli.Nombre
							 ,	TipoSwap			= unw.tipo_swap
							 ,	Origen			= 'TR-'
							 ,    TipoOperacion	     = unw.tipo_operacion 
							 ,  unw.numero_operacion  -- MAP 20170411
						 from	BacSwapSuda.dbo.Cartera_Unwind	unw with(nolock)
								 left join
								 (	select	Rut		= clrut
										 ,	Codigo	= clcodigo
										 ,	Dv		= cldv
										 ,	Nombre	= clnombre
									 from	BacparamSuda.dbo.cliente with(nolock)
								 )	Cli		On	Cli.Rut		= unw.rut_cliente
											 and	Cli.Codigo	= unw.codigo_cliente
	                            left join 
								(  -- Datos de la operación vigente al dia anterior MAP 20170411
								   select *
								   from #CarteraRESAnt 								    							   
								) OpOriginal on OpOriginal.numero_operacion = unw.numero_operacion 
						 where	unw.FechaAnticipo		BETWEEN @FechaDesde AND @Fechahasta
						 and		unw.Tipo_Flujo			= 1
						 AND		unw.tipo_swap			IN (2)
						 group 
						 by		unw.FechaAnticipo
							 ,  OpOriginal.fecha_inicio --  unw.fecha_inicio MAP 20170411
							 ,  OpOriginal.fecha_cierre --  unw.fecha_cierre MAP 20170411
							 ,	unw.numero_operacion
							 ,	unw.tipo_swap
							 ,	cli.Rut
							 ,	cli.Codigo
							 ,	cli.Dv
							 ,	cli.Nombre
							 ,  unw.tipo_operacion
							 ,  OpOriginal.fecha_termino -- unw.fecha_termino MAP 20170411
						 UNION
						 /*
						  * SWAP NY
						  */
						 select	Fecha			= unw.FechaAnticipo
							 ,	FechaAnticipo		= unw.FechaAnticipo
							 ,	FechaInicio	     = unw.fecha_inicio
							 ,	FechaCierre	     = unw.fecha_cierre
							 ,   FechaTermino		= unw.fecha_termino 
							 ,	Folio			= unw.numero_operacion
							 ,	Monto			= Min( unw.Devengo_Recibido_Mda_Val )
							 ,	Operador			= Min( unw.operador )
							 ,	Rut				= cli.Rut
							 ,	Codigo			= cli.Codigo
							 ,	Dv				= cli.Dv
							 ,	Nombre			= cli.Nombre
							 ,	TipoSwap			= unw.tipo_swap
							 ,	Origen			= 'TR-NY-'
							 ,    TipoOperacion	     = unw.tipo_operacion 
							 ,  unw.numero_operacion  -- MAP 20170411
						 from	BacSwapNY.dbo.Cartera_Unwind unw with(nolock)
								 left join
								 (	select	Rut		= clrut
										 ,	Codigo	= clcodigo
										 ,	Dv		= cldv
										 ,	Nombre	= clnombre
									 from	BacparamSuda.dbo.cliente with(nolock)
								 )	Cli		On	Cli.Rut		= unw.rut_cliente
											 and	Cli.Codigo	= unw.codigo_cliente
						 where	unw.FechaAnticipo		BETWEEN @FechaDesde AND @Fechahasta
						 and		unw.Tipo_Flujo			= 1
						 AND		unw.tipo_swap			IN (2)
						 group 
						 by		unw.FechaAnticipo
							 ,  unw.fecha_inicio
							 ,  unw.fecha_cierre 
							 ,	unw.numero_operacion
							 ,	unw.tipo_swap
							 ,	cli.Rut
							 ,	cli.Codigo
							 ,	cli.Dv
							 ,	cli.Nombre
							 ,  unw.tipo_operacion
							 ,unw.fecha_termino							 
					 )	Unwind

					 left join	-->	cartera activa
						 (	select	    Folio	= ch.numero_operacion
								 ,	Capital	= ch.compra_capital
								 ,	Moneda	= ch.compra_moneda
								 ,	vTasa	= ch.compra_valor_tasa
								 ,   vCodTasa  = ch.compra_codigo_tasa
								 ,	Nemo		= mon.nemo
								 ,	IdNemo	= mon.Id
								 ,	  vSpread	= ch.compra_spread
								 ,	  number_cash_flow = (select count(ch2.numero_flujo)
													 from #Cartera ch2 
													 where ch2.numero_operacion = ch.numero_operacion 
													 and ch2.tipo_flujo = 1
													 and ch2.compra_amortiza <> 0)								
							 from	#Cartera ch with(nolock)
									 inner join 
									 (	select	Contrato = numero_operacion
											 ,	Numero	 = min( numero_flujo )
											 ,	Tipo	 = tipo_flujo
										 from	#Cartera with(nolock)
										 where	tipo_flujo			= 1
										 group 
										 by		numero_operacion
											 ,	tipo_flujo
									 )	ac		on	ac.Contrato	= ch.numero_operacion
												 and	ac.Numero	= ch.numero_flujo
												 and	ac.Tipo		= ch.tipo_flujo
									 left join
									 (	select	Id		= mncodmon
											 ,	nemo		= mnnemo
										 from	BacParamSuda.dbo.Moneda with(nolock)
									 )	mon		On mon.Id	= ch.compra_moneda
							 --UNION 
							 --select	Folio	= ch.numero_operacion
								-- ,	Capital	= ch.compra_capital
								-- ,	Moneda	= ch.compra_moneda
								-- ,	vTasa	= ch.compra_valor_tasa
								-- ,	Nemo		= mon.nemo
								-- ,	IdNemo	= mon.Id
								-- ,	  vSpread	= ch.compra_spread
								-- ,	  number_cash_flow = (select count(ch2.numero_flujo)
								--					 from BacSwapSuda.dbo.CarteraHis ch2 
								--					 where ch2.numero_operacion = ch.numero_operacion 
								--					 and ch2.tipo_flujo = 1
								--					 and ch2.compra_amortiza > 0)
							 --from	bacswapsuda.dbo.CarteraHis ch with(nolock)
								--	 inner join 
								--	 (	select	Contrato = numero_operacion
								--			 ,	Numero	 = min( numero_flujo )
								--			 ,	Tipo	 = tipo_flujo
								--		 from	bacswapsuda.dbo.CarteraHis with(nolock)
								--		 where	tipo_flujo			= 1
								--		 group 
								--		 by		numero_operacion
								--			 ,	tipo_flujo
								--	 )	ac		on	ac.Contrato	= ch.numero_operacion
								--				 and	ac.Numero	= ch.numero_flujo
								--				 and	ac.Tipo		= ch.tipo_flujo
								--	 left join
								--	 (	select	Id		= mncodmon
								--			 ,	nemo		= mnnemo
								--		 from	BacParamSuda.dbo.Moneda with(nolock)
								--	 )	mon		On mon.Id	= ch.compra_moneda								  
							 UNION
							/*
							 * SWAP NY
							 */
							select	    Folio	= ch.numero_operacion
								 ,	Capital	= ch.compra_capital
								 ,	Moneda	= ch.compra_moneda
								 ,	vTasa	= ch.compra_valor_tasa
								 ,   vCodTasa  = ch.compra_codigo_tasa
								 ,	Nemo		= mon.nemo
								 ,	IdNemo	= mon.Id
								 ,	  vSpread	= ch.compra_spread
								 ,	  number_cash_flow = (select count(ch2.numero_flujo)
													 from #CarteraNY ch2 
													 where ch2.numero_operacion = ch.numero_operacion 
													 and ch2.tipo_flujo = 1
													 and ch2.compra_amortiza <> 0)
							 from	#CarteraNY ch with(nolock)
									 inner join 
									 (	select	Contrato = numero_operacion
											 ,	Numero	 = min( numero_flujo )
											 ,	Tipo	 = tipo_flujo
										 from	#CarteraNY with(nolock)
										 where	tipo_flujo			= 1
										 group 
										 by		numero_operacion
											 ,	tipo_flujo
									 )	ac		on	ac.Contrato	= ch.numero_operacion
												 and	ac.Numero	= ch.numero_flujo
												 and	ac.Tipo		= ch.tipo_flujo
									 left join
									 (	select	Id		= mncodmon
											 ,	nemo		= mnnemo
										 from	BacParamSuda.dbo.Moneda with(nolock)
									 )	mon		On mon.Id	= ch.compra_moneda
							 --UNION 
							 --select	Folio	= ch.numero_operacion
								-- ,	Capital	= ch.compra_capital
								-- ,	Moneda	= ch.compra_moneda
								-- ,	vTasa	= ch.compra_valor_tasa
								-- ,	Nemo		= mon.nemo
								-- ,	IdNemo	= mon.Id
								-- ,	  vSpread	= ch.compra_spread
								-- ,	  number_cash_flow = (select count(ch2.numero_flujo)
								--					 from BacSwapNY.dbo.CarteraHis ch2 
								--					 where ch2.numero_operacion = ch.numero_operacion 
								--					 and ch2.tipo_flujo = 1
								--					 and ch2.compra_amortiza > 0)
							 --from	BacSwapNY.dbo.CarteraHis ch with(nolock)
								--	 inner join 
								--	 (	select	Contrato = numero_operacion
								--			 ,	Numero	 = min( numero_flujo )
								--			 ,	Tipo	 = tipo_flujo
								--		 from	BacSwapNY.dbo.CarteraHis with(nolock)
								--		 where	tipo_flujo			= 1
								--		 group 
								--		 by		numero_operacion
								--			 ,	tipo_flujo
								--	 )	ac		on	ac.Contrato	= ch.numero_operacion
								--				 and	ac.Numero	= ch.numero_flujo
								--				 and	ac.Tipo		= ch.tipo_flujo
								--	 left join
								--	 (	select	Id		= mncodmon
								--			 ,	nemo		= mnnemo
								--		 from	BacParamSuda.dbo.Moneda with(nolock)
								--	 )	mon		On mon.Id	= ch.compra_moneda
						 )	Act	On Act.Folio	= Unwind.Folio

					 left join	-->	cartera pasiva
						 (	select	Folio	= ch.numero_operacion
								 ,	Capital	= ch.venta_capital
								 ,	Moneda	= ch.venta_moneda
								 ,	vTasa	= ch.venta_valor_tasa
								 ,   vCodTasa  = ch.venta_codigo_tasa
								 ,	Nemo		= mon.nemo
								 ,	IdNemo	= mon.Id
								 ,	vSpread   = ch.venta_spread
								 ,    number_cash_flow = (select count(ch2.numero_flujo)
													 from #Cartera ch2 
													 where ch2.numero_operacion = ch.numero_operacion 
													 and ch2.tipo_flujo = 2
													 and ch2.venta_amortiza <> 0)
							 from	#Cartera ch with(nolock)
									 inner join
									 (	select	Contrato = numero_operacion
											 ,	Numero	 = min( numero_flujo )
											 ,	Tipo	 = tipo_flujo
										 from	#Cartera with(nolock)
										 where	tipo_flujo			= 2
										 group 
										 by		numero_operacion
											 ,	tipo_flujo
									 )	ac		on	ac.Contrato	= ch.numero_operacion
												 and	ac.Numero	= ch.numero_flujo
												 and	ac.Tipo		= ch.tipo_flujo
									 left join
									 (	select	Id			= mncodmon
											 ,	nemo		= mnnemo
										 from	BacParamSuda.dbo.Moneda with(nolock)
									 )	mon		On mon.Id	= ch.venta_moneda
							 --UNION 
							 --select	Folio	= ch.numero_operacion
								-- ,	Capital	= ch.venta_capital
								-- ,	Moneda	= ch.venta_moneda
								-- ,	vTasa	= ch.venta_valor_tasa
								-- ,	Nemo		= mon.nemo
								-- ,	IdNemo	= mon.Id
								-- ,	vSpread   = ch.venta_spread
								-- ,    number_cash_flow = (select count(ch2.numero_flujo)
								--					 from BacSwapSuda.dbo.CarteraHis ch2 
								--					 where ch2.numero_operacion = ch.numero_operacion 
								--					 and ch2.tipo_flujo = 2
								--					 and ch2.compra_amortiza > 0)
							 --from	bacswapsuda.dbo.CarteraHis ch with(nolock)
								--	 inner join
								--	 (	select	Contrato = numero_operacion
								--			 ,	Numero	 = min( numero_flujo )
								--			 ,	Tipo	 = tipo_flujo
								--		 from	bacswapsuda.dbo.CarteraHis with(nolock)
								--		 where	tipo_flujo			= 2
								--		 group 
								--		 by		numero_operacion
								--			 ,	tipo_flujo
								--	 )	ac		on	ac.Contrato	= ch.numero_operacion
								--				 and	ac.Numero	= ch.numero_flujo
								--				 and	ac.Tipo		= ch.tipo_flujo
								--	 left join
								--	 (	select	Id			= mncodmon
								--			 ,	nemo		= mnnemo
								--		 from	BacParamSuda.dbo.Moneda with(nolock)
								--	 )	mon		On mon.Id	= ch.venta_moneda
							 UNION
							 /*
							 * SWAP NY
							 */
							 select	Folio	= ch.numero_operacion
								 ,	Capital	= ch.venta_capital
								 ,	Moneda	= ch.venta_moneda
								 ,	vTasa	= ch.venta_valor_tasa
								 ,   vCodTasa  = ch.venta_codigo_tasa
								 ,	Nemo		= mon.nemo
								 ,	IdNemo	= mon.Id
								 ,	vSpread   = ch.venta_spread
								 ,    number_cash_flow = (select count(ch2.numero_flujo)
													 from #CarteraNY ch2 
													 where ch2.numero_operacion = ch.numero_operacion 
													 and ch2.tipo_flujo = 2
													 and ch2.venta_amortiza <> 0)
							 from	#CarteraNY ch with(nolock)
									 inner join
									 (	select	Contrato = numero_operacion
											 ,	Numero	 = min( numero_flujo )
											 ,	Tipo	 = tipo_flujo
										 from	#CarteraNY with(nolock)
										 where	tipo_flujo			= 2
										 group 
										 by		numero_operacion
											 ,	tipo_flujo
									 )	ac		on	ac.Contrato	= ch.numero_operacion
												 and	ac.Numero	= ch.numero_flujo
												 and	ac.Tipo		= ch.tipo_flujo
									 left join
									 (	select	Id			= mncodmon
											 ,	nemo		= mnnemo
										 from	BacParamSuda.dbo.Moneda with(nolock)
									 )	mon		On mon.Id	= ch.venta_moneda
							 --UNION 
							 --select	Folio	= ch.numero_operacion
								-- ,	Capital	= ch.venta_capital
								-- ,	Moneda	= ch.venta_moneda
								-- ,	vTasa	= ch.venta_valor_tasa
								-- ,	Nemo		= mon.nemo
								-- ,	IdNemo	= mon.Id
								-- ,	vSpread   = ch.venta_spread
								-- ,    number_cash_flow = (select count(ch2.numero_flujo)
								--					 from BacSwapNY.dbo.CarteraHis ch2 
								--					 where ch2.numero_operacion = ch.numero_operacion 
								--					 and ch2.tipo_flujo = 2
								--					 and ch2.compra_amortiza > 0)
							 --from	BacSwapNY.dbo.CarteraHis ch with(nolock)
								--	 inner join
								--	 (	select	Contrato = numero_operacion
								--			 ,	Numero	 = min( numero_flujo )
								--			 ,	Tipo	 = tipo_flujo
								--		 from	BacSwapNY.dbo.CarteraHis with(nolock)
								--		 where	tipo_flujo			= 2
								--		 group 
								--		 by		numero_operacion
								--			 ,	tipo_flujo
								--	 )	ac		on	ac.Contrato	= ch.numero_operacion
								--				 and	ac.Numero	= ch.numero_flujo
								--				 and	ac.Tipo		= ch.tipo_flujo
								--	 left join
								--	 (	select	Id			= mncodmon
								--			 ,	nemo		= mnnemo
								--		 from	BacParamSuda.dbo.Moneda with(nolock)
								--	 )	mon		On mon.Id	= ch.venta_moneda									 								  
						 )	Pas	On Pas.Folio	= Unwind.Folio

					 left join	-->	Producto
						 (	select	Id			= case	when codigo_producto = 'ST' then 1
														 when codigo_producto = 'SM' then 2
														 when codigo_producto = 'SP' then 4
													 end
								 ,	Producto	= Descripcion
							 from	BacParamSuda.dbo.Producto with(nolock)
							 where	id_sistema	= 'PCS'
						 )	prod	On prod.Id	= Unwind.TipoSwap
		
		--> vencimientos CCS	, amortizaciones  contractuales
		---------------------------------------------------------------			 
		  INSERT INTO #RESULTADOS_CCS
		  SELECT 'U' AS [Type]
			 ,'Amortization' AS [Contract Update Reason] 
			 ,'N/A' AS [Part Account] 
			 ,dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Swap.tipo_operacion),1) AS [Part Position] 
			 ,CASE WHEN Swap.origen = 'TR-' then dbo.Fx_Convalida_Tipos(35,1,1,'',1) ELSE dbo.Fx_Convalida_Tipos(38,1,1,'',1) end AS [Part Code]
			 ,'N/A' AS [Part CPF/CNPJ] 
			 ,case when Swap.origen = 'TR-' then dbo.Fx_Convalida_Tipos(34,1,1,'',1) else dbo.Fx_Convalida_Tipos(37,1,1,'',1) end AS [Part] 
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
					   FROM TBL_CONTRATOUSD_PASO cp 
					   WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
					   AND cp.id = (SELECT max(cp2.id) 
								 FROM TBL_CONTRATOUSD_PASO cp2 
								 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 'Yes'
			  ELSE 'No' END AS [Counterpart Indentified]
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Swap.tipo_operacion),1) = 'SELLER' THEN 'BUYER' ELSE 'SELLER' END AS [Counterpart Position] 
			 ,'' AS [Counterpart Code] 
			 ,'N/A' AS [Counterpart CPF/CNPJ] 
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
						 FROM TBL_CONTRATOUSD_PASO cp 
						 WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
						 AND cp.id = (SELECT max(cp2.id) 
									  FROM TBL_CONTRATOUSD_PASO cp2 
									  WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 
								(SELECT cp.nombre_cliente FROM TBL_CONTRATOUSD_PASO cp 
								 WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
								 AND cp.id = (SELECT max(cp2.id) 
											 FROM TBL_CONTRATOUSD_PASO cp2 
											 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')))
			  ELSE '' END AS [Counterpart]
			 ,'CCS' AS [Derivative Type] 
			 ,'OTC' AS [Trading Place] 
			 ,Swap.origen + CONVERT(varchar(50),Swap.numero_operacion) AS [Contract Number] 
			 ,CONVERT(numeric(32,2),ROUND(Swap.compra_capital,2)) AS [Notional Amount] 
			 ,(CASE WHEN Swap.compra_moneda = 'UF' THEN 'CLF' ELSE Swap.compra_moneda END) AS [Reference Currency] 
			 ,(CASE WHEN Swap.venta_moneda = 'UF' THEN 'CLF' ELSE Swap.venta_moneda END) AS [Settlement Reference Currency] 
			 ,'N/A' AS [Underlying asset] 
			 ,CONVERT(varchar,Swap.fecha_cierre,3) AS [Trade Date] 
			 ,CONVERT(varchar,Swap.fecha_inicio,3) AS [Effective Date] 
			 ,CONVERT(varchar,Swap.fecha_termino,3) AS [Settlement Date]
			 ,dbo.Fx_Tasas_Moneda(Swap.compra_cod_tasa,(CASE WHEN Swap.compra_moneda = 'UF' THEN 'CLF' ELSE Swap.compra_moneda END)) AS [Asset Index] 
			 ,dbo.Fx_Tasas_Moneda(Swap.venta_cod_tasa,(CASE WHEN Swap.venta_moneda = 'UF' THEN 'CLF' ELSE Swap.venta_moneda END)) AS [Liability Index] 			  
			 ,format(Swap.compra_valor_tasa,N'0.00') AS [Asset Rate Percent] 
			 ,format(Swap.venta_valor_tasa,N'0.00') AS [Liability Rate Percent] 
			 ,convert(numeric(32,2),round(Swap.compra_capital,2)) AS [Asset Notional Amount] 
			 ,(CASE WHEN Swap.compra_moneda = 'UF' THEN 'CLF' ELSE Swap.compra_moneda END) AS [Asset Referency Currency] 
			 ,convert(numeric(32,2),round(Swap.venta_capital,2)) AS [Liability Notional Amount] 
			 ,(CASE WHEN Swap.venta_moneda = 'UF' THEN 'CLF' ELSE Swap.venta_moneda END) AS [Liability Referency Currency] 
			 ,convert(numeric(32,2),round(Swap.compra_spread,2)) AS [Asset Spread] 
			 ,convert(numeric(32,2),round(Swap.venta_spread,2)) AS [Liability Spread] 
			 ,case when Swap.number_cash_flow > 1 OR Swap.number_cash_flow_p > 1 then 'Yes' else 'No' end AS [Cash-Flow] 	   
			 ,CASE WHEN Swap.number_cash_flow > 1 OR Swap.number_cash_flow_p > 1 then 
		  		    CASE WHEN Swap.number_cash_flow >= Swap.number_cash_flow_p THEN convert(varchar,Swap.number_cash_flow - 1)
				    else convert(varchar,Swap.number_cash_flow_p - 1) END				    
			 ELSE '' end AS [Cash Flow Number] 
			 ,'CHILE' AS [Country Origin] 
			 ,'' AS [Registration] 
			 ,case when (select top 1 tipo_contrato from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')) = 'ISDA'
			 then 'ISDA' else 'CGD' end AS [Derivative Master Agreement]	
			 ,'N.A.' AS [Barrier] 
			 ,'Final' AS [Settlement Rate Type] 
			 ,'Asset Notional Amount: ' + convert(varchar,format(convert(numeric(32,2),round(Swap.compra_capital,2)),N'N')) + 
			 ' / Asset Referency Currency: '  + LTRIM(RTRIM((CASE WHEN Swap.compra_moneda = 'UF' THEN 'CLF' ELSE Swap.compra_moneda END))) + 
			 ' / Asset Rate Percent: ' + convert(varchar,format(Swap.compra_valor_tasa,N'0.00')) + 
			 ' / Liability Notional Amount: ' + convert(varchar,format(convert(numeric(32,2),round(Swap.venta_capital,2)),N'N')) + 
			 ' / Liability Referency Currency: ' + LTRIM(RTRIM((CASE WHEN Swap.venta_moneda = 'UF' THEN 'CLF' ELSE Swap.venta_moneda END))) + 
			 ' / Asset Rate Percent: ' + convert(varchar,format(Swap.venta_valor_tasa,N'0.00'))  AS [Addicional information] 			
			 ,ISNULL(dbo.Fx_DCE_contract(Swap.origen + CONVERT(varchar(50),Swap.numero_operacion),'CCS'),'')AS [DCE Contract] 
			 ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')),0) = 0 
			  then 'No' else 'Yes' end AS [US Person] 
			 ,'Yes' AS [OTC] 
			 ,'No' AS [Dealing Activity] 
			 ,'No' AS [IntraGroup] 
			 ,'No' AS [Unwind] 
			 ,'No' AS [Trade Done In Brazil] 
			 --,convert(numeric(36,2),round(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,swap.compra_codmoneda,Swap.compra_capital,13),2)) AS [USD Notional]
			 ,CONVERT(NUMERIC(36,2),ROUND(CASE WHEN Swap.compra_moneda = 'USD' THEN Swap.compra_capital
									   WHEN Swap.venta_moneda = 'USD' THEN Swap.venta_capital
			  ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,swap.compra_codmoneda,Swap.compra_capital,13) END,2)) AS [USD Notional]
			  ,  Swap.numero_operacion  -- MAP 20170411
			  ,  Swap.origen            -- MAP 20170411
			  ,  Swap.compra_codmoneda  -- MAP 20170411
			  ,  Swap.fecha_inicio      -- MAP 20170411
			  from	(	select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa
					   ,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador, Compra.fecha_cierre
					   ,		Venta_Moneda	= Venta.Venta_Moneda
					   ,		venta_codmoneda = Venta.venta_codmoneda
					   ,		Compra_Moneda	= Mon.mnnemo
					   ,		compra_codmoneda = Mon.mncodmon
					   ,		compra.Rut_Cliente, compra.codigo_cliente
					   ,		Compra.fecha_termino
					   ,		compra.tipo_operacion
					   ,		Venta.venta_spread
					   ,		compra.compra_spread
					   ,      compra.fecha_inicio
					   ,		number_cash_flow = (select count(compra1.numero_flujo)
										     from #Cartera compra1 
										     where compra1.numero_operacion = Compra.numero_operacion 
										     and compra1.tipo_flujo = 1
											and compra1.compra_amortiza <> 0)
					   ,		compra_amortiza = (select compra1.compra_amortiza
										    from #Cartera compra1  
										    where compra1.numero_operacion = Compra.numero_operacion  
										    and compra1.tipo_flujo = 1
										    and compra1.numero_flujo = (select max(numero_flujo)
																  from #Cartera
																  where numero_operacion = Compra.numero_operacion  
																  and tipo_flujo = 1)
										    and compra1.compra_amortiza <> 0)
					   ,			origen  = 'TR-'
					   ,		number_cash_flow_p = (select count(compra1.numero_flujo)
											    from #Cartera compra1 
											    where compra1.numero_operacion = Compra.numero_operacion 
											    and compra1.tipo_flujo = 2
											    and compra1.venta_amortiza <> 0)
					   ,		compra_amortiza_p = (select compra1.venta_amortiza
											   from #Cartera compra1  
											   where compra1.numero_operacion = Compra.numero_operacion  
											   and compra1.tipo_flujo = 2
											   and compra1.numero_flujo = (select max(numero_flujo)
																	 from #Cartera
																	 where numero_operacion = Compra.numero_operacion  
																	 and tipo_flujo = 2)
											   and compra1.venta_amortiza <> 0)	
					   ,		compra_cod_tasa  = compra_codigo_tasa
					   ,		venta_cod_tasa	  = Venta.venta_codigo_tasa
					   ,	    fecha_vence_flujo = Compra.fecha_vence_flujo										   									    
					   from	#Cartera Compra with(nolock)
							   inner join (select Contrato = ca.numero_operacion
												,flujo_act = MIN(ca.numero_flujo)
												,flujo_pas = (SELECT MIN(c.numero_flujo) 
															  FROM #Cartera c with(nolock)
															  WHERE c.tipo_flujo		 = 2	            
															  AND	  c.numero_operacion = ca.numero_operacion)
										 from	#Cartera ca with(nolock)
										 where ca.Estado		        = ''
										 AND	  ca.tipo_flujo		    = 1 
										 AND	  ca.fecha_vence_flujo  > @Fecha_anterior
										 AND	  ca.fecha_vence_flujo  <= @FechaHasta  
										 group by ca.numero_operacion
										  )	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												    and	GrpSwap.Flujo_act	= Compra.numero_flujo

							   inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo, venta_spread,
											 venta_codmoneda = Mon.mncodmon, venta_codigo_tasa
											   from	#Cartera	with(nolock)
													   inner join (	select	mncodmon, mnnemo 
																	   from	BacParamSuda.dbo.Moneda with(nolock)
																   )	Mon On	Mon.mncodmon	= Venta_Moneda
									   where		Estado	    = ''
											   and		tipo_flujo		= 2
								   )	Venta	On	Venta.numero_operacion	= GrpSwap.Contrato
											   and	Venta.numero_flujo		= GrpSwap.flujo_pas
							   inner join (	select	mncodmon, mnnemo
											   from	BacParamSuda.dbo.Moneda with(nolock)
										   )	Mon On	Mon.mncodmon	= Compra.compra_Moneda
					   where Estado 			= ''
					   and   tipo_flujo			= 1
					   and   Estado_oper_lineas	NOT IN ('P')
					   AND   fecha_vence_flujo  > @Fecha_anterior
					   AND   fecha_vence_flujo  <= @Fechahasta
					   AND   IntercPrinc = 1
					   AND   fecha_inicio_flujo <> fecha_vence_flujo
					   /*SWAP NY*/
					   UNION	 
					   select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa
					   ,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador, Compra.fecha_cierre
					   ,		Venta_Moneda	= Venta.Venta_Moneda
					   ,		venta_codmoneda = Venta.venta_codmoneda
					   ,		Compra_Moneda	= Mon.mnnemo
					   ,		compra_codmoneda = Mon.mncodmon
					   ,		compra.Rut_Cliente, compra.codigo_cliente
					   ,		Compra.fecha_termino
					   ,		compra.tipo_operacion
					   ,		Venta.venta_spread
					   ,		compra.compra_spread
					   ,      compra.fecha_inicio
					   ,		number_cash_flow = (select count(compra1.numero_flujo)
										     from #CarteraNY compra1 
										     where compra1.numero_operacion = Compra.numero_operacion 
										     and compra1.tipo_flujo = 1
											and compra1.compra_amortiza <> 0)
					   ,		compra_amortiza = (select compra1.compra_amortiza
										    from #CarteraNY compra1  
										    where compra1.numero_operacion = Compra.numero_operacion  
										    and compra1.tipo_flujo = 1
										    and compra1.numero_flujo = (select max(numero_flujo)
																  from #CarteraNY
																  where numero_operacion = Compra.numero_operacion  
																  and tipo_flujo = 1)
										    and compra1.compra_amortiza <> 0)
					   ,			origen  = 'TR-NY-'
					   ,		number_cash_flow_p = (select count(compra1.numero_flujo)
											    from #CarteraNY compra1 
											    where compra1.numero_operacion = Compra.numero_operacion 
											    and compra1.tipo_flujo = 2
											    and compra1.venta_amortiza <> 0)
					   ,		compra_amortiza_p = (select compra1.venta_amortiza
											   from #CarteraNY compra1  
											   where compra1.numero_operacion = Compra.numero_operacion  
											   and compra1.tipo_flujo = 2
											   and compra1.numero_flujo = (select max(numero_flujo)
																	 from #CarteraNY
																	 where numero_operacion = Compra.numero_operacion  
																	 and tipo_flujo = 2)
											   and compra1.venta_amortiza <> 0)
					   ,		compra_cod_tasa  = compra_codigo_tasa
					   ,		venta_cod_tasa	  = Venta.venta_codigo_tasa
					   ,	    fecha_vence_flujo = Compra.fecha_vence_flujo											   				   										    
					   from	#CarteraNY Compra with(nolock)
						inner join (	select Contrato = ca.numero_operacion
											  ,flujo_act = MIN(ca.numero_flujo)
											  ,flujo_pas = (SELECT MIN(c.numero_flujo) 
														    FROM #CarteraNY c with(nolock)
														    WHERE c.tipo_flujo		 = 2	            
														    AND	  c.numero_operacion = ca.numero_operacion)
											 from	#CarteraNY ca with(nolock)
										where ca.Estado		       = ''
										AND	 ca.tipo_flujo		   = 1 
										AND	 ca.fecha_vence_flujo  > @Fecha_anterior
										AND	 ca.fecha_vence_flujo  <= @FechaHasta  
											 group by ca.numero_operacion
										   )	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												    and	GrpSwap.Flujo_act	= Compra.numero_flujo

							   inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo, venta_spread,
											 venta_codmoneda = Mon.mncodmon, venta_codigo_tasa
											   from	#CarteraNY with(nolock)
													   inner join (	select	mncodmon, mnnemo 
																	   from	BacParamSuda.dbo.Moneda with(nolock)
																   )	Mon On	Mon.mncodmon	= Venta_Moneda
									   where		Estado		= ''
											   and		tipo_flujo		= 2
								   )	Venta	On	Venta.numero_operacion	= GrpSwap.Contrato
											   and	Venta.numero_flujo		= GrpSwap.flujo_pas
							   inner join (	select	mncodmon, mnnemo
											   from	BacParamSuda.dbo.Moneda with(nolock)
										   )	Mon On	Mon.mncodmon	= Compra.compra_Moneda
				    where Estado 			= ''
				    and   tipo_flujo			= 1
				    and   Estado_oper_lineas	NOT IN ('P')
				    AND   fecha_vence_flujo  > @Fecha_anterior
				    AND   fecha_vence_flujo  <= @Fechahasta
				    AND   IntercPrinc = 1
				    AND   fecha_inicio_flujo <> fecha_vence_flujo 				   
					   /*FIN SWAP NY*/   
				   )	Swap

				   inner join
				   (	select	clrut = clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
					   from	BacParamSuda.dbo.cliente with(nolock)
				   )	Clie	On	Clie.clrut		= Swap.Rut_Cliente
							   and Clie.clcodigo	= Swap.codigo_cliente
				where Swap.tipo_swap in (2)
				AND Swap.fecha_termino <> Swap.fecha_vence_flujo						 

         -- MAP 20170411
         -- Corregir Marca de Anticipos Totales
		 Update #RESULTADOS_CCS
		     set Type = 'E', [Contract Update Reason] = '', [Unwind] = 'Yes'
			 where #RESULTADOS_CCS.[Type] = 'U'
			 and  #RESULTADOS_CCS.Origen = 'TR-'
			 and  #RESULTADOS_CCS.[Contract Update Reason] = 'Parcial'
			 and  #RESULTADOS_CCS.Numero_Operacion 
			 not in -- Lista de Operaciones Vigentes
			       ( select distinct numero_operacion from #Cartera 
			           where estado = ' ' 
					   and fecha_termino  > @Fecha )

		 Update #RESULTADOS_CCS
		     set Type = 'E', [Contract Update Reason] = '', [Unwind] = 'Yes'
			 where #RESULTADOS_CCS.[Type] = 'U'
			 and  #RESULTADOS_CCS.Origen = 'TR-NY-'
			 and  #RESULTADOS_CCS.[Contract Update Reason] = 'Parcial'
			 and  #RESULTADOS_CCS.Numero_Operacion  
			 not in -- Lista de Operaciones Vigentes
			       ( select distinct numero_operacion from #CarteraNY 
			           where estado = ' ' 
					   and fecha_termino  > @Fecha )
		
         -- MAP 20170411
		 -- Corregir campos con Montos de anticipos parciales
		 Update #RESULTADOS_CCS
		     set #RESULTADOS_CCS.[Notional Amount] = ( select distinct compra_capital 
			                                            from #Cartera C 
														 where C.numero_operacion = #RESULTADOS_CCS.Numero_Operacion
														   and tipo_Flujo = 1
														   and estado = ' ' ) 
				, #RESULTADOS_CCS.[Asset Notional Amount] = ( select distinct compra_capital 
			                                            from #Cartera C 
														 where C.numero_operacion = #RESULTADOS_CCS.Numero_Operacion
														   and tipo_Flujo = 1
														   and estado = ' ' ) 
				, #RESULTADOS_CCS.[Liability Notional Amount] = ( select distinct venta_capital 
			                                            from #Cartera C 
														 where C.numero_operacion = #RESULTADOS_CCS.Numero_Operacion
														   and tipo_Flujo = 2
														   and estado = ' ' ) 
			 
			 where #RESULTADOS_CCS.Type = 'U'
			 and  #RESULTADOS_CCS.[Contract Update Reason] = 'Parcial'
			 and  #RESULTADOS_CCS.Origen = 'TR-'


		 Update #RESULTADOS_CCS
		     set #RESULTADOS_CCS.[Notional Amount] = ( select distinct compra_capital 
			                                            from #CarteraNY C 
														 where C.numero_operacion = #RESULTADOS_CCS.Numero_Operacion
														   and tipo_Flujo = 1
														   and estado = ' ' ) 
				, #RESULTADOS_CCS.[Asset Notional Amount] = ( select distinct compra_capital 
			                                            from #CarteraNY C 
														 where C.numero_operacion = #RESULTADOS_CCS.Numero_Operacion
														   and tipo_Flujo = 1
														   and estado = ' ' ) 
				, #RESULTADOS_CCS.[Liability Notional Amount] = ( select distinct venta_capital 
			                                            from #CarteraNY C 
														 where C.numero_operacion = #RESULTADOS_CCS.Numero_Operacion
														   and tipo_Flujo = 2
														   and estado = ' ' ) 
			 where #RESULTADOS_CCS.Type = 'U'
			 and  #RESULTADOS_CCS.[Contract Update Reason] = 'Parcial'
			 and  #RESULTADOS_CCS.Origen = 'TR-NY-'

		Update #RESULTADOS_CCS
		      set [USD Notional] = CONVERT(NUMERIC(36,2),ROUND(CASE WHEN [Asset Referency Currency] = 'USD' THEN 
			                                                             #RESULTADOS_CCS.[Asset Notional Amount] 
									                                WHEN [Liability Referency Currency] = 'USD' THEN 
                                                                         #RESULTADOS_CCS.[Liability Notional Amount]
			                                                        ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,Compra_Moneda,
																	                                                    #RESULTADOS_CCS.[Asset Notional Amount]  
																	                                                   ,13) 
																	END,2)) 
																	 
			  
		    where #RESULTADOS_CCS.Type = 'U'
			 and  #RESULTADOS_CCS.[Contract Update Reason] = 'Parcial'
			 and  #RESULTADOS_CCS.Origen = #RESULTADOS_CCS.Origen    -- MAP 20170411 No es relevante el origen

        -- MAP 20170412
		-- Anticipos Parciales de Operaciones con fecha efectiva anterior 
		-- al 17 de Marzo 2014 deben ser informadas como 'A' (correcciones)
		Update #RESULTADOS_CCS
		    Set [Type] = 'A' , [Contract Update Reason] = '', [Unwind] = 'Yes'
		where #RESULTADOS_CCS.Type = 'U'
		and  #RESULTADOS_CCS.[Contract Update Reason] = 'Parcial'
		and #RESULTADOS_CCS.[Effective Date Como Fecha] < '20140317'

		Update #RESULTADOS_CCS
		    Set [Type] = 'U' , [Contract Update Reason] = 'Amortization' , [Unwind] = 'No'
		where #RESULTADOS_CCS.[Type] = 'U'
		and  #RESULTADOS_CCS.[Contract Update Reason] = 'Parcial'
		-- Los anticipos parciales son
		-- mandados como Amortization
		-- despues de la ejecucipon de esto 
		-- ya no hay manera de diferenciarlos

		-- Poner sección campo a campo

			 -- select * from #RESULTADOS_CCS CCS order by CCS.[Contract Number] desc  -- homologar comentario
			select   [Type] 
		   ,[Contract Update Reason] 
		   ,[Part Account] 
		   ,[Part Position] 
		   ,[Part Code] 
		   ,[Part CPF/CNPJ] 
		   ,[Part] 
		   ,[Counterpart Indentified] 
		   ,[Counterpart Position] 
		   ,[Counterpart Code] 
		   ,[Counterpart CPF/CNPJ] 
		   ,[Counterpart] 
		   ,[Derivative Type] 
		   ,[Trading Place] 
		   ,[Contract Number] 
		   ,[Notional Amount] 
		   ,[Reference Currency] 
		   ,[Settlement Reference Currency] 
		   ,[Underlying asset] 
		   ,[Trade Date] 
		   ,[Effective Date]
		   ,[Settlement Date] 
		   ,[Asset Index] 
		   ,[Liability Index] 
		   ,[Asset Rate Percent] 
		   ,[Liability Rate Percent] 
		   ,[Asset Notional Amount] 
		   ,[Asset Referency Currency] 
		   ,[Liability Notional Amount] 
		   ,[Liability Referency Currency] 
		   ,[Asset Spread] 
		   ,[Liability Spread] 
		   ,[Cash-Flow] 
		   ,[Cash Flow Number] 
		   ,[Country Origin] 
		   ,[Registration] 
		   ,[Derivative Master Agreement] 
		   ,[Barrier] 
		   ,[Settlement Rate Type] 
		   ,[Addicional information] 
		   ,[DCE Contract] 
		   ,[US Person] 
		   ,[OTC] 
		   ,[Dealing Activity] 
		   ,[IntraGroup] 
		   ,[Unwind] 
		   ,[Trade Done In Brazil] 
		   ,[USD Notional]  
		   from #RESULTADOS_CCS CCS 
		   order by CCS.[Contract Number] desc

    
END
GO
