USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_BASILEA_DERIVADOS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_BASILEA_DERIVADOS]    
                      @FECHA DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

	 
    /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD SWAP                                           */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_REPORTE_BASILEA_DERIVADOS '2015-12-30'
	 
   
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES PATA                                               */
   /*-----------------------------------------------------------------------------*/
     DECLARE @A_FRECUENCIA_PAGO    INT
			,@P_FRECUENCIA_PAGO    INT
			,@A_INDICADOR          INT
			,@P_INDICADOR          INT
			,@A_TIPO_TASA          VARCHAR(20)
			,@P_TIPO_TASA          VARCHAR(20)
			,@A_COD_MONEDA         CHAR(03)
			,@P_COD_MONEDA         CHAR(03)
			,@A_MONEDA_STR         CHAR(03)
			,@P_MONEDA_STR         CHAR(03)


   /*-----------------------------------------------------------------------------*/
   /* CODIGO DE TASAS                                                             */
   /*-----------------------------------------------------------------------------*/
      DECLARE @CODIGO_TASA  TABLE
	        (CODIGO         VARCHAR(10)
			,GLOSA          VARCHAR(100))



   /*-----------------------------------------------------------------------------*/
   /* FRECUENCIA DE PAGO                                                          */
   /*-----------------------------------------------------------------------------*/
      DECLARE @FRECUENCIA_PAGO TABLE
	        (CODIGO         INT
			,GLOSA          VARCHAR(100)
			,DIAS           FLOAT
			,MESES          FLOAT )

      INSERT INTO @FRECUENCIA_PAGO
	  EXEC BACSWAPSUDA.DBO.SP_LEER_PERIODO 1044,'PCS'



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE INTERFAZ                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @INT_Ano_Mes_de_Referencia                         DATETIME
            ,@INT_Codigo_Agrupamiento_Producto                  VARCHAR(05)
            ,@INT_Codigo_Operacion                              NUMERIC
            ,@INT_Codigo_Producto                               VARCHAR(20)
            ,@INT_Codigo_Moneda_Original_Operacion              VARCHAR(03)
            ,@INT_Codigo_Indice_Economico_Activo                VARCHAR(05)
            ,@INT_Codigo_Indice_Economico_Pasivo                VARCHAR(05)
            ,@INT_Indicador_Derivados_Flujo_Caja                VARCHAR(01)
            ,@INT_Numero_Identificacion_Camara_Compensacion     VARCHAR(05)
            ,@INT_Codigo_Operacion_Garantizada                  VARCHAR(05)
            ,@INT_Agencia                                       VARCHAR(05)
            ,@INT_Codigo_Pais_Contraparte                       VARCHAR(05)
            ,@INT_Indicador_Prote_Renegociacion                 VARCHAR(05)
            ,@INT_Indicador_Proteccion							VARCHAR(05)
            ,@INT_Valor_Minimo_Ejecucion_Garantia				VARCHAR(05)
            ,@INT_Indicador_Tipo_Cobertura						VARCHAR(05)
            ,@INT_Numero_Default_Ejecucion_derivado_Credito		VARCHAR(05)
            ,@INT_Codigo_Indicador_Grupo_Operacion_Cubierta		VARCHAR(05)
            ,@INT_Valor_Premio_en_Apertura						VARCHAR(05)
            ,@INT_Indicador_Clausula_Insolvencia				VARCHAR(05)
            ,@INT_Orden_Cobertura_Garantia						VARCHAR(05)
            ,@INT_Valor_Maximo_Cobertura_Garantia				VARCHAR(05)
            ,@INT_Porcentaje_Maximo_Cobertura_Garantizada		VARCHAR(05)
            ,@INT_Indicador_Default_Operacion_Garantizada		VARCHAR(05)
            ,@INT_Rating_De_Operacion_Garantizada				VARCHAR(05)
            ,@INT_Nombre_Referencia								VARCHAR(05)
            ,@INT_CNJP_Referencia								VARCHAR(05)
            ,@INT_Spread										VARCHAR(05)
            ,@INT_Frecuencia_Spread								VARCHAR(05)
            ,@INT_Mesa_gestion									VARCHAR(20)

            




   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE INTERFAZ                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	        (Ano_Mes_de_Referencia                         DATETIME
            ,Codigo_Agrupamiento_Producto                  VARCHAR(05)
            ,Codigo_Operacion                              NUMERIC
            ,Codigo_Producto                               VARCHAR(20)
            ,Codigo_Moneda_Original_Operacion              VARCHAR(03)
            ,Codigo_Indice_Economico_Activo                VARCHAR(05)
            ,Codigo_Indice_Economico_Pasivo                VARCHAR(05)
            ,Indicador_Derivados_Flujo_Caja                VARCHAR(01)
            ,Numero_Identificacion_Camara_Compensacion     VARCHAR(05)
            ,Codigo_Operacion_Garantizada                  VARCHAR(05)
            ,Agencia                                       VARCHAR(05)
            ,Codigo_Pais_Contraparte                       VARCHAR(05)
            ,Indicador_Prote_Renegociacion                 VARCHAR(05)
            ,Indicador_Proteccion						   VARCHAR(05)
            ,Valor_Minimo_Ejecucion_Garantia			   VARCHAR(05)
            ,Indicador_Tipo_Cobertura					   VARCHAR(05)
            ,Numero_Default_Ejecucion_derivado_Credito	   VARCHAR(05)
            ,Codigo_Indicador_Grupo_Operacion_Cubierta	   VARCHAR(05)
            ,Valor_Premio_en_Apertura					   VARCHAR(05)
            ,Indicador_Clausula_Insolvencia				   VARCHAR(05)
            ,Orden_Cobertura_Garantia					   VARCHAR(05)
            ,Valor_Maximo_Cobertura_Garantia			   VARCHAR(05)
            ,Porcentaje_Maximo_Cobertura_Garantizada	   VARCHAR(05)
            ,Indicador_Default_Operacion_Garantizada	   VARCHAR(05)
            ,Rating_De_Operacion_Garantizada			   VARCHAR(05)
            ,Nombre_Referencia							   VARCHAR(05)
            ,CNJP_Referencia							   VARCHAR(05)
            ,Spread										   VARCHAR(05)
            ,Frecuencia_Spread							   VARCHAR(05)
            ,Mesa_gestion								   VARCHAR(20))
   


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES PARA OPERACIONES                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERADOR             VARCHAR(40)
			,@PAIS                 INT
			,@PERIODO_FRECUENCIA   INT
			,@MODALIDAD            CHAR(01)
			,@AGENCIA              VARCHAR(50)
			,@COD_PAIS             VARCHAR(5)


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES CURSOR OPERACIONES                                 */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPE_NUMERO_OPERACION NUMERIC
   


   /*-----------------------------------------------------------------------------*/
   /* TABLA OPERACIONES CARTERA                                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERACIONES TABLE
	 (OPERACION         NUMERIC
	 ,TIPO_FLUJO        INT
	 ,TIPO_SWAP         INT
	 ,RUT_CLIENTE       NUMERIC
	 ,COD_CLIENTE       INT
	 ,FECHA_CIERRE      DATETIME
	 ,FECHA_INICIO      DATETIME
	 ,FECHA_TERMINO     DATETIME
	 ,FECHA_VENCIMIENTO DATETIME
	 ,NOMINAL           NUMERIC(25,4)
	 ,MONEDA            INT
	 ,STR_MONEDA        CHAR(03)
	 ,VALOR_RAZONABLE   NUMERIC
	 ,FRECUENCIA_PAGO   INT
	 ,INDICADOR         INT
	 ,MODALIDAD         CHAR(01)
	 ,MODALIDAD_PAGO    VARCHAR(60)
	 ,MTM_MOVIMIENTO    NUMERIC
	 ,FECHA_LIQUIDACION DATETIME
	 ,MONEDA_PAGO       INT
	 ,CARTERA_NORMATIVA CHAR(02)
	 ,OPERADOR          VARCHAR(50)
	 ,PAIS              INT
	 ,AGENCIA           VARCHAR(50)
	 ,COD_PAIS          VARCHAR(5))
	 


	 
   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE OPERACIONES                                                      */
   /*-----------------------------------------------------------------------------*/
	 INSERT @OPERACIONES
	 SELECT OPERACION         
	       ,TIPO_FLUJO        
	       ,TIPO_SWAP         
	       ,RUT_CLIENTE       
	       ,COD_CLIENTE       
	       ,FECHA_CIERRE      
	       ,FECHA_INICIO      
	       ,FECHA_TERMINO     
	       ,FECHA_VENCIMIENTO 
	       ,NOMINAL           
	       ,MONEDA            
	       ,STR_MONEDA        
	       ,VALOR_RAZONABLE   
	       ,FRECUENCIA_PAGO   
	       ,INDICADOR         
	       ,MODALIDAD         
	       ,MODALIDAD_PAGO    
	       ,MTM_MOVIMIENTO    
	       ,FECHA_LIQUIDACION 
	       ,MONEDA_PAGO       
	       ,CARTERA_NORMATIVA 
	       ,OPERADOR          
	       ,PAIS              
	       ,AGENCIA           
	       ,COD_PAIS          
       FROM REPORTES.DBO.CARTERA_SWAP(@FECHA)
      ORDER BY OPERACION DESC

  

	  

   /*-----------------------------------------------------------------------------*/
   /* CURSOR DE CONTABILIDAD SOLO ARBITRAJES                                      */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT DISTINCT 
	         OPERACION
        FROM @OPERACIONES
	   ORDER BY OPERACION ASC


        OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION  


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN




          /*----------------------------------------------------------------------*/
	      /* EXTRAER INFORMACION DE LA CARTERA DE RESPALDO CON EL N° OPE          */
		  /* INFORMACION GENERAL                                                  */
          /*----------------------------------------------------------------------*/
		    SELECT @OPERADOR          = OPERADOR
				  ,@PAIS              = PAIS
				  ,@MODALIDAD         = MODALIDAD
				  ,@AGENCIA           = AGENCIA
				  ,@COD_PAIS          = COD_PAIS
		      FROM @OPERACIONES 	    
		     WHERE OPERACION          = @OPE_NUMERO_OPERACION

       
          /*----------------------------------------------------------------------*/
  		  /* INFORMACION PATA ACTIVA                                              */
		  /*----------------------------------------------------------------------*/
		    SELECT @A_FRECUENCIA_PAGO  = FRECUENCIA_PAGO 
				  ,@A_INDICADOR        = INDICADOR 
				  ,@A_COD_MONEDA       = MONEDA 
				  ,@A_MONEDA_STR       = STR_MONEDA
			  FROM @OPERACIONES 	    
			 WHERE OPERACION           = @OPE_NUMERO_OPERACION
			   AND TIPO_FLUJO          = 1 
			

          /*----------------------------------------------------------------------*/
  		  /* INFORMACION PATA PASIVA                                              */
		  /*----------------------------------------------------------------------*/
		    SELECT @P_FRECUENCIA_PAGO  = FRECUENCIA_PAGO 
				  ,@P_INDICADOR        = INDICADOR 
				  ,@P_COD_MONEDA       = MONEDA 
				  ,@P_MONEDA_STR       = STR_MONEDA
			  FROM @OPERACIONES 	    
			 WHERE OPERACION           = @OPE_NUMERO_OPERACION
			   AND TIPO_FLUJO          = 2

          /*----------------------------------------------------------------------*/
	      /* TIPO DE TASA ACTIVO                                                  */
		  /*----------------------------------------------------------------------*/
		      SET @PERIODO_FRECUENCIA = 0
		   SELECT @PERIODO_FRECUENCIA = DIAS FROM @FRECUENCIA_PAGO WHERE CODIGO = @A_FRECUENCIA_PAGO
				  

			      DELETE FROM @CODIGO_TASA
			      INSERT INTO @CODIGO_TASA
			      EXEC BACSWAPSUDA.DBO.SP_RETORNA_TASAMONEDA 0 ,@A_COD_MONEDA,0,@PERIODO_FRECUENCIA,4
	 	 
		             SET @A_TIPO_TASA = ''
		          SELECT @A_TIPO_TASA = LTRIM(RTRIM(UPPER(GLOSA))) FROM @CODIGO_TASA WHERE CODIGO = @A_INDICADOR

          /*----------------------------------------------------------------------*/
	      /* TIPO DE TASA PASIVO                                                  */
		  /*----------------------------------------------------------------------*/
		      SET @PERIODO_FRECUENCIA = 0
		   SELECT @PERIODO_FRECUENCIA = DIAS FROM @FRECUENCIA_PAGO WHERE CODIGO = @P_FRECUENCIA_PAGO
				  

			      DELETE FROM @CODIGO_TASA
			      INSERT INTO @CODIGO_TASA
			      EXEC BACSWAPSUDA.DBO.SP_RETORNA_TASAMONEDA 0 ,@P_COD_MONEDA,0,@PERIODO_FRECUENCIA,4
	 	 
		             SET @P_TIPO_TASA = ''
		          SELECT @P_TIPO_TASA = LTRIM(RTRIM(UPPER(GLOSA))) FROM @CODIGO_TASA WHERE CODIGO = @P_INDICADOR







          /*----------------------------------------------------------------------*/
	      /* SETEO DE MONTOS DE INTERFAZ                                          */
		  /*----------------------------------------------------------------------*/
            SELECT  @INT_Ano_Mes_de_Referencia                         = @FECHA
                   ,@INT_Codigo_Agrupamiento_Producto                  = '38'
                   ,@INT_Codigo_Operacion                              = @OPE_NUMERO_OPERACION
                   ,@INT_Codigo_Producto                               = ''
                   ,@INT_Codigo_Moneda_Original_Operacion              = @A_MONEDA_STR
                   ,@INT_Codigo_Indice_Economico_Activo                = 'OTHER'
                   ,@INT_Codigo_Indice_Economico_Pasivo                = 'OTHER'
                   ,@INT_Indicador_Derivados_Flujo_Caja                = 'N'
                   ,@INT_Numero_Identificacion_Camara_Compensacion     = ''
                   ,@INT_Codigo_Operacion_Garantizada                  = ''
                   ,@INT_Agencia                                       = '0000'
                   ,@INT_Codigo_Pais_Contraparte                       = @COD_PAIS --Reportes.dbo.Fx_Convalida_Pais('ADM',@PAIS)
                   ,@INT_Indicador_Prote_Renegociacion                 = ''
                   ,@INT_Indicador_Proteccion						   = ''
                   ,@INT_Valor_Minimo_Ejecucion_Garantia			   = ''
                   ,@INT_Indicador_Tipo_Cobertura					   = ''
                   ,@INT_Numero_Default_Ejecucion_derivado_Credito	   = ''
                   ,@INT_Codigo_Indicador_Grupo_Operacion_Cubierta	   = ''
                   ,@INT_Valor_Premio_en_Apertura					   = ''
                   ,@INT_Indicador_Clausula_Insolvencia				   = ''
                   ,@INT_Orden_Cobertura_Garantia					   = ''
                   ,@INT_Valor_Maximo_Cobertura_Garantia			   = ''
                   ,@INT_Porcentaje_Maximo_Cobertura_Garantizada	   = ''
                   ,@INT_Indicador_Default_Operacion_Garantizada	   = ''
                   ,@INT_Rating_De_Operacion_Garantizada			   = ''
                   ,@INT_Nombre_Referencia							   = ''
                   ,@INT_CNJP_Referencia							   = ''
                   ,@INT_Spread										   = ''
                   ,@INT_Frecuencia_Spread							   = ''
                   ,@INT_Mesa_gestion								   = BacParamSuda.dbo.fx_mesa_operador(@OPERADOR )


          /*----------------------------------------------------------------------*/
	      /* DETERMINAR TIPO DE INSTRUMENTO                                       */
		  /*----------------------------------------------------------------------*/
		    IF @A_COD_MONEDA != @P_COD_MONEDA BEGIN
			   SET @INT_Codigo_Producto  = 'CCS' 
			                             + '_' 
										 + @A_MONEDA_STR
										 + '_' 
										 + @P_MONEDA_STR 
										 + '_' 
										 + CASE WHEN @MODALIDAD ='E' THEN 'EF' 
										        WHEN @MODALIDAD ='C' THEN 'COM' 
												ELSE ''
										   END
			END
			ELSE BEGIN
			   SET @INT_Codigo_Producto  = 'IRS' 
			                             + '_' 
										 + @A_MONEDA_STR 
										 + '_' 
										 + @P_MONEDA_STR
										 + '_' 
										 + CASE WHEN @MODALIDAD ='E' THEN 'EF' 
										        WHEN @MODALIDAD ='C' THEN 'COM' 
												ELSE ''
										   END
			END


          /*----------------------------------------------------------------------*/
	      /* INGRESA REGISTROS POR OPERACION                                      */
		  /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA
		    (Ano_Mes_de_Referencia                             ,Codigo_Agrupamiento_Producto                 
            ,Codigo_Operacion                                  ,Codigo_Producto                              
            ,Codigo_Moneda_Original_Operacion                  ,Codigo_Indice_Economico_Activo               
            ,Codigo_Indice_Economico_Pasivo                    ,Indicador_Derivados_Flujo_Caja               
            ,Numero_Identificacion_Camara_Compensacion         ,Codigo_Operacion_Garantizada                 
            ,Agencia                                           ,Codigo_Pais_Contraparte                      
            ,Indicador_Prote_Renegociacion                     ,Indicador_Proteccion						  
            ,Valor_Minimo_Ejecucion_Garantia			       ,Indicador_Tipo_Cobertura					  
            ,Numero_Default_Ejecucion_derivado_Credito	       ,Codigo_Indicador_Grupo_Operacion_Cubierta	  
            ,Valor_Premio_en_Apertura					       ,Indicador_Clausula_Insolvencia				  
            ,Orden_Cobertura_Garantia					       ,Valor_Maximo_Cobertura_Garantia			  
            ,Porcentaje_Maximo_Cobertura_Garantizada	       ,Indicador_Default_Operacion_Garantizada	  
            ,Rating_De_Operacion_Garantizada			       ,Nombre_Referencia							  
            ,CNJP_Referencia							       ,Spread										  
            ,Frecuencia_Spread							       ,Mesa_gestion)                                      
		   
		    VALUES
		    (@INT_Ano_Mes_de_Referencia                        ,@INT_Codigo_Agrupamiento_Producto                 
            ,@INT_Codigo_Operacion                             ,@INT_Codigo_Producto                              
            ,@INT_Codigo_Moneda_Original_Operacion             ,@INT_Codigo_Indice_Economico_Activo               
            ,@INT_Codigo_Indice_Economico_Pasivo               ,@INT_Indicador_Derivados_Flujo_Caja               
            ,@INT_Numero_Identificacion_Camara_Compensacion    ,@INT_Codigo_Operacion_Garantizada                 
            ,@INT_Agencia                                      ,@INT_Codigo_Pais_Contraparte                      
            ,@INT_Indicador_Prote_Renegociacion                ,@INT_Indicador_Proteccion						  
            ,@INT_Valor_Minimo_Ejecucion_Garantia			   ,@INT_Indicador_Tipo_Cobertura					  
            ,@INT_Numero_Default_Ejecucion_derivado_Credito	   ,@INT_Codigo_Indicador_Grupo_Operacion_Cubierta	  
            ,@INT_Valor_Premio_en_Apertura					   ,@INT_Indicador_Clausula_Insolvencia				  
            ,@INT_Orden_Cobertura_Garantia					   ,@INT_Valor_Maximo_Cobertura_Garantia			  
            ,@INT_Porcentaje_Maximo_Cobertura_Garantizada	   ,@INT_Indicador_Default_Operacion_Garantizada	  
            ,@INT_Rating_De_Operacion_Garantizada			   ,@INT_Nombre_Referencia							  
            ,@INT_CNJP_Referencia							   ,@INT_Spread										  
            ,@INT_Frecuencia_Spread							   ,@INT_Mesa_gestion)     



       FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION  
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES




   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
	 SELECT CONVERT(CHAR(10),Ano_Mes_de_Referencia,103) AS Ano_Mes_de_Referencia                                                     
           ,Codigo_Agrupamiento_Producto                  
           ,Codigo_Operacion                              
           ,Codigo_Producto                               
           ,Codigo_Moneda_Original_Operacion              
           ,Codigo_Indice_Economico_Activo                
           ,Codigo_Indice_Economico_Pasivo                
           ,Indicador_Derivados_Flujo_Caja                
           ,Numero_Identificacion_Camara_Compensacion     
           ,Codigo_Operacion_Garantizada                  
           ,Agencia                                       
           ,Codigo_Pais_Contraparte                       
           ,Indicador_Prote_Renegociacion                 
           ,Indicador_Proteccion						  
           ,Valor_Minimo_Ejecucion_Garantia			   
           ,Indicador_Tipo_Cobertura					
           ,Numero_Default_Ejecucion_derivado_Credito	
           ,Codigo_Indicador_Grupo_Operacion_Cubierta	
           ,Valor_Premio_en_Apertura					
           ,Indicador_Clausula_Insolvencia				
           ,Orden_Cobertura_Garantia					
           ,Valor_Maximo_Cobertura_Garantia			   
           ,Porcentaje_Maximo_Cobertura_Garantizada	   
           ,Indicador_Default_Operacion_Garantizada	   
           ,Rating_De_Operacion_Garantizada			   
           ,Nombre_Referencia							
           ,CNJP_Referencia							   
           ,Spread										
           ,Frecuencia_Spread							  
           ,Mesa_gestion								                       
	  FROM @SALIDA
	 ORDER BY Codigo_Operacion


END
GO
