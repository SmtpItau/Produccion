USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_VCTOS_LINEAS_OPE]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RPT_VCTOS_LINEAS_OPE] (@nfechaVcto CHAR(08))
  						   	
AS BEGIN
   SET NOCOUNT ON

   CREATE TABLE #TEMP_LINEAS
   (   Rut_Emisor           NUMERIC(9,0)   NOT NULL
   ,   Nombre_Emisor 	    CHAR(70)        NOT NULL	
   ,   Sistema              CHAR(03)       NOT NULL
   ,   Tipo_Operacion       CHAR(50)       NOT NULL
   ,   Rut_Cliente          NUMERIC(9,0)   NOT NULL
   ,   Cod_cli 		    NUMERIC(9,0)   NOT NULL
   ,   Nombre_Cliente 	    CHAR(70)        NOT NULL		
   ,   Numero_Operacion     NUMERIC(10,0)  NOT NULL
   ,   Numero_Correlativo   NUMERIC(10,0)  NOT NULL	
   ,   Codigo_Prod          CHAR(5)        NOT NULL
   ,   Moneda_Oper          CHAR(5)        NOT NULL
   ,   Monto_Vencimiento    NUMERIC(19,4)  NOT NULL
   ,   Forma_Pago    	    CHAR(30)       NOT NULL
   ,   Fecha_Venc	    DATETIME	   NOT NULL
   ,   Grupo		    CHAR(10)       NOT NULL 	
   )
	


--------------------------------------------fwd-----------------------------------------------------


select 	 b.mocodigo
        ,'NomEmi' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = b.mocodigo and clcodigo =a.Codigo_Cliente)
	,a.Id_Sistema
	,c.Descripcion
	,a.Rut_Cliente
	,a.Codigo_Cliente
        ,'Nomcli' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = b.mocodigo and clcodigo =a.Codigo_Cliente)
	,a.NumeroOperacion
	,a.NumeroCorrelativo
	,a.Codigo_Producto
	,'Moneda' = (select mnnemo  from view_moneda where  b.mocodmon1=mncodmon) --,'c'
	,a.MontoTransaccion
	,'FormaPago' = ISNULL( (select glosa from view_forma_de_pago where  b.mofpagomn =codigo),'') --,'c'
	,'FecVcto' =  a.FechaVencimiento
        ,'Grupo'= 'CLIENTE'
into #tempFWD
from  linea_transaccion a  
     ,bacfwdsuda.dbo.mfmoh b
     ,PRODUCTO_SISTEMA	c

where a.Id_Sistema ='bfw' AND    
      a.NumeroOperacion = b.monumoper	AND
      a.Id_Sistema = c.Id_Sistema	AND
      convert(char(05),b.mocodpos1) = c.Codigo_Producto AND
      a.FechaVencimiento = @nfechaVcto	


insert into #TEMP_LINEAS select *  from #tempFWD 



--------------------------------------------fwd-----------------------------------------------------

--------------------------------------------bcc-----------------------------------------------------

select 	 b.MORUTCLI
	,'NomEmi' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = b.MORUTCLI and clcodigo =a.Codigo_Cliente)
	,a.Id_Sistema
	,c.Descripcion
	,a.Rut_Cliente
	,a.Codigo_Cliente
	,'NomCli' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = b.MORUTCLI and clcodigo =a.Codigo_Cliente)
	,a.NumeroOperacion
	,a.NumeroCorrelativo
	,a.Codigo_Producto
	,'Moneda' = b.mocodmon  --'Moneda' = (select mnnemo  from view_moneda where b.mocodmon=mncodmon)	 --,'c'
	,a.MontoTransaccion
	,'FormaPago' = ISNULL( (select glosa from view_forma_de_pago where  b.moentre =codigo),'')	 --,'c'
	,'FecVcto' = a.FechaVencimiento
        ,'Grupo'= 'CLIENTE'
