USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_ART84_DERIVADOS_MAP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
          drop table   #TempArt84
          CREATE TABLE #TempArt84
          (
          RutDeudor     CHAR (15)      ,                        -- 1
          Modulo        CHAR (10)      ,                        -- 2
          Tipoper       CHAR (10)      ,                        -- 3  
          Moneda        NUMERIC (05)   ,                        -- 4
          Monto         NUMERIC(18) NULL DEFAULT (0),           -- 5
          Fec_Proc      CHAR (08) --DATETIME                                   -- 6 
          )



        INSERT INTO  #TempArt84
         EXECUTE Sp_Calcula_Art84_Derivados_MAP '20090220'



         SELECT RutDeudor
               ,Modulo
               ,Tipoper
               ,RIGHT('000000000000000000'+CONVERT(VARCHAR(118),SUM(Monto)),18)-- SUM(Monto)
               ,Fec_Proc
         FROM #TempArt84    
         GROUP BY  RutDeudor
                  ,Modulo
                  ,Tipoper
                  ,Fec_Proc 
         ORDER BY RutDeudor
*/
--select * into ART84_DERIVADOS_20Feb2009 from ART84_DERIVADOS
CREATE PROCEDURE [dbo].[SP_CALCULA_ART84_DERIVADOS_MAP]
   (   @Fecha       DATETIME   
   ) 
-- Sp_Calcula_Art84_Derivados '20090220'      
AS  
BEGIN
	SET NOCOUNT ON

	DECLARE  @fecpro              DATETIME       
               , @fecproPCS           DATETIME       
               , @fecproBFW           DATETIME       


       	SELECT	@fecproPCS           = fechaproc       
	FROM	BacSwapSuda..SwapGeneral


        SELECT	@fecproBFW           = acfecproc 
	FROM	BacFwdSuda..MFAC


   IF EXISTS(SELECT 1 FROM ART84_DERIVADOS WHERE Fecha_Proc = @Fecha OR (@fecproPCS =  @Fecha OR @fecproBFW =  @Fecha))
   BEGIN 
             DELETE ART84_DERIVADOS  WHERE  Fecha_Proc = @Fecha
   END
          



-- Valor Moneda para fecha parámetro
   --> 06 Junio 2008 (Solicitado por Carlos Basterrica)
   SELECT vmfecha, vmcodigo, vmvalor
     INTO #TMP_VALOR_MONEDA_ART84_DERIVADOS
     FROM BacParamSuda..VALOR_MONEDA
    WHERE vmFecha    = @Fecha
      and vmcodigo   IN(995,997,998)

   INSERT INTO #TMP_VALOR_MONEDA_ART84_DERIVADOS
      SELECT @Fecha, 999, 1.0


   INSERT INTO #TMP_VALOR_MONEDA_ART84_DERIVADOS
      SELECT @Fecha, codigo_moneda , tipo_cambio
      FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
      WHERE  fecha          = @Fecha
      AND    codigo_moneda  NOT IN(13,994,995,997,998,999)
      AND    tipo_cambio   <> 0.0


   INSERT INTO #TMP_VALOR_MONEDA_ART84_DERIVADOS
      SELECT @Fecha, 13, tipo_cambio
      FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   
      WHERE  fecha         = @Fecha
      AND    codigo_moneda = 994
   --> 06 Junio 2008 (Solicitado por Carlos Basterrica)


