USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACIONES_MODIFICADAS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACIONES_MODIFICADAS_SWAP]    
     (   @PRODUCTO                      Numeric(5,1)            -- PRODUCTO
       , @RUT_CLIENTE                   Numeric(9,0)  = 0       -- RUT
	   , @OPERADOR                      CHAR(15)      = 'T'     -- USUARIO
	   , @FEC_INI                       DATETIME                -- FECHA INICIO
	   , @FEC_FIN                       DATETIME                -- FECHA FIN
       , @operacion                     INT           = 0
	  )
AS    
BEGIN    
	SET NOCOUNT ON    
/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES DE ENTRADAS                                        */
/*-----------------------------------------------------------------------------*/
--exec SP_CONSULTA_OPERACIONES_MODIFICADAS_SWAP 0 ,0,'T','20141016','20141016',3
/*-----------------------------------------------------------------------------*/

/* OBJETIVO : CONSULTA OPERACIONES MODIFICADAS SWAP                            */
/* AUTOR    : PATRICIO ALBERTO FERNANDEZ IBACETA                               */
/* FECHA    : 09/07/2015                                                       */
/*          : ORDEN DE PROCEDIMIENTO  PARA SWAP              */
/*-----------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES POR DEFECTO                                        */
/*-----------------------------------------------------------------------------*/

  DECLARE @Const_Area_Responsable        NUMERIC(09)   = 0
	    , @Const_Cartera_Normativa       NUMERIC(09)   = 1111
	    , @Const_SubCartera_Normativa    NUMERIC(09)   = 1554
        , @Const_Libro                   NUMERIC(09)   = 1552
		, @SistemaSwap					 CHAR(03)	   = 'PCS'

/*-----------------------------------------------------------------------------*/
/* TABLA DE GRUPOS                                                             */
/*-----------------------------------------------------------------------------*/

  CREATE TABLE #GRUPOS 
               (Numero_Operacion	 NUMERIC(10)  ,
			    NUMERO_FLUJO         INT          )
/*-----------------------------------------------------------------------------*/
/* TABLA TEMPORAL DE COMPRAS                                                   */
/*-----------------------------------------------------------------------------*/

  CREATE TABLE #paso_compras(
	            	Swap 					CHAR(20)	    ,
					Tipo_Modificacion		CHAR(15)		,
					Numero_Operacion		NUMERIC(10)		,
					Codigo_Cliente			NUMERIC(10)		, 
					Nombrecli				CHAR(70)	    ,
					Tipo_operacion			CHAR(01)		, 
					Tipo_Flujo   			DECIMAL         , 
					NombreOp				CHAR(7)			,
					FechaInicio  			CHAR(10)   		,
					Fechatermino 			CHAR(10)	    ,
					MonedaOperacion			NUMERIC(3)	    ,
					NombreMoneda			CHAR(40)	    ,
					MontoOperacion 			NUMERIC(21,04)	,
					TasaBase				NUMERIC(15,04)	,
					MontoConversion			NUMERIC(21,04)	,
					TasaConversion			NUMERIC(15,04)	,
					Modalidad				CHAR(15)	    ,
					rutcli					CHAR(12)   		,
					Area_Responsable		CHAR(50)	    ,
					Cartera_Normativa		CHAR(50)	    ,
					SubCartera_Normativa	CHAR(50)	    ,
					Libro					CHAR(50)	    ,
					PLAZO					INT             ,
					OPERADOR				CHAR(50)	    ,
					NUMERO_FLUJO			INT				,
				  )	