into #tempBCC
from  linea_transaccion a  
     ,baccamsuda.dbo.memoh b
     ,PRODUCTO_SISTEMA	c

where a.Id_Sistema ='bcc' AND    
      a.NumeroOperacion = b.monumope	AND
      a.Id_Sistema = c.Id_Sistema	AND
      b.motipmer = c.Codigo_Producto	AND
      a.FechaVencimiento = @nfechaVcto



insert into #TEMP_LINEAS select *  from #tempBCC   





--------------------------------------------bcc-----------------------------------------------------


--------------------------------------------swap-----------------------------------------------------

   DECLARE @encabezadoc    VARCHAR(255)
   DECLARE @encabezadov    VARCHAR(255)
   DECLARE @encabezado1    VARCHAR(255)
   DECLARE @encabezado2    VARCHAR(255)
   DECLARE @encabezado3    VARCHAR(255)
   DECLARE @encabezado4    VARCHAR(255)
   DECLARE @encabezado5    VARCHAR(255)
   DECLARE @encabezado6    VARCHAR(255)
   DECLARE @encabezado7    VARCHAR(255)
   DECLARE @encabezado8    VARCHAR(255)
   DECLARE @encabezado9    VARCHAR(255)
   DECLARE @encabezado10    VARCHAR(255)

 
   DECLARE @Tabla	   VARCHAR(255)

   DECLARE @Condi          VARCHAR(255)
   DECLARE @Condi1         VARCHAR(255)
   DECLARE @CondicionCli   VARCHAR(255)
   DECLARE @CondicionMon   VARCHAR(255)
   DECLARE @CondicionFech  VARCHAR(255)
   DECLARE @CondicionOrden VARCHAR(255)

   DECLARE @final 	   VARCHAR(6000)


   DECLARE @ord		  VARCHAR(20)
   DECLARE @cond	  VARCHAR(200)
   DECLARE @cliente	  VARCHAR(100)
   DECLARE @unir	  VARCHAR(10)
   DECLARE @unir1	  VARCHAR(10)

   DECLARE @unecompra1	  VARCHAR(255)
   DECLARE @unecompra2	  VARCHAR(255)

  DECLARE @uneventa1	  VARCHAR(255)
   DECLARE @uneventa2	  VARCHAR(255)  

   DECLARE @operacion	  NUMERIC(03)
   DECLARE @tipoper	NUMERIC ( 03 )
   DECLARE @condicion	NUMERIC ( 03 )
   DECLARE @orden	NUMERIC ( 03 )
   DECLARE @codcliente	NUMERIC ( 09 )
   DECLARE @rutcliente	NUMERIC ( 09 )
   DECLARE @codmoneda	NUMERIC ( 09 )
   DECLARE @opcionfecha	NUMERIC ( 01 )
   DECLARE @fecha1	VARCHAR ( 08 )
   DECLARE @fecha2	VARCHAR ( 08 )




	SET @operacion = 2
	SET @tipoper   = 0
	SET @condicion = 0
	SET @orden     = 0
	SET @codcliente  = 0
	SET @rutcliente	 = 0
	SET @codmoneda	 = 0
	SET @opcionfecha = 0



   /*=======================================================================*/
   /* Encabezado de la Consulta						    */	
   /*=======================================================================*/
    	CREATE TABLE #paso_compras(
					Swap 			CHAR(6)		,
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
					FormaPago		CHAR(30)	,
					FormaPago2		CHAR(30)	
				  )		

    	CREATE TABLE #paso_ventas(
					Swap 			CHAR(6)		,
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
					FormaPago		CHAR(30)	,
					FormaPago2		CHAR(30)	
				  )		

	SELECT @encabezadoc 		= 'INSERT INTO #paso_compras SELECT DISTINCT '
		+  'Swap= Tipo_Swap,' 
		+  'Numero_Operacion, '
		+  'Codigo_Cliente, '
		+  'Nombrecli= ISNULL((SELECT clnombre FROM View_Cliente WHERE clcodigo=codigo_cliente ' 

		
	SELECT @encabezadov 		= 'INSERT INTO #paso_ventas SELECT DISTINCT '
		+  'Swap= Tipo_Swap,' 
		+  'Numero_Operacion, '
		+  'Codigo_Cliente, '
		+  'Nombrecli= ISNULL((SELECT clnombre FROM View_Cliente WHERE clcodigo=codigo_cliente ' 
		 
        	
        SELECT @encabezado1 =		' AND Clrut = rut_cliente),'' ''),'
		+  'Tipo_operacion, ' 
		+ 'NombreOp	= (CASE Tipo_operacion WHEN ''C'' THEN ''COMPRA '' ELSE ''VENTA  '' END), '  	 
		+ 'FechaInicio  = CONVERT(CHAR(10), Fecha_Cierre, 103), '
		+ 'Fechatermino = CONVERT(CHAR(10), Fecha_termino, 103), '
        
	SELECT @encabezado2 		= ' '
		+  'MonedaOperacion	= (CASE Tipo_operacion WHEN ''C'' THEN compra_moneda ELSE venta_moneda END), '
		+  'NombreMoneda	= (CASE Tipo_operacion WHEN ''C'' THEN ISNULL((SELECT mnglosa FROM View_Moneda '

	SELECT @encabezado3 		= ' '
					+ ' WHERE  mncodmon = compra_moneda) , '' '')'
					+ ' ELSE ISNULL((SELECT mnglosa FROM View_Moneda '
					+ ' WHERE  mncodmon = venta_moneda), '' '') END), ' 
        
	SELECT @encabezado4 		= ' '
       		+  ' MontoOperacion 	= (CASE Tipo_operacion WHEN ''C'' THEN Compra_capital ELSE Venta_capital END), '		
       		+  ' TasaBase		= (CASE Tipo_operacion WHEN ''C'' THEN ' 
		+  ' Compra_valor_tasa ELSE Venta_valor_tasa END), '		


	SELECT @encabezado5 		= ' '
       		+  ' MontoConversion	= (CASE Tipo_operacion WHEN ''C'' THEN Venta_capital ELSE Compra_capital END), '		
       		+  ' TasaConversion	= (CASE Tipo_operacion WHEN ''C'' THEN '
		+ ' Venta_valor_tasa ELSE Compra_valor_tasa END), '		
       
	SELECT @encabezado6 		= ' '
       		+  ' Modalidad		= ISNULL((CASE Modalidad_Pago WHEN ''C'' THEN '
					+ ' ''COMPENSACION'' ELSE ''ENTREGA'' END),'' ''), '
		+  ' rutcli		= CONVERT(CHAR(9),rut_cliente),'


	SELECT @encabezado7 		= ' '
					+  'FormaPago	= (CASE Tipo_operacion WHEN ''C'' THEN ISNULL((SELECT glosa FROM view_forma_de_pago '


	SELECT @encabezado8 		= ' '
					+ ' WHERE  codigo = pagamos_documento) , '' '')'
					+ ' ELSE ISNULL((SELECT glosa FROM view_forma_de_pago '
					+ ' WHERE  codigo = recibimos_documento), '' '') END), ' 

        SELECT @encabezado9 		= ' '
					+  'FormaPago2	= (CASE Tipo_operacion WHEN ''V'' THEN ISNULL((SELECT glosa FROM view_forma_de_pago '


	SELECT @encabezado10 		= ' '
					+ ' WHERE  codigo = Pagamos_documento) , '' '')'
					+ ' ELSE ISNULL((SELECT glosa FROM view_forma_de_pago '
					+ ' WHERE  codigo = recibimos_documento), '' '') END) ' 

				 		
	/***********************************/
	/*              Tabla              */
	/***********************************/
		SELECT @Tabla  = ' FROM bacswapsuda.dbo.MovHistorico '



	/***********************************/
	/*     Filtro tipo de Swaps        */
	/***********************************/



	SELECT @Condi = ' '
	IF @tipoper = 1 OR @tipoper = 2 OR @tipoper = 3 BEGIN	-- Solo Operaciones de Tasas o Monedas
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
		SELECT @Condi  = @Condi  + @unir + ' numero_flujo <= 1 '
		SELECT @Condi1 = @Condi1 + @unir + ' numero_flujo <= 1 '
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
/*	SELECT @CondicionFech = " "
	IF @opcionfecha = 1 BEGIN	-- Fecha proceso
 		SELECT @CondicionFech =  @unir + " Fecha_Inicio = '" + @fecha1 + "' "

	END ELSE IF @opcionfecha = 2 BEGIN  -- Fecha de vencimiento
		SELECT @CondicionFech = @unir + " Fecha_termino = '" + @fecha2 + "'"

	END ELSE IF @opcionfecha = 3 BEGIN  -- Fecha Proceso entre fecha
		SELECT @CondicionFech = @unir + " ( Fecha_Inicio BETWEEN '" + @fecha1 + "' AND '" + @fecha2 + "') "   	

	END ELSE IF @opcionfecha = 4 BEGIN  -- Fecha de vencimiento entre fecha 
		SELECT @CondicionFech = @unir + " ( Fecha_termino BETWEEN '" + @fecha1 + "' AND '" + @fecha2 + "') "  	

	END */


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

	SELECT  @unecompra1	= ' UPDATE #paso_compras '
		+		  ' SET #paso_compras.MontoConversion = #paso_ventas.MontoConversion , '
		+		  ' #paso_compras.TasaConversion  = #paso_ventas.TasaConversion '
	        +		  ' FROM #paso_ventas '	

	SELECT  @unecompra2	= ' WHERE #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion AND '
		+		  ' #paso_ventas.Tipo_operacion = ''C'''


	SELECT  @uneventa1	= ' UPDATE #paso_compras '
		+		  ' SET #paso_compras.MontoOperacion = #paso_ventas.MontoOperacion , '
		+		  ' #paso_compras.TasaBase = #paso_ventas.TasaBase , '
		+		  ' #paso_compras.MonedaOperacion = #paso_ventas.MonedaOperacion , '
		

	SELECT  @uneventa2	= ' #paso_compras.NombreMoneda = #paso_ventas.NombreMoneda '
		+		  ' FROM #paso_ventas '
		+		  ' WHERE   #paso_compras.Numero_Operacion = #paso_ventas.Numero_Operacion AND '
		+		  ' #paso_ventas.Tipo_operacion = ''V'''


   EXECUTE ( @encabezadoc + @encabezado1 + @encabezado2 + @encabezado3 + @encabezado4 + @encabezado5 + @encabezado6 + @encabezado7 +  @encabezado8 + @encabezado9 + @encabezado10 + @tabla + @condi  + @condicionCli + @condicionMon + @condicionFech + @condicionOrden )
   EXECUTE ( @encabezadov + @encabezado1 + @encabezado2 + @encabezado3 + @encabezado4 + @encabezado5 + @encabezado6 + @encabezado7 +  @encabezado8 + @encabezado9 + @encabezado10 + @tabla + @condi1 + @condicionCli + @condicionMon + @condicionFech + @condicionOrden )


   EXECUTE (@unecompra1 + @unecompra2 )
   EXECUTE (@uneventa1  + @uneventa2  )  	