-- Swap

   SELECT 'Numero_operacion'    = CONVERT(NUMERIC(10),Numero_operacion)
        , 'rut_cliente'         = rut_cliente
        , 'codigo_cliente'      = codigo_cliente
        , 'Nocional'            = CASE tipo_flujo WHEN 1 THEN compra_capital ELSE venta_capital END
        , 'fecha_Cierre'        = fecha_Cierre
        , 'fecha_inicio'        = fecha_inicio
        , 'Tir' 		= CONVERT(FLOAT,0.0)
        , 'Moneda'              = CONVERT(NUMERIC(05),(CASE tipo_flujo WHEN 1 THEN Compra_moneda ELSE venta_moneda END))
        , 'Producto' 	        = tipo_swap
        , 'Valor_Razonable_CLP' = CONVERT(FLOAT, Valor_RazonableCLP)
        , 'fecha_termino'       = fecha_termino   
	, 'Fecha'               = @fecproPCS	
   INTO #CARTERAPCS 
   FROM BacSwapSuda..CARTERA    with(nolock) 
   WHERE Estado             <> 'C'
   AND   tipo_Flujo         =  1
   union
   SELECT 'Numero_operacion'    = Numero_operacion
        , 'rut_cliente'         = rut_cliente
        , 'codigo_cliente'      = codigo_cliente
        , 'Nocional'            = CASE tipo_flujo WHEN 1 THEN compra_capital ELSE venta_capital END
        , 'fecha_Cierre'        = fecha_Cierre
        , 'fecha_inicio'        = fecha_inicio
        , 'Tir' 		= CONVERT(FLOAT,0.0)            
        , 'Moneda'              = CONVERT(NUMERIC(05),(CASE tipo_flujo WHEN 1 THEN Compra_moneda ELSE venta_moneda END))
        , 'Producto' 	        = tipo_swap
        , 'Valor_Razonable_CLP' = CONVERT(FLOAT, Valor_RazonableCLP)
        , 'fecha_termino'       = fecha_termino   
	, 'Fecha'               = @Fecha
   FROM BacSwapSuda..CARTERARES with(nolock) 
   WHERE fecha_proceso    = @Fecha
   AND Estado             <> 'C'
   AND tipo_Flujo         =  1


   IF @Fecha <> @fecproPCS     
       DELETE  FROM  #CARTERAPCS  WHERE  Fecha = @fecproPCS

      SELECT DISTINCT
             'Numope'  		= numero_operacion
         ,   'Correla' 		= 0
         ,   'Modulo'  		= 'PCS'
         ,   'Fec_Proc'		= @Fecha
         ,   'rut_cliente'   	= rut_cliente
         ,   'codigo_cliente'   = codigo_cliente
         ,   'Instrumento'	= ' '
         ,   'Mascara'  	= ' '
         ,   'Nocional'         = CONVERT(FLOAT, Nocional)
	 ,   'fecha_Cierre'     = fecha_Cierre
         ,   'fecha_inicio'     = fecha_inicio
	 ,   'Seriado'		= ' '				
 	 ,   'Codigo'		= 0			
	 ,   'Tir'		= CONVERT(FLOAT, 0.0)
     	 ,   'Moneda'		= CONVERT(NUMERIC(05),Moneda)
	 ,   'Producto'	        = CONVERT(NUMERIC(05),Producto)
	 ,   'Monto1'		= CONVERT(FLOAT, Valor_Razonable_CLP)
 	 ,   'Vigencia_Dias'	= DATEDIFF(DAY, @fecha, fecha_termino)   -- Para que el histórico sirva como histórico
       INTO #TEMPCART
       FROM #CARTERAPCS


-- Forward

   SELECT 'Numero_operacion'    = canumoper
        , 'rut_cliente'         = cacodigo
        , 'codigo_cliente'      = cacodcli 
        , 'Nocional'            = camtomon1
        , 'fecha_Cierre'        = cafecha
        , 'fecha_inicio'        = fechaemision
        , 'Tir' 		= CONVERT(FLOAT,catasaufclp)
        , 'Moneda'              = CONVERT(NUMERIC(05),cacodmon1)
        , 'Producto' 	        = CONVERT(NUMERIC(05),cacodpos1)
        , 'Valor_Razonable_CLP' = CONVERT(FLOAT, fRes_Obtenido)
        , 'fecha_termino'       = cafecvcto   
	, 'Fecha'               = @fecproBFW
   INTO #CARTERABFW
   FROM BacFwdSuda..MFCA with(nolock)
--   WHERE cafecvcto >= @Fecha
   union
   SELECT 'Numero_operacion'    = canumoper
        , 'rut_cliente'         = cacodigo
        , 'codigo_cliente'      = cacodcli 
        , 'Nocional'            = camtomon1
        , 'fecha_Cierre'        = cafecha
        , 'fecha_inicio'        = fechaemision
        , 'Tir' 		= CONVERT(FLOAT,catasaufclp)
        , 'Moneda'              = CONVERT(NUMERIC(05),cacodmon1)
        , 'Producto' 	        = CONVERT(NUMERIC(05),cacodpos1)
        , 'Valor_Razonable_CLP' = CONVERT(FLOAT, fRes_Obtenido)
        , 'fecha_termino'       = cafecvcto   
	, 'Fecha'               = @Fecha
   FROM BacFwdSuda..MFCARES with(nolock) 
   WHERE CaFechaProceso    = @Fecha
