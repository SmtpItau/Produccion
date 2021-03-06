USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_ANTICIPO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FILTRO_ANTICIPO]
   (   @operacion	                NUMERIC(03)
   ,   @tipoper	                        NUMERIC(03)
   ,   @condicion	                NUMERIC(03)
   ,   @orden		                NUMERIC(03)
   ,   @opcionfecha	                NUMERIC(01)
   ,   @fecha1		                VARCHAR(08)
   ,   @fecha2		                VARCHAR(08)
   ,   @Const_Area_Responsable          CHAR(10)   = ''
   ,   @Const_Cartera_Normativa         CHAR(10)   = ''
   ,   @Const_SubCartera_Normativa      CHAR(10)   = ''
   ,   @Const_Libro                     CHAR(10)   = ''
   ,   @nNumeroOperacion                NUMERIC(9) = 0
   )
AS
BEGIN

   SET NOCOUNT ON 

   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @encabezadoc    VARCHAR(1000)
   DECLARE @encabezadocc    VARCHAR(1000)
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


declare @datos integer
   /*=======================================================================*/
   /* Encabezado de la Consulta						    */	
   /*=======================================================================*/
   CREATE TABLE #paso_compras
   (   Swap 			CHAR(20)
   ,   Numero_Operacion	        NUMERIC(10)
   ,   Codigo_Cliente		NUMERIC(10)
   ,   Nombrecli		CHAR(70)
   ,   Tipo_operacion		CHAR(1)
   ,   NombreOp		        CHAR(7)
   ,   FechaInicio  		CHAR(10)
   ,   Fechatermino 		CHAR(10)
   ,   MonedaOperacion		NUMERIC(3)
   ,   NombreMoneda		CHAR(40)
   ,   MontoOperacion 		NUMERIC(21,04)
   ,   TasaBase		        NUMERIC(15,04)
   ,   MontoConversion		NUMERIC(21,04)
   ,   TasaConversion		NUMERIC(15,04)
   ,   Modalidad	        CHAR(15)
   ,   rutcli			CHAR(12)
   ,   Area_Responsable	        CHAR(50)
   ,   Cartera_Normativa	CHAR(50)
   ,   SubCartera_Normativa	CHAR(50)
   ,   Libro			CHAR(50)
   ,   Estado                   CHAR(1)
				  )		

   CREATE TABLE #paso_ventas
   (   Swap 			CHAR(20)
   ,   Numero_Operacion	        NUMERIC(10)
   ,   Codigo_Cliente		NUMERIC(10)
   ,   Nombrecli		CHAR(70)
   ,   Tipo_operacion		CHAR(1)
   ,   NombreOp		        CHAR(7)
   ,   FechaInicio  		CHAR(10)
   ,   Fechatermino 		CHAR(10)
   ,   MonedaOperacion		NUMERIC(3)
   ,   NombreMoneda		CHAR(40)
   ,   MontoOperacion 		NUMERIC(21,04)
   ,   TasaBase		        NUMERIC(15,04)
   ,   MontoConversion		NUMERIC(21,04)
   ,   TasaConversion		NUMERIC(15,04)
   ,   Modalidad	        CHAR(15)
   ,   rutcli			CHAR(12)
   ,   Area_Responsable	        CHAR(50)
   ,   Cartera_Normativa	CHAR(50)
   ,   SubCartera_Normativa	CHAR(50)
   ,   Libro			CHAR(50)
   ,   Estado                   CHAR(1)
				  )		

   SET @encabezadoc   = 'INSERT INTO #paso_compras SELECT DISTINCT '    
                        +  'Swap = (CASE Tipo_Swap WHEN 1 THEN ''TASA           '''       
      + ' WHEN 2 THEN ''MONEDA         '''      
      + ' WHEN 3 THEN ''FRA            '''      
      + ' ELSE ''PROM. CAMARA'' END),'      
      + ' Numero_Operacion, '      
      + ' Codigo_Cliente, '      
      + ' Nombrecli=ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo=codigo_cliente '       

   SET @encabezadov   = 'INSERT INTO #paso_ventas SELECT DISTINCT '      
      +  'Swap=(CASE Tipo_Swap WHEN 1 THEN ''TASA           '''       
      + ' WHEN 2 THEN ''MONEDA         '''      
      + ' WHEN 3 THEN ''FRA            '''      
      + ' ELSE ''PROM. CAMARA'' END),'      
      +  'Numero_Operacion, '      
      +  'Codigo_Cliente, '      
      +  'Nombrecli=ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo=codigo_cliente '       
		 
   SET @encabezado1     = ' And Clrut = rut_cliente),'' ''),'      
      + ' Tipo_operacion,'       
      + ' NombreOp = (CASE Tipo_operacion WHEN ''C'' THEN ''COMPRA '' ELSE ''VENTA  '' END),'      
      + ' FechaInicio  = CONVERT(CHAR(10), Fecha_Cierre, 103),'      
      + ' Fechatermino = CONVERT(CHAR(10), Fecha_termino, 103),'      
        
   SET @encabezado2   = ' '     
      +  ' MonedaOperacion = (CASE Tipo_operacion WHEN ''C'' THEN compra_moneda ELSE venta_moneda END), '      
      +  ' NombreMoneda = (CASE Tipo_operacion WHEN ''C'' THEN ISNULL((SELECT mnglosa FROM View_Moneda '      

   SET @encabezado3   = ' '      
      + ' WHERE  mncodmon = compra_moneda) , '' '')'      
      + ' ELSE ISNULL((SELECT mnglosa FROM View_Moneda '      
      + ' WHERE  mncodmon = venta_moneda), '' '') END), '       
        
   SET @encabezado4   = ' '      
      +  ' MontoOperacion  = (CASE Tipo_operacion WHEN ''C'' THEN Compra_capital ELSE Venta_capital END), '        
      +  ' TasaBase  = (CASE Tipo_operacion WHEN ''C'' THEN '       
      +  ' Compra_valor_tasa ELSE Venta_valor_tasa END), '        

   SET @encabezado5   = ' '      
      +  ' MontoConversion = (CASE Tipo_operacion WHEN ''C'' THEN Venta_capital ELSE Compra_capital END), '        
      +  ' TasaConversion = (CASE Tipo_operacion WHEN ''C'' THEN '      
      + ' Venta_valor_tasa ELSE Compra_valor_tasa END), '        
       
   SET @encabezado6   = ' '      
      +  ' Modalidad  = ISNULL((CASE Modalidad_Pago WHEN ''C'' THEN '      
      +  ' ''COMPENSACION'' ELSE ''ENTREGA'' END),'' ''), '      
      +  ' rutcli  = RTRIM(CONVERT(CHAR(9),rut_cliente)) + ''-'' + ISNULL((SELECT '       
      +  ' cldv FROM View_Cliente WHERE clcodigo = codigo_cliente '      
      +  ' AND clrut = rut_cliente ),''*'')'      
				 		
	/***********************************/
	/*              Tabla              */
	/***********************************/

   IF @operacion = 3 
   BEGIN  --> Tabla Cartera
      SET @Encabezado7  = ', ''Area'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Area_Responsable + ' AND TBCODIGO1 = car_area_responsable),''No Especificado'') , '      
      SET @Encabezado7  = @Encabezado7  + ' ''CarteraNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Cartera_Normativa + ' AND TBCODIGO1 = car_cartera_normativa),''No Especificado'') , '      
      SET @Encabezado7  = @Encabezado7  + ' ''SubCartNorm'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_SubCartera_Normativa + ' AND TBCODIGO1 = car_subcartera_normativa),''No Especificado''), '      
      SET @Encabezado7  = @Encabezado7  + ' ''Libro'' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = ' + @Const_Libro + ' AND TBCODIGO1 = car_libro),''No Especificado'') '      
      SET @Encabezado7  = @Encabezado7  + ' ,Estado '      

           
      SET @Tabla        = ' FROM CARTERA '
	END

        /***********************************/
	/*     Filtro tipo de Swaps        */
	/***********************************/

   SET @Condi = ' '      

   IF @tipoper = 1 OR @tipoper = 2 OR @tipoper = 3 OR @tipoper = 4
   BEGIN	-- Solo Operaciones de Tasas o Monedas
      SET @Condi  = ' WHERE tipo_flujo = 1 AND Tipo_swap = ' + CONVERT(CHAR(9),@tipoper)        
      SET @Condi1 = ' WHERE tipo_flujo = 2 AND Tipo_swap = ' + CONVERT(CHAR(9),@tipoper)        
   SET @unir   = ' AND '      
   END ELSE 
   IF @tipoper = 0
   BEGIN -- Todas las Operaciones		
      SET @Condi  = ' WHERE tipo_flujo = 1 '      
      SET @Condi1 = ' WHERE tipo_flujo = 2 '      
      SET @unir = ' AND '         
   END

   IF @nNumeroOperacion <> 0
   BEGIN
      SET @Condi  = @Condi  + ' AND numero_operacion = ' + LTRIM(RTRIM( @nNumeroOperacion )) + ' '       
      SET @Condi1 = @Condi1 + ' AND numero_operacion = ' + LTRIM(RTRIM( @nNumeroOperacion )) + ' '      
	END

	/***********************************/
	/*          que flujo sacar        */
	/***********************************/		
   IF @operacion = 1 OR @operacion = 2  
   BEGIN --Tabla Movimiento diario -- Para esta opciones sacara datos del primer flujo
      SET @Condi  = @Condi  + @unir + ' numero_flujo <= 1 '      
      SET @Condi1 = @Condi1 + @unir + ' numero_flujo <= 1 '      
      SET @unir = ' AND '      
	END 

