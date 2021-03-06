USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTASFILTRO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CONSULTASFILTRO]
	(   @operacion						NUMERIC(03),
        @tipoper						NUMERIC(03),
        @condicion						NUMERIC(03),
        @orden							NUMERIC(03),
		@codcliente						NUMERIC(09),
		@rutcliente						NUMERIC(09),
		@codmoneda						NUMERIC(09),
		@opcionfecha					NUMERIC(01),
		@fecha1							VARCHAR(08),
		@fecha2							VARCHAR(08),
		@Const_Area_Responsable			CHAR(10)	= '',
		@Const_Cartera_Normativa		CHAR(10)	= '',
		@Const_SubCartera_Normativa		CHAR(10)	= '',
		@Const_Libro					CHAR(10)	= ''
   )
AS
BEGIN

   SET NOCOUNT ON 

   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @encabezadoc    VARCHAR(1000)
   DECLARE @encabezadov    VARCHAR(1000)
   DECLARE @encabezado1    VARCHAR(1000)
   DECLARE @encabezado2    VARCHAR(1000)
   DECLARE @encabezado3    VARCHAR(1000)
   DECLARE @encabezado4    VARCHAR(1000)
   DECLARE @encabezado5    VARCHAR(1000)
   DECLARE @encabezado6    VARCHAR(1000)
   DECLARE @encabezado7	   VARCHAR(1000)

   DECLARE @Tabla	   VARCHAR(255)

   DECLARE @Condi          VARCHAR(1000)
   DECLARE @Condi1         VARCHAR(1000)
   DECLARE @CondicionCli   VARCHAR(1000)
   DECLARE @CondicionMon   VARCHAR(1000)
   DECLARE @CondicionFech  VARCHAR(1000)
   DECLARE @CondicionOrden VARCHAR(1000)

   DECLARE @final 	   VARCHAR(8000)

   DECLARE @ord		  VARCHAR(1000)
   DECLARE @cond	  VARCHAR(1000)
   DECLARE @cliente	  VARCHAR(1000)
   DECLARE @unir	  VARCHAR(1000)
   DECLARE @unir1	  VARCHAR(1000)

   DECLARE @unecompra1	  VARCHAR(255)
   DECLARE @unecompra2	  VARCHAR(255)

   DECLARE @uneventa1	  VARCHAR(255)
   DECLARE @uneventa2	  VARCHAR(255)

   /*=======================================================================*/
   /* Encabezado de la Consulta						    */	
   /*=======================================================================*/
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
					Area_Responsable	CHAR(50)	,
					Cartera_Normativa	CHAR(50)	,
					SubCartera_Normativa	CHAR(50)	,
					Libro			CHAR(50)	
				  )		

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
					Area_Responsable	CHAR(50)	,
					Cartera_Normativa	CHAR(50)	,
					SubCartera_Normativa	CHAR(50)	,
					Libro			CHAR(50)	
				  )		

	SELECT @encabezadoc   = 'INSERT INTO #paso_compras SELECT DISTINCT '  
						+  'Swap = (CASE Tipo_Swap WHEN 1 THEN ''TASA           '''   
						+ ' WHEN 2 THEN ''MONEDA         '''  
						+ ' WHEN 3 THEN ''FRA            '''  
						+ ' ELSE ''PROMEDIO CAMARA'' END),'  
						+  'Numero_Operacion, '  
						+  'Codigo_Cliente, '  
						+  'Nombrecli=ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo=codigo_cliente '   


	SELECT @encabezadov   = 'INSERT INTO #paso_ventas SELECT DISTINCT '  
						+  'Swap=(CASE Tipo_Swap WHEN 1 THEN ''TASA           '''   
						+ ' WHEN 2 THEN ''MONEDA         '''  
						+ ' WHEN 3 THEN ''FRA            '''  
						+ ' ELSE ''PROMEDIO CAMARA'' END),'   
						+  'Numero_Operacion, '  
						+  'Codigo_Cliente, '  
						+  'Nombrecli=ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo=codigo_cliente '   
		 
        	
        SELECT @encabezado1 =  ' And Clrut = rut_cliente),'' ''),'  
						+ 'Tipo_operacion,'   
        --      MAP 20080520 : Mejoras SWAP
						-- + 'NombreOp = (CASE Tipo_operacion WHEN ''C'' THEN ''COMPRA '' ELSE ''VENTA  '' END),'  
						+ 'NombreOp = (CASE Estado WHEN ''C'' THEN ''COTIZ. '' ELSE ''CARTERA'' END),'  
						+ 'FechaInicio  = CONVERT(CHAR(10), Fecha_Cierre, 103),'  
						+ 'Fechatermino = CONVERT(CHAR(10), Fecha_termino, 103),'  
        
		SELECT @encabezado2   = ' '  
						+  'MonedaOperacion = (CASE Tipo_operacion WHEN ''C'' THEN compra_moneda ELSE venta_moneda END), '  
						+  'NombreMoneda = (CASE Tipo_operacion WHEN ''C'' THEN ISNULL((SELECT mnglosa FROM View_Moneda '  

		SELECT @encabezado3   = ' '  
						+ ' WHERE  mncodmon = compra_moneda) , '' '')'  
						+ ' ELSE ISNULL((SELECT mnglosa FROM View_Moneda '  
						+ ' WHERE  mncodmon = venta_moneda), '' '') END), '   
        
		SELECT @encabezado4   = ' '  
						+  ' MontoOperacion  = (CASE Tipo_operacion WHEN ''C'' THEN Compra_capital ELSE Venta_capital END), '    
						+  ' TasaBase  = (CASE Tipo_operacion WHEN ''C'' THEN '   
						+  ' Compra_valor_tasa ELSE Venta_valor_tasa END), '    


		SELECT @encabezado5   = ' '  
						+  ' MontoConversion = (CASE Tipo_operacion WHEN ''C'' THEN Venta_capital ELSE Compra_capital END), '    
						+  ' TasaConversion = (CASE Tipo_operacion WHEN ''C'' THEN '  
						+ ' Venta_valor_tasa ELSE Compra_valor_tasa END), '    
       
		SELECT @encabezado6   = ' '  
						+  ' Modalidad  = ISNULL((CASE Modalidad_Pago WHEN ''C'' THEN '  
						+ ' ''COMPENSACION'' ELSE ''ENTREGA'' END),'' ''), '  
						+  ' rutcli  = RTRIM(CONVERT(CHAR(9),rut_cliente)) + ''-'' + ISNULL((SELECT '   
						+ ' cldv FROM View_Cliente WHERE clcodigo = codigo_cliente '  
						+ 'AND clrut = rut_cliente ),''*'')'  
				 		
	/***********************************/
	/*              Tabla              */
	/***********************************/

	IF @operacion = 1  BEGIN --Tabla Movimiento diario 
  SELECT @Encabezado7 =                 ', ''Area'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Area_Responsable  + ' AND TBCODIGO1 = mov_area_responsable),''No Especificado'') , '  
  SELECT @Encabezado7  = @Encabezado7  + ' ''CarteraNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Cartera_Normativa + ' AND TBCODIGO1 = mov_cartera_normativa),''No Especificado'') , '  
  SELECT @Encabezado7  = @Encabezado7  + ' ''SubCartNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_SubCartera_Normativa  + ' AND TBCODIGO1 = mov_subcartera_normativa),''No Especificado'') ,'  
  SELECT @Encabezado7  = @Encabezado7  + ' ''Libro'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Libro + ' AND TBCODIGO1 = mov_libro),''No Especificado'') '  
  SELECT @Tabla  = ' FROM MOVDIARIO '    

	END ELSE IF @operacion = 2 BEGIN  -- Tabla Movimiento Historico
  SELECT @Encabezado7 = ', ''Area'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Area_Responsable + ' AND TBCODIGO1 = mhi_area_responsable),''No Especificado'') , '  
  SELECT @Encabezado7  = @Encabezado7  + ' ''CarteraNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Cartera_Normativa + ' AND TBCODIGO1 = mhi_cartera_normativa),''No Especificado'') , '  
  SELECT @Encabezado7  = @Encabezado7  + ' ''SubCartNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_SubCartera_Normativa + ' AND TBCODIGO1 = mhi_subcartera_normativa),''No Especificado''),'  
  SELECT @Encabezado7  = @Encabezado7  + ' ''Libro'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Libro + ' AND TBCODIGO1 = mhi_libro),''No Especificado'') '  

  SELECT @Tabla  = ' FROM MovHistorico '  


	END ELSE IF @operacion = 3 BEGIN  -- Tabla Cartera
  SELECT @Encabezado7 = ', ''Area'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Area_Responsable + ' AND TBCODIGO1 = car_area_responsable),''No Especificado'') , '  
  SELECT @Encabezado7  = @Encabezado7  + ' ''CarteraNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Cartera_Normativa + ' AND TBCODIGO1 = car_cartera_normativa),''No Especificado'') , '  
  SELECT @Encabezado7  = @Encabezado7  + ' ''SubCartNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_SubCartera_Normativa + ' AND TBCODIGO1 = car_subcartera_normativa),''No Especificado''), '  
  SELECT @Encabezado7  = @Encabezado7  + ' ''Libro'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Libro + ' AND TBCODIGO1 = car_libro),''No Especificado'') '  

  SELECT @Tabla  = ' FROM CARTERA '  

	END ELSE IF @operacion = 4 BEGIN  -- Tabla Cartera Historica
  SELECT @Encabezado7 = ', ''Area'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Area_Responsable + ' AND TBCODIGO1 = chi_area_responsable),''No Especificado'') ,'  
  SELECT @Encabezado7  = @Encabezado7  + ' ''CarteraNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Cartera_Normativa + ' AND TBCODIGO1 = chi_cartera_normativa),''No Especificado'') , '  
  SELECT @Encabezado7  = @Encabezado7  + ' ''SubCartNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_SubCartera_Normativa + ' AND TBCODIGO1 = chi_subcartera_normativa),''No Especificado''),'  
  SELECT @Encabezado7  = @Encabezado7  + ' ''Libro'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Libro + ' AND TBCODIGO1 = chi_libro),''No Especificado'') '  

  SELECT @Tabla  = ' FROM CARTERAHIS '  
	END

                     	/***********************************/
	/*     Filtro tipo de Swaps        */
	/***********************************/
 SELECT @Condi = ' '  
	IF @tipoper = 1 OR @tipoper = 2 OR @tipoper = 3 OR @tipoper = 4  BEGIN	-- Solo Operaciones de Tasas o Monedas
   SELECT @Condi  = ' WHERE tipo_flujo = 1 AND Tipo_swap = ' + CONVERT(CHAR(9),@tipoper)    
   SELECT @Condi1 = ' WHERE tipo_flujo = 2 AND Tipo_swap = ' + CONVERT(CHAR(9),@tipoper)    
  SELECT @unir   = ' AND '  

	END ELSE IF @tipoper = 0 BEGIN  -- Todas las Operaciones		
   SELECT @Condi  = ' WHERE tipo_flujo = 1 '  
   SELECT @Condi1 = ' WHERE tipo_flujo = 2 '  
  SELECT @unir = ' AND '     
	END

	/***********************************/
	/*          que flujo sacar        */
	/***********************************/		
	IF @operacion = 1 OR @operacion = 2  BEGIN --Tabla Movimiento diario 
		--para esta opciones sacara datos del primer flujo
		--para esta opciones sacara datos del segundo flujo
