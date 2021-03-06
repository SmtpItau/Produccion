USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSMOVIMDIARIOMONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATOSMOVIMDIARIOMONEDA] (  @Operacion FLOAT  ,  
						 	@Fecha		CHAR (08)	,
						 	@Tabla 		FLOAT		,
						 	@Cartera	Integer		,
							@Area_Resp		CHAR(10)= '',
							@Cart_Norm		CHAR(10)= '',
							@SubCart_Norm		CHAR(10)= '',
							@Libro			CHAR(10)= '',
							@Const_Area_Resp	CHAR(10)= '',
							@Const_Cart_Norm	CHAR(10)= '',
							@Const_SubCart_Norm	CHAR(10)= '',
							@Const_Libro		CHAR(10)= ''
	                         		 )
AS
BEGIN

   /*=======================================================================*/
   /*=======================================================================*/
	DECLARE @UF		FLOAT		,
		@OBS		FLOAT		,
		@BANCO		CHAR (45)	,
	     	@FechaProc 	CHAR (10)	,
		@Glosa_Cartera 	Char (20)	,
		@Glosa_Area_Resp	CHAR(50)	,
		@Glosa_Cart_Norm	CHAR(50)	,
		@Glosa_SubCart_Norm	CHAR(50)	,
		@Glosa_Libro		CHAR(50)