--   AND cafecvcto >= @Fecha

   IF @Fecha <> @fecproBFW     
       DELETE  FROM  #CARTERABFW  WHERE  Fecha = @fecproBFW

     INSERT INTO #TEMPCART
      SELECT DISTINCT
             'Numope'  		= numero_operacion
         ,   'Correla' 		= 0
         ,   'Modulo'  		= 'BFW'
         ,   'Fec_Proc'		= @Fecha
         ,   'rut_cliente'   	= rut_cliente
         ,   'codigo_cliente'   = codigo_cliente
         ,   'Instrumento'	= ' '
         ,   'Mascara'  	= ' '
         ,   'Nocional'         = CONVERT(FLOAT, Nocional)
	 ,   'fecha_Cierre'     = fecha_Cierre
         ,   'fecha_inicio'     = fecha_inicio
	 ,   'Seriado'		= ' '				
 	 ,   'Codigo'		= 0			
    	 ,   'Tir'		= Tir 
     	 ,   'Moneda'		= CONVERT(NUMERIC(05),Moneda)
	 ,   'producto'	        = CONVERT(NUMERIC(05),Producto)
	 ,   'Monto1'		= CONVERT(FLOAT, Valor_Razonable_CLP)
 	 ,   'Vigencia_Dias'	= DATEDIFF(DAY, @fecha, fecha_termino) --18
       FROM #CARTERABFW


-- Swap


	SELECT	 DISTINCT
                 NumOpe    
		,Correla     
		,Modulo  
		,Fec_Proc            
		,rut_cliente 
             ,codigo_cliente 
		,Instrumento 
		,Mascara 
		,Nocional
		,fecha_Cierre                
		,fecha_inicio                
		,Seriado 
		,Codigo      
		,Tir                   
		,'Moneda'       = CONVERT(NUMERIC(05),Moneda)
		,'Producto'     = CONVERT(NUMERIC(05),Producto)
                ,C.Descripcion
		,Monto1
		,Vigencia_Dias
                ,'Valor_Moneda' = convert(float,vmvalor)
                ,'Nocional_CLP' = convert(float, Nocional * vmvalor )
                ,'Factor'       = convert(float,(ISNULL(Factor1,0.0))) 
        INTO    #TEMP_RES
	FROM	#TEMPCART 
        ,       #TMP_VALOR_MONEDA_ART84_DERIVADOS
	,	BACPARAMSUDA..MONEDA
	,	BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS
        ,       BACPARAMSUDA..Producto			C
        ,       BACPARAMSUDA..Riesgo_Normativo          A
        ,       BACPARAMSUDA..Matriz_Riesgo_Normativo   B 
	WHERE	producto		NOT IN (2)	
	AND	vmfecha			   =  @Fecha 
	AND	vmcodigo		   =  moneda 
	AND	mncodmon		   =  moneda
	AND	Acrp_CodigoClasificacion   =  mnClasificaRiesgoPais
 	AND	Modulo   		   =  'PCS'
	AND	codigo_producto		   =  (CASE WHEN producto = 1 THEN 'ST' 
			   	           WHEN producto = 2 THEN 'SM'
		            		            WHEN producto = 3 THEN 'FR'
		                               WHEN producto = 4 THEN 'SP'
                		              END)
        AND     Riesgo_Normativo           =  A.Codigo_Riesgo
        AND     A.Codigo_Riesgo     	   =  B.Codigo_Riesgo	
	AND	Vigencia_Dias BETWEEN B.Plazo_Desde AND B.Plazo_Hasta 



        INSERT INTO #TEMP_RES
	SELECT DISTINCT
     		 NumOpe    
		,Correla     
		,Modulo 
		,Fec_Proc                    
		,rut_cliente 
                ,codigo_cliente 
		,Instrumento 
		,Mascara 
		,Nocional               
		,fecha_Cierre                
		,fecha_inicio                
		,Seriado 
		,Codigo      
		,Tir                   
		,CONVERT(NUMERIC(05),Moneda)
		,CONVERT(NUMERIC(05),producto )
		,C.Descripcion
		,Monto1
		,Vigencia_Dias
                ,'Valor_Moneda' = vmvalor
                ,'Nocional_CLP' = Nocional * vmvalor 
                ,'Factor'       = (CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Factor1,0.0) ELSE ISNULL(Factor2,0.0) END) 
	FROM	#TEMPCART 
        ,       #TMP_VALOR_MONEDA_ART84_DERIVADOS
	,	BACPARAMSUDA..MONEDA
	,	BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS
        ,       BACPARAMSUDA..Producto			C
        ,       BACPARAMSUDA..Riesgo_Normativo 		A
        ,       BACPARAMSUDA..Matriz_Riesgo_Normativo   B
	WHERE	producto		   = 2	
	AND	vmfecha			   =  @Fecha  
	AND	vmcodigo		   =  moneda 
	AND	mncodmon		   =  moneda
	AND	Acrp_CodigoClasificacion   =  mnClasificaRiesgoPais
 	AND	Modulo  		   =  'PCS'

	AND	codigo_producto		   =  (CASE WHEN producto = 1 THEN 'ST' 
			   	                    WHEN producto = 2 THEN 'SM'
		            		            WHEN producto = 3 THEN 'FR'
		                                    WHEN producto = 4 THEN 'SP'
                		              END)

        AND     Riesgo_Normativo           =  A.Codigo_Riesgo
        AND     A.Codigo_Riesgo     	   =  B.Codigo_Riesgo	
	AND	Vigencia_Dias BETWEEN B.Plazo_Desde AND B.Plazo_Hasta 


