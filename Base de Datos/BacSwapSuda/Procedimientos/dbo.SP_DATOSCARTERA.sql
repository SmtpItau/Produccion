USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSCARTERA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DATOSCARTERA]  
       (
        @Operacion	FLOAT		,
	@TipoOperacion	CHAR	(1)= ''	,
	@Fecha		CHAR	(08)	,
	@FechaProc	CHAR	(08)	,
	@Cartera	Integer 	,
	@Area_Resp	CHAR(10)	,
	@Cart_Norm	CHAR(10)	,
	@SubCart_Norm	CHAR(10)	,
	@Libro		CHAR(10)	,
	@Const_Area_Resp	CHAR(10),
	@Const_Cart_Norm	CHAR(10),
	@Const_SubCart_Norm	CHAR(10),
	@Const_Libro		CHAR(10)
	)
AS
BEGIN

	SET NOCOUNT ON

	Declare @Glosa_Cartera Char(20)			,
		@Glosa_Area_Resp	CHAR(50)	,
		@Glosa_Cart_Norm	CHAR(50)	,
		@Glosa_SubCart_Norm	CHAR(50)	,
		@Glosa_Libro		CHAR(50)

Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'PCS'
     And  rcrut     = @Cartera
	--ORDER BY rcrut  

  if @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'  


	SELECT	@Glosa_Area_Resp	= CASE @Area_Resp	WHEN '' THEN '< TODOS >'
								ELSE (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Area_Resp AND TBCODIGO1 = @Area_Resp ) END	,
		@Glosa_Cart_Norm	= CASE @Cart_Norm	WHEN '' THEN '< TODOS >'
								ELSE (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Cart_Norm AND TBCODIGO1 = @Cart_Norm ) END	,
		@Glosa_SubCart_Norm	= CASE @SubCart_Norm	WHEN '' THEN '< TODOS >'
								ELSE (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_SubCart_Norm AND TBCODIGO1 = @SubCart_Norm ) END	,
		@Glosa_Libro		= CASE @Libro		WHEN '' THEN '< TODOS >'
								ELSE (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Libro AND TBCODIGO1 = @Libro) END	


	--RECUPERA VENTA
	SELECT	Numero_Operacion											,
		Codigo_Cliente												,
		'Nombrecli'			= ISNULL(clnombre ,'*')        ,  
		Tipo_operacion 												, 			
		'NombreOp'			= (CASE Tipo_operacion WHEN 'C' THEN'COMPRA ' ELSE 'VENTA  ' END)  ,  
		'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103)      ,   
		'FechaCierre'		= CONVERT(CHAR(10), Fecha_Cierre, 103)      ,   
		'Fechatermino'		= CONVERT(CHAR(10), Fecha_termino, 103)      ,  
		'MonedaOperacion'	= (CASE Tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END) ,   
		'NombreMoneda'		= ISNULL( ( SELECT mnnemo FROM View_moneda WHERE  mncodmon = compra_moneda) , '*'),
		'valormoneda'		= ISNULL( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = compra_moneda AND vmfecha = @fechaProc ),0) ,
		'MontoOperacion'	= Compra_capital         ,    
		'CapitalVigente'	= Compra_Amortiza         ,    
		'Modalidad'			= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' '),   
		'rutcli'			= ISNULL(rut_cliente,0),   
		'digcli'			= ISNULL(cldv,'*'),   
		'montouf'		= ISNULL((SELECT vmvalor FROM View_valor_moneda WHERE  vmcodigo = 998 AND vmfecha = @fecha ),0) ,
		'montoobs'		= ISNULL((SELECT vmvalor FROM View_valor_moneda WHERE  vmcodigo = 994 AND vmfecha = @fechaProc ),0),	
		'banco'		= ISNULL((SELECT nombre FROM swapgeneral),'*') 				,
		'fechainicioflujo'	= CONVERT(CHAR(10), Fecha_inicio_flujo, 103)    ,  
		'fechavenceflujo'	= CONVERT(CHAR(10), Fecha_vence_flujo, 103)    ,  
		'dias'				= DATEDIFF(dd,Fecha_inicio_flujo, Fecha_vence_flujo)   ,  
		'diasDevengo'		= devengo_dias        ,  
		'cartinversion'		= CONVERT (CHAR(20),cartera_inversion)     ,  
		'TasaFija'			= compra_valor_tasa + compra_spread     ,  
		'devengodiariom_o'	= compra_interes        ,   
		'devengoacumuladom_o' = devengo_compra_acum        ,   
		'devengoacumuladopes' = devengo_monto_peso       ,   
		'Tasavariable'		= (compra_valor_tasa + compra_spread)      ,         
		'Flujo'				= 'REC '+ (CASE compra_codigo_tasa WHEN 0 THEN 'F' ELSE 'V' END) ,  
		'hora'				= CONVERT ( CHAR(10), GETDATE (), 108) ,   
 	 	  numero_flujo      	,
		'Fechaproceso'		= Substring(@fecha ,7,2) + '/' +Substring(@fecha ,5,2) + '/' +Substring(@fecha ,1,4)    ,   
		'FechaDevengo'		= Substring(@fechaProc ,7,2) + '/' +Substring(@fechaProc ,5,2) + '/' +Substring(@fechaProc ,1,4)   ,  
		 tipo_swap,
		'SumaCapInicial'	= Compra_capital  ,  
		'SumaInteresPAG'	= 0,  
		'SumaInteresREC'	= compra_interes,  
		'SumaDiarioPAG'		= 0,  
		'SumaDiarioREC'		= compra_interes/DATEDIFF(dd,Fecha_inicio_flujo, Fecha_vence_flujo),  
		'SumaAcumuladoPAG'	= 0,  
		'SumaAcumuladoREC'	= devengo_compra_acum,  
		'SumaAcumuladoPesoPAG' = 0,  
		'SumaAcumuladoPesoREC' = devengo_monto_peso,  
		'SUMRECDIA'			= CONVERT(FLOAT,0.0),  
		'SUMPAGDIA'			= CONVERT(FLOAT,0.0),  
		'Tipo_Cartera'		= CONVERT(CHAR(20),'') ,  
		'Area_Responsable'	= @Glosa_Area_Resp ,  
		'Cartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Cart_Norm AND TBCODIGO1 = car_Cartera_Normativa )	,
		'SubCartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_SubCart_Norm AND TBCODIGO1 = car_SubCartera_Normativa )		,
		'Libro'			= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Libro AND TBCODIGO1 = car_Libro)
	INTO	#PASO_REC_LOG
 	FROM 	Cartera ,
		View_cliente  	 		
	WHERE 	Tipo_swap = @operacion 	
		AND (Fecha_inicio_flujo <= @Fecha AND Fecha_vence_flujo >  @Fecha)	
		AND (clrut     = rut_cliente
		AND  clcodigo  = codigo_cliente)
		AND tipo_flujo = 1
		And (cartera_inversion = @Cartera Or @Cartera = 0)
		AND (car_area_responsable	= @Area_Resp	OR @Area_Resp 		= '')
		AND (car_Cartera_Normativa	= @Cart_Norm	OR @Cart_Norm 		= '')
		AND (car_SubCartera_Normativa	= @SubCart_Norm	OR @SubCart_Norm	= '')
		AND (car_Libro			= @Libro	OR @Libro		= '')
                AND estado <> 'C'
	
	--PAGA COMPRA 
	SELECT	Numero_Operacion, 
		Codigo_Cliente	, 
		'Nombrecli'			= ISNULL(clnombre ,'*'),   
		Tipo_operacion 	, 			
		'NombreOp'			= (CASE Tipo_operacion WHEN 'C' THEN   
					  'COMPRA ' ELSE 'VENTA  ' END),   	 
		'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103),   
		'FechaCierre'		= CONVERT(CHAR(10), Fecha_Cierre, 103),   
		'Fechatermino'		= CONVERT(CHAR(10), Fecha_termino, 103),  
		'MonedaOperacion'	= venta_moneda     ,   
		'NombreMoneda'	= ISNULL( ( SELECT mnnemo FROM View_moneda WHERE  mncodmon = venta_moneda), '*') , 
		'valormoneda'		= ISNULL( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = venta_moneda AND vmfecha = @fechaProc ),0)    		,
		'MontoOperacion' 	= Venta_capital 			,		
       		'CapitalVigente' 	= Venta_Amortiza 			,		
     		'Modalidad'		= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 
					  'COMPENSACION' ELSE 'ENTREGA' END),' '), 
		'rutcli'			= ISNULL(rut_cliente,0), 
		'digcli'			= ISNULL(cldv,'*'), 
		'montouf'		= ISNULL((SELECT vmvalor FROM View_valor_moneda WHERE  vmcodigo = 998 AND vmfecha = @fecha ),0) ,
		'montoobs'		= ISNULL((SELECT vmvalor FROM View_valor_moneda WHERE  vmcodigo = 994 AND vmfecha = @fechaProc ),0),	
		'banco'		= ISNULL((SELECT nombre FROM swapgeneral),'*') , 
	        'fechainicioflujo'	= CONVERT(CHAR(10), Fecha_inicio_flujo, 103),  
		'fechavenceflujo'	= CONVERT(CHAR(10), Fecha_vence_flujo, 103),  
		'dias'				= DATEDIFF(dd,Fecha_inicio_flujo, Fecha_vence_flujo),  
		'diasDevengo'		= devengo_dias,  
		'cartinversion'		= CONVERT (CHAR(20),cartera_inversion)   ,   
		'TasaFija'			= (venta_valor_tasa + venta_spread)    ,   
		'devengodiariom_o'	= venta_interes*-1      ,   
		'devengoacumuladom_o' = devengo_venta_acum*-1     ,   
		'devengoacumuladopes' = devengo_monto_peso*-1      ,  
		'Tasavariable'		= venta_valor_tasa + venta_spread   ,       
		'Flujo'				= 'PAG '+ (CASE venta_codigo_tasa WHEN 0 THEN 'F' ELSE 'V' END) ,  
		'hora'				= CONVERT ( CHAR(10), GETDATE (), 108) ,   
 	 	numero_flujo      								,
		'Fechaproceso'		= Substring(@fecha ,7,2) + '/' +Substring(@fecha ,5,2) + '/' +Substring(@fecha ,1,4)    ,   
		'FechaDevengo'		= Substring(@fechaProc ,7,2) + '/' +Substring(@fechaProc ,5,2) + '/' +Substring(@fechaProc ,1,4)   ,  
		tipo_swap						,
		'SumaCapInicial'	= 0    ,  
		'SumaInteresPAG'	= venta_interes*-1,  
		'SumaInteresREC'	= 0,  
		'SumaDiarioPAG'		= (venta_interes/DATEDIFF(dd,Fecha_inicio_flujo, Fecha_vence_flujo))*-1,  
		'SumaDiarioREC'		= 0,  
		'SumaAcumuladoPAG'	= devengo_venta_acum*-1,  
		'SumaAcumuladoREC'	= 0,  
		'SumaAcumuladoPesoPAG' = devengo_monto_peso*-1,  
		'SumaAcumuladoPesoREC' = 0,  
	        'SUMRECDIA'			= CONVERT(FLOAT,0.0),  
		'SUMPAGDIA'			= CONVERT(FLOAT,0.0),  
		'Tipo_Cartera'		= CONVERT(CHAR(20),'') ,  
		'Area_Responsable'	= @Glosa_Area_Resp ,  
		'Cartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Cart_Norm AND TBCODIGO1 = car_Cartera_Normativa )	,
		'SubCartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_SubCart_Norm AND TBCODIGO1 = car_SubCartera_Normativa )		,
		'Libro'			= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Libro AND TBCODIGO1 = car_Libro)		
	INTO #PASO_PAG_LOG  
	FROM 	Cartera ,
		View_cliente  	 		
	WHERE 	Tipo_swap = @operacion 	
		AND (Fecha_inicio_flujo <= @Fecha AND Fecha_vence_flujo >  @Fecha)	
		AND (clrut     = rut_cliente
		AND  clcodigo  = codigo_cliente)
		AND tipo_flujo = 2
		And (cartera_inversion		= @Cartera	OR @Cartera 		= 0)
		AND (car_area_responsable	= @Area_Resp	OR @Area_Resp 		= '')
		AND (car_Cartera_Normativa	= @Cart_Norm	OR @Cart_Norm 		= '')
		AND (car_SubCartera_Normativa	= @SubCart_Norm	OR @SubCart_Norm	= '')
		AND (car_Libro			= @Libro	OR @Libro		= '')
                AND estado <> 'C'

		update #PASO_PAG_LOG SET SUMRECDIA=(select SUMRECDIA=SUM(SumaDiarioREC) from #PASO_REC_LOG)
		update #PASO_REC_LOG SET SUMPAGDIA=(select SUMPAGDIA=SUM(SumaDiarioPAG) from #PASO_PAG_LOG)
		Update #PASO_PAG_LOG Set Tipo_Cartera = @Glosa_Cartera
		UPDATE #PASO_PAG_LOG SET CARTINVERSION = RCNOMBRE FROM BACPARAMSUDA..TIPO_CARTERA WHERE RCRUT = CARTINVERSION AND RCSISTEMA = 'PCS'

		update #PASO_PAG_LOG SET SUMPAGDIA=(select SUMPAGDIA=sum(SumaDiarioPAG) from #PASO_PAG_LOG)
		update #PASO_REC_LOG SET SUMRECDIA=(select SUMRECDIA=sum(SumaDiarioREC) from #PASO_REC_LOG)
		Update #PASO_REC_LOG Set Tipo_Cartera = @Glosa_Cartera
		UPDATE #PASO_REC_LOG SET CARTINVERSION = RCNOMBRE FROM BACPARAMSUDA..TIPO_CARTERA WHERE RCRUT = CARTINVERSION AND RCSISTEMA = 'PCS'

	SELECT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #PASO_REC_LOG	
	UNION
	SELECT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #PASO_PAG_LOG
	ORDER BY numero_operacion,flujo

   RETURN 0

	SET NOCOUNT OFF

END

GO