--  SELECT @Condi  = @Condi  + @unir + ' numero_flujo <= 1 '  
--  SELECT @Condi1 = @Condi1 + @unir + ' numero_flujo <= 1 '  
                SELECT @Condi  = @Condi  + @unir + ' estado_flujo = 1 '  
  SELECT @Condi1 = @Condi1 + @unir + ' estado_flujo = 1 '  
  SELECT @unir = ' AND '  
	END 

	/***********************************/
	/*        Filtro de Cliente	   */
	/***********************************/
 SELECT @CondicionCli = ' '  
	IF @codcliente <>0 BEGIN	
   SELECT @CondicionCli = @unir + ' codigo_cliente = ' + CONVERT ( CHAR ( 9 ),@codcliente)   
         + 'AND rut_cliente = ' + CONVERT ( CHAR ( 9 ),@rutcliente )  
					
  SELECT @unir = ' AND '  

	END

	/***********************************/
	/*        Filtro de Moneda	   */
	/***********************************/
 SELECT @CondicionMon = ' '  
	IF @codmoneda <>0 BEGIN	
   SELECT @CondicionMon = @unir + ' compra_Moneda = ' + CONVERT ( CHAR ( 9 ), @codmoneda )   
  SELECT @unir = ' AND '  

	END

	/***********************************/
	/*        Filtro de Fechas	   */
	/***********************************/
 SELECT @CondicionFech = ' '  
	IF @opcionfecha = 1 BEGIN	-- Fecha proceso
   SELECT @CondicionFech =  @unir + ' Fecha_Inicio = ''' + @fecha1 + ''' '  

	END ELSE IF @opcionfecha = 2 BEGIN  -- Fecha de vencimiento
  SELECT @CondicionFech = @unir + ' Fecha_termino = ''' + @fecha2 + ''''  

	END ELSE IF @opcionfecha = 3 BEGIN  -- Fecha Proceso entre fecha
  SELECT @CondicionFech = @unir + ' ( Fecha_Inicio BETWEEN ''' + @fecha1 + ''' AND ''' + @fecha2 + ''') '      

	END ELSE IF @opcionfecha = 4 BEGIN  -- Fecha de vencimiento entre fecha 
  SELECT @CondicionFech = @unir + ' ( Fecha_termino BETWEEN ''' + @fecha1 + ''' AND ''' + @fecha2 + ''') '     

	END

	/***********************************/
	/*        	ORDEN		   */
	/***********************************/
 SELECT @CondicionOrden = ' '  
	IF @orden = 1 BEGIN	
   SELECT @CondicionOrden = ' ORDER BY nombrecli '  

	END ELSE IF @orden = 2 BEGIN  
  SELECT @CondicionOrden = ' ORDER BY NombreMoneda '  

	END ELSE IF @orden = 3 BEGIN 
  SELECT @CondicionOrden = ' ORDER BY Fechainicio '  

	END ELSE IF @orden = 4 BEGIN 
  SELECT @CondicionOrden = ' ORDER BY FechaTermino '  

	END ELSE BEGIN
  SELECT @CondicionOrden = ' ORDER BY Numero_operacion '    
	END

 SELECT  @unecompra1 = ' UPDATE #paso_compras '  
  +    ' SET #paso_compras.MontoConversion = #paso_ventas.MontoConversion , '  
  +    ' #paso_compras.TasaConversion  = #paso_ventas.TasaConversion '  
         +    ' FROM #paso_ventas '   

 SELECT  @unecompra2 = ' WHERE #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion AND '  
  +    ' #paso_ventas.Tipo_operacion = ''C'''  


 SELECT  @uneventa1 = ' UPDATE #paso_compras '  
  +    ' SET #paso_compras.MontoOperacion = #paso_ventas.MontoOperacion , '  
  +    ' #paso_compras.TasaBase = #paso_ventas.TasaBase , '  
  +    ' #paso_compras.MonedaOperacion = #paso_ventas.MonedaOperacion , '  
		

 SELECT  @uneventa2 = ' #paso_compras.NombreMoneda = #paso_ventas.NombreMoneda '  
  +    ' FROM #paso_ventas '  
  +    ' WHERE   #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion AND '  
  +    ' #paso_ventas.Tipo_operacion = ''V'''  

