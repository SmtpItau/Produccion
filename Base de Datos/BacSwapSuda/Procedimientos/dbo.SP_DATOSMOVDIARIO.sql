USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSMOVDIARIO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATOSMOVDIARIO] ( @Operacion FLOAT (01)   
					,	@BaseParam	CHAR 	(20)	
					,	@Fecha		CHAR	(10)	
					,	@hora		CHAR	(12)	
					,	@tabla		FLOAT	(01)	
					,	@Cartera 	Integer		
					,	@Area_Resp	CHAR(10)	
					,	@Cart_Norm	CHAR(10)	
					,	@SubCart_Norm	CHAR(10)	
					,	@Libro		CHAR(10)	
					,	@Const_Area_Resp	CHAR(10)	= '1553'
					,	@Const_Cart_Norm	CHAR(10)	= '1111'
					,	@Const_SubCart_Norm	CHAR(10)	= '1554'
					,	@Const_Libro		CHAR(10)	= '1552'
					)
AS
BEGIN 

	IF @tabla = 1  
		BEGIN --Tabla Movimiento diario 

   SELECT 
		Numero_Operacion,  
				Codigo_Cliente	, 	
				'Nombrecli'		=  ISNULL((SELECT clnombre FROM  view_cliente WHERE clcodigo = codigo_cliente 
							   AND clrut = rut_cliente ),'**'), 
				Tipo_operacion, 		
		'NombreOp'			= (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END),       
		'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103),   
		'FechaCierre'		= CONVERT(CHAR(10), Fecha_Cierre, 103),   
		'Fechatermino'		= CONVERT(CHAR(10), Fecha_termino, 103),   
		'MonedaOperacion'	= (CASE Tipo_flujo WHEN 1  THEN compra_moneda ELSE venta_moneda END),   
		'NombreMoneda'		= (CASE Tipo_flujo WHEN 1  THEN	ISNULL((SELECT mnglosa FROM view_moneda WHERE  mncodmon = compra_moneda ) , ' ') 
										   ELSE ISNULL((SELECT mnglosa FROM view_moneda WHERE  mncodmon = venta_moneda  ) , ' ') 
							   END), 
		'valormoneda'		= (CASE Tipo_flujo WHEN 1 THEN ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = compra_moneda AND vmfecha = fecha_cierre ) , 0)  
										    ELSE ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = venta_moneda AND vmfecha = fecha_cierre  ) , 0) 
							   END), 
		'MontoOperacion'	= (CASE tipo_flujo WHEN 1 THEN Compra_capital ELSE Venta_capital END) ,  
		'Modalidad'			= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' '),    
		'rutcli'			= rut_cliente ,   
	        'digcli'		= ISNULL((SELECT cldv FROM view_cliente WHERE clcodigo = codigo_cliente
							  AND clrut = rut_cliente	 ),'*'),
		'montouf'		= ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = 998 AND vmfecha = fecha_cierre ),0) ,	
		'montoobs'		= ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = 994 AND vmfecha = fecha_cierre),0), 
		'banco'			= ISNULL((SELECT nombre FROM swapgeneral),' ') , 
		'fechainicioflujo'	= CONVERT(CHAR(10), Fecha_inicio_flujo, 103),
		'fechavenceflujo'	= CONVERT(CHAR(10), Fecha_vence_flujo, 103),
		'dias'			= DATEDIFF(dd,Fecha_inicio_flujo,Fecha_vence_flujo),
		'cartinversion'		= (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'PCS' And rcrut = cartera_inversion),
				compra_base		,
				venta_base		,
				compra_valor_tasa	,
				venta_valor_tasa	,
		'nombretasacompra'	= CASE tipo_flujo WHEN 1 THEN ISNULL((SELECT tbglosa FROM view_tabla_general_detalle WHERE tbcodigo1 = compra_codigo_tasa 
				  	   AND tbcateg = 1042 ), ' ') ELSE '' END ,
		'nombretasaventa'	= CASE tipo_flujo WHEN 2 THEN ISNULL((SELECT tbglosa FROM view_tabla_general_detalle WHERE tbcodigo1 = venta_codigo_tasa 
				  	  AND tbcateg = 1042 ), ' ')  ELSE '' END , 
		'pagamosdoc'		= CASE tipo_flujo WHEN 2 THEN ISNULL((SELECT glosa FROM view_forma_de_pago WHERE codigo = pagamos_documento ), ' ')   ELSE '' END , 
		'recibimosdoc'		= CASE tipo_flujo WHEN 1 THEN ISNULL((SELECT glosa FROM view_forma_de_pago WHERE codigo = recibimos_documento ), ' ') ELSE '' END , 	
		'hora'			= @Hora ,
		'queconsulto'		= CONVERT(CHAR(1),@tabla),  		
				numero_flujo,     	
		'compra_amortiza'	= CASE tipo_flujo WHEN 1 THEN compra_amortiza  ELSE 0 END  ,  
		'compra_saldo'		= CASE tipo_flujo WHEN 1 THEN compra_saldo  ELSE 0 END ,  
		'compra_interes'	= CASE tipo_flujo WHEN 1 THEN compra_interes ELSE 0 END ,  
		'compra_capital'	= CASE tipo_flujo WHEN 1 THEN compra_capital ELSE 0 END ,  
		'compra_valor_tasa' = CASE tipo_flujo WHEN 1 THEN compra_valor_tasa ELSE 0 END ,  
		'venta_capital'		= CASE tipo_flujo WHEN 2 THEN venta_capital ELSE 0 END ,  
		'venta_amortiza'	= CASE tipo_flujo WHEN 2 THEN venta_amortiza ELSE 0 END ,  
		'venta_saldo'		= CASE tipo_flujo WHEN 2 THEN venta_saldo ELSE 0 END ,  
		'venta_interes'		= CASE tipo_flujo WHEN 2 THEN venta_interes ELSE 0 END ,  
		'venta_valor_tasa'  = CASE tipo_flujo WHEN 2 THEN venta_valor_tasa  ELSE 0 END ,  
				tipo_flujo										,
		'TipoSwap'              = convert(integer,@operacion)					,
		'Tipo_Cartera'		= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = '204' AND TBCODIGO1 = cartera_inversion ), --@Glosa_Cartera	,
		'Area_Responsable'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Area_Resp AND TBCODIGO1 = Mov_area_responsable ), --@Glosa_Area_Resp	,
		'Cartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Cart_Norm AND TBCODIGO1 = Mov_Cartera_Normativa ), --@Glosa_Cart_Norm	,
		'SubCartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_SubCart_Norm AND TBCODIGO1 = Mov_SubCartera_Normativa ), --@Glosa_SubCart_Norm	,
		'Libro'			= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Libro AND TBCODIGO1 = Mov_Libro), --@Glosa_Libro		
		'Tipo_Swap'		=  ISNULL(descripcion,''),
                'Operador'              = ISNULL(operador,'')
			FROM 	MovDiario 
			,	VIEW_PRODUCTO
			WHERE   Tipo_swap 	   		= @operacion
			  AND   (cartera_inversion		= @Cartera	OR @Cartera		= 0 )
			  AND	(Mov_area_responsable		= @Area_Resp	OR @Area_Resp 		= '')
			  AND	(Mov_Cartera_Normativa		= @Cart_Norm	OR @Cart_Norm 		= '')
			  AND	(Mov_SubCartera_Normativa	= @SubCart_Norm	OR @SubCart_Norm	= '')
			  AND   (Mov_Libro			= @Libro	OR @Libro		= '')
       --AND    codigo_producto			=* tipo_swap  
			ORDER   BY tipo_flujo, numero_flujo

		END 
	ELSE 
	IF @tabla = 2 
		BEGIN  -- Tabla Movimiento Historico

			SELECT	Numero_Operacion,
				Codigo_Cliente	, 	
				'Nombrecli'		=  ISNULL((SELECT clnombre FROM  view_cliente WHERE clcodigo = codigo_cliente 
							   AND clrut = rut_cliente ),'**'), 
				Tipo_operacion, 		
				'NombreOp'		= (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END),   	 
				'FechaInicio' 		= CONVERT(CHAR(10), Fecha_inicio, 103), 
				'FechaCierre'   	= CONVERT(CHAR(10), Fecha_Cierre, 103), 
				'Fechatermino'   	= CONVERT(CHAR(10), Fecha_termino, 103), 
			        'MonedaOperacion'	= (CASE Tipo_flujo WHEN 1  THEN compra_moneda ELSE venta_moneda END), 
				'NombreMoneda'		= (CASE Tipo_flujo WHEN 1  THEN	ISNULL((SELECT mnglosa FROM view_moneda WHERE  mncodmon = compra_moneda ) , ' ') 
										   ELSE ISNULL((SELECT mnglosa FROM view_moneda WHERE  mncodmon = venta_moneda  ) , ' ') 
							   END), 
				'valormoneda'		= (CASE Tipo_flujo WHEN 1 THEN ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = compra_moneda AND vmfecha = fecha_cierre ) , 0)  
										    ELSE ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = venta_moneda AND vmfecha = fecha_cierre  ) , 0) 
							   END), 
		       		'MontoOperacion' 	= (CASE tipo_flujo WHEN 1 THEN Compra_capital ELSE Venta_capital END) ,
		     		'Modalidad'		= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' '),  
				'rutcli'		= rut_cliente , 
				'digcli'		= ISNULL((SELECT cldv FROM view_cliente WHERE clcodigo = codigo_cliente
							  AND clrut = rut_cliente	 ),'*'),
				'montouf'		= ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = 998 AND vmfecha = fecha_cierre ),0) ,	
				'montoobs'		= ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = 994 AND vmfecha = fecha_cierre),0), 
				'banco'			= ISNULL((SELECT nombre FROM swapgeneral),' ') , 
				'fechainicioflujo'	= CONVERT(CHAR(10), Fecha_inicio_flujo, 103),
				'fechavenceflujo'	= CONVERT(CHAR(10), Fecha_vence_flujo, 103),
				'dias'			= DATEDIFF(dd,Fecha_inicio,Fecha_vence_flujo),
				'cartinversion'		= (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'PCS' And rcrut = cartera_inversion),
				compra_base		,
				venta_base		,
				compra_valor_tasa	,
				venta_valor_tasa	,
				'nombretasacompra'	= CASE tipo_flujo WHEN 1 THEN ISNULL((SELECT tbglosa FROM view_tabla_general_detalle WHERE tbcodigo1 = compra_codigo_tasa 
						  	   AND tbcateg = 1042 ), ' ') ELSE '' END ,
				'nombretasaventa'	= CASE tipo_flujo WHEN 2 THEN ISNULL((SELECT tbglosa FROM view_tabla_general_detalle WHERE tbcodigo1 = venta_codigo_tasa 
						  	  AND tbcateg = 1042 ), ' ')  ELSE '' END , 
				'pagamosdoc'		= CASE tipo_flujo WHEN 2 THEN ISNULL((SELECT glosa FROM view_forma_de_pago WHERE codigo = pagamos_documento ), ' ')   ELSE '' END , 
				'recibimosdoc'		= CASE tipo_flujo WHEN 1 THEN ISNULL((SELECT glosa FROM view_forma_de_pago WHERE codigo = recibimos_documento ), ' ') ELSE '' END , 	
				'hora'			= @Hora ,
				'queconsulto'		= CONVERT(CHAR(1),@tabla),  		
				numero_flujo,     	
				'compra_amortiza'	= CASE tipo_flujo WHEN 1 THEN compra_amortiza 	ELSE 0 END 	,
				'compra_saldo'		= CASE tipo_flujo WHEN 1 THEN compra_saldo 	ELSE 0 END	,
				'compra_interes'	= CASE tipo_flujo WHEN 1 THEN compra_interes	ELSE 0 END	,
				'compra_capital'	= CASE tipo_flujo WHEN 1 THEN compra_capital	ELSE 0 END	,
				'compra_valor_tasa'	= CASE tipo_flujo WHEN 1 THEN compra_valor_tasa ELSE 0 END	,
				'venta_capital'		= CASE tipo_flujo WHEN 2 THEN venta_capital	ELSE 0 END	,
				'venta_amortiza'	= CASE tipo_flujo WHEN 2 THEN venta_amortiza	ELSE 0 END	,
				'venta_saldo'		= CASE tipo_flujo WHEN 2 THEN venta_saldo	ELSE 0 END	,
				'venta_interes'		= CASE tipo_flujo WHEN 2 THEN venta_interes	ELSE 0 END	,
				'venta_valor_tasa' 	= CASE tipo_flujo WHEN 2 THEN venta_valor_tasa  ELSE 0 END	,
				tipo_flujo										,
				'TipoSwap'              = convert(integer,@operacion)					,
				'Tipo_Cartera'		= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = '204' AND TBCODIGO1 = cartera_inversion ), --@Glosa_Cartera	,
				'Area_Responsable'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Area_Resp AND TBCODIGO1 = Mhi_area_responsable ), --@Glosa_Area_Resp	,
				'Cartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Cart_Norm AND TBCODIGO1 = Mhi_Cartera_Normativa ), --@Glosa_Cart_Norm	,
				'SubCartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_SubCart_Norm AND TBCODIGO1 = Mhi_SubCartera_Normativa ), --@Glosa_SubCart_Norm	,
				'Libro'			= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Libro AND TBCODIGO1 = Mhi_Libro), --@Glosa_Libro		
				'Tipo_Swap'		=  ISNULL(descripcion,''),
                                'Operador'              = ISNULL(operador,'')
 			FROM 	Movhistorico 
			LEFT JOIN VIEW_PRODUCTO ON tipo_swap = codigo_producto			
			WHERE 	Fecha_Cierre = @Fecha 
			  AND 	Tipo_swap =  @operacion 	
			  AND   (cartera_inversion		= @Cartera	OR @Cartera		= 0 )
			  AND	(Mhi_area_responsable		= @Area_Resp	OR @Area_Resp 		= '')
			  AND	(Mhi_Cartera_Normativa		= @Cart_Norm	OR @Cart_Norm 		= '')
			  AND	(Mhi_SubCartera_Normativa	= @SubCart_Norm	OR @SubCart_Norm	= '')
			  AND   (Mhi_Libro			= @Libro	OR @Libro		= '')
		
			ORDER   BY tipo_flujo, numero_flujo	

		END 
END 
GO
