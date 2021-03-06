USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_CONTABILIDAD_SPOT]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FUSION_CONTABILIDAD_SPOT]    
                      @FECHA DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   


    /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD SPOT                                           */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_FUSION_CONTABILIDAD_SPOT '2008-12-30'
	 
  
  
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE CURSOR                                          */
   /*-----------------------------------------------------------------------------*/
     DECLARE  @RUT_CLIENTE         NUMERIC
	         ,@COD_CLIENTE         INT
	         ,@MERCADO             VARCHAR(10)
	         ,@OPERACION           NUMERIC
	         ,@TIPO_OPERACION      VARCHAR(01)
	         ,@NOMBRE_CLIENTE      VARCHAR(150)
	         ,@MONEDA_1            VARCHAR(04)
	         ,@MONEDA_2            VARCHAR(04)
	         ,@COD_MONEDA_1        INT
	         ,@COD_MONEDA_2        INT
	         ,@MONTO               NUMERIC
	         ,@MOMONPE             NUMERIC
	         ,@FECHA_INGRESO       DATETIME
	         ,@FECHA_VALUTA_1      DATETIME
	         ,@FECHA_VALUTA_2      DATETIME
	         ,@PAIS                INT
             ,@CNPJ                VARCHAR(20)
	         ,@Clopcion            VARCHAR(03)
	         ,@RUT_DV              VARCHAR(02)
	         ,@CONTADOR            INT
			 ,@TIPO_OPERACION_TRAN VARCHAR(01)
			 ,@FECHA_INI_MES_STR   VARCHAR(10)
			 ,@FECHA_INICIO_MES    DATETIME
			 ,@FECHA_CIERRE_CONT   DATETIME
			


   /*-----------------------------------------------------------------------------*/
   /* GENERACION DE SALIDA                                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	 (SISTEMA              VARCHAR(15)
	 ,Operacao             NUMERIC
	 ,Data_Inicio          CHAR(08)
	 ,Data_Vencimento      CHAR(08)
	 ,Dias_Atraso          INT
	 ,Cod_Produto          VARCHAR(10)
	 ,Tipo_Operacao        VARCHAR(01)
	 ,Liquidacao           VARCHAR(01)
	 ,Moeda_Balanco        VARCHAR(03)
	 ,Moeda_Operacao       VARCHAR(03)
	 ,Cosif_Principal      VARCHAR(12)
	 ,Valor_Principal      FLOAT
	 ,Cosif_Obrigacao      VARCHAR(12)
	 ,Saldo_Obrigacao      FLOAT
	 ,MTM                  FLOAT
	 ,Cosif_Adiantamento   VARCHAR(12)
	 ,Valor_Adiantamento   VARCHAR(17)
	 ,Cosif_Rendas         VARCHAR(12)
	 ,Valor_Rendas         VARCHAR(17)
	 ,Cod_Contraparte      VARCHAR(01)
	 ,Nome_Contraparte     VARCHAR(150)
	 ,CNPJ_CGI_Contraparte VARCHAR(20)
	 ,R_N                  VARCHAR(01)
	 ,Tipo_Perssoa         VARCHAR(03)
	 ,Pais_Contraparte     VARCHAR(03)
	 ,CNPJ_CGI_Compensacao VARCHAR(20)
	 ,Agencia              VARCHAR(04))



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE LLENADO                                         */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SISTEMA              VARCHAR(15)
	        ,@Operacao             NUMERIC
	        ,@Data_Inicio          CHAR(08)
	        ,@Data_Vencimento      CHAR(08)
	        ,@Dias_Atraso          INT
	        ,@Cod_Produto          VARCHAR(10)
	        ,@Tipo_Operacao        VARCHAR(01)
	        ,@Liquidacao           VARCHAR(01)
	        ,@Moeda_Balanco        VARCHAR(03)
	        ,@Moeda_Operacao       VARCHAR(03)
	        ,@Cosif_Principal      VARCHAR(12)
	        ,@Valor_Principal      FLOAT
	        ,@Cosif_Obrigacao      VARCHAR(12)
	        ,@Saldo_Obrigacao      FLOAT
	        ,@MTM                  FLOAT
	        ,@Cosif_Adiantamento   VARCHAR(12)
	        ,@Valor_Adiantamento   VARCHAR(17)
	        ,@Cosif_Rendas         VARCHAR(12)
	        ,@Valor_Rendas         VARCHAR(17)
	        ,@Cod_Contraparte      VARCHAR(01)
	        ,@Nome_Contraparte     VARCHAR(150)
	        ,@CNPJ_CGI_Contraparte VARCHAR(20)
	        ,@R_N                  VARCHAR(01)
	        ,@Tipo_Perssoa         VARCHAR(03)
	        ,@Pais_Contraparte     VARCHAR(03)
	        ,@CNPJ_CGI_Compensacao VARCHAR(20)
	        ,@Agencia              VARCHAR(04)


   /*-----------------------------------------------------------------------------*/
   /* CREACION TABLA OPERACIONES                                                  */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERACIONES TABLE
	 (RUT_CLIENTE         NUMERIC
	 ,COD_CLIENTE         INT
	 ,MERCADO             VARCHAR(10)
	 ,OPERACION           NUMERIC
	 ,TIPO_OPERACION      VARCHAR(01)
	 ,NOMBRE_CLIENTE      VARCHAR(150)
	 ,MONEDA_1            VARCHAR(04)
	 ,MONEDA_2            VARCHAR(04)
	 ,COD_MONEDA_1        INT
	 ,COD_MONEDA_2        INT
	 ,MONTO               NUMERIC
	 ,MOMONPE             NUMERIC
	 ,FECHA_INGRESO       DATETIME
	 ,FECHA_VALUTA_1      DATETIME
	 ,FECHA_VALUTA_2      DATETIME
	 ,PAIS                INT
     ,CNPJ                VARCHAR(20)
	 ,Clopcion            VARCHAR(03)
	 ,RUT_DV              VARCHAR(02))
	 


   /*-----------------------------------------------------------------------------*/
   /* OPERACIONES                                                                 */
   /*-----------------------------------------------------------------------------*/
	 INSERT INTO @OPERACIONES
	 SELECT OPE.MORUTCLI 
	      , OPE.MOCODCLI 
	      , OPE.MOTIPMER 
	      , OPE.MONUMOPE 
		  , OPE.MOTIPOPE 
		  , OPE.MONOMCLI 
		  , OPE.MOCODMON
		  , OPE.MOCODCNV 
		  , MO1.mncodmon  
		  , MO2.mncodmon  
		  , OPE.MOMONMO 
		  , OPE.MOMONPE
		  , OPE.MOFECH
		  , OPE.MOVALUTA1 
		  , OPE.MOVALUTA2 
		  , CLI.CLPAIS 
		  , ISNULL(CLI.CNPJ,LTRIM(RTRIM(CLI.Clrut)) + '-' + LTRIM(RTRIM(CLI.CLDV))) 
		  , CASE 
			WHEN CLI.cltipcli = 8 THEN 'PF'
			WHEN CLI.cltipcli = 1 THEN 'IF'
			WHEN CLI.cltipcli = 2 THEN 'IF'
			WHEN CLI.cltipcli = 3 THEN 'IF'
			WHEN CLI.cltipcli = 4 THEN 'IF'
			WHEN CLI.cltipcli = 5 THEN 'IF'
			WHEN CLI.cltipcli = 6 THEN 'IF'
			WHEN CLI.cltipcli = 7 THEN 'PJ'
			WHEN CLI.cltipcli = 9 THEN 'PJ'
			WHEN CLI.cltipcli = 10 THEN 'PJ'
			WHEN CLI.cltipcli = 11 THEN 'PJ'
			WHEN CLI.cltipcli = 12 THEN 'PJ'
			WHEN CLI.cltipcli = 13 THEN 'PJ'
			ELSE  'PJ'
		    END 
		  , CLDV
       FROM BacCamSuda.dbo.memoh       OPE WITH(NOLOCK)
      INNER JOIN
	        BacParamSuda.DBO.MONEDA    MO1 WITH(NOLOCK)
	     ON	MO1.mnnemo  = OPE.MOCODMON
      INNER JOIN
	        BacParamSuda.DBO.MONEDA    MO2 WITH(NOLOCK)
	     ON	MO2.mnnemo    = OPE.MOCODCNV
	   LEFT JOIN
	        BacParamSuda.DBO.CLIENTE   CLI WITH(NOLOCK)
		 ON OPE.MORUTCLI   = CLI.Clrut          
		AND OPE.MOCODCLI   = CLI.Clcodigo       
	  WHERE MOFECH        <= @FECHA
	    AND OPE.MOVALUTA1  > @FECHA
		AND OPE.MOVALUTA2  > @FECHA
	    AND OPE.MOESTATUS  = ''
	--	AND OPE.MOTERM NOT IN('FORWARD','OPCIONES')


   /*-----------------------------------------------------------------------------*/
   /* CALCULO DE FECHA DE CIERRE                                                  */
   /*-----------------------------------------------------------------------------*/
     SET @FECHA_INI_MES_STR = CONVERT(VARCHAR,YEAR(@FECHA))
	                        + '-'
							+ CONVERT(VARCHAR,MONTH(@FECHA))
							+ '-'
							+ '01'


     SET @FECHA_INICIO_MES  = DATEADD(MM,1,CONVERT(DATETIME,@FECHA_INI_MES_STR))
	 SET @FECHA_CIERRE_CONT = (SELECT BACPARAMSUDA.dbo.FX_FECHA_HABIL_ANTERIOR(@FECHA_INICIO_MES))



   /*-----------------------------------------------------------------------------*/
   /* CURSOR DE CONTABILIDAD                                                      */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT RUT_CLIENTE         
	        ,COD_CLIENTE         
	        ,MERCADO             
	        ,OPERACION           
	        ,TIPO_OPERACION      
	        ,NOMBRE_CLIENTE      
	        ,MONEDA_1            
	        ,MONEDA_2            
	        ,COD_MONEDA_1        
	        ,COD_MONEDA_2        
	        ,MONTO               
	        ,MOMONPE             
	        ,FECHA_INGRESO       
	        ,FECHA_VALUTA_1      
	        ,FECHA_VALUTA_2      
	        ,PAIS                
            ,CNPJ                
	        ,Clopcion            
	        ,RUT_DV              
        FROM @OPERACIONES
	   ORDER BY OPERACION ASC



        OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @RUT_CLIENTE         
	                                          ,@COD_CLIENTE         
	                                          ,@MERCADO             
	                                          ,@OPERACION           
	                                          ,@TIPO_OPERACION      
	                                          ,@NOMBRE_CLIENTE      
	                                          ,@MONEDA_1            
	                                          ,@MONEDA_2            
	                                          ,@COD_MONEDA_1        
	                                          ,@COD_MONEDA_2        
	                                          ,@MONTO               
	                                          ,@MOMONPE             
	                                          ,@FECHA_INGRESO       
	                                          ,@FECHA_VALUTA_1      
	                                          ,@FECHA_VALUTA_2      
	                                          ,@PAIS                
                                              ,@CNPJ                
	                                          ,@Clopcion            
	                                          ,@RUT_DV              

   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


        /*------------------------------------------------------------------------*/
        /*------------------------------------------------------------------------*/
        /* CARTERA SPOT                                                           */
        /*------------------------------------------------------------------------*/
        /*------------------------------------------------------------------------*/
	      IF @MERCADO != 'ARBI' BEGIN


             /*-------------------------------------------------------------------*/
             /* INCIALIZACIONES DE SALIDA DE REPORTE                              */
             /*-------------------------------------------------------------------*/
               SELECT  @SISTEMA              ='TURING'
	                  ,@Operacao             = @OPERACION
	                  ,@Data_Inicio          = CONVERT(CHAR(10),@FECHA_INGRESO,112)
	                  ,@Dias_Atraso          = 0
	                  ,@Tipo_Operacao        = @TIPO_OPERACION
	                  ,@Liquidacao           ='P'
	                  ,@Moeda_Balanco        = 'CLP'
	                  ,@Moeda_Operacao       = @MONEDA_1
	                  ,@Valor_Principal      = @MOMONPE
	                  ,@Saldo_Obrigacao      = BacParamSuda.dbo.fx_convierte_monto_25(@FECHA_CIERRE_CONT,@COD_MONEDA_1,@MONTO,999) 
	                  ,@MTM                  = 0
	                  ,@Cosif_Adiantamento   ='000000000000'
	                  ,@Valor_Adiantamento   ='00000000000000000'
	                  ,@Cosif_Rendas         ='000000000000'
	                  ,@Valor_Rendas         ='00000000000000000'
	                  ,@Cod_Contraparte      = ''
	                  ,@Nome_Contraparte     = @NOMBRE_CLIENTE
	                  ,@CNPJ_CGI_Contraparte = @CNPJ
	                  ,@R_N                  ='N'
	                  ,@Tipo_Perssoa         = @Clopcion 
	                  ,@Pais_Contraparte     =DBO.Fx_RetornaPaisItau(@PAIS)
	                  ,@CNPJ_CGI_Compensacao ='00000000000000000000'
	                  ,@Agencia              ='0000'

             /*-------------------------------------------------------------------*/
             /* CASOS DE MERCADOS                                                 */
             /*-------------------------------------------------------------------*/
 		       SET @Cod_Produto = (CASE  WHEN @MERCADO IN('PTAS','EMPR') AND @Tipo_Operacao ='C' THEN 'CSPOT'
								         ELSE 'VSPOT'
								   END)
						
						           
               IF @Cod_Produto = 'CSPOT' BEGIN 
			      SET @Data_Vencimento      = CONVERT(CHAR(10),@FECHA_VALUTA_2,112)
			   END

               IF @Cod_Produto = 'VSPOT' BEGIN 
			      SET @Data_Vencimento      = CONVERT(CHAR(10),@FECHA_VALUTA_1,112)
			   END

             /*-------------------------------------------------------------------*/
             /* ASIGNACION DE VALORES PARA SER INSERTADOS EN SALIDA               */
             /*-------------------------------------------------------------------*/
			   IF @Cod_Produto = 'CSPOT' BEGIN
			      SET @Cosif_Principal = '182066070000'
			      SET @Cosif_Obrigacao = '492355060000'
			   END

			   IF @Cod_Produto = 'VSPOT' BEGIN
			      SET @Cosif_Principal = '492055050000'
			      SET @Cosif_Obrigacao = '182255090000'
			   END
             /*-------------------------------------------------------------------*/
             /* INSERTO SALIDA FINAL                                              */
             /*-------------------------------------------------------------------*/
			   INSERT INTO @SALIDA 
               (SISTEMA              ,Operacao             , Data_Inicio         ,Data_Vencimento      ,Dias_Atraso         
               ,Cod_Produto          ,Tipo_Operacao        , Liquidacao          ,Moeda_Balanco        ,Moeda_Operacao      
               ,Cosif_Principal      ,Valor_Principal      , Cosif_Obrigacao     ,Saldo_Obrigacao      ,MTM                 
               ,Cosif_Adiantamento   ,Valor_Adiantamento   , Cosif_Rendas        ,Valor_Rendas         ,Cod_Contraparte     
               ,Nome_Contraparte     ,CNPJ_CGI_Contraparte , R_N                 ,Tipo_Perssoa         ,Pais_Contraparte    
               ,CNPJ_CGI_Compensacao ,Agencia              )             
               Values
              (@SISTEMA              ,@Operacao             , @Data_Inicio         ,@Data_Vencimento      ,@Dias_Atraso         
              ,@Cod_Produto          ,@Tipo_Operacao        , @Liquidacao          ,@Moeda_Balanco        ,@Moeda_Operacao      
              ,@Cosif_Principal      ,@Valor_Principal      , @Cosif_Obrigacao     ,@Saldo_Obrigacao      ,@MTM                 
              ,@Cosif_Adiantamento   ,@Valor_Adiantamento   , @Cosif_Rendas        ,@Valor_Rendas         ,@Cod_Contraparte     
              ,@Nome_Contraparte     ,@CNPJ_CGI_Contraparte , @R_N                 ,@Tipo_Perssoa         ,@Pais_Contraparte    
              ,@CNPJ_CGI_Compensacao ,@Agencia            )  




		  END
        /*------------------------------------------------------------------------*/
        /*------------------------------------------------------------------------*/
        /* CARTERA ARBITRAJE                                                      */
        /*------------------------------------------------------------------------*/
        /*------------------------------------------------------------------------*/
	      IF @MERCADO = 'ARBI' BEGIN
		      
			  
             /*-------------------------------------------------------------------*/
             /* INICIO DE CICLO DE APERTURA DE DOS                                */
             /*-------------------------------------------------------------------*/
			     SET @CONTADOR  = 1
			   WHILE @CONTADOR <= 2 BEGIN




                   /*-------------------------------------------------------------*/
                   /* DETERMINAR OPERACION DE TRANSACCION                         */
                   /*-------------------------------------------------------------*/
				     IF @CONTADOR = 1 BEGIN
					    SET @TIPO_OPERACION_TRAN = @TIPO_OPERACION
					 END
					 ELSE BEGIN

				         SET @TIPO_OPERACION_TRAN = CASE WHEN @TIPO_OPERACION ='V' THEN 'C'
					                                     WHEN @TIPO_OPERACION ='C' THEN 'V'
														 ELSE ''
												    END
					    
					 END




                   /*-------------------------------------------------------------*/
                   /* INCIALIZACIONES DE SALIDA DE REPORTE                        */
                   /*-------------------------------------------------------------*/
                     SELECT  @SISTEMA              ='TURING'
	                        ,@Operacao             = @OPERACION
	                        ,@Data_Inicio          = CONVERT(CHAR(10),@FECHA_INGRESO,112)
	                        ,@Dias_Atraso          = 0
	                        ,@Tipo_Operacao        = @TIPO_OPERACION_TRAN
	                        ,@Liquidacao           ='P'
	                        ,@Moeda_Balanco        = 'CLP'
	                        ,@Moeda_Operacao       = CASE WHEN @CONTADOR = 1 THEN @MONEDA_1 ELSE @MONEDA_2 END
	                        ,@Valor_Principal      = @MOMONPE
	                        ,@MTM                  = 0
	                        ,@Cosif_Adiantamento   ='000000000000'
	                        ,@Valor_Adiantamento   ='00000000000000000'
	                        ,@Cosif_Rendas         ='000000000000'
	                        ,@Valor_Rendas         ='00000000000000000'
	                        ,@Cod_Contraparte      = ''
	                        ,@Nome_Contraparte     = @NOMBRE_CLIENTE
	                        ,@CNPJ_CGI_Contraparte = @CNPJ
	                        ,@R_N                  ='N'
	                        ,@Tipo_Perssoa         = CASE WHEN @Clopcion = 'J' THEN 'IF' ELSE 'PJ' END
	                        ,@Pais_Contraparte     =DBO.Fx_RetornaPaisItau(@PAIS)
	                        ,@CNPJ_CGI_Compensacao ='00000000000000000000'
	                        ,@Agencia              ='0000'


					 IF @CONTADOR = 1 BEGIN
					    SET @Saldo_Obrigacao      = BacParamSuda.dbo.fx_convierte_monto_25(@FECHA_INGRESO,@COD_MONEDA_1,@MONTO,999) 
					 END
					 IF @CONTADOR = 2 BEGIN
					    SET @Saldo_Obrigacao      = BacParamSuda.dbo.fx_convierte_monto_25(@FECHA_INGRESO,@COD_MONEDA_2,@MONTO,999) 
					 END

                   /*-------------------------------------------------------------*/
                   /* CASOS DE MERCADOS                                           */
                   /*-------------------------------------------------------------*/
 		             SET @Cod_Produto = 'ARB' 

					 IF @Tipo_Operacao = 'C' BEGIN 
			            SET @Data_Vencimento      = CONVERT(CHAR(10),@FECHA_VALUTA_2,112)
			         END

					 IF @Tipo_Operacao = 'V' BEGIN 
			            SET @Data_Vencimento      = CONVERT(CHAR(10),@FECHA_VALUTA_1,112)
			         END

                   /*-------------------------------------------------------------*/
                   /* ASIGNACION DE VALORES PARA SER INSERTADOS EN SALIDA         */
                   /*-------------------------------------------------------------*/
		             IF @Tipo_Operacao ='C' BEGIN
			            SET @Cosif_Principal = '182067000001'
			            SET @Cosif_Obrigacao = '492356090000'
		             END
		             ELSE BEGIN
                        SET @Cosif_Principal = '492056080001'
			            SET @Cosif_Obrigacao = '182256020000'
		             END

                   /*-------------------------------------------------------------*/
                   /* INSERTO SALIDA FINAL                                        */
                   /*-------------------------------------------------------------*/
			          INSERT INTO @SALIDA 
                      (SISTEMA              ,Operacao             , Data_Inicio         ,Data_Vencimento      ,Dias_Atraso         
                      ,Cod_Produto          ,Tipo_Operacao        , Liquidacao          ,Moeda_Balanco        ,Moeda_Operacao      
                      ,Cosif_Principal      ,Valor_Principal      , Cosif_Obrigacao     ,Saldo_Obrigacao      ,MTM                 
                      ,Cosif_Adiantamento   ,Valor_Adiantamento   , Cosif_Rendas        ,Valor_Rendas         ,Cod_Contraparte     
                      ,Nome_Contraparte     ,CNPJ_CGI_Contraparte , R_N                 ,Tipo_Perssoa         ,Pais_Contraparte    
                      ,CNPJ_CGI_Compensacao ,Agencia              )             
                      Values
                      (@SISTEMA              ,@Operacao             , @Data_Inicio         ,@Data_Vencimento      ,@Dias_Atraso         
                      ,@Cod_Produto          ,@Tipo_Operacao        , @Liquidacao          ,@Moeda_Balanco        ,@Moeda_Operacao      
                      ,@Cosif_Principal      ,@Valor_Principal      , @Cosif_Obrigacao     ,@Saldo_Obrigacao      ,@MTM                 
                      ,@Cosif_Adiantamento   ,@Valor_Adiantamento   , @Cosif_Rendas        ,@Valor_Rendas         ,@Cod_Contraparte     
                      ,@Nome_Contraparte     ,@CNPJ_CGI_Contraparte , @R_N                 ,@Tipo_Perssoa         ,@Pais_Contraparte    
                      ,@CNPJ_CGI_Compensacao ,@Agencia            )  


			   SET @CONTADOR = @CONTADOR + 1
			   END


		  END
        /*------------------------------------------------------------------------*/
        /*------------------------------------------------------------------------*/
        /* FIN CARTERA ARBITRAJE                                                  */
        /*------------------------------------------------------------------------*/
        /*------------------------------------------------------------------------*/
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @RUT_CLIENTE         
	                                          ,@COD_CLIENTE         
	                                          ,@MERCADO             
	                                          ,@OPERACION           
	                                          ,@TIPO_OPERACION      
	                                          ,@NOMBRE_CLIENTE      
	                                          ,@MONEDA_1            
	                                          ,@MONEDA_2            
	                                          ,@COD_MONEDA_1        
	                                          ,@COD_MONEDA_2        
	                                          ,@MONTO               
	                                          ,@MOMONPE             
	                                          ,@FECHA_INGRESO       
	                                          ,@FECHA_VALUTA_1      
	                                          ,@FECHA_VALUTA_2      
	                                          ,@PAIS                
                                              ,@CNPJ                
	                                          ,@Clopcion            
	                                          ,@RUT_DV  
											  
											       
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES

   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
	 SELECT SISTEMA              
	       ,Operacao             
	       ,Data_Inicio          
	       ,Data_Vencimento      
	       ,Dias_Atraso          
	       ,Cod_Produto          
	       ,Tipo_Operacao        
	       ,Liquidacao           
	       ,Moeda_Balanco        
	       ,Moeda_Operacao       
	       ,Cosif_Principal      
	       ,Valor_Principal      
	       ,Cosif_Obrigacao      
	       ,Saldo_Obrigacao      
	       ,MTM                  
	       ,Cosif_Adiantamento   
	       ,Valor_Adiantamento   
	       ,Cosif_Rendas         
	       ,Valor_Rendas         
	       ,Cod_Contraparte      
	       ,Nome_Contraparte     
	       ,CNPJ_CGI_Contraparte 
	       ,R_N                  
	       ,Tipo_Perssoa         
	       ,Pais_Contraparte     
	       ,CNPJ_CGI_Compensacao 
	       ,Agencia              
	   FROM @SALIDA
	   
	   
	   

END
GO