/*-----------------------------------------------------------------------------*/
/* TABLA TEMPORAL DE COMPRAS                                                   */
/*-----------------------------------------------------------------------------*/
  CREATE TABLE #paso_ventas(
	            	Swap 					CHAR(20)	    ,
					Tipo_Modificacion		CHAR(15)		,
					Numero_Operacion		NUMERIC(10)		,
					Codigo_Cliente			NUMERIC(10)		, 
					Nombrecli				CHAR(70)	    ,
					Tipo_operacion			CHAR(01)		, 
					Tipo_Flujo   			DECIMAL         , 
					NombreOp				CHAR(7)			,
					FechaInicio  			CHAR(10)   		,
					Fechatermino 			CHAR(10)	    ,
					MonedaOperacion			NUMERIC(3)	    ,
					NombreMoneda			CHAR(40)	    ,
					MontoOperacion 			NUMERIC(21,04)	,
					TasaBase				NUMERIC(15,04)	,
					MontoConversion			NUMERIC(21,04)	,
					TasaConversion			NUMERIC(15,04)	,
					Modalidad				CHAR(15)	    ,
					rutcli					CHAR(12)   		,
					Area_Responsable		CHAR(50)	    ,
					Cartera_Normativa		CHAR(50)	    ,
					SubCartera_Normativa	CHAR(50)	    ,
					Libro					CHAR(50)	    ,
					PLAZO					INT             ,
					OPERADOR				CHAR(50)	    ,
					NUMERO_FLUJO			INT             , 
				  )	


/*-----------------------------------------------------------------------------*/
/* TABLA DE MOVIMIENTOS DIARIOS                                                */
/*-----------------------------------------------------------------------------*/

  IF @operacion = 1 BEGIN
     INSERT INTO #paso_compras
     SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)

           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                                 FROM View_Moneda 
                                                             WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = (CASE tipo_flujo 
		                             WHEN 1 THEN Compra_capital 
			                         ELSE Venta_capital 
								     END)
           ,'TASABASE'            = (CASE tipo_flujo 
		                             WHEN 1 THEN  Compra_valor_tasa 
			                         ELSE Venta_valor_tasa 
								     END)
           ,'MONTOCONVERSION'     = (CASE tipo_flujo 
		                             WHEN 2 THEN Venta_capital 
			                         ELSE Compra_capital 
								     END)
           ,'TASACONVERSION'      = (CASE tipo_flujo 
		                             WHEN 2 THEN  Venta_valor_tasa 
			                         ELSE Compra_valor_tasa 
								     END) 
           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                                    WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
           ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
		                                                                               FROM View_Cliente 
			                                                                   WHERE clcodigo = codigo_cliente 
																					       AND clrut    = rut_cliente ),'*')
           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = mov_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = mov_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = mov_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
										     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = mov_libro),'No Especificado')
           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)	
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo
	  FROM MOVDIARIO WITH(NOLOCK)
     WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0)
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
	   AND  tipo_flujo     = 1                  
	   AND  estado_flujo   = 1
     ORDER BY Numero_Operacion


	INSERT INTO #paso_ventas
     SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)
           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)



           ,'MONEDAOPERACION'     = (CASE tipo_flujo 



		                             WHEN 1 THEN compra_moneda 



     		                         ELSE venta_moneda END)



		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 



		                             WHEN 1 THEN ISNULL((SELECT mnglosa 



			                                                 FROM View_Moneda 



                                                            WHERE mncodmon = compra_moneda) , ' ')



								     ELSE ISNULL((SELECT mnglosa 



								                    FROM View_Moneda 



										           WHERE mncodmon = venta_moneda), ' ') 



								     END)



           ,'MONTOOPERACION'      = (CASE tipo_flujo 



		                             WHEN 1 THEN Compra_capital 



			                         ELSE Venta_capital 



								     END)



           ,'TASABASE'            = (CASE tipo_flujo 



		                             WHEN 1 THEN  Compra_valor_tasa 



			                         ELSE Venta_valor_tasa 



								   END)



           ,'MONTOCONVERSION'     = (CASE tipo_flujo 



		                             WHEN 2 THEN Venta_capital 



			                         ELSE Compra_capital 



								     END)



           ,'TASACONVERSION'      = (CASE tipo_flujo 



		                             WHEN 2 THEN  Venta_valor_tasa 



			                         ELSE Compra_valor_tasa 



								     END) 



           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 



		                                    WHEN 'C' THEN  'COMPENSACION' 



			                                ELSE 'ENTREGA' 



										    END),' ')



           ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 



		                                                                                  FROM View_Cliente 



			                                                                             WHERE clcodigo = codigo_cliente 



																					       AND clrut    = rut_cliente ),'*')



           ,'Area'                = ISNULL((SELECT TBGLOSA 



		                                      FROM VIEW_TABLA_GENERAL_DETALLE



			                                 WHERE TBCATEG    = @Const_Area_Responsable           



											   AND TBCODIGO1  = mov_area_responsable),'No Especificado') 



	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 



		                                      FROM VIEW_TABLA_GENERAL_DETALLE 



			                                 WHERE TBCATEG    = @Const_Cartera_Normativa



										       AND TBCODIGO1  = mov_cartera_normativa),'No Especificado') 



           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 



		                                      FROM VIEW_TABLA_GENERAL_DETALLE 



			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa



										       AND TBCODIGO1  = mov_subcartera_normativa),'No Especificado') 



           ,'Libro'               = ISNULL((SELECT TBGLOSA 



		                                      FROM VIEW_TABLA_GENERAL_DETALLE 



										     WHERE TBCATEG    = @Const_Libro 



										       AND TBCODIGO1  = mov_libro),'No Especificado')



           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)	



		   ,'OPERADOR'            = operador



		   ,'NUMERO_FLUJO'        = numero_flujo



	  FROM MOVDIARIO WITH(NOLOCK)



     WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)



	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0)



	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')



	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN



	   AND  tipo_flujo     = 2                 



	   AND  estado_flujo   = 1



     ORDER BY Numero_Operacion



  END



