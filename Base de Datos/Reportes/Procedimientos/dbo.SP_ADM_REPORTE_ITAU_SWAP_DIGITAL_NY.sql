USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_ITAU_SWAP_DIGITAL_NY]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_ITAU_SWAP_DIGITAL_NY]    
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
     --EXEC Reportes.dbo.SP_ADM_REPORTE_ITAU_SWAP_DIGITAL_NY '2015-12-30'
	 
  
 
   /*-----------------------------------------------------------------------------*/
   /* CODIGO DE TASAS                                                             */
   /*-----------------------------------------------------------------------------*/
      DECLARE @CODIGO_TASA  TABLE
	        (CODIGO         VARCHAR(10)
			,GLOSA          VARCHAR(100))





   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE INTERFAZ                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @INT_Fecha_Referencia           DATETIME
            ,@INT_Codigo_Origen              VARCHAR(05)
            ,@INT_Tipo_Operación             VARCHAR(05)
            ,@INT_COdigo_Empresa_SINC        VARCHAR(05)
            ,@INT_Fecha_Operación            DATETIME
            ,@INT_Fecha_Vencimiento          DATETIME
            ,@INT_Numero_Contrato_Modelo     NUMERIC
            ,@INT_Numero_Contrato_Interno    NUMERIC
            ,@INT_Cliente                    VARCHAR(150)
            ,@INT_CNPJ                       VARCHAR(50)
            ,@INT_Tipo_Cliente               VARCHAR(03)
            ,@INT_Codigo_Client_SINC         VARCHAR(05)
            ,@INT_Indice_Activo              VARCHAR(20)
            ,@INT_Perc_Indice_Activo         FLOAT
            ,@INT_Tasa_Indice_Activo         FLOAT
            ,@INT_Indice_Pasivo              VARCHAR(20)
            ,@INT_Perc_Indice_Pasivo         FLOAT
            ,@INT_Tasa_Indice_Pasivo         FLOAT
            ,@INT_Ind_Garantía               VARCHAR(05)
            ,@INT_Central_Custodia           NUMERIC
            ,@INT_Valor_Base_Original        NUMERIC
            ,@INT_Valor_Base_Actual          NUMERIC
            ,@INT_Leg_Ativa                  NUMERIC
            ,@INT_Leg_Pasiva                 NUMERIC
            ,@INT_Valor_Actual_Ajuste        NUMERIC
            ,@INT_Valor_Mercado_Ajuste       NUMERIC
            ,@INT_RDCI                       NUMERIC
            ,@INT_Riesgo_Potencial           NUMERIC
            ,@INT_PDT                        NUMERIC
            ,@INT_PVT                        NUMERIC
            ,@INT_Premio_Pagado              NUMERIC
            ,@INT_Premio_Recebido            NUMERIC
            ,@INT_Premio_Diferido            NUMERIC
            ,@INT_Agio_Desagio               NUMERIC
            ,@INT_Resultado_Apropriado_Ano   NUMERIC
            ,@INT_MTM_Apropriado_Ano         NUMERIC
            ,@INT_Cosif_Compensación         VARCHAR(20)
            ,@INT_Cosif_Ger_Compensación     VARCHAR(20)
            ,@INT_Cuenta_SINC_Compensación   VARCHAR(20)
            ,@INT_Cosif_Costo                VARCHAR(20)
            ,@INT_Cosif_Ger_Costo            VARCHAR(20)
            ,@INT_Cuenta_Cosif_Notnl         VARCHAR(20)
            ,@INT_Cuenta_SINC_Costo          VARCHAR(20)
            ,@INT_Moneda_Origen              VARCHAR(03)
            ,@INT_Observacion                VARCHAR(100)
            ,@INT_Info_Adicional             VARCHAR(100)


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE INTERFAZ                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	        (Fecha_Referencia           DATETIME
            ,Codigo_Origen              VARCHAR(05)
            ,Tipo_Operación             VARCHAR(05)
            ,COdigo_Empresa_SINC        VARCHAR(05)
            ,Fecha_Operación            DATETIME
            ,Fecha_Vencimiento          DATETIME
            ,Numero_Contrato_Modelo     NUMERIC
            ,Numero_Contrato_Interno    NUMERIC
            ,Cliente                    VARCHAR(150)
            ,CNPJ                       VARCHAR(50)
            ,Tipo_Cliente               VARCHAR(03)
            ,Codigo_Client_SINC         VARCHAR(05)
            ,Indice_Activo              VARCHAR(20)
            ,Perc_Indice_Activo         FLOAT
            ,Tasa_Indice_Activo         FLOAT
            ,Indice_Pasivo              VARCHAR(20)
            ,Perc_Indice_Pasivo         FLOAT
            ,Tasa_Indice_Pasivo         FLOAT
            ,Ind_Garantía               VARCHAR(05)
            ,Central_Custodia           NUMERIC
            ,Valor_Base_Original        NUMERIC
            ,Valor_Base_Actual          NUMERIC
            ,Leg_Ativa                  NUMERIC
            ,Leg_Pasiva                 NUMERIC
            ,Valor_Actual_Ajuste        NUMERIC
            ,Valor_Mercado_Ajuste       NUMERIC
            ,RDCI                       NUMERIC
            ,Riesgo_Potencial           NUMERIC
            ,PDT                        NUMERIC
            ,PVT                        NUMERIC
            ,Premio_Pagado              NUMERIC
            ,Premio_Recebido            NUMERIC
            ,Premio_Diferido            NUMERIC
            ,Agio_Desagio               NUMERIC
            ,Resultado_Apropriado_Ano   NUMERIC
            ,MTM_Apropriado_Ano         NUMERIC
            ,Cosif_Compensación         VARCHAR(20)
            ,Cosif_Ger_Compensación     VARCHAR(20)
            ,Cuenta_SINC_Compensación   VARCHAR(20)
            ,Cosif_Costo                VARCHAR(20)
            ,Cosif_Ger_Costo            VARCHAR(20)
            ,Cuenta_Cosif_Notnl         VARCHAR(20)
            ,Cuenta_SINC_Costo          VARCHAR(20)
            ,Moneda_Origen              VARCHAR(03)
            ,Observacion                VARCHAR(100)
            ,Info_Adicional             VARCHAR(100))
   

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES PARA OPERACIONES                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @TIPO_SWAP            INT
	        ,@RUT_CLIENTE          NUMERIC
	        ,@COD_CLIENTE          INT
	        ,@FECHA_CIERRE         DATETIME
	        ,@FECHA_TERMINO        DATETIME
			,@PERIODO_FRECUENCIA   INT
			,@VALOR_RAZONABLE_USD  NUMERIC
			,@VALOR_RAZONABLE_CLP  NUMERIC
			,@NOMBRE_CLIENTE       VARCHAR(150)
			,@CNPJ                 VARCHAR(20)
			,@CLOPCION             VARCHAR(02)



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES PATA                                               */
   /*-----------------------------------------------------------------------------*/
     DECLARE @A_NOMINAL            NUMERIC
	        ,@P_NOMINAL            NUMERIC
			,@A_MONEDA             CHAR(03)
			,@P_MONEDA             CHAR(03)
			,@A_COD_MONEDA         CHAR(03)
			,@P_COD_MONEDA         CHAR(03)
			,@A_FRECUENCIA_PAGO    INT
			,@P_FRECUENCIA_PAGO    INT
			,@A_INDICADOR          INT
			,@P_INDICADOR          INT
			,@A_TIPO_TASA          VARCHAR(20)
			,@P_TIPO_TASA          VARCHAR(20)
			,@A_MTM                NUMERIC
			,@P_MTM                NUMERIC
			,@A_TASA               FLOAT
			,@P_TASA               FLOAT
			,@A_SPREAD             FLOAT
			,@P_SPREAD             FLOAT

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES CURSOR OPERACIONES                                 */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPE_NUMERO_OPERACION NUMERIC
   


   /*-----------------------------------------------------------------------------*/
   /* TABLA OPERACIONES CARTERA                                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERACIONES TABLE
	 (OPERACION             NUMERIC
	 ,TIPO_FLUJO            INT
	 ,TIPO_SWAP             INT
	 ,RUT_CLIENTE           NUMERIC
	 ,COD_CLIENTE           INT
	 ,FECHA_CIERRE          DATETIME
	 ,FECHA_INICIO          DATETIME
	 ,FECHA_TERMINO         DATETIME
	 ,FECHA_VENCIMIENTO     DATETIME
	 ,NOMINAL               NUMERIC(25,4)
	 ,MONEDA                INT
	 ,STR_MONEDA            CHAR(03)
	 ,VALOR_RAZONABLE_USD   NUMERIC
	 ,VALOR_RAZONABLE_CLP   NUMERIC
	 ,FRECUENCIA_PAGO       INT
	 ,INDICADOR             INT
	 ,MODALIDAD_PAGO        VARCHAR(60)
	 ,MTM_MOVIMIENTO        NUMERIC
	 ,FECHA_LIQUIDACION     DATETIME
	 ,MONEDA_PAGO           INT
	 ,CARTERA_NORMATIVA     CHAR(02)
	 ,TASA                  FLOAT
	 ,SPREAD                FLOAT
	 ,NOMBRE_CLIENTE        VARCHAR(150)
	 ,CNPJ                  VARCHAR(20)
	 ,CLOPCION              VARCHAR(02))
	 



   /*-----------------------------------------------------------------------------*/
   /* TABLA DE TASAS                                                              */
   /*-----------------------------------------------------------------------------*/
     DECLARE @TASAS TABLE
	 (CodigoMoneda    NUMERIC
	 ,GlosaMoneda     VARCHAR(20)
	 ,CodigoTasa      NUMERIC
	 ,GlosaTasa       VARCHAR(14)
	 ,CodigoPariodo   NUMERIC
	 ,GlosaPariodo    VARCHAR(15)
	 ,Meses           NUMERIC
	 ,Dias            NUMERIC)

   
   /*-----------------------------------------------------------------------------*/
   /* TASAS SEGUN LA FRECUENCIA DE PAGO QUE INDIQUE SWAP                          */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @TASAS
     SELECT convert(numeric(5) , tm.Codigo_Moneda )        as CodigoMoneda
           ,convert(varchar(20),ltrim(rtrim(mn.mnglosa)))  as GlosaMoneda
           ,convert(numeric(5) , tm.Codigo_Tasa )          as CodigoTasa 
           ,convert(varchar(14),ltrim(rtrim(tb.tbglosa)))  as GlosaTasa 
           ,convert(numeric(5) , tb.tbtasa )               as CodigoPariodo
           ,convert(varchar(15),ltrim(rtrim(pa.glosa)))    as GlosaPariodo
           ,convert(numeric(5),pa.meses)                   as Meses
           ,convert(numeric(9),pa.dias)                    as Dias
       FROM BacparamSuda..TASAS_MONEDA          TM WITH(NOLOCK)
       LEFT JOIN
	        BacparamSuda..MONEDA                MN WITH(NOLOCK)
	     ON TM.Codigo_Moneda    = MN.mncodmon
	   LEFT JOIN
	        BacparamSuda..TABLA_GENERAL_DETALLE TB WITH(NOLOCK)
	     ON TB.tbcateg          = 1042
	    AND TB.tbcodigo1        = TM.Codigo_Tasa 
	   LEFT JOIN
	        BacparamSuda..PERIODO_AMORTIZACION PA WITH(NOLOCK)
	     ON PA.tabla            = 1044
	    AND (TB.tbtasa    = PA.codigo or TB.tbtasa = 0)
      ORDER BY TM.Codigo_Moneda , TM.Codigo_Tasa , TB.tbtasa



	 
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
	       ,VALOR_RAZONABLE_USD
		   ,VALOR_RAZONABLE_CLP   
	       ,FRECUENCIA_PAGO   
	       ,INDICADOR         
	       ,MODALIDAD_PAGO    
	       ,MTM_MOVIMIENTO    
	       ,FECHA_LIQUIDACION 
	       ,MONEDA_PAGO       
	       ,CARTERA_NORMATIVA 
	       ,TASA 
		   ,SPREAD             
	       ,NOMBRE_CLIENTE    
	       ,CNPJ              
	       ,CLOPCION  
	   FROM REPORTES.DBO.CARTERA_SWAP_NY(@FECHA)        
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
		    SELECT @TIPO_SWAP             = TIPO_SWAP
	              ,@RUT_CLIENTE           = RUT_CLIENTE
	              ,@COD_CLIENTE           = COD_CLIENTE
	              ,@FECHA_CIERRE          = FECHA_CIERRE
	              ,@FECHA_TERMINO         = FECHA_TERMINO
				  ,@VALOR_RAZONABLE_USD   = VALOR_RAZONABLE_USD
				  ,@VALOR_RAZONABLE_CLP   = VALOR_RAZONABLE_CLP
				  ,@NOMBRE_CLIENTE        = NOMBRE_CLIENTE
				  ,@CNPJ                  = CNPJ
				  ,@Clopcion              = CLOPCION 
		      FROM @OPERACIONES 	    
		     WHERE OPERACION          = @OPE_NUMERO_OPERACION

          /*----------------------------------------------------------------------*/
  		  /* INFORMACION PATA ACTIVA                                              */
		  /*----------------------------------------------------------------------*/
		    SELECT @A_NOMINAL          = NOMINAL
	          	  ,@A_COD_MONEDA       = MONEDA 
				  ,@A_MONEDA           = STR_MONEDA 
				  ,@A_FRECUENCIA_PAGO  = FRECUENCIA_PAGO 
				  ,@A_INDICADOR        = INDICADOR 
				  ,@A_MTM              = MTM_MOVIMIENTO
				  ,@A_TASA             = TASA
				  ,@A_SPREAD           = SPREAD
			  FROM @OPERACIONES 	    
			 WHERE OPERACION           = @OPE_NUMERO_OPERACION
			   AND TIPO_FLUJO          = 1 
			

          /*----------------------------------------------------------------------*/
  		  /* INFORMACION PATA PASIVA                                              */
		  /*----------------------------------------------------------------------*/
		    SELECT @P_NOMINAL          = NOMINAL
	          	  ,@P_COD_MONEDA       = MONEDA 
				  ,@P_MONEDA           = STR_MONEDA 
				  ,@P_FRECUENCIA_PAGO  = FRECUENCIA_PAGO 
				  ,@P_INDICADOR        = INDICADOR 
				  ,@P_MTM              = MTM_MOVIMIENTO
				  ,@P_TASA             = TASA
				  ,@P_SPREAD           = SPREAD
			  FROM @OPERACIONES 	    
			 WHERE OPERACION           = @OPE_NUMERO_OPERACION
			   AND TIPO_FLUJO          = 2





          /*----------------------------------------------------------------------*/
	      /* TIPO DE TASA ACTIVO                                                  */
		  /*----------------------------------------------------------------------*/
		    SET @A_TIPO_TASA = ''
		    SELECT @A_TIPO_TASA = LTRIM(RTRIM(UPPER(GlosaTasa))) FROM @TASAS  WHERE CodigoMoneda  = @A_COD_MONEDA AND CodigoTasa = @A_INDICADOR


          /*----------------------------------------------------------------------*/
	      /* TIPO DE TASA PASIVO                                                  */
		  /*----------------------------------------------------------------------*/
		    SET @P_TIPO_TASA = ''
		    SELECT @P_TIPO_TASA = LTRIM(RTRIM(UPPER(GlosaTasa))) FROM @TASAS  WHERE CodigoMoneda  = @P_COD_MONEDA AND CodigoTasa = @P_INDICADOR

       

          /*----------------------------------------------------------------------*/
	      /* SETEO DE MONTOS DE INTERFAZ                                          */
		  /*----------------------------------------------------------------------*/
            SELECT  @INT_Fecha_Referencia           = @FECHA
                   ,@INT_Codigo_Origen              = 'US776'
                   ,@INT_Tipo_Operación             = 'Swap'
                   ,@INT_COdigo_Empresa_SINC        = '0776'
                   ,@INT_Fecha_Operación            = @FECHA_CIERRE
                   ,@INT_Fecha_Vencimiento          = @FECHA_TERMINO
                   ,@INT_Numero_Contrato_Modelo     = 0
                   ,@INT_Numero_Contrato_Interno    = @OPE_NUMERO_OPERACION
                   ,@INT_Cliente                    = SUBSTRING(LTRIM(RTRIM(@NOMBRE_CLIENTE)),1,35)
                   ,@INT_CNPJ                       = @CNPJ 
                   ,@INT_Tipo_Cliente               = @Clopcion
                   ,@INT_Codigo_Client_SINC         = '0000'
                   ,@INT_Indice_Activo              = CASE WHEN @A_TIPO_TASA = 'FIJA' THEN 'FIX' ELSE @A_TIPO_TASA END  
                   ,@INT_Perc_Indice_Activo         = @A_SPREAD
                   ,@INT_Tasa_Indice_Activo         = @A_TASA           
                   ,@INT_Indice_Pasivo              = CASE WHEN @A_TIPO_TASA = 'FIJA' THEN 'FIX' ELSE @A_TIPO_TASA END  
                   ,@INT_Perc_Indice_Pasivo         = @P_SPREAD
                   ,@INT_Tasa_Indice_Pasivo         = @P_TASA
                   ,@INT_Ind_Garantía               = 's/gar'
                   ,@INT_Central_Custodia           = 0
                   ,@INT_Valor_Base_Original        = @A_NOMINAL
                   ,@INT_Valor_Base_Actual          = @P_NOMINAL
                   ,@INT_Leg_Ativa                  = @A_MTM
                   ,@INT_Leg_Pasiva                 = @P_MTM
                   ,@INT_Valor_Actual_Ajuste        = @VALOR_RAZONABLE_USD
                   ,@INT_Valor_Mercado_Ajuste       = @VALOR_RAZONABLE_USD
                   ,@INT_RDCI                       = 0
                   ,@INT_Riesgo_Potencial           = 0
                   ,@INT_PDT                        = 0
                   ,@INT_PVT                        = 0
                   ,@INT_Premio_Pagado              = 0
                   ,@INT_Premio_Recebido            = 0
                   ,@INT_Premio_Diferido            = 0
                   ,@INT_Agio_Desagio               = 0
                   ,@INT_Resultado_Apropriado_Ano   = 0
                   ,@INT_MTM_Apropriado_Ano         = 0
                   ,@INT_Cosif_Compensación         = '30610408'
                   ,@INT_Cosif_Ger_Compensación     = '0999'
                   ,@INT_Cuenta_SINC_Compensación   = '0'
                   ,@INT_Cosif_Costo                = ''
                   ,@INT_Cosif_Ger_Costo            = ''
                   ,@INT_Cuenta_Cosif_Notnl         = ''
                   ,@INT_Cuenta_SINC_Costo          = '0'
                   ,@INT_Moneda_Origen              = 'CLP'
                   ,@INT_Observacion                = ''
                   ,@INT_Info_Adicional             = ''

          /*----------------------------------------------------------------------*/
	      /* CUENTA CONTABLE DE RECIBIMOS EN LAS OBSERVACIONES                    */
		  /*----------------------------------------------------------------------*/
		       SET @INT_Observacion = ''
            SELECT @INT_Observacion = CUENTA
	          FROM REPORTES.DBO.ContabilidadNominalSwapNY(@FECHA,@OPE_NUMERO_OPERACION)
	         WHERE TIPO_OPERACION in ('1C','2C','4')
			   AND CORRELATIVO_PER  = 1


          /*----------------------------------------------------------------------*/
	      /* CUENTA COSIF                                                         */
		  /*----------------------------------------------------------------------*/
		    SELECT @INT_Cosif_Compensación         = COSIF
                  ,@INT_Cosif_Ger_Compensación     = COSIF_GER 
             FROM REPORTES.DBO.CODIGOS_COSIF(LTRIM(RTRIM(@INT_Observacion)))



          /*----------------------------------------------------------------------*/
	      /* INGRESA REGISTROS POR OPERACION                                      */
		  /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA
		    (Fecha_Referencia           ,Codigo_Origen               ,Tipo_Operación               ,COdigo_Empresa_SINC            ,Fecha_Operación            
            ,Fecha_Vencimiento          ,Numero_Contrato_Modelo      ,Numero_Contrato_Interno      ,Cliente                        ,CNPJ                       
            ,Tipo_Cliente               ,Codigo_Client_SINC          ,Indice_Activo                ,Perc_Indice_Activo             ,Tasa_Indice_Activo         
            ,Indice_Pasivo              ,Perc_Indice_Pasivo          ,Tasa_Indice_Pasivo           ,Ind_Garantía                   ,Central_Custodia           
            ,Valor_Base_Original        ,Valor_Base_Actual           ,Leg_Ativa                    ,Leg_Pasiva                     ,Valor_Actual_Ajuste        
            ,Valor_Mercado_Ajuste       ,RDCI                        ,Riesgo_Potencial             ,PDT                            ,PVT                        
            ,Premio_Pagado              ,Premio_Recebido             ,Premio_Diferido              ,Agio_Desagio                   ,Resultado_Apropriado_Ano   
            ,MTM_Apropriado_Ano         ,Cosif_Compensación          ,Cosif_Ger_Compensación       ,Cuenta_SINC_Compensación       ,Cosif_Costo                
            ,Cosif_Ger_Costo            ,Cuenta_Cosif_Notnl          ,Cuenta_SINC_Costo            ,Moneda_Origen                  ,Observacion                
            ,Info_Adicional)             
		   
		    VALUES
		   ( @INT_Fecha_Referencia      ,@INT_Codigo_Origen          ,@INT_Tipo_Operación          ,@INT_COdigo_Empresa_SINC       ,@INT_Fecha_Operación            
            ,@INT_Fecha_Vencimiento     ,@INT_Numero_Contrato_Modelo ,@INT_Numero_Contrato_Interno ,@INT_Cliente                   ,@INT_CNPJ                       
            ,@INT_Tipo_Cliente          ,@INT_Codigo_Client_SINC     ,@INT_Indice_Activo           ,@INT_Perc_Indice_Activo        ,@INT_Tasa_Indice_Activo         
            ,@INT_Indice_Pasivo         ,@INT_Perc_Indice_Pasivo     ,@INT_Tasa_Indice_Pasivo      ,@INT_Ind_Garantía              ,@INT_Central_Custodia           
            ,@INT_Valor_Base_Original   ,@INT_Valor_Base_Actual      ,@INT_Leg_Ativa               ,@INT_Leg_Pasiva                ,@INT_Valor_Actual_Ajuste        
            ,@INT_Valor_Mercado_Ajuste  ,@INT_RDCI                   ,@INT_Riesgo_Potencial        ,@INT_PDT                       ,@INT_PVT                        
            ,@INT_Premio_Pagado         ,@INT_Premio_Recebido        ,@INT_Premio_Diferido         ,@INT_Agio_Desagio              ,@INT_Resultado_Apropriado_Ano   
            ,@INT_MTM_Apropriado_Ano    ,@INT_Cosif_Compensación     ,@INT_Cosif_Ger_Compensación  ,@INT_Cuenta_SINC_Compensación  ,@INT_Cosif_Costo                
            ,@INT_Cosif_Ger_Costo       ,@INT_Cuenta_Cosif_Notnl     ,@INT_Cuenta_SINC_Costo       ,@INT_Moneda_Origen             ,@INT_Observacion                
            ,@INT_Info_Adicional)  



       FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION  
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES




   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
	 SELECT CONVERT(CHAR(10),Fecha_Referencia,103) AS Fecha_Referencia           
           ,Codigo_Origen              
           ,Tipo_Operación             
           ,COdigo_Empresa_SINC        
           ,CONVERT(CHAR(10),Fecha_Operación,103)   AS Fecha_Operación          
           ,CONVERT(CHAR(10),Fecha_Vencimiento,103) AS Fecha_Vencimiento         
           ,Numero_Contrato_Modelo     
           ,Numero_Contrato_Interno    
           ,Cliente                     
           ,CNPJ                       
           ,Tipo_Cliente               
           ,Codigo_Client_SINC         
           ,Indice_Activo              
           ,Perc_Indice_Activo         
           ,Tasa_Indice_Activo         
           ,Indice_Pasivo              
           ,Perc_Indice_Pasivo         
           ,Tasa_Indice_Pasivo         
           ,Ind_Garantía               
           ,Central_Custodia           
           ,Valor_Base_Original        
           ,Valor_Base_Actual          
           ,Leg_Ativa                  
           ,Leg_Pasiva                 
           ,Valor_Actual_Ajuste        
           ,Valor_Mercado_Ajuste       
           ,RDCI                       
           ,Riesgo_Potencial           
           ,PDT                        
           ,PVT                        
           ,Premio_Pagado              
           ,Premio_Recebido            
           ,Premio_Diferido            
           ,Agio_Desagio               
           ,Resultado_Apropriado_Ano   
           ,MTM_Apropriado_Ano         
           ,Cosif_Compensación         
           ,Cosif_Ger_Compensación     
           ,Cuenta_SINC_Compensación   
           ,Cosif_Costo                
           ,Cosif_Ger_Costo            
           ,Cuenta_Cosif_Notnl         
           ,Cuenta_SINC_Costo          
           ,Moneda_Origen              
           ,Observacion                
           ,Info_Adicional             
	  FROM @SALIDA
	 ORDER BY Numero_Contrato_Interno

END
GO