select 	 b.rutcli
	,'NomEmi' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = a.Rut_Cliente and clcodigo =a.Codigo_Cliente)
	,a.Id_Sistema
	,c.Descripcion
	,a.Rut_Cliente
	,a.Codigo_Cliente
	,'NomCli' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = a.Rut_Cliente and clcodigo =a.Codigo_Cliente)
	,a.NumeroOperacion
	,a.NumeroCorrelativo
	,a.Codigo_Producto
	,'Moneda' = (select mnnemo  from view_moneda where b.MonedaOperacion = mncodmon)	 --,'c'
	,a.MontoTransaccion
	,'Forma_Pago' =(CASE  WHEN b.Tipo_operacion ='C' THEN b.FormaPago2
					 ELSE b.FormaPago END) --,'c'
	,'FecVcto' =a.FechaVencimiento 
        ,'Grupo'= 'CLIENTE'
into #tempPCS
from  linea_transaccion a  
     ,#paso_compras b
     ,PRODUCTO_SISTEMA	c

where a.Id_Sistema ='PCS' AND    
      a.NumeroOperacion = b.Numero_Operacion	AND
      a.Id_Sistema = c.Id_Sistema	AND
      b.swap = c.Codigo_Producto        AND
      a.FechaVencimiento = @nfechaVcto



    insert into #TEMP_LINEAS select *  from #tempPCS ---WHERE FecVcto = @nfechaVcto 



