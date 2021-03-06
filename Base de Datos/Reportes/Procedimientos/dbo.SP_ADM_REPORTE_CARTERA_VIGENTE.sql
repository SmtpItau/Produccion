USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_CARTERA_VIGENTE]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_CARTERA_VIGENTE]
	@FECHA	DATETIME
AS
BEGIN

	SET NOCOUNT ON   

	SET NOCOUNT ON   

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD SWAP                                           */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_REPORTE_CARTERA_VIGENTE '2015-12-30'
	 
   
   
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @TIPO_FLUJO           INT
	        ,@TIPO_SWAP            INT
	        ,@RUT_CLIENTE          NUMERIC
			,@RUT_DV               CHAR(01)
	        ,@COD_CLIENTE          INT
	        ,@FECHA_CIERRE         DATETIME
	        ,@FECHA_INICIO         DATETIME
	        ,@FECHA_TERMINO        DATETIME
			,@FECHA_VENCIMIENTO    DATETIME
			,@PERIODO_FRECUENCIA   INT
			,@VALOR_RAZONABLE      NUMERIC
			,@MODALIDAD_PAGO       VARCHAR(60)
			,@TIPO_OPERACION       CHAR
			,@FECHA_LIQUIDACION    DATETIME
			,@CARTERA_INVERSION    CHAR(02)
			,@CARTERA              VARCHAR(50)
			,@MODALIDAD            CHAR(01)
			,@ESTADO               VARCHAR(01)




   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES PATA                                               */
   /*-----------------------------------------------------------------------------*/
     DECLARE @A_NOMINAL            NUMERIC(25,4)	-->	NUMERIC
	        ,@P_NOMINAL            NUMERIC(25,4)	-->	NUMERIC
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
			,@A_MONEDA_PAGO        INT
			,@P_MONEDA_PAGO        INT
			,@A_MONEDA_PAGO_STR    VARCHAR(03)
			,@P_MONEDA_PAGO_STR    VARCHAR(03)


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES AUXILIARES                                         */
   /*-----------------------------------------------------------------------------*/
     DECLARE @NOMBRE_CLIENTE		VARCHAR(150)

	 

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES CURSOR DE OPERACIONES                              */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPE_NUMERO_OPERACION  NUMERIC
	        ,@OPE_ESTADO            VARCHAR(01)
	        ,@FECHA_INICIAL_MES     DATETIME
			,@FECHA_INICIAL_MES_STR VARCHAR(10)

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES CURSOR DE NOMINALES                                */
   /*-----------------------------------------------------------------------------*/
     DECLARE @CUR_FOLIO_PERFIL            INT
	        ,@CUR_CORRELATIVO             INT
	        ,@CUR_CUENTA                  VARCHAR(20)
	        ,@CUR_TIPO_MONTO              VARCHAR(01)
	        ,@CUR_MONTO                   NUMERIC
	        ,@CUR_MONEDA                  INT
	        ,@CUR_TIPO_MOVIMIENTO         CHAR(04)
	        ,@CUR_TIPO_OPERACION          CHAR(04)
	        ,@CUR_MONEDA_INSTRUMENTO      INT
	        ,@CUR_TIPO_CUENTA             CHAR(04)
			

 


   /*-----------------------------------------------------------------------------*/
   /* CODIGO DE TASAS                                                             */
   /*-----------------------------------------------------------------------------*/
      DECLARE @CODIGO_TASA  TABLE
	        (CODIGO         VARCHAR(10)
			,GLOSA          VARCHAR(100))



   /*-----------------------------------------------------------------------------*/
   /* VARIABLES DE INTERFAZ                                                       */
   /*-----------------------------------------------------------------------------*/
      DECLARE @INT_NERO_DEAL                        NUMERIC
	         ,@INT_RUT_CLIENTE                      VARCHAR(15)
	         ,@INT_NOMBRE_CLIENTE                   VARCHAR(150)
	         ,@INT_CARTERA                          VARCHAR(20)
	         ,@INT_TIPO_INSTRUMENTO                 VARCHAR(20)
	         ,@INT_FECHA_INGRESO                    DATETIME
	         ,@INT_FECHA_INICIO                     DATETIME
	         ,@INT_FECHA_VENCIMIENTO                DATETIME
	         ,@INT_MONEDA_LEG_ACTIVA                CHAR(03)
	         ,@INT_NOCIONAL_ACTIVO                  NUMERIC(25,4)	-->	NUMERIC
	         ,@INT_MONEDA_LEG_PASIVA                CHAR(03)
	         ,@INT_NOCIONAL_PASIVO                  NUMERIC(25,4)	-->	NUMERIC
	         ,@INT_TIPO_TASA_ACTIVO                 CHAR(10)
	         ,@INT_TIPO_TASA_PASIVO                 CHAR(10)
	         ,@INT_TIPO                             CHAR(10)
	         ,@INT_MONEDA_MTM                       CHAR(03)
	         ,@INT_MTM_ACTIVO                       NUMERIC
	         ,@INT_MTM_PASIVO                       NUMERIC
	         ,@INT_MONTO_MTM                        NUMERIC
	         ,@INT_MONTO_MTM_CLP                    NUMERIC
	         ,@INT_CUENTA_ACT_PAS                   VARCHAR(20)
	         ,@INT_NOCIONAL_RECIBO                  VARCHAR(20)
	         ,@INT_NOCIONAL_PAGO                    VARCHAR(20)
	         ,@INT_MODALIDAD_NOCIONALES             VARCHAR(30)
	         ,@INT_MODALIDAD_INTERES                VARCHAR(30)
	         ,@INT_FECHA_LIQUIDACION                DATETIME
	         ,@INT_MONEDA_PAGO_1                    VARCHAR(03)
	         ,@INT_LIQUIDACION_NOCIONALES_RECIBIDOS NUMERIC
	         ,@INT_LIQUIDACION_INTERES_RECIBIDOS    NUMERIC
             ,@INT_MONEDA_PAGO_2                    VARCHAR(03)
	         ,@INT_LIQUIDACION_NOCIONALES_PAGADOS   NUMERIC
	         ,@INT_LIQUIDACION_INTERES_PAGADOS      NUMERIC
	         ,@INT_LIQUIDACION_NETA_INTERES         NUMERIC
	         ,@INT_TOTAL_NOCIONA_ACTIVO_RECIBIMOS   NUMERIC
	         ,@INT_TOTAL_INTERES_ACTIVOS_RECIBIDOS  NUMERIC
	         ,@INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS   NUMERIC
	         ,@INT_TOTAL_INTERES_PASIVOS_PAGADOS    NUMERIC
	         ,@INT_REPORTE_CASA_MATRIZ              VARCHAR(100)
	         ,@INT_R_STATUS                         VARCHAR(20)

   /*-----------------------------------------------------------------------------*/
   /* TABLA OPERACIONES CARTERA                                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA_2  TABLE
	 (NERO_DEAL                        NUMERIC
	 ,RUT_CLIENTE                      VARCHAR(15)
	 ,NOMBRE_CLIENTE                   VARCHAR(150)
	 ,CARTERA                          VARCHAR(20)
	 ,TIPO_INSTRUMENTO                 VARCHAR(20)
	 ,FECHA_INGRESO                    DATETIME
	 ,FECHA_INICIO                     DATETIME
	 ,FECHA_VENCIMIENTO                DATETIME
	 ,MONEDA_LEG_ACTIVA                CHAR(03)
	 ,NOCIONAL_ACTIVO                  NUMERIC(25,4)	-->	NUMERIC
	 ,MONEDA_LEG_PASIVA                CHAR(03)
	 ,NOCIONAL_PASIVO				   NUMERIC(25,4)	-->	NUMERIC
	 ,TIPO_TASA_ACTIVO                 CHAR(10)
	 ,TIPO_TASA_PASIVO                 CHAR(10)
	 ,TIPO                             CHAR(10)
	 ,MONEDA_MTM                       CHAR(03)
	 ,MTM_ACTIVO                       NUMERIC
	 ,MTM_PASIVO                       NUMERIC
	 ,MONTO_MTM                        NUMERIC
	 ,MONTO_MTM_CLP                    NUMERIC
	 ,CUENTA_ACT_PAS                   VARCHAR(20)
	 ,NOCIONAL_RECIBO                  VARCHAR(20)
	 ,NOCIONAL_PAGO                    VARCHAR(20)
	 ,MODALIDAD_NOCIONALES             VARCHAR(30)
	 ,MODALIDAD_INTERES                VARCHAR(30)
	 ,FECHA_LIQUIDACION                DATETIME
	 ,MONEDA_PAGO_1                    VARCHAR(03)
	 ,LIQUIDACION_NOCIONALES_RECIBIDOS NUMERIC
	 ,LIQUIDACION_INTERES_RECIBIDOS    NUMERIC
     ,MONEDA_PAGO_2                    VARCHAR(03)
	 ,LIQUIDACION_NOCIONALES_PAGADOS   NUMERIC
	 ,LIQUIDACION_INTERES_PAGADOS      NUMERIC
	 ,LIQUIDACION_NETA_INTERES         NUMERIC
	 ,TOTAL_NOCIONA_ACTIVO_RECIBIMOS   NUMERIC
	 ,TOTAL_INTERES_ACTIVOS_RECIBIDOS  NUMERIC
	 ,TOTAL_NOCIONAL_PASIVOS_PAGADOS   NUMERIC
	 ,TOTAL_INTERES_PASIVOS_PAGADOS    NUMERIC
	 ,REPORTE_CASA_MATRIZ              VARCHAR(100)
	 ,R_STATUS                         VARCHAR(20))


	 
   /*-----------------------------------------------------------------------------*/
   /* NOCIONALES                                                                  */
   /*-----------------------------------------------------------------------------*/
     DECLARE @NOCIONALES_CONTABLES TABLE 
	 (Cuenta              char(20) 
	 ,Tipo_Monto          char(1)
	 ,Moneda              numeric(3, 0)
     ,ID_SISTEMA          CHAR(3)
     ,TIPO_MOVIMIENTO     CHAR(3)
     ,TIPO_OPERACION      CHAR(5)
     ,OPERACION           NUMERIC(10)
     ,MONEDA_INSTRUMENTO  CHAR(6)
     ,CORRELATIVO         NUMERIC(5)
     ,CORRELATIVO_PER     NUMERIC(5)
	 ,Nombre_Campo        VARCHAR(100)
	 ,FOLIO_PERFIL        NUMERIC(5)
	 ,CODIGO_CAMPO        NUMERIC(03)
	 ,CODIGO_CAMPO_VAR    NUMERIC(03)
	 ,GLOSA_PERFIL        CHAR(70)
	 ,TIPO_CUENTA         CHAR(04)
	 ,DESCRIPCION         VARCHAR(150))

	 


   /*-----------------------------------------------------------------------------*/
   /* TABLA OPERACIONES CARTERA                                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERACIONES TABLE
	 (OPERACION         NUMERIC
	 ,TIPO_FLUJO        INT
	 ,TIPO_SWAP         INT
	 ,RUT_CLIENTE       NUMERIC
	 ,RUT_DV            CHAR(01)
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
	 ,CARTERA           VARCHAR(50)
	 ,NOMBRE_CLIENTE    VARCHAR(100)
	 ,MONEDA_PAGO_STR   VARCHAR(04)
	 ,ESTADO            VARCHAR(01))
	 
	 

   /*-----------------------------------------------------------------------------*/
   /* DETERMINAR PRIMER DIA DE MES DE LA FECHA ENVIADA                            */
   /*-----------------------------------------------------------------------------*/
      SET @FECHA_INICIAL_MES_STR = LTRIM(RTRIM(CONVERT(VARCHAR,YEAR(@FECHA))))
	                             + '-' 
						         + LTRIM(RTRIM(CONVERT(VARCHAR,MONTH(@FECHA))))
						         + '-01'  


      SET @FECHA_INICIAL_MES = CONVERT(DATETIME,@FECHA_INICIAL_MES_STR)
	 

   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE OPERACIONES                */
   /*-----------------------------------------------------------------------------*/
	 INSERT @OPERACIONES
	 SELECT OPERACION         
	       ,TIPO_FLUJO        
	       ,TIPO_SWAP         
	       ,RUT_CLIENTE       
	       ,RUT_DV            
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
	       ,CARTERA           
	       ,NOMBRE_CLIENTE
		   ,MONEDA_PAGO_STR
		   ,'V'
       
	 FROM REPORTES.DBO.CARTERA_SWAP(@FECHA)		       


   /*-----------------------------------------------------------------------------*/
   /* SE DEVEN INCLUIR TODAS LAS OPERACIONES VENCIDAS                             */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @OPERACIONES
     SELECT OPERACION         
	       ,TIPO_FLUJO        
	       ,TIPO_SWAP         
	       ,RUT_CLIENTE       
	       ,RUT_DV            
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
	       ,CARTERA           
	       ,NOMBRE_CLIENTE
		   ,MONEDA_PAGO_STR
		   ,'H'
       FROM REPORTES.DBO.CARTERA_SWAP_HIS(@FECHA_INICIAL_MES ,DATEADD(DD,-1,@FECHA))		       
           



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
   /* CURSOR DE CONTABILIDAD SOLO ARBITRAJES                                      */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT  OPERACION
			 ,ESTADO
        FROM @OPERACIONES
	   GROUP BY OPERACION
	           ,ESTADO
	   ORDER BY OPERACION ASC


        OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_ESTADO 


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN




          /*----------------------------------------------------------------------*/
	      /* EXTRAER INFORMACION DE LA CARTERA DE RESPALDO CON EL N° OPE          */
		  /* INFORMACION GENERAL                                                  */
          /*----------------------------------------------------------------------*/
		    SELECT @TIPO_FLUJO        = TIPO_FLUJO
	              ,@TIPO_SWAP         = TIPO_SWAP
	              ,@RUT_CLIENTE       = RUT_CLIENTE
				  ,@RUT_DV            = RUT_DV
	              ,@COD_CLIENTE       = COD_CLIENTE
	              ,@FECHA_CIERRE      = FECHA_CIERRE
	              ,@FECHA_INICIO      = FECHA_INICIO
	              ,@FECHA_TERMINO     = FECHA_TERMINO
		          ,@FECHA_VENCIMIENTO = FECHA_VENCIMIENTO 
				  ,@VALOR_RAZONABLE   = VALOR_RAZONABLE
				  ,@MODALIDAD_PAGO    = MODALIDAD_PAGO
				  ,@FECHA_LIQUIDACION = FECHA_LIQUIDACION
				  ,@CARTERA_INVERSION = CARTERA_NORMATIVA
				  ,@CARTERA           = CARTERA
				  ,@MODALIDAD         = MODALIDAD
				  ,@NOMBRE_CLIENTE    = NOMBRE_CLIENTE
				  ,@ESTADO            = ESTADO
		      FROM @OPERACIONES 	    
		     WHERE OPERACION          = @OPE_NUMERO_OPERACION
			   AND ESTADO             = @OPE_ESTADO

          /*----------------------------------------------------------------------*/
  		  /* INFORMACION PATA ACTIVA                                              */
		  /*----------------------------------------------------------------------*/
		    SELECT @A_NOMINAL          = NOMINAL
	          	  ,@A_COD_MONEDA       = MONEDA 
				  ,@A_MONEDA           = STR_MONEDA 
				  ,@A_FRECUENCIA_PAGO  = FRECUENCIA_PAGO 
				  ,@A_INDICADOR        = INDICADOR 
				  ,@A_MTM              = MTM_MOVIMIENTO
				  ,@A_MONEDA_PAGO      = MONEDA_PAGO 
				  ,@A_MONEDA_PAGO_STR  = MONEDA_PAGO_STR
			  FROM @OPERACIONES 	    
			 WHERE OPERACION           = @OPE_NUMERO_OPERACION
			   AND TIPO_FLUJO          = 1 
			   AND ESTADO              = @OPE_ESTADO
			

          /*----------------------------------------------------------------------*/
  		  /* INFORMACION PATA PASIVA                                              */
		  /*----------------------------------------------------------------------*/
		    SELECT @P_NOMINAL          = NOMINAL
	          	  ,@P_COD_MONEDA       = MONEDA 
				  ,@P_MONEDA           = STR_MONEDA 
				  ,@P_FRECUENCIA_PAGO  = FRECUENCIA_PAGO 
				  ,@P_INDICADOR        = INDICADOR 
				  ,@P_MTM              = MTM_MOVIMIENTO
				  ,@P_MONEDA_PAGO      = MONEDA_PAGO 
				  ,@P_MONEDA_PAGO_STR  = MONEDA_PAGO_STR
			  FROM @OPERACIONES 	    
			 WHERE OPERACION           = @OPE_NUMERO_OPERACION
			   AND TIPO_FLUJO          = 2
			   AND ESTADO              = @OPE_ESTADO




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
            SELECT @INT_NERO_DEAL                        = @OPE_NUMERO_OPERACION
	              ,@INT_RUT_CLIENTE                      = LTRIM(RTRIM(@RUT_CLIENTE)) + '-' + LTRIM(RTRIM(@RUT_DV))
	              ,@INT_NOMBRE_CLIENTE                   = SUBSTRING(LTRIM(RTRIM(@NOMBRE_CLIENTE)),1,35)
	              ,@INT_CARTERA                          = @CARTERA--Reportes.dbo.Fx_Convalida_Cartera_Normativa ('ADM',@CARTERA_INVERSION)
	              ,@INT_TIPO_INSTRUMENTO                 = ''
	              ,@INT_FECHA_INGRESO                    = @FECHA_CIERRE
	              ,@INT_FECHA_INICIO                     = @FECHA_INICIO
	              ,@INT_FECHA_VENCIMIENTO                = CASE WHEN @ESTADO ='V' THEN @FECHA_TERMINO
				                                                ELSE @FECHA_VENCIMIENTO
														   END
	              ,@INT_MONEDA_LEG_ACTIVA                = @A_MONEDA
	              ,@INT_NOCIONAL_ACTIVO                  = @A_NOMINAL
	              ,@INT_MONEDA_LEG_PASIVA                = @P_MONEDA
	              ,@INT_NOCIONAL_PASIVO                  = @P_NOMINAL
	              ,@INT_TIPO_TASA_ACTIVO                 = @A_TIPO_TASA
	              ,@INT_TIPO_TASA_PASIVO                 = @P_TIPO_TASA
	              ,@INT_TIPO                             = ''
	              ,@INT_MONEDA_MTM                       = 'CLP'
	              ,@INT_MTM_ACTIVO                       = @A_MTM
	              ,@INT_MTM_PASIVO                       = @P_MTM
	              ,@INT_MONTO_MTM                        = @VALOR_RAZONABLE
	              ,@INT_MONTO_MTM_CLP                    = @VALOR_RAZONABLE
	              ,@INT_MODALIDAD_NOCIONALES             = @MODALIDAD_PAGO
	              ,@INT_MODALIDAD_INTERES                = @MODALIDAD_PAGO
	              ,@INT_FECHA_LIQUIDACION                = @FECHA_LIQUIDACION
	              ,@INT_MONEDA_PAGO_1                    = ''
	              ,@INT_LIQUIDACION_NOCIONALES_RECIBIDOS = REPORTES.DBO.Fx_RetornaSumasHis_Swap(@OPE_NUMERO_OPERACION,1,1)
	              ,@INT_LIQUIDACION_INTERES_RECIBIDOS    = REPORTES.DBO.Fx_RetornaSumasHis_Swap(@OPE_NUMERO_OPERACION,1,2)
                  ,@INT_MONEDA_PAGO_2                    =''
	              ,@INT_LIQUIDACION_NOCIONALES_PAGADOS   = REPORTES.DBO.Fx_RetornaSumasHis_Swap(@OPE_NUMERO_OPERACION,2,1)
	              ,@INT_LIQUIDACION_INTERES_PAGADOS      = REPORTES.DBO.Fx_RetornaSumasHis_Swap(@OPE_NUMERO_OPERACION,2,2)
	              ,@INT_LIQUIDACION_NETA_INTERES         = 0
	              ,@INT_TOTAL_NOCIONA_ACTIVO_RECIBIMOS   = 0
	              ,@INT_TOTAL_INTERES_ACTIVOS_RECIBIDOS  = 0
	              ,@INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS   = 0
	              ,@INT_TOTAL_INTERES_PASIVOS_PAGADOS    = 0
	              ,@INT_REPORTE_CASA_MATRIZ              = 'Reporte Swap Digital'
	              ,@INT_R_STATUS                         = CASE WHEN @ESTADO ='V' THEN 'Vigente' 
				                                                WHEN @ESTADO ='H' THEN 'Vencidos'
																ELSE ''
														   END

          /*----------------------------------------------------------------------*/
	      /* DETERMINAR TIPO DE INSTRUMENTO                                       */
		  /*----------------------------------------------------------------------*/
		    IF @A_COD_MONEDA != @P_COD_MONEDA BEGIN
			   SET @INT_TIPO_INSTRUMENTO = 'CCS' 
			                             + '_' 
										 + @A_MONEDA 
										 + '_' 
										 + @P_MONEDA 
										 + '_' 
										 + CASE WHEN @MODALIDAD ='E' THEN 'EF' 
										        WHEN @MODALIDAD ='C' THEN 'COM' 
												ELSE ''
										   END
			END
			ELSE BEGIN
			   SET @INT_TIPO_INSTRUMENTO = 'IRS' 
			                             + '_' 
										 + @A_MONEDA 
										 + '_' 
										 + @P_MONEDA 
										 + '_' 
										 + CASE WHEN @MODALIDAD ='E' THEN 'EF' 
										        WHEN @MODALIDAD ='C' THEN 'COM' 
												ELSE ''
										   END
			END
            

		
          /*----------------------------------------------------------------------*/
	      /* DETERMINAR CUENTA CONTABLE DE NOCIONALES                             */
		  /*----------------------------------------------------------------------*/
		    IF @ESTADO ='V' BEGIN
		       DELETE FROM @NOCIONALES_CONTABLES
		       INSERT INTO @NOCIONALES_CONTABLES
		       SELECT Cuenta              
	                 ,Tipo_Monto          
	                 ,Moneda              
                     ,ID_SISTEMA          
                     ,TIPO_MOVIMIENTO     
                     ,TIPO_OPERACION      
                     ,OPERACION           
                     ,MONEDA_INSTRUMENTO  
                     ,CORRELATIVO         
                     ,CORRELATIVO_PER     
	                 ,Nombre_Campo        
	                 ,FOLIO_PERFIL        
	                 ,CODIGO_CAMPO        
	                 ,CODIGO_CAMPO_VAR    
	                 ,GLOSA_PERFIL        
	                 ,TIPO_CUENTA         
	                 ,DESCRIPCION         
	            FROM REPORTES.DBO.ContabilidadNominalSwap(@FECHA,@OPE_NUMERO_OPERACION)
   		      ORDER BY FOLIO_PERFIL
			          ,TIPO_MONTO

		    END
		    IF @ESTADO ='H' BEGIN



		       DELETE FROM @NOCIONALES_CONTABLES
		       INSERT INTO @NOCIONALES_CONTABLES
		       SELECT Cuenta              
	                 ,Tipo_Monto          
	                 ,Moneda              
                     ,ID_SISTEMA          
                     ,TIPO_MOVIMIENTO     
                     ,TIPO_OPERACION      
                     ,OPERACION           
                     ,MONEDA_INSTRUMENTO  
                     ,CORRELATIVO         
                     ,CORRELATIVO_PER     
	                 ,Nombre_Campo        
	                 ,FOLIO_PERFIL        
	                 ,CODIGO_CAMPO        
	                 ,CODIGO_CAMPO_VAR    
	                 ,GLOSA_PERFIL        
	                 ,TIPO_CUENTA         
	                 ,DESCRIPCION         
	            FROM REPORTES.DBO.ContabilidadNominalSwapHIS(@OPE_NUMERO_OPERACION)
   		      ORDER BY FOLIO_PERFIL
			          ,TIPO_MONTO

		    END

          /*----------------------------------------------------------------------*/
	      /* DETERMINAR EL TIPO DE OPERACION                                      */
		  /*----------------------------------------------------------------------*/
		    SET @INT_NOCIONAL_RECIBO =''
			SET @INT_NOCIONAL_PAGO   =''

		    IF @TIPO_SWAP = 1 BEGIN


			      SET @INT_NOCIONAL_RECIBO = ''
			   SELECT @INT_NOCIONAL_RECIBO = CUENTA
			     FROM @NOCIONALES_CONTABLES
			    WHERE TIPO_OPERACION = '1C'
			      AND TIPO_MONTO     = 'D'
				

			      SET @INT_NOCIONAL_PAGO = ''
			   SELECT @INT_NOCIONAL_PAGO = CUENTA
			     FROM @NOCIONALES_CONTABLES
			    WHERE TIPO_OPERACION = '1V'
			      AND TIPO_MONTO     = 'D'

			END

		    IF @TIPO_SWAP = 2 BEGIN


			      SET @INT_NOCIONAL_RECIBO = ''
			   SELECT @INT_NOCIONAL_RECIBO = CUENTA
			     FROM @NOCIONALES_CONTABLES
			    WHERE TIPO_OPERACION = '2C'
			      AND TIPO_MONTO     = 'D'
				

			      SET @INT_NOCIONAL_PAGO = ''
			   SELECT @INT_NOCIONAL_PAGO = CUENTA
			     FROM @NOCIONALES_CONTABLES
			    WHERE TIPO_OPERACION = '2V'
			      AND TIPO_MONTO     = 'D'

			END
			

		    IF @TIPO_SWAP = 4 BEGIN


			      SET @INT_NOCIONAL_RECIBO = ''
			   SELECT @INT_NOCIONAL_RECIBO = CUENTA
			     FROM @NOCIONALES_CONTABLES
			    WHERE TIPO_OPERACION = '4'
			      AND TIPO_MONTO     = 'D'
				

			      SET @INT_NOCIONAL_PAGO = ''
			   SELECT @INT_NOCIONAL_PAGO = CUENTA
			     FROM @NOCIONALES_CONTABLES
			    WHERE TIPO_OPERACION = '4'
			      AND TIPO_MONTO     = 'D'

			END					 




          /*----------------------------------------------------------------------*/
	      /* CUENTA CONTABLE DE DEVENGO                                           */
		  /*---------------------------------------------------------------------*/
		    IF @ESTADO ='V' BEGIN
	           IF @VALOR_RAZONABLE > 0 BEGIN


			        SET @INT_CUENTA_ACT_PAS = ''
		         SELECT @INT_CUENTA_ACT_PAS = CUENTA_CONTABLE
		           FROM ContabilidadDevengoSwap(@FECHA,@OPE_NUMERO_OPERACION)
		          WHERE COD_CAMPO              = 204
		            AND TIPO_MOVIMIENTO_CUENTA ='D'


			   END

		       IF @VALOR_RAZONABLE < 0 BEGIN

			        SET @INT_CUENTA_ACT_PAS = ''
		         SELECT @INT_CUENTA_ACT_PAS = CUENTA_CONTABLE
		           FROM ContabilidadDevengoSwap(@FECHA,@OPE_NUMERO_OPERACION)
		          WHERE COD_CAMPO              = 205
		            AND TIPO_MOVIMIENTO_CUENTA ='H'
			   

		       END

			END
          /*----------------------------------------------------------------------*/
	      /* CUENTA CONTABLE DE DEVENGO                                           */
		  /*---------------------------------------------------------------------*/
		    IF @ESTADO ='H' BEGIN
	           IF @VALOR_RAZONABLE > 0 BEGIN


			        SET @INT_CUENTA_ACT_PAS = ''
		         SELECT @INT_CUENTA_ACT_PAS = CUENTA_CONTABLE
		           FROM ContabilidadDevengoSwapHIS(@OPE_NUMERO_OPERACION)
		          WHERE COD_CAMPO              = 204
		            AND TIPO_MOVIMIENTO_CUENTA ='D'


			   END

		       IF @VALOR_RAZONABLE < 0 BEGIN

			        SET @INT_CUENTA_ACT_PAS = ''
		         SELECT @INT_CUENTA_ACT_PAS = CUENTA_CONTABLE
		           FROM ContabilidadDevengoSwapHIS(@OPE_NUMERO_OPERACION)
		          WHERE COD_CAMPO              = 205
		            AND TIPO_MOVIMIENTO_CUENTA ='H'
			   

		       END

			END
          /*----------------------------------------------------------------------*/
	      /* FIN CUENTA CONTABLE DE DEVENGO                                       */
		  /*----------------------------------------------------------------------*/
		  SET @INT_REPORTE_CASA_MATRIZ = (SELECT CATEGORIA 
			                               FROM REPORTES.DBO.CODIGOS_COSIF(@INT_NOCIONAL_RECIBO))








          /*----------------------------------------------------------------------*/
	      /* INGRESA REGISTROS POR OPERACION                                      */
		  /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA_2
		    (NERO_DEAL     	                      ,RUT_CLIENTE                         ,NOMBRE_CLIENTE                        ,CARTERA       	                   ,TIPO_INSTRUMENTO                 
            ,FECHA_INGRESO                        ,FECHA_INICIO                        ,FECHA_VENCIMIENTO                     ,MONEDA_LEG_ACTIVA                   ,NOCIONAL_ACTIVO                  
            ,MONEDA_LEG_PASIVA                    ,NOCIONAL_PASIVO                     ,TIPO_TASA_ACTIVO                      ,TIPO_TASA_PASIVO                    ,TIPO                             
            ,MONEDA_MTM                           ,MTM_ACTIVO                          ,MTM_PASIVO                         ,MONTO_MTM                           ,MONTO_MTM_CLP                    
            ,CUENTA_ACT_PAS                       ,NOCIONAL_RECIBO                     ,NOCIONAL_PAGO                         ,MODALIDAD_NOCIONALES                ,MODALIDAD_INTERES                
            ,FECHA_LIQUIDACION                    ,MONEDA_PAGO_1                       ,LIQUIDACION_NOCIONALES_RECIBIDOS      ,LIQUIDACION_INTERES_RECIBIDOS       ,MONEDA_PAGO_2                    
            ,LIQUIDACION_NOCIONALES_PAGADOS       ,LIQUIDACION_INTERES_PAGADOS         ,LIQUIDACION_NETA_INTERES              ,TOTAL_NOCIONA_ACTIVO_RECIBIMOS      ,TOTAL_INTERES_ACTIVOS_RECIBIDOS 
		    ,TOTAL_NOCIONAL_PASIVOS_PAGADOS       ,TOTAL_INTERES_PASIVOS_PAGADOS       ,REPORTE_CASA_MATRIZ                   ,R_STATUS )                        
		   
		    VALUES
		    (@INT_NERO_DEAL     	              ,@INT_RUT_CLIENTE                    ,@INT_NOMBRE_CLIENTE                   ,@INT_CARTERA       	               ,@INT_TIPO_INSTRUMENTO                 
	        ,@INT_FECHA_INGRESO                   ,@INT_FECHA_INICIO                   ,@INT_FECHA_VENCIMIENTO                ,@INT_MONEDA_LEG_ACTIVA              ,@INT_NOCIONAL_ACTIVO                  
	        ,@INT_MONEDA_LEG_PASIVA               ,@INT_NOCIONAL_PASIVO                ,@INT_TIPO_TASA_ACTIVO                 ,@INT_TIPO_TASA_PASIVO               ,@INT_TIPO                             
	        ,@INT_MONEDA_MTM                      ,@INT_MTM_ACTIVO                     ,@INT_MTM_PASIVO                       ,@INT_MONTO_MTM                      ,@INT_MONTO_MTM_CLP                    
	        ,@INT_CUENTA_ACT_PAS                  ,@INT_NOCIONAL_RECIBO                ,@INT_NOCIONAL_PAGO                    ,@INT_MODALIDAD_NOCIONALES           ,@INT_MODALIDAD_INTERES                
	        ,@INT_FECHA_LIQUIDACION               ,@INT_MONEDA_PAGO_1                  ,@INT_LIQUIDACION_NOCIONALES_RECIBIDOS ,@INT_LIQUIDACION_INTERES_RECIBIDOS  ,@INT_MONEDA_PAGO_2                    
	        ,@INT_LIQUIDACION_NOCIONALES_PAGADOS  ,@INT_LIQUIDACION_INTERES_PAGADOS    ,@INT_LIQUIDACION_NETA_INTERES         ,@INT_TOTAL_NOCIONA_ACTIVO_RECIBIMOS ,@INT_TOTAL_INTERES_ACTIVOS_RECIBIDOS 
		    ,@INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS  ,@INT_TOTAL_INTERES_PASIVOS_PAGADOS  ,@INT_REPORTE_CASA_MATRIZ              ,@INT_R_STATUS )                        


          /*----------------------------------------------------------------------*/
	      /* ACTAUALIZACION DE VALORES COMPUESTOS                                 */
		  /*----------------------------------------------------------------------*/
		    UPDATE @SALIDA_2
			   SET LIQUIDACION_NETA_INTERES         = LIQUIDACION_NOCIONALES_RECIBIDOS - LIQUIDACION_NOCIONALES_PAGADOS
	              ,TOTAL_NOCIONA_ACTIVO_RECIBIMOS   = 0
	              ,TOTAL_INTERES_ACTIVOS_RECIBIDOS  = LIQUIDACION_NOCIONALES_RECIBIDOS
	              ,TOTAL_NOCIONAL_PASIVOS_PAGADOS   = 0
	              ,TOTAL_INTERES_PASIVOS_PAGADOS    = LIQUIDACION_NOCIONALES_PAGADOS
				  ,MONEDA_PAGO_1                    = CASE
				                                      WHEN (LIQUIDACION_NOCIONALES_RECIBIDOS + LIQUIDACION_NOCIONALES_PAGADOS
													       +LIQUIDACION_INTERES_RECIBIDOS    + LIQUIDACION_INTERES_PAGADOS ) != 0 THEN @A_MONEDA_PAGO_STR
										              ELSE ''
										              END
				  ,MONEDA_PAGO_2         = CASE
				                                      WHEN (LIQUIDACION_NOCIONALES_RECIBIDOS + LIQUIDACION_NOCIONALES_PAGADOS
													       +LIQUIDACION_INTERES_RECIBIDOS    + LIQUIDACION_INTERES_PAGADOS ) != 0 THEN @P_MONEDA_PAGO_STR
													  ELSE ''
													  END
			 WHERE NERO_DEAL = @OPE_NUMERO_OPERACION
				              






			FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_ESTADO   
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES




   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
	 SELECT NERO_DEAL                        
	       ,RUT_CLIENTE                      
	       ,NOMBRE_CLIENTE                   
	       ,CARTERA                          
	       ,TIPO_INSTRUMENTO
	       ,CONVERT(CHAR(10),FECHA_INGRESO,103)         AS FECHA_INGRESO
	       ,CONVERT(CHAR(10),FECHA_INICIO,103)          AS FECHA_INICIO           
	       ,CONVERT(CHAR(10),FECHA_VENCIMIENTO,103)     AS FECHA_VENCIMIENTO           
	       ,MONEDA_LEG_ACTIVA                
	       ,NOCIONAL_ACTIVO                  
	       ,MONEDA_LEG_PASIVA                
	       ,NOCIONAL_PASIVO                  
	       ,TIPO_TASA_ACTIVO 
	       ,TIPO_TASA_PASIVO 
	       ,TIPO                             
	       ,MONEDA_MTM                       
	       ,MTM_ACTIVO                       
	       ,MTM_PASIVO                       
	       ,MONTO_MTM                        
	       ,MONTO_MTM_CLP                    
	       ,CUENTA_ACT_PAS                   
	       ,NOCIONAL_RECIBO                  
	       ,NOCIONAL_PAGO                    
	       ,MODALIDAD_NOCIONALES             
	       ,MODALIDAD_INTERES                
	       ,CONVERT(CHAR(10),FECHA_LIQUIDACION,103) AS FECHA_LIQUIDACION
	       ,MONEDA_PAGO_1                    
	       ,LIQUIDACION_NOCIONALES_RECIBIDOS 
	       ,LIQUIDACION_INTERES_RECIBIDOS    
           ,MONEDA_PAGO_2                    
	       ,LIQUIDACION_NOCIONALES_PAGADOS   
	       ,LIQUIDACION_INTERES_PAGADOS      
	       ,LIQUIDACION_NETA_INTERES         
	       ,TOTAL_NOCIONA_ACTIVO_RECIBIMOS   
	       ,TOTAL_INTERES_ACTIVOS_RECIBIDOS  
	       ,TOTAL_NOCIONAL_PASIVOS_PAGADOS   
	       ,TOTAL_INTERES_PASIVOS_PAGADOS    
	       ,REPORTE_CASA_MATRIZ              
	       ,R_STATUS                         
	  FROM @SALIDA_2
	 ORDER BY NERO_DEAL

END
GO