SET NOCOUNT ON

Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'PCS'
     And  rcrut     = @Cartera
  -- ORDER BY rcrut  

  if @Glosa_Cartera = '' 
 Select @Glosa_Cartera = '< TODAS >'  


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


   /*=======================================================================*/
   /* Encabezado de la Consulta						    */	
   /*=======================================================================*/    
	SELECT @UF = ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE 
		     vmcodigo = 998 AND vmfecha = @fecha ),0) 	

	SELECT @OBS = ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE
		     vmcodigo = 994 AND vmfecha = @fecha ),0) 


        SELECT @BANCO = ISNULL( nombre ,' ') ,
		@FechaProc = CONVERT(CHAR(10), fechaproc , 103)
	FROM swapgeneral
	

	IF @tabla = 1  
		BEGIN --Tabla Movimiento diario 

			SELECT	Numero_Operacion	, 
				Codigo_Cliente		, 
		  'Nombrecli'		= ISNULL((SELECT clnombre FROM view_cliente WHERE clcodigo = codigo_cliente AND clrut = rut_cliente ),'*'), 
				Tipo_operacion 		, 
				Tipo_swap	 	, 
		  'NombreOp'		= (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END),   	 
		  'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103), 
		  'FechaCierre'   	= CONVERT(CHAR(10), Fecha_Cierre, 103), 
		  'Fechatermino'   	= CONVERT(CHAR(10), Fecha_termino, 103), 
		  'CodMonedaOperacion'	= (CASE Tipo_flujo WHEN 1 THEN compra_moneda ELSE venta_moneda END), 
                  'NombreMonedadolar'	= ISNULL( (SELECT mnnemo FROM view_moneda WHERE mncodmon = compra_moneda AND tipo_flujo = 1 ) , '*'),
		  'MontoEnDolares' 	= (CASE tipo_flujo WHEN 1 THEN Compra_Amortiza 
										  ELSE 0
							  END) ,
		  'TCRef' 		= ISNULL((SELECT mnnemo FROM view_moneda WHERE mncodmon = (CASE tipo_flujo WHEN 2 THEN pagamos_moneda ELSE recibimos_moneda END ) ) , ' '),
		  'valorTCRef'		= ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = (CASE tipo_flujo WHEN 2 THEN pagamos_moneda ELSE recibimos_moneda END ) AND vmfecha = Fecha_Cierre) , 0),
		  'EquivalenteUSD' 	= (CASE tipo_flujo WHEN 2 THEN pagamos_monto_clp ELSE recibimos_monto_clp END) ,
		  'TasaEnDolares' 	= (CASE tipo_flujo WHEN 1 THEN Compra_Valor_Tasa ELSE 0	END) ,		
                  'NombreMoneda'	  	= ISNULL((SELECT mnnemo FROM view_moneda WHERE  mncodmon = venta_moneda and tipo_flujo = 2) , '*')  ,
		  'MontoEnMoneda' 	= (CASE tipo_flujo WHEN 2 THEN venta_Amortiza ELSE 0 END) ,		
	          'valorRefMoneda'	= (CASE tipo_flujo WHEN 2 THEN ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = pagamos_moneda AND vmfecha = Fecha_Cierre) , 0)  
   										  ELSE ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = recibimos_moneda AND vmfecha = Fecha_Cierre) , 0) 
							   END), 
		  'EquivalenteMon' 	= (CASE tipo_flujo WHEN 1 THEN  recibimos_monto_clp ELSE pagamos_monto_clp END) ,		
		  'TasaEnMoneda'	 	= (CASE tipo_flujo WHEN 2 THEN Venta_Valor_Tasa ELSE 0	END) ,		
		  'Modalidad'		= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' '),  
                  'cartinversion'		= (SELECT distinct IsNull(rcnombre,'') FROM BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'PCS' And  rcrut=  cartera_inversion)	,
		  'fechainicioflujo'	= CONVERT(CHAR(10), Fecha_inicio_flujo, 103),
		  'fechavenceflujo'	= CONVERT(CHAR(10), Fecha_vence_flujo, 103) ,
		  'rutcli'		= rut_cliente , 
	          'digcli'		= '-' + ISNULL((SELECT cldv FROM view_cliente WHERE clcodigo = codigo_cliente AND clrut = rut_cliente),'*'), 
		  'montouf'		= @UF 	,
		  'montoobs'		= @OBS 	,
		  'banco' 		= @BANCO,
		  'dias'			= DATEDIFF(dd,Fecha_inicio, Fecha_vence_flujo),
		  'hora'  		= CONVERT(CHAR(08), getdate() , 114), 
				numero_flujo      	,
		  'entregar'	   	= ISNULL((SELECT glosa FROM view_forma_de_pago WHERE codigo =(CASE tipo_flujo WHEN 2 THEN pagamos_documento  ELSE 0 END)),'*'), 
		  'recibir'	   	   = ISNULL((SELECT glosa FROM view_forma_de_pago WHERE codigo =(CASE tipo_flujo WHEN 2 THEN pagamos_documento  ELSE recibimos_documento END) ),'*'), 
		  'Fechaproceso'  	    = @FechaProc		,
				tipo_flujo					,
		  'InteresesCompa'	    = (CASE tipo_flujo WHEN 1 THEN compra_interes ELSE 0 END),
		  'InteresVenta'		= (CASE tipo_flujo WHEN 2 THEN venta_interes ELSE 0 END),
		  'Tipo_Cartera' 		= @Glosa_Cartera	,
		  'Area_Responsable'	= @Glosa_Area_Resp	,
		  'Cartera_Normativa'	= @Glosa_Cart_Norm	,
		  'SubCartera_Normativa'= @Glosa_SubCart_Norm	,
		  'Libro'			    = @Glosa_Libro		,
                  'Operador'            = Operador
			INTO	#tmp_1
			FROM 	MovDiario 
			WHERE 	Tipo_swap = @operacion  				
	   		  And   (cartera_inversion = @Cartera Or @Cartera = 0)
			  AND	(Mov_area_responsable		= @Area_Resp	OR @Area_Resp 		= '')
			  AND	(Mov_Cartera_Normativa		= @Cart_Norm	OR @Cart_Norm 		= '')
			  AND	(Mov_SubCartera_Normativa	= @SubCart_Norm	OR @SubCart_Norm	= '')
			  AND   (Mov_Libro			= @Libro	OR @Libro		= '')
			ORDER BY tipo_flujo,numero_flujo

			UPDATE 	#tmp_1
			SET	NombreMoneda = mnnemo 
			FROM 	view_moneda ,
				movdiario
			WHERE  	movdiario.tipo_flujo = 2						AND 
				#tmp_1.Numero_Operacion = movdiario.Numero_Operacion	AND
				movdiario.venta_moneda = mncodmon


			UPDATE 	#tmp_1
			SET	NombreMonedadolar = mnnemo 
			FROM 	view_moneda ,
				movdiario
			WHERE  	movdiario.tipo_flujo = 1						AND 
				#tmp_1.Numero_Operacion = movdiario.Numero_Operacion	AND
				movdiario.compra_moneda = mncodmon

			SELECT * FROM #tmp_1

		END 

	ELSE 
	IF @tabla = 2 

		BEGIN  -- Tabla Movimiento Historico


			SELECT	Numero_Operacion	, 
				Codigo_Cliente		, 
				'Nombrecli'		= ISNULL((SELECT clnombre FROM view_cliente WHERE clcodigo = codigo_cliente AND clrut = rut_cliente ),'*'), 
				Tipo_operacion 		, 
				Tipo_swap	 	, 
				'NombreOp'		= (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END),   	 
				'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103), 
				'FechaCierre'   	= CONVERT(CHAR(10), Fecha_Cierre, 103), 
				'Fechatermino'   	= CONVERT(CHAR(10), Fecha_termino, 103), 
				'CodMonedaOperacion'	= (CASE Tipo_flujo WHEN 1 THEN compra_moneda ELSE venta_moneda END), 
				'NombreMonedadolar'	= ISNULL( (SELECT mnnemo FROM view_moneda WHERE mncodmon = compra_moneda AND tipo_flujo = 1 ) , '*'),
				'MontoEnDolares' 	= (CASE tipo_flujo WHEN 1 THEN Compra_Amortiza 
										  ELSE 0
							  END) ,
				'TCRef' 		= ISNULL((SELECT mnnemo FROM view_moneda WHERE mncodmon = (CASE tipo_flujo WHEN 2 THEN pagamos_moneda ELSE recibimos_moneda END ) ) , ' '),
				'valorTCRef'		= ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = (CASE tipo_flujo WHEN 2 THEN pagamos_moneda ELSE recibimos_moneda END ) AND vmfecha = Fecha_Cierre) , 0),
				'EquivalenteUSD' 	= (CASE tipo_flujo WHEN 2 THEN pagamos_monto_clp ELSE recibimos_monto_clp END) ,
				'TasaEnDolares' 	= (CASE tipo_flujo WHEN 1 THEN Compra_Valor_Tasa ELSE 0	END) ,		
				'NombreMoneda'	  	= ISNULL((SELECT mnnemo FROM view_moneda WHERE  mncodmon = venta_moneda and tipo_flujo = 2) , '*')  ,
				'MontoEnMoneda' 	= (CASE tipo_flujo WHEN 2 THEN venta_Amortiza ELSE 0 END) ,		
				'valorRefMoneda'	= (CASE tipo_flujo WHEN 2 THEN ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = pagamos_moneda AND vmfecha = Fecha_Cierre) , 0)  
   										  ELSE ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE  vmcodigo = recibimos_moneda AND vmfecha = Fecha_Cierre) , 0) 
							   END), 
				'EquivalenteMon' 	= (CASE tipo_flujo WHEN 1 THEN  recibimos_monto_clp ELSE pagamos_monto_clp END) ,		
				'TasaEnMoneda'	 	= (CASE tipo_flujo WHEN 2 THEN Venta_Valor_Tasa ELSE 0	END) ,		
				'Modalidad'		= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' '),  
				'cartinversion'		= (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'PCS' And  rcrut     = cartera_inversion), 				
				'fechainicioflujo'	= CONVERT(CHAR(10), Fecha_inicio_flujo, 103),
				'fechavenceflujo'	= CONVERT(CHAR(10), Fecha_vence_flujo, 103) ,
				'rutcli'		= rut_cliente , 
				'digcli'		= '-' + ISNULL((SELECT cldv FROM view_cliente WHERE clcodigo = codigo_cliente AND clrut = rut_cliente),'*'), 
				'montouf'		= @UF 	,
				'montoobs'		= @OBS 	,
				'banco' 		= @BANCO,
				'dias'			= DATEDIFF(dd,Fecha_inicio, Fecha_vence_flujo),
				'hora'  		= CONVERT(CHAR(08), getdate() , 114), 
				numero_flujo      	,
				'entregar'	   	= ISNULL((SELECT glosa FROM view_forma_de_pago WHERE codigo =(CASE tipo_flujo WHEN 2 THEN pagamos_documento  ELSE 0 END)),'*'), 
				'recibir'	   	= ISNULL((SELECT glosa FROM view_forma_de_pago WHERE codigo =(CASE tipo_flujo WHEN 2 THEN pagamos_documento  ELSE recibimos_documento END) ),'*'), 
				'Fechaproceso'  	= @FechaProc	,
				tipo_flujo				,
				'InteresesCompa'	= (CASE tipo_flujo WHEN 1 THEN compra_interes ELSE 0 END),
				'InteresVenta'		= (CASE tipo_flujo WHEN 2 THEN venta_interes ELSE 0 END),
				'Tipo_Cartera' 		= @Glosa_Cartera	,
				'Area_Responsable'	= @Glosa_Area_Resp	,
				'Cartera_Normativa'	= @Glosa_Cart_Norm	,
				'SubCartera_Normativa'	= @Glosa_SubCart_Norm	,
				'Libro'			= @Glosa_Libro		,
                                'Operador'              = Operador
			INTO	#tmp_2
			FROM 	MovHistorico
			WHERE 	Tipo_swap = @operacion  AND
				Fecha_Cierre = @Fecha 
  	  		  And   (cartera_inversion = @Cartera Or @Cartera = 0)
			  AND	(Mhi_area_responsable		= @Area_Resp	OR @Area_Resp 		= '')
			  AND	(Mhi_Cartera_Normativa		= @Cart_Norm	OR @Cart_Norm 		= '')
			  AND	(Mhi_SubCartera_Normativa	= @SubCart_Norm	OR @SubCart_Norm	= '')
			  AND   (Mhi_Libro			= @Libro	OR @Libro		= '')

			ORDER BY tipo_flujo, numero_flujo

			UPDATE 	#tmp_2
			SET	NombreMoneda = mnnemo 
			FROM 	view_moneda ,
				movdiario
			WHERE  	movdiario.tipo_flujo = 2						AND 
				#tmp_2.Numero_Operacion = movdiario.Numero_Operacion	AND
				movdiario.venta_moneda = mncodmon


			UPDATE 	#tmp_2
			SET	NombreMonedadolar = mnnemo 
			FROM 	view_moneda ,
				movdiario
			WHERE  	movdiario.tipo_flujo = 1						AND 
				#tmp_2.Numero_Operacion = movdiario.Numero_Operacion	AND
				movdiario.compra_moneda = mncodmon

			SELECT * FROM #tmp_2

		END
	SET NOCOUNT OFF
   RETURN 0

END
GO
