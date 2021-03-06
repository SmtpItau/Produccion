USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_STOCK_CCS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REPORTES_STOCK_CCS]
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
		  
		  SELECT @Fecha_anterior = sg.fechaant FROM BacSwapSuda.dbo.SwapGeneral sg		  
	   END
	ELSE 
	   BEGIN
	   	  SET @FechaDesde = @Fecha	  
		  SET @FechaHasta = @Fecha
	   END
    
    PRINT @Fecha
    
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
			 from	(	select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa
					   ,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador, Compra.fecha_cierre
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
											 from BacSwapSuda.dbo.cartera compra1 
											 where compra1.numero_operacion = Compra.numero_operacion 
											 and compra1.tipo_flujo = 1
											 and compra1.compra_amortiza <> 0)
					   ,		compra_amortiza = (select compra1.compra_amortiza
											 from BacSwapSuda.dbo.cartera compra1  
											 where compra1.numero_operacion = Compra.numero_operacion  
											 and compra1.tipo_flujo = 1
											 and compra1.numero_flujo = (select max(numero_flujo)
																    from BacSwapSuda.dbo.cartera
																    where numero_operacion = Compra.numero_operacion  
																    and tipo_flujo = 1)
											 and compra1.compra_amortiza <> 0)
					   ,		origen  = 'TR-'
					   ,		number_cash_flow_p = (select count(compra1.numero_flujo)
												from BacSwapSuda.dbo.cartera compra1 
												where compra1.numero_operacion = Compra.numero_operacion 
												and compra1.tipo_flujo = 2
												and compra1.venta_amortiza <> 0)
					   ,		compra_amortiza_p = (select compra1.venta_amortiza
												from BacSwapSuda.dbo.cartera compra1  
												where compra1.numero_operacion = Compra.numero_operacion  
												and compra1.tipo_flujo = 2
												and compra1.numero_flujo = (select max(numero_flujo)
																	   from BacSwapSuda.dbo.cartera
																	   where numero_operacion = Compra.numero_operacion  
																	   and tipo_flujo = 2)
												and compra1.venta_amortiza <> 0)
					   ,		compra_cod_tasa  = compra_codigo_tasa
					   ,		venta_cod_tasa	  = Venta.venta_codigo_tasa											   													
					   from	BacSwapSuda.dbo.cartera	Compra	with(nolock)

							 inner join (	select Contrato = ca.numero_operacion
											 ,Flujo_act = Min( ca.numero_flujo )
											 ,flujo_pas = (SELECT min(ca1.numero_flujo)
														FROM BacSwapSuda.dbo.cartera ca1 WITH(NOLOCK) 
														WHERE ca1.numero_operacion = ca.numero_operacion
														AND	ca1.fecha_termino > @fecha
														AND	ca1.fecha_vence_flujo > @fecha
														AND	ca1.estado <> 'C'
														AND	ca1.tipo_flujo = 2)
											 from	BacSwapSuda.dbo.cartera ca with(nolock)
											 where	ca.fecha_termino		  > @fecha
											 AND		ca.fecha_vence_flujo	  > @fecha
											 and		ca.Estado <> 'C' 
											 and		ca.tipo_flujo =1 
											 group by ca.numero_operacion
										  )	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												    and	GrpSwap.Flujo_act	= Compra.numero_flujo

								inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo, venta_spread,
											 venta_codmoneda = Mon.mncodmon, venta_codigo_tasa
												from	BacSwapSuda.dbo.cartera	with(nolock)
													   inner join (	select	mncodmon, mnnemo 
																	   from	BacParamSuda.dbo.Moneda with(nolock)
																    )	Mon On	Mon.mncodmon	= Venta_Moneda
												where	fecha_termino		    > @fecha
												AND	fecha_vence_flujo	    > @fecha
												and		Estado			<> 'C'
												and		tipo_flujo		= 2
											 )	Venta	On	Venta.numero_operacion	= GrpSwap.Contrato
													   and	Venta.numero_flujo		= GrpSwap.flujo_pas

								inner join (	select	mncodmon, mnnemo
												from	BacParamSuda.dbo.Moneda with(nolock)
											 )	Mon On	Mon.mncodmon	= Compra.compra_Moneda

					   where	Estado_oper_lineas 	    NOT IN ('P')
					   and 	Estado 			    = ''
					   and	tipo_flujo		    = 1
					   UNION
					   /*SWAP NY*/
					   select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa
					   ,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador, Compra.fecha_cierre
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
											 from BacSwapNY.dbo.cartera compra1 
											 where compra1.numero_operacion = Compra.numero_operacion 
											 and compra1.tipo_flujo = 1
											 and compra1.compra_amortiza <> 0)
					   ,		compra_amortiza = (select compra1.compra_amortiza
											 from BacSwapNY.dbo.cartera compra1  
											 where compra1.numero_operacion = Compra.numero_operacion  
											 and compra1.tipo_flujo = 1
											 and compra1.numero_flujo = (select max(numero_flujo)
																    from BacSwapNY.dbo.cartera
																    where numero_operacion = Compra.numero_operacion  
																    and tipo_flujo = 1)
											 and compra1.compra_amortiza <> 0)
					   ,			origen  = 'TR-NY-'
					   ,		number_cash_flow_p = (select count(compra1.numero_flujo)
												from BacSwapNY.dbo.cartera compra1 
												where compra1.numero_operacion = Compra.numero_operacion 
												and compra1.tipo_flujo = 2
												and compra1.venta_amortiza <> 0)
					   ,		compra_amortiza_p = (select compra1.venta_amortiza
												from BacSwapNY.dbo.cartera compra1  
												where compra1.numero_operacion = Compra.numero_operacion  
												and compra1.tipo_flujo = 2
												and compra1.numero_flujo = (select max(numero_flujo)
																	   from BacSwapNY.dbo.cartera
																	   where numero_operacion = Compra.numero_operacion  
																	   and tipo_flujo = 2)
												and compra1.venta_amortiza <> 0)
					   ,		compra_cod_tasa  = compra_codigo_tasa
					   ,		venta_cod_tasa	  = Venta.venta_codigo_tasa											   													
					   from	BacSwapNY.dbo.cartera	Compra	with(nolock)

							 inner join (	select Contrato = ca.numero_operacion
											 ,Flujo_act = Min( ca.numero_flujo )
											 ,flujo_pas = (SELECT min(ca1.numero_flujo)
														FROM BacSwapSuda.dbo.cartera ca1 WITH(NOLOCK)
														WHERE ca1.numero_operacion = ca.numero_operacion
														AND	ca1.fecha_termino > @fecha
														AND	ca1.fecha_vence_flujo > @fecha
														AND	ca1.estado <> 'C'
														AND	ca1.tipo_flujo = 2)
											 from	BacSwapSuda.dbo.cartera ca with(nolock)
											 where	ca.fecha_termino		  > @fecha
											 AND		ca.fecha_vence_flujo	  > @fecha
											 and		ca.Estado <> 'C' 
											 and		ca.tipo_flujo =1 
											 group by ca.numero_operacion
										  )	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												    and	GrpSwap.Flujo_act	= Compra.numero_flujo

								inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo, venta_spread,
											 venta_codmoneda = Mon.mncodmon, venta_codigo_tasa
												from	BacSwapNY.dbo.cartera	with(nolock)
													   inner join (	select	mncodmon, mnnemo 
																	   from	BacParamSuda.dbo.Moneda with(nolock)
																    )	Mon On	Mon.mncodmon	= Venta_Moneda
												where	fecha_termino		    > @fecha
												AND	fecha_vence_flujo	    > @fecha
												and		Estado			<> 'C'
												and		tipo_flujo		= 2
											 )	Venta	On	Venta.numero_operacion	= GrpSwap.Contrato
													   and	Venta.numero_flujo		= GrpSwap.flujo_pas

								inner join (	select	mncodmon, mnnemo
												from	BacParamSuda.dbo.Moneda with(nolock)
											 )	Mon On	Mon.mncodmon	= Compra.compra_Moneda

					   where	Estado_oper_lineas 	    NOT IN ('P')
					   and 	Estado 			    = ''
					   and	tipo_flujo		    = 1
					   /*FIN SWAP NY*/      
				    )	Swap

				    inner join
				    (	select	clrut = clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
					   from	BacParamSuda.dbo.cliente with(nolock)
				    )	Clie	On	Clie.clrut		= Swap.Rut_Cliente
								and Clie.clcodigo	= Swap.codigo_cliente
				
				where Swap.tipo_swap in (2)

		  -- select * from #RESULTADOS_CCS CCS order by CCS.[Contract Number] desc
		  
				select *
				from #RESULTADOS_CCS CCS
				WHERE convert(datetime,CCS.[Trade Date],3) <= '20160331'
				--WHERE convert(datetime,CCS.[Trade Date],3) > '20160331'  
				ORDER BY CCS.[Contract Number] DESC 

    
END
GO