--------------------------------------------Swap-----------------------------------------------------


--------------------------------------------BEX-----------------------------------------------------



 DECLARE @fecantBEX	DATETIME
 DECLARE @fecprocBEX	DATETIME


      SELECT @fecantBEX =acfecante,   -- '20040708', --'20040702' ,--
             @fecprocBEX= acfecproc   -- '20040709'  --'20040705' -- 
      FROM bacbonosextsuda.dbo.text_arc_ctl_dri




select 	'rutemisor' = case when (b.motipoper  = 'CP' OR  b.motipoper  = 'VP' ) then b.morutemi 
	      		   else b.morutcli end
	,'NomEmi' = isnull(case when (b.motipoper  = 'CP' OR b.motipoper = 'VP' ) then (select emnombre  from bacparamsuda.dbo.emisor where emrut = b.morutemi)
			 else (select clnombre  from bacparamsuda.dbo.cliente where clrut = b.morutcli) end,'')
	,a.Id_Sistema
	,c.Descripcion
	,a.Rut_Cliente
	,a.Codigo_Cliente
	,'NomCli' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut =b.morutcli and clcodigo =b.mocodcli)
	,a.NumeroOperacion
	,a.NumeroCorrelativo
	,a.Codigo_Producto
	,'Moneda' = (select mnnemo  from view_moneda where b.momonemi = mncodmon)	 	 --,'c'
	,a.MontoTransaccion
	,'FormaPago' = ISNULL( (select glosa from view_forma_de_pago where  b.forma_pago =codigo),'') --,'c'
	,'FecVcto' = a.FechaVencimiento
        ,'Grupo'= 'EMISOR'