-- 20090209  - Se agrega condición, ya que no tienen el mismo valor en el campo tasa base en todos los flujos, 
--             por lo que se duplican.
   IF @operacion = 3  
   BEGIN
      SET @Condi  = @Condi  + @unir + ' estado_flujo = 1 '      
      SET @Condi1 = @Condi1 + @unir + ' estado_flujo = 1 '      
      SET @unir = ' AND '      
        END

   SET @CondicionFech =  @unir + ' fecha_cierre < ''' + @fecha1 + ''' '       
   SET @CondicionFech =  @CondicionFech + ' AND fecha_inicio_flujo <> fecha_vence_flujo   '      

	/***********************************/
	/*        	ORDEN		   */
	/***********************************/

   SET @CondicionOrden = ' '      

   IF @orden = 1 
   BEGIN	
      SET @CondicionOrden = ' ORDER BY nombrecli '      
   END ELSE 
   IF @orden = 2 
   BEGIN  
      SET @CondicionOrden = ' ORDER BY NombreMoneda '      
   END ELSE 
   IF @orden = 3 
   BEGIN 
      SET @CondicionOrden = ' ORDER BY  Fechainicio '      
   END ELSE 
   IF @orden = 4 
   BEGIN 
      SET @CondicionOrden = ' ORDER BY  FechaTermino '      
   END ELSE 
   BEGIN
      SET @CondicionOrden = ' ORDER BY  Numero_operacion '        
	END

      SET @unecompra1  = ' UPDATE #paso_compras '      
     +    ' SET #paso_compras.MontoConversion = #paso_ventas.MontoConversion , '      
     +    ' #paso_compras.TasaConversion  = #paso_ventas.TasaConversion '      
     +    ' FROM #paso_ventas '       

      SET @unecompra2  = ' WHERE #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion AND '      
     +    ' #paso_ventas.Tipo_operacion = ''C'''      

      SET @uneventa1  = ' UPDATE #paso_compras '      
     +    ' SET #paso_compras.MontoOperacion = #paso_ventas.MontoOperacion , '     
     +    ' #paso_compras.TasaBase = #paso_ventas.TasaBase , '      
     +    ' #paso_compras.MonedaOperacion = #paso_ventas.MonedaOperacion , '    
		
      SET @uneventa2  = ' #paso_compras.NombreMoneda = #paso_ventas.NombreMoneda '      
     +    ' FROM #paso_ventas '      
     +    ' WHERE   #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion AND '      
     +    ' #paso_ventas.Tipo_operacion = ''V'''      

   EXECUTE ( @encabezadoc + @encabezado1 + @encabezado2 + @encabezado3 + @encabezado4 + @encabezado5 + @encabezado6 + @Encabezado7 + @tabla + @condi  + @condicionCli + @condicionMon + @condicionFech + @condicionOrden )
   EXECUTE ( @encabezadov + @encabezado1 + @encabezado2 + @encabezado3 + @encabezado4 + @encabezado5 + @encabezado6 + @Encabezado7 + @tabla + @condi1 + @condicionCli + @condicionMon + @condicionFech + @condicionOrden )

   EXECUTE (@unecompra1 + @unecompra2 )
   EXECUTE (@uneventa1  + @uneventa2  )  	

   SELECT Numero_operacion
      ,   Estado 
     INTO #Tabla_Operaciones
   FROM   CARTERA 
   WHERE  Estado = 'N'

   UPDATE #paso_compras 
      SET ESTADO = 'N' 
     FROM #Tabla_Operaciones
     WHERE  #paso_compras.numero_operacion =   #Tabla_Operaciones.numero_operacion 

   DELETE #PASO_COMPRAS
     FROM BacSwapSuda.dbo.CARTERA_UNWIND unw
    WHERE FechaAnticipo        = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))
      and unw.numero_operacion = #PASO_COMPRAS.Numero_Operacion

   SELECT  *
     FROM #paso_compras
    WHERE ESTADO <> 'N'
      AND estado <> 'C'

END
--exec SP_FILTRO_ANTICIPO 1,0,0,1,0,'20110106','20110106',7209,7209,7209,7209,0
GO