-- Forward

        INSERT INTO #TEMP_RES
	SELECT	  NumOpe    
		,Correla     
		,Modulo 
		,Fec_Proc                    
		,rut_cliente 
		,codigo_cliente
		,Instrumento 
		,Mascara 
		,Nocional               
		,fecha_Cierre                
		,fecha_inicio                
		,Seriado 
		,Codigo      
		,Tir                   
		,CONVERT(NUMERIC(05),Moneda)
		,CONVERT(NUMERIC(05),producto )
		,C.Descripcion
		,Monto1
		,Vigencia_Dias
                ,'Valor_Moneda' = vmvalor
                ,'Nocional_CLP' = Nocional * vmvalor 
                ,'Factor'       = (CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Factor1,0.0) ELSE ISNULL(Factor2,0.0) END) 
	FROM	#TEMPCART 
        ,       #TMP_VALOR_MONEDA_ART84_DERIVADOS
	,	BACPARAMSUDA..MONEDA
	,	BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS
        ,       BACPARAMSUDA..Producto			C
        ,       BACPARAMSUDA..Riesgo_Normativo          A
        ,       BACPARAMSUDA..Matriz_Riesgo_Normativo   B 
	WHERE	producto			NOT IN (10,11)		 
	AND	vmfecha				=  @Fecha
	AND	vmcodigo			=  moneda 
	AND	mncodmon			=  moneda
	AND	Acrp_CodigoClasificacion	=  mnClasificaRiesgoPais
 	AND	Modulo   			=  'BFW'
	AND	codigo_producto			=  CONVERT(CHAR(05),producto)
        AND     Riesgo_Normativo                =  A.Codigo_Riesgo
        AND     A.Codigo_Riesgo     		=  B.Codigo_Riesgo	
	AND	Vigencia_Dias BETWEEN Plazo_Desde AND Plazo_Hasta



        INSERT INTO #TEMP_RES
	SELECT	 NumOpe    
		,Correla     
		,Modulo 
		,Fec_Proc                    
		,rut_cliente 
		,codigo_cliente
		,Instrumento 
		,Mascara 
		,Nocional
		,fecha_Cierre                
		,fecha_inicio                
		,Seriado 
		,Codigo    
		,Tir                   
		,Moneda 
		,producto 
		,C.Descripcion
		,Monto1
		,Vigencia_Dias
     ,'Valor_Moneda' = vmvalor
                ,'Nocional_CLP' = Nocional * vmvalor 
       ,'Factor'       = ISNULL(Factor1,0.0) 
	FROM	#TEMPCART
        ,       #TMP_VALOR_MONEDA_ART84_DERIVADOS
	,	BACPARAMSUDA..MONEDA
	,	BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS
        ,       BACPARAMSUDA..Producto			C	
        ,       BACPARAMSUDA..Riesgo_Normativo          A
        ,       BACPARAMSUDA..Matriz_Riesgo_Normativo   B 
	WHERE	producto			in  (10,11)		 
	AND	vmfecha				=  @Fecha
	AND	vmcodigo			=  moneda 
	AND	mncodmon			=  moneda
	AND	Acrp_CodigoClasificacion	=  mnClasificaRiesgoPais
 	AND	Modulo   			=  'BFW'
	AND	codigo_producto			=  CONVERT(CHAR(05),producto)
        AND     Riesgo_Normativo                =  A.Codigo_Riesgo
        AND     A.Codigo_Riesgo     		=  B.Codigo_Riesgo	
	AND	Vigencia_Dias BETWEEN Plazo_Desde AND Plazo_Hasta


     

     IF NOT EXISTS(SELECT 1 FROM ART84_DERIVADOS WHERE Fecha_Proc = @Fecha)
     BEGIN
        INSERT INTO ART84_DERIVADOS
        SELECT   Fec_Proc                    
                ,NumOpe    
		,Correla     
		,Modulo 		
		,rut_cliente 
                ,codigo_cliente
		,Instrumento 
		,Mascara 
		,Nocional     
		,fecha_Cierre                
		,fecha_inicio                
		,Seriado 
		,Codigo      
		,Tir                   
		,Moneda 
		,producto 
		,Descripcion
		,Monto1
		,Vigencia_Dias
                ,Valor_Moneda 
                ,Nocional_CLP     
                ,Factor       
                ,0.0
                ,0.0
                ,0.0
                ,Nocional_CLP *  (Factor/100)
                ,''
         FROM #TEMP_RES 
            , BACPARAMSUDA..Cliente 
         WHERE rut_cliente = Clrut
          and  codigo_cliente = ClCodigo
         -- Comentario MAP En esto se pudo haber cargado compensación bilateral
     END
  

   IF @@ROWCOUNT <> 0
   BEGIN

          -- Comentario MAP se informa el rut del padre que, por contingencia se asumirá que será 1 
          SELECT  'rut_cliente'= rut_cliente -- Todos informan directamente, las AFP suman
                , 'Codigo_Cliente' = 1  -- MAP 20090223, esto se debe generalizar sin afectar perfomance
                , 'Modulo' = 'Forward'
                , 'Tipoper'= 'FWD'  
                , 'Moneda' = 999
                , 'Monto'  = CONVERT (FLOAT,AVR)
                , 'Monto2'  = CONVERT(FLOAT,(CASE WHEN (AVR <= 0.0) THEN 0.0 ELSE AVR END))
                , 'Nocional_x_Factor' = Monto_Matriz 
                , 'Fecha_Proc' = @Fecha
                , 'CompBilateral' = ' ' -- ClCompBilateral -- MAP 20090223 Después obtendremos este dato
                , 'Mto_Final'  = CONVERT(FLOAT,0.0)
                , 'AVR' = AVR
                , 'Monto_Matriz' = Monto_Matriz
                 
          INTO  #TEMP_DERIVADOS_ALL
          FROM  ART84_DERIVADOS 
 WHERE Fecha_Proc      = @Fecha
	  
          -- MAP 20090223 Queda grabado el Rut del padre, por tanto consultamos por el padre
          update #TEMP_DERIVADOS_ALL
                 set CompBilateral = isnull( ( select ClCompBilateral from BACPARAMSUDA..Cliente where clrut = rut_cliente and clcodigo = Codigo_Cliente ), 'N' )



          -- MAP MAP 20090223 Hasta ahora tenemos todos los contratos a nombre del rut que corresponde, ei. del padre si hay padre
          -- en la tabla #TEMP_DERIVADOS_ALL

          -- Comentario MAP se informa el rut del padre que, por contingencia se asumirá que será 1 
          SELECT  'rut_cliente'= rut_cliente 
                , 'Codigo_Cliente' = Codigo_cliente
                , 'Modulo' = 'Forward'
                , 'Tipoper'= 'FWD'  
                , 'Moneda' = 999
                , 'Monto'  = CONVERT (FLOAT,AVR)
                , 'Monto2'  = CONVERT(FLOAT,(CASE WHEN (AVR <= 0.0) THEN 0.0 ELSE AVR END))
                , 'Nocional_x_Factor' = Monto_Matriz 
                , 'Fec_Proc' = @Fecha
                , 'CompBilateral' = CompBilateral 
                , 'Mto_Final'  = CONVERT(FLOAT,0.0)
          INTO  #TEMP_DERIVADOS
          FROM  #TEMP_DERIVADOS_ALL 
          WHERE   Fecha_Proc      = @Fecha
              and CompBilateral   = 'N'


          INSERT INTO #TEMP_DERIVADOS
          SELECT  'rut_cliente'= rut_cliente
                , 'Codigo_Cliente' = 1 --Codigo_Cliente  
                , 'Modulo' = 'Forward'
                , 'Tipoper'= 'FWD'  
                , 'Moneda' = 999
                , 'Monto'  = CONVERT (FLOAT,SUM(CASE WHEN (AVR <= 0.0) THEN 0.0 ELSE AVR END))
                , 'Monto2'  = CONVERT (FLOAT,(CASE WHEN (SUM(AVR)<=0.0) THEN 0.0 ELSE SUM(AVR) END))
                , 'Nocional_x_Factor' =SUM(Monto_Matriz) 
                , 'Fec_Proc' = @Fecha
                , 'CompBilateral' = CompBilateral
                , 'Mto_Final'  = CONVERT(FLOAT,0.0)          
          FROM  #TEMP_DERIVADOS_ALL
          WHERE CompBilateral ='S'
          AND   Fecha_Proc      = @Fecha
          GROUP BY rut_cliente                
                , CompBilateral
                , Fecha_Proc


          UPDATE #TEMP_DERIVADOS 
          SET Mto_Final = CASE WHEN  CompBilateral = 'N' THEN Monto2 + Nocional_x_Factor 
                              ELSE   Monto2 + Nocional_x_Factor  * (CASE WHEN Monto =0.0 THEN 1 ELSE (0.4 + 0.6 *(Monto2/Monto ))END)
             	             END	

	  -- select * from #TEMP_DERIVADOS where rut_cliente = 98000400
          -- Hasta aquí salen bien las operaciones, con todos los 
          -- calculos bien hechos 


          UPDATE ART84_DERIVADOS 
          SET  Sum_AVR_Positivo = Monto
             , Max_Sum_AVR_Cero = Monto2
             , Acu_Comp_Bilateral = CompBilateral		 
          FROM #TEMP_DERIVADOS 
          WHERE     ART84_DERIVADOS.rut_cliente = #TEMP_DERIVADOS.rut_cliente