into #tempBEXpaso
from  linea_transaccion a  
     ,bacbonosextsuda.dbo.text_mvt_dri b
     ,PRODUCTO_SISTEMA	c

where a.Id_Sistema ='BEX' AND    
      a.NumeroOperacion = b.monumoper	AND
      a.Id_Sistema= c.Id_Sistema	AND
      case when b.motipoper='CP'then 'CPX' else 'VPX' end = c.Codigo_Producto AND
      a.FechaVencimiento = @nfechaVcto

group  by a.NumeroOperacion 
	 ,b.morutemi
	 ,a.Id_Sistema
	 ,c.Descripcion
	 ,a.Rut_Cliente	 
	 ,a.Codigo_Cliente
	 ,b.momonemi 
	 ,b.morutemi
	 ,b.motipoper 
	 ,b.morutcli
	 ,b.mocodcli
  	 ,a.MontoTransaccion
  	 ,b.forma_pago 
	 ,a.FechaVencimiento
	 ,a.NumeroCorrelativo
	 ,a.Codigo_Producto


select *   into  #tempBEX  from #tempBEXpaso where Codigo_Producto <> 'CPX' 
delete #tempBEXpaso where Codigo_Producto <> 'CPX' 




insert into #tempBEX
Select  'rutemisor' = isnull(b.rsrutemis,0)
	,'NomEmi' = (select emnombre from bacparamsuda.dbo.emisor where emrut = b.rsrutemis)
	,a.Id_Sistema
	,c.Descripcion
	,a.Rut_Cliente
	,a.Codigo_Cliente
	,'NomCli' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = a.Rut_Cliente and clcodigo =a.Codigo_Cliente)
	,b.rsnumoper
	,b.rscorrelativo
	,a.Codigo_Producto
	,'Moneda' = (select mnnemo  from view_moneda where b.rsmonemi = mncodmon)		 --,'c'
	,b.rsflujo
	,'FormaPago' ='VCTO. CUPON' 
	,'FecVcto' = b.rsfecpro --b.rsfecucup
        ,'Grupo'= 'EMISOR'