/*-----------------------------------------------------------------------------*/
/* CONSULTA UNION ENTRE CARTERA MODIFICADA Y CARTERA LOG                        */
/*-----------------------------------------------------------------------------*/
  IF @operacion = 2 BEGIN

	/* INGRESO REGISTROS DE CARTERA MODIFICADA */
     INSERT INTO #paso_compras
     SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)
		   ,'TIPO_MODIFICACION'   = ISNULL((SELECT  COD_OPERACION
		                                      FROM [BacParamSuda].[dbo].[TBL_PREPARA_OPERACIONES]
			                                 WHERE NRO_OPERACION = Numero_Operacion 
										       And ID_SISTEMA = @SistemaSwap),'M')	
           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		  ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                                 FROM View_Moneda 
                                    WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = (CASE Tipo_operacion 
		                             WHEN 'C' THEN Compra_capital 
			                         ELSE Venta_capital 
								     END)
           ,'TASABASE'            = (CASE Tipo_operacion 
		                             WHEN 'C' THEN  Compra_valor_tasa 
			                         ELSE Venta_valor_tasa 
								     END)
           ,'MONTOCONVERSION'     = (CASE Tipo_operacion 
		                             WHEN 'C' THEN Venta_capital 
			                         ELSE Compra_capital 
								     END)
           ,'TASACONVERSION'      = (CASE Tipo_operacion 
		                             WHEN 'C' THEN  Venta_valor_tasa 
			                         ELSE Compra_valor_tasa 
								     END) 
           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                                    WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
           ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
		                                                                                  FROM View_Cliente 
			                                                                             WHERE clcodigo = codigo_cliente 
																					       AND clrut    = rut_cliente ),'*')
           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = car_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = car_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = car_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
										     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = car_libro),'No Especificado')
           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo

	  FROM CarteraModificada WITH(NOLOCK)
     WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0 )
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
	   AND  tipo_flujo     = 1                  
	   AND  estado_flujo   = 1
	 ORDER BY Numero_Operacion
	 


     INSERT INTO #paso_ventas
     SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)
		   ,'TIPO_MODIFICACION'   = ISNULL((SELECT  COD_OPERACION
		                                      FROM [BacParamSuda].[dbo].[TBL_PREPARA_OPERACIONES]
			                                 WHERE NRO_OPERACION = Numero_Operacion 
										       And ID_SISTEMA = @SistemaSwap),'M')	

           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                                 FROM View_Moneda 
                                                            WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = (CASE Tipo_operacion 
		                             WHEN 'C' THEN Compra_capital 
			                         ELSE Venta_capital 
								     END)
           ,'TASABASE'            = (CASE Tipo_operacion 
		                             WHEN 'C' THEN  Compra_valor_tasa 
			                         ELSE Venta_valor_tasa 
								     END)
           ,'MONTOCONVERSION'     = (CASE Tipo_operacion 
		                             WHEN 'C' THEN Venta_capital 
			                         ELSE Compra_capital 
								     END)
           ,'TASACONVERSION'      = (CASE Tipo_operacion 
		                             WHEN 'C' THEN  Venta_valor_tasa 
			                         ELSE Compra_valor_tasa 
								     END) 
           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                                    WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
           ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
		                                                                                  FROM View_Cliente 
			                                                                             WHERE clcodigo = codigo_cliente 
																					       AND clrut    = rut_cliente ),'*')
           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = car_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = car_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = car_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
										     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = car_libro),'No Especificado')
           ,'PLAZO'   = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo
	  FROM CarteraModificada WITH(NOLOCK)
     WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0 )
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
	   AND  tipo_flujo     = 2                  
	   AND  estado_flujo   = 1
	 ORDER BY Numero_Operacion




	 /* INGRESO REGISTROS DE CARTERALOG */
	 INSERT INTO #paso_compras
       SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)
		   ,'TIPO_MODIFICACION'   = ISNULL((SELECT  COD_OPERACION
		                                      FROM [BacParamSuda].[dbo].[TBL_PREPARA_OPERACIONES]
			                                 WHERE NRO_OPERACION = Numero_Operacion 
										       And ID_SISTEMA = @SistemaSwap),'M')		

           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                                 FROM View_Moneda 
                                                            WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = Compra_capital 
           ,'TASABASE'            =  
		                              Compra_valor_tasa 
           ,'MONTOCONVERSION'     =  
 			                          Compra_capital 
           ,'TASACONVERSION'      = 
			                          Compra_valor_tasa 

           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                               WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
	        ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
			                                                                                FROM View_Cliente 
				                                                                             WHERE clcodigo = codigo_cliente 
																						       AND clrut    = rut_cliente ),'*')

           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = log_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = log_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = log_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
											     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = log_libro),'No Especificado')
           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)	
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo

	  FROM CARTERALOG WITH(NOLOCK)
       WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0 )
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
   	   AND  tipo_flujo     = 1 
	   AND estado = 'A'
   	 ORDER BY Numero_Operacion
	 
	 
	 
	  INSERT INTO #paso_ventas
       SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)

           ,'TIPO_MODIFICACION'   = ISNULL((SELECT  COD_OPERACION
		                                      FROM [BacParamSuda].[dbo].[TBL_PREPARA_OPERACIONES]
			                                 WHERE NRO_OPERACION = Numero_Operacion 
										       And ID_SISTEMA = @SistemaSwap),'M')		

           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                           FROM View_Moneda 
                                                            WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = 
			                          Venta_capital 
           ,'TASABASE'            =  
			                          Venta_valor_tasa 
           ,'MONTOCONVERSION'     =  Venta_capital 

           ,'TASACONVERSION'      = 
		                              Venta_valor_tasa 
           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                                    WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
           ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
		                                                                                  FROM View_Cliente 
			                                                                             WHERE clcodigo = codigo_cliente 
																					       AND clrut    = rut_cliente ),'*')
           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = log_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = log_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = log_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
										     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = log_libro),'No Especificado')

           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)	
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo

	  FROM CARTERALOG WITH(NOLOCK)
      WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0 )
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
   	   AND  tipo_flujo     = 2  
	   AND estado = 'A'
	 ORDER BY Numero_Operacion



  END


