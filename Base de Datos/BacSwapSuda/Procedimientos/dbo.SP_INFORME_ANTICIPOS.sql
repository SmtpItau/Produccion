USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_ANTICIPOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_ANTICIPOS]
   (   @Fecha_inicio   DATETIME ,  
       @cusuario       VARCHAR(15) --> @Fecha_Final    DATETIME  
   ) 
AS

BEGIN
 SET NOCOUNT ON
    	CREATE TABLE #paso_compras(
					Swap 			CHAR(20)		,
					Numero_Operacion	NUMERIC(10)	,
					Codigo_Cliente		NUMERIC(10)	, 
					Nombrecli		CHAR(70)	,
					Tipo_operacion		CHAR(1)		, 
					NombreOp		CHAR(7)		,
					FechaInicio  		CHAR(10)	,
					Fechatermino 		CHAR(10)	,
					MonedaOperacion		NUMERIC(3)	,
					NombreMoneda		CHAR(40)	,
					MontoOperacion 		NUMERIC(21,04)	,
					TasaBase		NUMERIC(15,04)	,
					MontoConversion		NUMERIC(21,04)	,
					TasaConversion		NUMERIC(15,04)	,
					Modalidad	        CHAR(15)	,
					rutcli			CHAR(12)	,
                                        Estado                  CHAR(1)   ) /*,
					Area_Responsable	CHAR(50)	,
					Cartera_Normativa	CHAR(50)	,
					SubCartera_Normativa	CHAR(50)	,
					Libro			CHAR(50)	,

				  )		*/

    	CREATE TABLE #paso_ventas(
					Swap 			CHAR(20)	,
					Numero_Operacion	NUMERIC(10)	,
					Codigo_Cliente		NUMERIC(10)	, 
					Nombrecli		CHAR(70)	,
					Tipo_operacion		CHAR(1)		, 
					NombreOp		CHAR(7)		,
					FechaInicio  		CHAR(10)	,
					Fechatermino 		CHAR(10)	,
					MonedaOperacion		NUMERIC(3)	,
					NombreMoneda		CHAR(40)	,
					MontoOperacion 		NUMERIC(21,04)	,
					TasaBase		NUMERIC(15,04)	,
					MontoConversion		NUMERIC(21,04)	,
					TasaConversion		NUMERIC(15,04)	,
					Modalidad	        CHAR(15)	,
					rutcli			CHAR(12)	,
                                        Estado                  CHAR(1)         ) 
					/*Area_Responsable	CHAR(50)	,
					Cartera_Normativa	CHAR(50)	,
					SubCartera_Normativa	CHAR(50)	,
					Libro			CHAR(50)	,

				  )		*/

    INSERT INTO #paso_compras SELECT DISTINCT 
                              (CASE Tipo_Swap WHEN 1 THEN 'TASA           '
                                                      WHEN 2 THEN 'MONEDA         '
                                                      WHEN 3 THEN 'FRA            '
                                                      ELSE 'PROMEDIO CAMARA' END),
                               Numero_Operacion, 
                               Codigo_Cliente, 
                               ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo=codigo_cliente 
                                                And Clrut = rut_cliente),' '),
       
                              Tipo_operacion, 
		              NombreOp	= (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END),
		              FechaInicio  = CONVERT(CHAR(10), Fecha_Cierre, 103),
		              Fechatermino = CONVERT(CHAR(10), Fecha_termino, 103),
        
			      MonedaOperacion	= (CASE Tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END), 
                              NombreMoneda	= (CASE Tipo_operacion WHEN 'C' THEN ISNULL((SELECT mnglosa FROM View_Moneda 
                                                   WHERE  mncodmon = compra_moneda) , ' ')
					            ELSE ISNULL((SELECT mnglosa FROM View_Moneda 
					            WHERE  mncodmon = venta_moneda), ' ') END),  
        
	
                              MontoOperacion 	= (CASE Tipo_operacion WHEN 'C' THEN Compra_capital ELSE Venta_capital END), 
                              TasaBase		= (CASE Tipo_operacion WHEN 'C' THEN 
                              Compra_valor_tasa ELSE Venta_valor_tasa END), 



                              MontoConversion	= (CASE Tipo_operacion WHEN 'C' THEN Venta_capital ELSE Compra_capital END), 
       	                      TasaConversion	= (CASE Tipo_operacion WHEN 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END), 
       
	
                              Modalidad		= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN  'COMPENSACION' ELSE 'ENTREGA' END),' '), 
                              rutcli		= RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv FROM View_Cliente WHERE clcodigo = codigo_cliente 
					                AND clrut = rut_cliente ),'*'),
                              Estado


    FROM CARTERA 
  WHERE tipo_flujo   = 1
    AND fecha_cierre = @Fecha_inicio  


     INSERT INTO #paso_ventas SELECT DISTINCT 
                               (CASE Tipo_Swap WHEN 1 THEN 'TASA           ' 
                                                       WHEN 2 THEN 'MONEDA         '
                                                       WHEN 3 THEN 'FRA            '
                                                              ELSE 'PROMEDIO CAMARA' END), 
                              Numero_Operacion,
		              Codigo_Cliente,
		             ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo=codigo_cliente 
                                                And Clrut = rut_cliente),' '),
       
                              Tipo_operacion, 
		              NombreOp	= (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END),
		              FechaInicio  = CONVERT(CHAR(10), Fecha_Cierre, 103),
		              Fechatermino = CONVERT(CHAR(10), Fecha_termino, 103),
        
			      MonedaOperacion	= (CASE Tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END), 
                              NombreMoneda	= (CASE Tipo_operacion WHEN 'C' THEN ISNULL((SELECT mnglosa FROM View_Moneda 
                                                   WHERE  mncodmon = compra_moneda) , ' ')
					            ELSE ISNULL((SELECT mnglosa FROM View_Moneda 
					            WHERE  mncodmon = venta_moneda), ' ') END),  
        
	
                              MontoOperacion 	= (CASE Tipo_operacion WHEN 'C' THEN Compra_capital ELSE Venta_capital END), 
                              TasaBase		= (CASE Tipo_operacion WHEN 'C' THEN 
                              Compra_valor_tasa ELSE Venta_valor_tasa END), 



                              MontoConversion	= (CASE Tipo_operacion WHEN 'C' THEN Venta_capital ELSE Compra_capital END), 
       	                      TasaConversion	= (CASE Tipo_operacion WHEN 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END), 
       
	
                              Modalidad		= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN  'COMPENSACION' ELSE 'ENTREGA' END),' '), 
                              rutcli		= RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL((SELECT cldv FROM View_Cliente WHERE clcodigo = codigo_cliente 
					                AND clrut = rut_cliente ),'*'),
                              Estado
				 		
                   FROM CARTERA 
                   WHERE tipo_flujo = 2
                     AND fecha_cierre = @Fecha_inicio
                ORDER BY  Numero_operacion 	

   UPDATE #paso_compras 
      SET #paso_compras.MontoConversion  = #paso_ventas.MontoConversion 
        , #paso_compras.TasaConversion   = #paso_ventas.TasaConversion 
     FROM #paso_ventas 
    WHERE #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion 
      AND #paso_ventas.Tipo_operacion    = 'C'

   UPDATE #paso_compras 
      SET #paso_compras.MontoOperacion   = #paso_ventas.MontoOperacion 
        , #paso_compras.TasaBase         = #paso_ventas.TasaBase 
        , #paso_compras.MonedaOperacion  = #paso_ventas.MonedaOperacion 
        , #paso_compras.NombreMoneda     = #paso_ventas.NombreMoneda 
     FROM #paso_ventas 
    WHERE #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion 
      AND #paso_ventas.Tipo_operacion    = 'V'

   SELECT Numero_operacion
        , Estado 
     INTO #Tabla_Operaciones
     FROM CARTERA 
    WHERE Estado = 'N'

   UPDATE #paso_compras 
      SET ESTADO = 'N' 
     FROM #Tabla_Operaciones
    WHERE #paso_compras.numero_operacion = #Tabla_Operaciones.numero_operacion 

   SELECT  *
      FROM #paso_compras , #paso_ventas order by #paso_compras.numero_operacion

END
GO