--   SELECT ( @encabezadoc + @encabezado1 + @encabezado2 + @encabezado3 + @encabezado4 + @encabezado5 + @encabezado6 + @Encabezado7 + @tabla + @condi  + @condicionCli + @condicionMon + @condicionFech + @condicionOrden )
--   SELECT ( @encabezadov + @encabezado1 + @encabezado2 + @encabezado3 + @encabezado4 + @encabezado5 + @encabezado6 + @Encabezado7 + @tabla + @condi1 + @condicionCli + @condicionMon + @condicionFech + @condicionOrden )

   EXECUTE ( @encabezadoc + @encabezado1 + @encabezado2 + @encabezado3 + @encabezado4 + @encabezado5 + @encabezado6 + @Encabezado7 + @tabla + @condi  + @condicionCli + @condicionMon + @condicionFech + @condicionOrden )
   EXECUTE ( @encabezadov + @encabezado1 + @encabezado2 + @encabezado3 + @encabezado4 + @encabezado5 + @encabezado6 + @Encabezado7 + @tabla + @condi1 + @condicionCli + @condicionMon + @condicionFech + @condicionOrden )

   EXECUTE (@unecompra1 + @unecompra2 )
   EXECUTE (@uneventa1  + @uneventa2  )  	

	SELECT	Swap
		,	Numero_Operacion
		,	Codigo_Cliente
		,	Nombrecli
		,	Tipo_operacion
		,	NombreOp
		,	FechaInicio
		,	Fechatermino
		,	MonedaOperacion
		,	NombreMoneda
		,	MontoOperacion
		,	TasaBase
		,	MontoConversion
		,	TasaConversion
		,	Modalidad
		,	rutcli
		,	Area_Responsable
		,	Cartera_Normativa
		,	SubCartera_Normativa
		,	Libro
	FROM	#paso_compras 
	ORDER 
	BY		CASE	WHEN @orden = 1 THEN nombrecli 
					WHEN @orden = 2 THEN NombreMoneda 
					WHEN @orden = 3 THEN Fechainicio
					WHEN @orden = 4 THEN FechaTermino
									ELSE Numero_operacion
				END

   /*=======================================================================*/
   /*=======================================================================*/
   SET NOCOUNT OFF

END
GO