--                And ART84_DERIVADOS.Fec_Proc = @Fecha
               

          SELECT rut_cliente
               , Equiv_Credito  = SUM(Mto_Final) 
          INTO #Temp_Equiv_Cred
          FROM #TEMP_DERIVADOS 
          GROUP BY rut_cliente



          UPDATE ART84_DERIVADOS 
          SET    ART84_DERIVADOS.Equiv_Credito  = A.Equiv_Credito      
          FROM #Temp_Equiv_Cred A
          WHERE  A.rut_cliente = ART84_DERIVADOS.rut_cliente
          
  

 
         SELECT (rtrim(convert(numeric(12),clrut)) ) + cldv   -- Ojo con disitnc funciona pero omite operaciones por ser iguales...
               ,Modulo
               ,Tipoper
               ,Moneda
               ,ROUND(ISNULL(Mto_Final,0.0),0.0) 
               ,CONVERT( CHAR(08),Fec_Proc,112)                
         FROM  #TEMP_DERIVADOS 
          , BACPARAMSUDA..CLIENTE 
         WHERE  Clrut = rut_cliente  and clCodigo = 1         -- MAP 20090223 Falta hacer que funcione para clientes principales con
                                                           -- ClCodigo <> 1

   END

	SET NOCOUNT OFF
END

GO