from  --linea_transaccion a  
      linea_transaccion_detalle a  
     ,bacbonosextsuda..text_rsu b
     ,PRODUCTO_SISTEMA	c

where a.NumeroOperacion = b.rsnumoper	AND
      c.Id_Sistema = 'BEX'	AND
      c.Codigo_Producto='CPX'    AND
--      b.rsfecpro   = @fecprocBEX	AND
--      ( b.rsfecucup > @fecantBEX  AND	
--	b.rsfecucup <=@nfechaVcto ) AND
      b.rsfecpro  = @nfechaVcto	AND
      b.rstipoper	='VCP'  	


 

  insert into #TEMP_LINEAS select distinct *  from  #tempBEX where  FecVcto =@nfechaVcto /*(FecVcto >@fecantBEX  and
 					FecVcto <=@nfechaVcto ) */


--------------------------------------------BEX-----------------------------------------------------


--------------------------------------------BTR-----------------------------------------------------
 DECLARE @fecant	DATETIME
 DECLARE @fecproc	DATETIME



      SELECT @fecant =acfecante, -- '20040708' ,--
             @fecproc= acfecproc -- '20040709' --
      FROM BACTRADERSUDA.dbo.MDAC 




select 	'rutemisor' = case when (b.motipoper  = 'CP' OR  b.motipoper  = 'VP' ) then b.morutemi 
	      		   else b.morutcli end 
	,'NomEmi' = isnull(case when (b.motipoper  = 'CP' OR b.motipoper = 'VP' ) then (select emnombre  from bacparamsuda.dbo.emisor where emrut = b.morutemi)
			 else (select clnombre  from bacparamsuda.dbo.cliente where clrut = b.morutcli) end,'')
	,a.Id_Sistema
	,c.Descripcion
	,a.Rut_Cliente
	,a.Codigo_Cliente
	,'NomCli' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = b.morutcli and clcodigo =b.mocodcli)
	,a.NumeroOperacion
	,a.NumeroCorrelativo
	,a.Codigo_Producto
	,'Moneda' = (select mnnemo  from view_moneda where b.momonemi = mncodmon)		 --,'c'
	,a.MontoTransaccion
	,'FormaPago' = ISNULL( (select glosa from view_forma_de_pago where  b.moforpagi =codigo),'')	 --,'c'
	,'FecVcto' = a.FechaVencimiento
        ,'Grupo'= case when (b.motipoper  = 'CP' or b.motipoper  = 'VP') then 'EMISOR'
	      		   else 'CLIENTE' end
into #tempBTRpaso
from  linea_transaccion a  
     ,bactradersuda.dbo.mdmh b
     ,PRODUCTO_SISTEMA	c

where a.Id_Sistema ='BTR' AND    
      a.NumeroOperacion = b.monumoper	AND
      b.Id_Sistema = c.Id_Sistema	AND
      b.motipoper = c.Codigo_Producto   AND
      a.FechaVencimiento = @nfechaVcto

