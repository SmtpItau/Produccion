USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_CARTERA_FWD_ARB]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_CARTERA_FWD_ARB]    
                      @FECHA DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

  /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD FORWARD                                        */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_REPORTE_CARTERA_FWD_ARB '2015-12-30'
	 
   
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @MONEDA               INT
			,@FECHA_INGRESO        DATETIME
			,@FECHA_VENCTO         DATETIME
			,@RUT_CLIENTE          NUMERIC
			,@COD_CLIENTE          NUMERIC
			,@COD_PRODUCTO         INT
			,@TIPO_OPERACION       CHAR(01)
			,@TIPO_TRANSACCION     CHAR(01)
			,@MONTO                numeric(25,4)
			,@MONEDA_STR           CHAR(04)
			,@NOMBRE_CLIENTE       VARCHAR(100)
			,@PAIS                 INT
			,@VALOR_RAZONABLE      DECIMAL
			,@PRODUCTO             VARCHAR(30)
	        ,@CNPJ                 VARCHAR(20)
			,@Clopcion             VARCHAR(02)
			,@MTM_ACTIVO           NUMERIC
			,@MTM_PASIVO           NUMERIC
			,@OPE_NUMERO_OPERACION NUMERIC

	




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
	 ,Valor_Principal      numeric(25,4)
	 ,Cosif_Obrigacao      VARCHAR(12)
	 ,Saldo_Obrigacao      numeric(25,4)
	 ,MTM                  FLOAT
	 ,Cosif_Adiantamento   VARCHAR(12)
	 ,Valor_Adiantamento   VARCHAR(17)
	 ,Cosif_Rendas         VARCHAR(12)
	 ,Valor_Rendas         VARCHAR(17)
	 ,Cod_Contraparte      VARCHAR(01)
	 ,Nome_Contraparte     VARCHAR(150)
	 ,CNPJ_CGI_Contraparte VARCHAR(20)
	 ,R_N                  VARCHAR(01)
	 ,Tipo_Perssoa         VARCHAR(02)
	 ,Pais_Contraparte     VARCHAR(03)
	 ,CNPJ_CGI_Compensacao VARCHAR(20)
	 ,Agencia              VARCHAR(04)
	 ,A_Relacion	       INT
	 ,A_MTM                FLOAT
	 ,A_CUENTA             VARCHAR(20)
	 ,A_COSIF              VARCHAR(20))




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
	        ,@Valor_Principal      numeric(25,4)
	        ,@Cosif_Obrigacao      VARCHAR(12)
	        ,@Saldo_Obrigacao      numeric(25,4)
	        ,@MTM                  FLOAT
	        ,@Cosif_Adiantamento   VARCHAR(12)
	        ,@Valor_Adiantamento   VARCHAR(17)
	        ,@Cosif_Rendas         VARCHAR(12)
	        ,@Valor_Rendas         VARCHAR(17)
	        ,@Cod_Contraparte      VARCHAR(01)
	        ,@Nome_Contraparte     VARCHAR(150)
	        ,@CNPJ_CGI_Contraparte VARCHAR(20)
	        ,@R_N                  VARCHAR(01)
	        ,@Tipo_Perssoa         VARCHAR(02)
	        ,@Pais_Contraparte     VARCHAR(03)
	        ,@CNPJ_CGI_Compensacao VARCHAR(20)
	        ,@Agencia              VARCHAR(04)
			,@A_Relacion	       INT
	        ,@A_MTM                FLOAT
	        ,@A_CUENTA             VARCHAR(20)
			,@A_COSIF              VARCHAR(20)


   /*-----------------------------------------------------------------------------*/
   /* TABLA OPERACIONES CARTERA                                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERACIONES TABLE
	 (OPERACION       NUMERIC
	 ,RUT_CLIENTE     NUMERIC
	 ,COD_CLIENTE     NUMERIC
	 ,COD_PRODUCTO    INT
	 ,COD_MONEDA      INT
	 ,MONTO           numeric(25,4)
	 ,TIPO_OPERACION  CHAR(01)
	 ,FECHA_INGRESO   DATETIME
	 ,FECHA_VCTO      DATETIME
	 ,VALOR_RAZONABLE FLOAT
	 ,TIPO_OPE_TRAN   CHAR(01)
	 ,ORDEN           INT
	 ,MONEDA_STR      VARCHAR(03)
     ,NOMBRE_CLIENTE  VARCHAR(100)
     ,PAIS            INT
     ,PRODUCTO        VARCHAR(30)
	 ,CNPJ            VARCHAR(20)
	 ,Clopcion        VARCHAR(02)
	 ,MTM_ACTIVO      NUMERIC
	 ,MTM_PASIVO      NUMERIC
	 ,A_RELACION      INT
	 ,A_MTM           FLOAT)





   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE OPERACIONES VIGENTE                                              */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @OPERACIONES
     SELECT canumoper 
	       ,cacodigo
		   ,cacodcli
	       ,cacodpos1 
		   ,cacodmon1 
		   ,camtomon1
		   ,catipoper 
		   ,cafecha 
		   ,cafecvcto
		   ,fRes_Obtenido
		   ,CASE 
			WHEN catipoper ='V' THEN 'V'
			WHEN catipoper ='C' THEN 'C'
			END
		   ,1  AS ORDEN
		   ,''
		   ,''
		   ,0
		   ,''
		   ,''
		   ,''
		   ,ValorRazonableActivo	
		   ,ValorRazonablePasivo
		   ,1	
		   ,0
       FROM bacfwdsuda.dbo.mfcares 
	  WHERE cafechaproceso      = @FECHA
	    AND cacodpos1           = 2
		AND cacartera_normativa ='T'
	  UNION 
     SELECT canumoper 
	       ,cacodigo
		   ,cacodcli
	       ,cacodpos1 
		   ,cacodmon2 
		   ,camtomon2
		   ,catipoper 
		   ,cafecha 
		   ,cafecvcto 
		   ,fRes_Obtenido
		   ,CASE 
		    WHEN catipoper ='V' THEN 'C'
			WHEN catipoper ='C' THEN 'V'
			END
		   ,2 AS ORDEN
		   ,''
		   ,''
		   ,0
		   ,''
		   ,''
		   ,''
		   ,ValorRazonableActivo	
		   ,ValorRazonablePasivo	
		   ,2
		   ,0
       FROM bacfwdsuda.dbo.mfcares 
	  WHERE cafechaproceso      = @FECHA
	    AND cacodpos1           = 2
		AND cacartera_normativa ='T'
	  ORDER BY canumoper ,ORDEN 

	  


   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR MONEDAS EN TABLA DE OPERACIONES                                  */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET MONEDA_STR  = MON.mnnemo 
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.MONEDA      MON
		 ON MON.mncodmon         = OPE.COD_MONEDA

		 

   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR NOMBRE CLIENTE                                                   */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET NOMBRE_CLIENTE  = CLI.Clnombre  
		   ,CNPJ            = ISNULL(CLI.CNPJ,LTRIM(RTRIM(CLI.Clrut)) + '-' + LTRIM(RTRIM(CLI.CLDV)))
		   ,PAIS            = CLI.CLPAIS
		   ,Clopcion        = CASE 
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
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.DBO.CLIENTE      CLI WITH(NOLOCK)
		 ON CLI.Clrut          = OPE.RUT_CLIENTE 
		AND CLI.Clcodigo       = OPE.COD_CLIENTE 



   /*-----------------------------------------------------------------------------*/
   /* PRODUCTO                                                                    */
   /*-----------------------------------------------------------------------------*/
     UPDATE OPE
	    SET PRODUCTO   = PRO.DESCRIPCION
	   FROM @OPERACIONES OPE
	  INNER JOIN
            BacParamSuda.dbo.PRODUCTO PRO
		 ON PRO.id_sistema      = 'BFW'
		AND PRO.CODIGO_PRODUCTO = OPE.COD_PRODUCTO 



   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR MTM DE CALCULO                                                   */
   /*-----------------------------------------------------------------------------*/
     UPDATE @OPERACIONES
	    SET A_MTM       = MTM_ACTIVO - MTM_PASIVO
	  WHERE A_RELACION  = 1



   /*-----------------------------------------------------------------------------*/
   /* ELIMINAR VENCIMIENTOS                                                       */
   /*-----------------------------------------------------------------------------*/
	  DELETE 
	    FROM @OPERACIONES
	   WHERE FECHA_VCTO <= @FECHA 




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
          /*POR CADA OPERACION SE DEBE REALIZAR UN REGISTRO QUE CUMPLA LA PARTIDA */
		  /*DOBLE DE LA CONTABILIDAD                                              */
          /*----------------------------------------------------------------------*/
            DECLARE CURSOR_CONTABILIDAD CURSOR LOCAL FOR
             SELECT COD_MONEDA 
				   ,FECHA_INGRESO
				   ,FECHA_VCTO  
				   ,RUT_CLIENTE 
				   ,COD_CLIENTE 
				   ,COD_PRODUCTO
				   ,TIPO_OPERACION 
				   ,TIPO_OPE_TRAN
				   ,VALOR_RAZONABLE 
				   ,MONTO
				   ,MONEDA_STR
				   ,NOMBRE_CLIENTE 
				   ,PAIS
				   ,PRODUCTO
	               ,CNPJ
				   ,Clopcion
				   ,MTM_ACTIVO
				   ,MTM_PASIVO
				   ,A_RELACION 
				   ,A_MTM
			   FROM @OPERACIONES 
			  WHERE OPERACION         = @OPE_NUMERO_OPERACION


               OPEN CURSOR_CONTABILIDAD
              FETCH NEXT FROM CURSOR_CONTABILIDAD INTO @MONEDA 
				                                      ,@FECHA_INGRESO
				                                      ,@FECHA_VENCTO  
				                                      ,@RUT_CLIENTE 
				                                      ,@COD_CLIENTE 
				                                      ,@COD_PRODUCTO
				                                      ,@TIPO_OPERACION 
				                                      ,@TIPO_TRANSACCION
				                                      ,@VALOR_RAZONABLE 
				                                      ,@MONTO
				                                      ,@MONEDA_STR
				                                      ,@NOMBRE_CLIENTE 
				                                      ,@PAIS
				                                      ,@PRODUCTO
	                                                  ,@CNPJ
				                                      ,@Clopcion
				                                      ,@MTM_ACTIVO
													  ,@MTM_PASIVO
													  ,@A_RELACION
													  ,@A_MTM
	                                   

          /*----------------------------------------------------------------------*/
          /* INICIO DE CICLO CONTABLE                                             */
          /*----------------------------------------------------------------------*/
            WHILE @@FETCH_STATUS  = 0 BEGIN

			 




			    /*----------------------------------------------------------------*/
				/* ASIGNACION DE VALORES PARA SER INSERTADOS EN SALIDA            */
			    /*----------------------------------------------------------------*/	
                  SELECT  @SISTEMA              ='TURING'
	                     ,@Operacao             = @OPE_NUMERO_OPERACION
	                     ,@Data_Inicio          = CONVERT(CHAR(10),@FECHA_INGRESO,112)
	                     ,@Data_Vencimento      = CONVERT(CHAR(10),@FECHA_VENCTO,112)
	                     ,@Dias_Atraso          = 0
	                     ,@Cod_Produto          = 'ARB' --@PRODUCTO
	                     ,@Tipo_Operacao        = @TIPO_TRANSACCION
	                     ,@Liquidacao           ='P'
	                     ,@Moeda_Balanco        = 'CLP'
	                     ,@Moeda_Operacao       = @MONEDA_STR
	                     ,@Cosif_Principal      = ''
	                     ,@Valor_Principal      = @MONTO 
	                     ,@Cosif_Obrigacao      = ''
	                     ,@Saldo_Obrigacao      = BacParamSuda.dbo.fx_convierte_monto_25(@FECHA_INGRESO,@MONEDA,@MONTO,999) 
	                     ,@Cosif_Adiantamento   ='000000000000'
	                     ,@Valor_Adiantamento   ='00000000000000000'
	                     ,@Cosif_Rendas         ='000000000000'
	                     ,@Valor_Rendas         ='00000000000000000'
	                     ,@Cod_Contraparte      = ''
	                     ,@Nome_Contraparte     = SUBSTRING(LTRIM(RTRIM(@NOMBRE_CLIENTE)),1,35)
	                     ,@CNPJ_CGI_Contraparte = @CNPJ 
	                     ,@R_N                  ='R'
	                     ,@Tipo_Perssoa         = @Clopcion
	                     ,@Pais_Contraparte     = DBO.Fx_RetornaPaisItau(@PAIS)
	                     ,@CNPJ_CGI_Compensacao ='00000000000000000000'
	                     ,@Agencia              ='0000'
						 ,@MTM                  = 0



			    /*----------------------------------------------------------------*/
				/* DEFINIR CUENTA CONTABLE                                        */
			    /*----------------------------------------------------------------*/
				  IF @Tipo_Operacao ='C' BEGIN
				     SET @Cosif_Principal = '182067000001'
					 SET @Cosif_Obrigacao = '492356090000'
					 SET @MTM             = @MTM_ACTIVO 
				  END

				  IF @Tipo_Operacao ='V' BEGIN
				     SET @Cosif_Principal = '492056080001'
					 SET @Cosif_Obrigacao = '182256020000'
					 SET @MTM             = @MTM_PASIVO * -1
				  END


			    /*----------------------------------------------------------------*/
				/* DEFINIR CUENTA CONTABLE                                        */
			    /*----------------------------------------------------------------*/
				  SET @A_CUENTA =''
		          IF @VALOR_RAZONABLE > 0 BEGIN

		
                        SET @A_CUENTA = ''
		             SELECT @A_CUENTA = CUENTA_CONTABLE
		               FROM ContabilidadDevengoForward(@FECHA,@OPE_NUMERO_OPERACION)
		              WHERE COD_CAMPO              = 304
		                AND TIPO_MOVIMIENTO_CUENTA ='D'

			      END

		          IF @VALOR_RAZONABLE < 0 BEGIN

			            SET @A_CUENTA = ''
		             SELECT @A_CUENTA = CUENTA_CONTABLE
		               FROM ContabilidadDevengoForward(@FECHA,@OPE_NUMERO_OPERACION)
		              WHERE COD_CAMPO              = 305
		                AND TIPO_MOVIMIENTO_CUENTA ='H'


			      END
			    /*----------------------------------------------------------------*/
				/* DEFINIR COSIF                                                  */
			    /*----------------------------------------------------------------*/
				     SET @A_COSIF = ''
				  SELECT @A_COSIF = COSIF FROM REPORTES.DBO.CODIGOS_COSIF(@A_CUENTA)
				  


			    /*----------------------------------------------------------------*/
				/* RESCATON VALOR DE COSIF                                        */
				/*----------------------------------------------------------------*/
                  INSERT INTO @SALIDA 
	              (SISTEMA              ,Operacao             , Data_Inicio         ,Data_Vencimento      ,Dias_Atraso         
	              ,Cod_Produto          ,Tipo_Operacao        , Liquidacao          ,Moeda_Balanco        ,Moeda_Operacao      
	              ,Cosif_Principal      ,Valor_Principal      , Cosif_Obrigacao     ,Saldo_Obrigacao      ,MTM                 
	              ,Cosif_Adiantamento   ,Valor_Adiantamento   , Cosif_Rendas        ,Valor_Rendas         ,Cod_Contraparte     
	              ,Nome_Contraparte     ,CNPJ_CGI_Contraparte , R_N                 ,Tipo_Perssoa         ,Pais_Contraparte    
	              ,CNPJ_CGI_Compensacao ,Agencia              , A_Relacion	        ,A_MTM                ,A_CUENTA    
				  ,A_COSIF)
	              Values
	              (@SISTEMA              ,@Operacao             , @Data_Inicio         ,@Data_Vencimento      ,@Dias_Atraso         
	              ,@Cod_Produto          ,@Tipo_Operacao        , @Liquidacao          ,@Moeda_Balanco        ,@Moeda_Operacao      
	              ,@Cosif_Principal      ,@Valor_Principal      , @Cosif_Obrigacao     ,@Saldo_Obrigacao      ,@MTM                 
	              ,@Cosif_Adiantamento   ,@Valor_Adiantamento   , @Cosif_Rendas        ,@Valor_Rendas         ,@Cod_Contraparte     
	              ,@Nome_Contraparte     ,@CNPJ_CGI_Contraparte , @R_N                 ,@Tipo_Perssoa         ,@Pais_Contraparte    
	              ,@CNPJ_CGI_Compensacao ,@Agencia              , @A_Relacion	       ,@A_MTM                ,@A_CUENTA
				  ,@A_COSIF)             


			    

			

              FETCH NEXT FROM CURSOR_CONTABILIDAD INTO @MONEDA 
				                                      ,@FECHA_INGRESO
				                                      ,@FECHA_VENCTO  
				                                      ,@RUT_CLIENTE 
				                                      ,@COD_CLIENTE 
				                                      ,@COD_PRODUCTO
				                                      ,@TIPO_OPERACION 
				                                      ,@TIPO_TRANSACCION
				                                      ,@VALOR_RAZONABLE 
				                                      ,@MONTO
				                                      ,@MONEDA_STR
				                                      ,@NOMBRE_CLIENTE 
				                                      ,@PAIS
				                                      ,@PRODUCTO
	                                                  ,@CNPJ
				                                      ,@Clopcion
				                                      ,@MTM_ACTIVO
													  ,@MTM_PASIVO 
													  ,@A_RELACION
													  ,@A_MTM 
													   
            END
            CLOSE CURSOR_CONTABILIDAD
            DEALLOCATE CURSOR_CONTABILIDAD
          /*----------------------------------------------------------------------*/
          /* FIN  CICLO CONTABLE                                                  */
          /*----------------------------------------------------------------------*/




       FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION  
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
		   ,A_Relacion	        
	       ,A_MTM               
	       ,A_CUENTA              
		   ,A_COSIF
	   FROM @SALIDA

END
GO