/*-----------------------------------------------------------------------------*/
/* TABLA DE MOVIMIENTOS CARTERA                                                */
/*-----------------------------------------------------------------------------*/
  IF @operacion = 3 BEGIN
     INSERT INTO #paso_compras

     SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)
		   ,'TIPO_MODIFICACION'   = ISNULL((SELECT  COD_OPERACION
		                                      FROM [BacParamSuda].[dbo].[TBL_PREPARA_OPERACIONES]
			                                 WHERE NRO_OPERACION = Numero_Operacion 
										       And ID_SISTEMA = @SistemaSwap),'M')		
           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)

		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                                 FROM View_Moneda 
                                                            WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = 
		                             Compra_capital 
           ,'TASABASE'            = 
		                              Compra_valor_tasa 
           ,'MONTOCONVERSION'     = 
			                         Compra_capital 
           ,'TASACONVERSION'      = 
			                          Compra_valor_tasa 
           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                                    WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
           ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
		                                                                                  FROM View_Cliente 
			                                                                             WHERE clcodigo = codigo_cliente 
																					       AND clrut    = rut_cliente ),'*')
           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = car_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = car_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                               WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = car_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
										     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = car_libro),'No Especificado')
           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)	
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo
	  FROM CarteraModificada WITH(NOLOCK)
     WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0 )
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
   	   AND  tipo_flujo     = 1                  
	 ORDER BY Numero_Operacion


     INSERT INTO #paso_ventas
     SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)
           ,'TIPO_MODIFICACION'   = ISNULL((SELECT  COD_OPERACION
		                            FROM [BacParamSuda].[dbo].[TBL_PREPARA_OPERACIONES]
			                        WHERE NRO_OPERACION = Numero_Operacion 
			    				    And ID_SISTEMA = @SistemaSwap),'M')		

           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                                 FROM View_Moneda 
                                                            WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = Venta_capital
           ,'TASABASE'            = Venta_valor_tasa 
           ,'MONTOCONVERSION'     = 
		                            Venta_capital 
           ,'TASACONVERSION'      = 
		                            Venta_valor_tasa 
           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                                    WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
           ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
		                                                                                  FROM View_Cliente 
			                                                                             WHERE clcodigo = codigo_cliente 
																					       AND clrut    = rut_cliente ),'*')
           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = car_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = car_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = car_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
										     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = car_libro),'No Especificado')
           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)	
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo
	  FROM CarteraModificada WITH(NOLOCK)
     WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0 )
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
   	   AND  tipo_flujo     = 2                  
	 ORDER BY Numero_Operacion
  END


