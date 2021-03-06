USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_CARTERA_TICKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RPT_CARTERA_TICKET] ( 
        @Operacion	numeric(1,0)		,
	@TipoOperacion	CHAR	(1)= ''	,
	@Fecha		CHAR	(08)	,
	@FechaProc	CHAR	(08)	,
	@CarteraOrg	Integer, 
	@CarteraDes	Integer 
	)
AS
BEGIN

	SET NOCOUNT ON

	Declare @Glosa_Cartera Char(20)			,
		@Glosa_Area_Resp	CHAR(50)	,
		@Glosa_Cart_Norm	CHAR(50)	,
		@Glosa_SubCart_Norm	CHAR(50)	,
		@Glosa_Libro		CHAR(50)

	SELECT @Glosa_Cartera = '' 

	SELECT	Distinct	@Glosa_Cartera = IsNull(rcnombre,'')
	FROM	BacParamSuda..TIPO_CARTERA
	WHERE	rcsistema = 'PCS'
--	AND	rcrut     = @Cartera
 --ORDER BY rcrut  

	--RECUPERA VENTA
	SELECT	TBL_FLJTICKETSWAP.Numero_Operacion											,
		Tipo_operacion 												, 			
		'NombreOp'		        = (CASE Tipo_operacion WHEN 'C' THEN'COMPRA ' ELSE 'VENTA  ' END)		,
		'FechaInicio'		    = CONVERT(CHAR(10), Fecha_inicio, 103)						, 
		'FechaCierre'   		= CONVERT(CHAR(10), Fecha_Cierre, 103)						, 
		'Fechatermino'   	    = CONVERT(CHAR(10), Fecha_termino, 103)						,
		'MonedaOperacion'	    = (CASE Tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END)	, 
		'NombreMoneda'		    = ISNULL( ( SELECT mnnemo FROM View_moneda WHERE  mncodmon = compra_moneda) , '*'),
		'valormoneda'		    = ISNULL( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = compra_moneda AND vmfecha = @fechaProc ),0) ,
		'MontoOperacion' 	    = Compra_capital 								,		
       	'CapitalVigente' 	    = Compra_Amortiza 								,		
     	'Modalidad'		        = ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' '), 
		'montouf'		        = ISNULL((SELECT vmvalor FROM View_valor_moneda WHERE  vmcodigo = 998 AND vmfecha = @fecha ),0) ,
		'montoobs'		        = ISNULL((SELECT vmvalor FROM View_valor_moneda WHERE  vmcodigo = 994 AND vmfecha = @fechaProc ),0),	
		'banco'		            = ISNULL((SELECT nombre FROM swapgeneral),'*') 				,
		'fechainicioflujo'	    = CONVERT(CHAR(10), Fecha_inicio_flujo, 103)				,
		'fechavenceflujo'	    = CONVERT(CHAR(10), Fecha_vence_flujo, 103)				,
		'dias'			        = DATEDIFF(dd,Fecha_inicio_flujo, Fecha_vence_flujo)			,
		'diasDevengo'		    = devengo_dias								,
		'TasaFija'		        = compra_valor_tasa + compra_spread					,
		'devengodiariom_o'	    = compra_interes 							, 
		'devengoacumuladom_o'	= devengo_compra_acum 							, 
		'devengoacumuladopes'	= devengo_monto_peso							, 
		'Tasavariable'		    = (compra_valor_tasa + compra_spread) 					,					  
		'Flujo'			        = 'REC '+ (CASE compra_codigo_tasa WHEN 0 THEN 'F' ELSE 'V' END)	,
		'hora'			        = CONVERT ( CHAR(10), GETDATE (), 108) , 
 	 	  numero_flujo      	,
		'Fechaproceso'	        = Substring(@fecha ,7,2) + '/' +Substring(@fecha ,5,2) + '/' +Substring(@fecha ,1,4)				, 
		'FechaDevengo'	        = Substring(@fechaProc ,7,2) + '/' +Substring(@fechaProc ,5,2) + '/' +Substring(@fechaProc ,1,4) 		,
		 tipo_swap,
		'SumaCapInicial'	    = Compra_capital		,
		'SumaInteresPAG'	    = 0,
		'SumaInteresREC'	    = compra_interes,
		'SumaDiarioPAG'	        = 0,
		'SumaDiarioREC'	        = (CASE compra_interes WHEN 0 THEN compra_interes ELSE compra_interes/DATEDIFF(dd,Fecha_inicio_flujo, Fecha_vence_flujo )END),
	 	'SumaAcumuladoPAG'	    = 0,
		'SumaAcumuladoREC'	    = devengo_compra_acum,
		'SumaAcumuladoPesoPAG'	= 0,
		'SumaAcumuladoPesoREC'	= devengo_monto_peso,
		'SUMRECDIA'             = CONVERT(FLOAT,0.0),
		'SUMPAGDIA'             = CONVERT(FLOAT,0.0),
		'Tipo_Cartera'		    = CONVERT(CHAR(20),'')	,
		'CarteraOrigen'		    = RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
							WHERE 	rcsistema		= 'PCS'
							AND	RCCODPRO		= 'FR'
					and	rcrut			=TBL_CARTICKETSWAP.CodCarteraOrigen),'No Especificado')),
		'MesaOrigen'		    = RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
							  WHERE 	tbcodigo1=TBL_CARTICKETSWAP.CodMesaOrigen),'No Especificado')),
		'CarteraDestino'	    = RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
							WHERE 	rcsistema		= 'PCS'
							AND	RCCODPRO		= 'FR'
								and	rcrut			=TBL_CARTICKETSWAP.CodCarteraDestino),'No Especificado')),
		'sMesaDestino'		    = RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
					  WHERE 	tbcodigo1=TBL_CARTICKETSWAP.CodMesaDestino),'No Especificado'))
	INTO	#PASO_REC_LOG
 	FROM 	TBL_FLJTICKETSWAP
		INNER JOIN TBL_CARTICKETSWAP   ON TBL_CARTICKETSWAP.Numero_Operacion  = TBL_FLJTICKETSWAP.Numero_Operacion
	WHERE 	Tipo_swap = @operacion 	
		AND (Fecha_inicio_flujo <= @Fecha AND Fecha_vence_flujo >  @Fecha)	
		AND tipo_flujo = 1
                AND estado <> 'C'
	AND	(TBL_CARTICKETSWAP.CodCarteraOrigen = @CarteraOrg OR @CarteraOrg =0)
	AND	(TBL_CARTICKETSWAP.CodCarteraDestino = @CarteraDes OR @CarteraDes =0)

	
	--PAGA COMPRA 
	SELECT	TBL_FLJTICKETSWAP.Numero_Operacion											,
		Tipo_operacion 												, 			
		'NombreOp'		        = (CASE Tipo_operacion WHEN 'C' THEN'COMPRA ' ELSE 'VENTA  ' END)		,
		'FechaInicio'		    = CONVERT(CHAR(10), Fecha_inicio, 103)						, 
		'FechaCierre'   		= CONVERT(CHAR(10), Fecha_Cierre, 103)						, 
		'Fechatermino'   	    = CONVERT(CHAR(10), Fecha_termino, 103)						,
		'MonedaOperacion'	    = (CASE Tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END)	, 
		'NombreMoneda'		    = ISNULL( ( SELECT mnnemo FROM View_moneda WHERE  mncodmon = compra_moneda) , '*'),
		'valormoneda'		    = ISNULL( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = compra_moneda AND vmfecha = @fechaProc ),0) ,
		'MontoOperacion' 	    = Compra_capital 								,		
       	'CapitalVigente' 	    = Compra_Amortiza 								,		
     	'Modalidad'		        = ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' '), 
		'montouf'		        = ISNULL((SELECT vmvalor FROM View_valor_moneda WHERE  vmcodigo = 998 AND vmfecha = @fecha ),0) ,
		'montoobs'		        = ISNULL((SELECT vmvalor FROM View_valor_moneda WHERE  vmcodigo = 994 AND vmfecha = @fechaProc ),0),	
		'banco'		            = ISNULL((SELECT nombre FROM swapgeneral),'*') 				,
		'fechainicioflujo'	    = CONVERT(CHAR(10), Fecha_inicio_flujo, 103)				,
		'fechavenceflujo'	    = CONVERT(CHAR(10), Fecha_vence_flujo, 103)				,
		'dias'			        = DATEDIFF(dd,Fecha_inicio_flujo, Fecha_vence_flujo)			,
		'diasDevengo'		    = devengo_dias								,
		'TasaFija'		        = compra_valor_tasa + compra_spread					,
		'devengodiariom_o'	    = compra_interes 							, 
		'devengoacumuladom_o'	= devengo_compra_acum 							, 
		'devengoacumuladopes'	= devengo_monto_peso							, 
		'Tasavariable'		    = (compra_valor_tasa + compra_spread) 					,					  
		'Flujo'			        = 'REC '+ (CASE compra_codigo_tasa WHEN 0 THEN 'F' ELSE 'V' END)	,
		'hora'			        = CONVERT ( CHAR(10), GETDATE (), 108) , 
 	 	  numero_flujo      	,
	    'Fechaproceso'		    = Substring(@fecha ,7,2) + '/' +Substring(@fecha ,5,2) + '/' +Substring(@fecha ,1,4)    ,   
	    'FechaDevengo'		    = Substring(@fechaProc ,7,2) + '/' +Substring(@fechaProc ,5,2) + '/' +Substring(@fechaProc ,1,4)   ,  
		 tipo_swap,
	    'SumaCapInicial'	    = Compra_capital  ,  
	    'SumaInteresPAG'	    = 0,  
	    'SumaInteresREC'	    = compra_interes,  
	    'SumaDiarioPAG'		    = 0,  
	    'SumaDiarioREC'		    = (CASE compra_interes WHEN 0 THEN compra_interes ELSE compra_interes/DATEDIFF(dd,Fecha_inicio_flujo, Fecha_vence_flujo )END),  
	    'SumaAcumuladoPAG'	    = 0,  
	    'SumaAcumuladoREC'	    = devengo_compra_acum,  
	    'SumaAcumuladoPesoPAG'  = 0,  
	    'SumaAcumuladoPesoREC'  = devengo_monto_peso,  
	    'SUMRECDIA'			    = CONVERT(FLOAT,0.0),  
	    'SUMPAGDIA'			    = CONVERT(FLOAT,0.0),  
	    'Tipo_Cartera'		    = CONVERT(CHAR(20),'') ,  
		'CarteraOrigen'		    = RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
							WHERE 	rcsistema		= 'PCS'
							AND	RCCODPRO		= 'FR'
					and	rcrut			=TBL_CARTICKETSWAP.CodCarteraOrigen),'No Especificado')),
		'MesaOrigen'		    = RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
							  WHERE 	tbcodigo1=TBL_CARTICKETSWAP.CodMesaOrigen),'No Especificado')),
		'CarteraDestino'	    = RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
							WHERE 	rcsistema		= 'PCS'
							AND	RCCODPRO		= 'FR'
								and	rcrut			=TBL_CARTICKETSWAP.CodCarteraDestino),'No Especificado')),
		'sMesaDestino'		    = RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
					  WHERE 	tbcodigo1=TBL_CARTICKETSWAP.CodMesaDestino),'No Especificado'))
	INTO #PASO_PAG_LOG  
 	FROM 	TBL_FLJTICKETSWAP
		INNER JOIN TBL_CARTICKETSWAP   ON TBL_CARTICKETSWAP.Numero_Operacion  = TBL_FLJTICKETSWAP.Numero_Operacion
	WHERE 	Tipo_swap = @operacion 	
		AND (Fecha_inicio_flujo <= @Fecha AND Fecha_vence_flujo >  @Fecha)	
		AND tipo_flujo = 2
                AND estado <> 'C'
	AND	(TBL_CARTICKETSWAP.CodCarteraOrigen = @CarteraOrg OR @CarteraOrg =0)
	AND	(TBL_CARTICKETSWAP.CodCarteraDestino = @CarteraDes OR @CarteraDes =0)

		update #PASO_PAG_LOG SET SUMRECDIA=(select SUMRECDIA=SUM(SumaDiarioREC) from #PASO_REC_LOG)
		update #PASO_REC_LOG SET SUMPAGDIA=(select SUMPAGDIA=SUM(SumaDiarioPAG) from #PASO_PAG_LOG)
		Update #PASO_PAG_LOG Set Tipo_Cartera = @Glosa_Cartera

		update #PASO_PAG_LOG SET SUMPAGDIA=(select SUMPAGDIA=sum(SumaDiarioPAG) from #PASO_PAG_LOG)
		update #PASO_REC_LOG SET SUMRECDIA=(select SUMRECDIA=sum(SumaDiarioREC) from #PASO_REC_LOG)
		Update #PASO_REC_LOG Set Tipo_Cartera = @Glosa_Cartera

	SELECT * FROM #PASO_REC_LOG	
	UNION
	SELECT * FROM #PASO_PAG_LOG
	ORDER BY numero_operacion,flujo

   RETURN 0

	SET NOCOUNT OFF

END
GO