group  by a.NumeroOperacion 
	 ,a.Id_Sistema
	 ,c.Descripcion
	 ,a.Rut_Cliente
	 ,a.Codigo_Cliente	 
	 ,b.momonemi 
  	 ,a.MontoTransaccion
  	 ,b.moforpagi
	 ,b.morutemi
	 ,b.motipoper 
	 ,b.morutcli
	 ,b.mocodcli
	 ,a.FechaVencimiento
	 ,a.NumeroCorrelativo
         ,a.Codigo_Producto


select *   into  #tempBTR  from #tempBTRpaso where Codigo_Producto <> 'CP' 
delete #tempBTRpaso where Codigo_Producto <> 'CP' 




insert into  #tempBTR  
Select  'rutemisor' = isnull(b.rsrutemis,0)
	,'NomEmi' = (select emnombre from bacparamsuda.dbo.emisor where emrut = b.rsrutemis)
	,a.Id_Sistema
	,c.Descripcion
	,b.rsrutcli --a.Rut_Cliente
	,b.rscodcli --a.Codigo_Cliente
	,'NomCli' = (select Clnombre  from bacparamsuda.dbo.cliente where Clrut = b.rsrutcli and clcodigo =b.rscodcli)
	,b.rsnumoper
	,b.rscorrela
	,a.Codigo_Producto
	,'Moneda' = (select mnnemo  from view_moneda where b.rsmonemi = mncodmon)		 --,'c'
	,case when (select inmdse from  view_instrumento where incodigo = b.rscodigo)= 'N'then  rsvppresenx else (b.rsvppresen - b.rsvppresenx) end 
	,'FormaPago' ='VCTO. CUPON' 
	,'FecVcto' = b.rsfecha --b.rsfecucup
        ,'Grupo'= 'EMISOR'

from  --linea_transaccion a  
      linea_transaccion_detalle a  
     ,bactradersuda.dbo.mdrs b
     ,PRODUCTO_SISTEMA	c

where a.NumeroOperacion = b.rsnumoper	AND
      c.Id_Sistema = 'BTR'	AND
      c.Codigo_Producto='CP'    AND
--      b.rsfecha   = @fecproc	AND
--      ( b.rsfecucup > @fecant  AND	
--	b.rsfecucup <=@nfechaVcto ) AND
      b.rsfecha   = @nfechaVcto	AND
      b.rstipoper	='VC'  	AND
      b.rstipopero	='CP'  		





  insert into #TEMP_LINEAS select distinct *  from  #tempBTR where FecVcto =@nfechaVcto 

--------------------------------------------BTR-----------------------------------------------------

        
	SELECT  'ENTIDAD'=(SELECT rcnombre  FROM VIEW_ENTIDAD),
		'FECHA'=(SELECT acfecproc  FROM VIEW_MDAC),
                'FECHAPAGO'= case when Sistema ='BEX' OR  Sistema ='BTR'THEN (SELECT fecha_valuta_Ent  FROM bacparamsuda.dbo.CTACTEBCCH b WHERE a.Numero_Operacion=b.numero_operacion and  b.tipo_operacion in('VC','VCP'))ELSE Fecha_Venc END,
		*  FROM #TEMP_LINEAS a
SET NOCOUNT OFF
END
-- Sp_Rpt_Vctos_Lineas_Ope '20040812'
-- Sp_Rpt_Vctos_Lineas_Ope '20040816'
-- Sp_Rpt_Vctos_Lineas_Ope '20040201'
-- SELECT *  FROM  BACPARAMSUDA..CTACTEBCCH WHERE numero_operacion=103659
-- SELECT *  FROM  linea_transaccion WHERE numerooperacion=103659
-- select *  from mdrs where  rsfecha ='20040831' and  rsnumoper =47833
-- select *  from view_noserie where  nsnumdocu =47833
-- select *  from view_noserie ,mdrs   where rsnumoper =nsnumdocu and rscorrela =nscorrela   and nsfecven = '20040831' and rstipoper ='vc'
-- select *  from  view_instrumento
GO