/*-----------------------------------------------------------------------------*/
/* TABLA DE MOVIMIENTOS CARTERA LOG			                                   */
/*-----------------------------------------------------------------------------*/
  IF @operacion = 4 BEGIN
       INSERT INTO #paso_compras
       SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)
		   ,'TIPO_MODIFICACION'   = ISNULL((SELECT  COD_OPERACION
		                                      FROM [BacParamSuda].[dbo].[TBL_PREPARA_OPERACIONES]
			                                 WHERE NRO_OPERACION = Numero_Operacion 
										       And ID_SISTEMA = @SistemaSwap),'M')		

           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                                 FROM View_Moneda 
                                                            WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = Compra_capital 
           ,'TASABASE'            =  
		                              Compra_valor_tasa 
           ,'MONTOCONVERSION'     =  
 			                          Compra_capital 
           ,'TASACONVERSION'      = 
			                          Compra_valor_tasa 

           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                               WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
	        ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
			                                                                                FROM View_Cliente 
				                                                                             WHERE clcodigo = codigo_cliente 
																						       AND clrut    = rut_cliente ),'*')

           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = log_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = log_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = log_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
											     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = log_libro),'No Especificado')
           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)	
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo

	  FROM CARTERALOG WITH(NOLOCK)
       WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0 )
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
   	   AND  tipo_flujo     = 1 
	   AND estado = 'A'
   	 ORDER BY Numero_Operacion


       INSERT INTO #paso_ventas
       SELECT DISTINCT
           'SWAP'                 = (CASE Tipo_Swap 
	                                 WHEN 1 THEN 'TASA'
			                         WHEN 2 THEN 'MONEDA'
				                     WHEN 3 THEN 'FRA'
				                     ELSE 'PROMEDIO CAMARA'
				                     END)

           ,'TIPO_MODIFICACION'   = ISNULL((SELECT  COD_OPERACION
		                                      FROM [BacParamSuda].[dbo].[TBL_PREPARA_OPERACIONES]
			                                 WHERE NRO_OPERACION = Numero_Operacion 
										       And ID_SISTEMA = @SistemaSwap),'M')		

           ,'NUMERO_OPERACION'    = Numero_Operacion
		   ,'CODIGO_CLIENTE'      = Codigo_Cliente
		   ,'NOMBRE_CLIENTE'      = ISNULL((SELECT clnombre 
		                                      FROM VIEW_CLIENTE 
			                                 WHERE clcodigo = codigo_cliente 
										       And Clrut    = rut_cliente),' ')
           ,'TIPO_OPERACION'      = Tipo_operacion											      
           ,'TIPO_FLUJO'          = Tipo_flujo
	       ,'NOMBREOPE'           = (CASE Estado 
                                     WHEN 'C' THEN 'COTIZ. ' 
								     ELSE 'CARTERA' 
								     END)
		   ,'FECHAINICIO'         = CONVERT(CHAR(10), Fecha_Cierre, 103)
		   ,'FECHATERMINO'        = CONVERT(CHAR(10), Fecha_termino, 103)
           ,'MONEDAOPERACION'     = (CASE tipo_flujo 
		                             WHEN 1 THEN compra_moneda 
			                         ELSE venta_moneda END)
		   ,'NOMBREMONEDA'        = (CASE tipo_flujo 
		                             WHEN 1 THEN ISNULL((SELECT mnglosa 
			                                           FROM View_Moneda 
                                                            WHERE mncodmon = compra_moneda) , ' ')
								     ELSE ISNULL((SELECT mnglosa 
								                    FROM View_Moneda 
										           WHERE mncodmon = venta_moneda), ' ') 
								     END)
           ,'MONTOOPERACION'      = 
			                          Venta_capital 
           ,'TASABASE'            =  
			                          Venta_valor_tasa 
           ,'MONTOCONVERSION'     =  Venta_capital 

           ,'TASACONVERSION'      = 
		                              Venta_valor_tasa 
           ,'MODALIDAD'           = ISNULL((CASE Modalidad_Pago 
		                                    WHEN 'C' THEN  'COMPENSACION' 
			                                ELSE 'ENTREGA' 
										    END),' ')
           ,'RUTCLI'              = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv 
		                                                                                  FROM View_Cliente 
			                                                                             WHERE clcodigo = codigo_cliente 
																					       AND clrut    = rut_cliente ),'*')
           ,'Area'                = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE
			                                 WHERE TBCATEG    = @Const_Area_Responsable           
											   AND TBCODIGO1  = log_area_responsable),'No Especificado') 
	       ,'CarteraNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_Cartera_Normativa
										       AND TBCODIGO1  = log_cartera_normativa),'No Especificado') 
           ,'SubCartNorm'         = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
			                                 WHERE TBCATEG    = @Const_SubCartera_Normativa
										       AND TBCODIGO1  = log_subcartera_normativa),'No Especificado') 
           ,'Libro'               = ISNULL((SELECT TBGLOSA 
		                                      FROM VIEW_TABLA_GENERAL_DETALLE 
										     WHERE TBCATEG    = @Const_Libro 
										       AND TBCODIGO1  = log_libro),'No Especificado')

           ,'PLAZO'               = isnull(DATEDIFF(dd,Fecha_Cierre,Fecha_termino),0)	
		   ,'OPERADOR'            = operador
		   ,'NUMERO_FLUJO'        = numero_flujo

	  FROM CARTERALOG WITH(NOLOCK)
      WHERE (Tipo_Swap      = @PRODUCTO       OR @PRODUCTO       = 0)
	   AND (rut_cliente    = @RUT_CLIENTE    OR @RUT_CLIENTE    = 0 )
	   AND (operador       = @OPERADOR       OR @OPERADOR       = 'T')
	   AND  Fecha_Cierre     Between   @FEC_INI AND   @FEC_FIN
   	   AND  tipo_flujo     = 2  
	   AND estado = 'A'
	 ORDER BY Numero_Operacion
  END
  
  UPDATE #paso_compras  
    SET #paso_compras.NombreMoneda       = #paso_ventas.NombreMoneda  
	  ,  #paso_compras.MontoConversion    = #paso_ventas.MontoConversion
	  ,  #paso_compras.TasaConversion     = #paso_ventas.TasaConversion  
    FROM #paso_ventas  
    WHERE #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion 
     AND #paso_ventas.Tipo_Flujo    = 2


  UPDATE #paso_compras  
     SET #paso_compras.NombreMoneda      = #paso_ventas.NombreMoneda  
	  ,  #paso_compras.MontoConversion   = #paso_ventas.MontoConversion
	  ,  #paso_compras.TasaConversion    = #paso_ventas.TasaConversion  
  FROM #paso_ventas 
  WHERE #paso_compras.Numero_Operacion  = #paso_ventas.Numero_Operacion 
   AND #paso_ventas.Tipo_Flujo         = 2


   INSERT INTO #GRUPOS
   SELECT Numero_Operacion
         ,MAX(numero_flujo)
     FROM #paso_compras
    GROUP BY 
	      Numero_Operacion

	SELECT	DISTINCT 
	        C.Swap                 AS SWAP
		,   CASE C.Tipo_Modificacion WHEN 'M' THEN 'MODIFICACION'
				WHEN 'A' THEN 'ANULACION' 
				ELSE '' 
			END AS TIPO_MODIFICACION
		,	C.Numero_Operacion     AS NUMERO_OPERACION
		,	C.Codigo_Cliente       AS CODIGO_CLIENTE
		,	C.Nombrecli            AS NOMBRE_CLIENTE
		,	C.Tipo_Flujo           AS TIPO_FLUJO
		,	C.NombreOp             AS NOMBREOPE
		,	C.FechaInicio          AS FECHAINICIO
		,	C.Fechatermino         AS FECHATERMINO
		,	C.MonedaOperacion      AS MONEDAOPERACION
		,	C.NombreMoneda         AS NOMBREMONEDA
		,	C.MontoOperacion       AS MONTOOPERACION
		,	C.TasaBase             AS TASABASE
		,	C.MontoConversion      AS MONTOCONVERSION
		,	C.TasaConversion       AS TASACONVERSION
		,	C.Modalidad            AS MODALIDAD
		,	C.rutcli              AS RUTCLI
		,	C.Area_Responsable     AS Area
		,	C.Cartera_Normativa    AS CarteraNorm
		,	C.SubCartera_Normativa AS SubCartNorm
		,	C.Libro                AS Libro
		,   C.PLAZO                AS PLAZO
		,   C.OPERADOR             AS OPERADOR
		

	FROM  #paso_compras    C 
		INNER JOIN         #GRUPOS          G
			ON G.Numero_Operacion   = C.Numero_Operacion
			AND G.numero_flujo       = C.numero_flujo

    DROP TABLE #paso_compras
	DROP TABLE #paso_ventas



 END
GO
