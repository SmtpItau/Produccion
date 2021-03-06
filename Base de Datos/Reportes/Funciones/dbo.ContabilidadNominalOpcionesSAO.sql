USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[ContabilidadNominalOpcionesSAO]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ContabilidadNominalOpcionesSAO](@FECHA DATETIME ,@CONTRATO NUMERIC,@TIPO_MOVIMIENTO VARCHAR(03),@NUMERO_ESTRUCTURA INT)


 /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @CONTABILIDAD TABLE
	 (GLOSA_PERFIL           CHAR(70)
	 ,FOLIO_PERFIL           NUMERIC(5)
     ,ID_SISTEMA             CHAR(3)
     ,TIPO_MOVIMIENTO        CHAR(3)
     ,TIPO_OPERACION         CHAR(5)
     ,OPERACION              NUMERIC(10)
     ,CORRELATIVO            NUMERIC(5)
	 ,MONEDA_INSTRUMENTO     CHAR(6)
	 ,CUENTA_CONTABLE        VARCHAR(20)
	 ,TIPO_MOVIMIENTO_CUENTA VARCHAR(04)
	 ,COD_CAMPO              INT
	 ,TIPO_CUENTA            VARCHAR(04)
	 ,DESCRIPCION            VARCHAR(2000)
	 ,CAMPO_VARIABLE         CHAR(01))
	 
	 




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA OPCIONES SAO CONTABLE                               */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

  /*-----------------------------------------------------------------------------*/
   /* TABLA DE SALIDA                                                             */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	        (TIPO_VOUCHER           CHAR(1)
            ,GLOSA_PERFIL           CHAR(70)
		    ,FOLIO_PERFIL           NUMERIC(5)
            ,ID_SISTEMA             CHAR(3)
            ,TIPO_MOVIMIENTO        CHAR(3)
            ,TIPO_OPERACION         CHAR(5)
            ,OPERACION              NUMERIC(10)
            ,CORRELATIVO            NUMERIC(5)
			,MONEDA_INSTRUMENTO     CHAR(6)
			,CUENTA_CONTABLE        VARCHAR(20)
			,TIPO_MOVIMIENTO_CUENTA VARCHAR(02)
			,COD_CAMPO              INT
			,CAMPO_VARIABLE         CHAR(01))
			

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES CURSOR PRINCIPAL                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @CUR_TIPO_VOUCHER           CHAR(1)
            ,@CUR_GLOSA_PERFIL           CHAR(70)
		    ,@CUR_FOLIO_PERFIL           NUMERIC(5)
            ,@CUR_ID_SISTEMA             CHAR(3)
            ,@CUR_TIPO_MOVIMIENTO        CHAR(3)
            ,@CUR_TIPO_OPERACION         CHAR(5)
            ,@CUR_OPERACION              NUMERIC(10)
            ,@CUR_CORRELATIVO            NUMERIC(5)
			,@CUR_MONEDA_INSTRUMENTO     CHAR(6)
			,@CUR_TIPO_MARCA             CHAR(01)

     DECLARE @DET_CODIGO_CAMPO           NUMERIC(03)
	        ,@DET_TIPO_MOVIMIENTO_CUENTA CHAR(01)
            ,@DET_PERFIL_FIJO            CHAR(1)
            ,@DET_CODIGO_CUENTA          CHAR(20)
            ,@DET_CORRELATIVO_PERFIL     NUMERIC(3)
            ,@DET_CAMPO_VARIABLE         NUMERIC(3)
            ,@DET_FOLIO_PERFIL           NUMERIC(5)


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES AUXILIARES                                         */
   /*-----------------------------------------------------------------------------*/
     DECLARE @AUX_CODIGO_CUENTA          VARCHAR(20)


   /*-----------------------------------------------------------------------------*/
   /* BAC CONTABILIZA                                                             */
   /*-----------------------------------------------------------------------------*/
     DECLARE @BAC_CNT_CONTABILIZA TABLE
           ( ID_SISTEMA            VARCHAR(03)
           , TIPO_MOVIMIENTO       VARCHAR(03)
           , TIPO_OPERACION        VARCHAR(04)
           , OPERACION             NUMERIC
           , CODIGO_INSTRUMENTO    INT
           , MONEDA_INSTRUMENTO    INT)
           

  

   /*-----------------------------------------------------------------------------*/
   /* REPRESENTACION DE MODELO DE CONTABILIZACION PARA MOVIMIENTOS                */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @BAC_CNT_CONTABILIZA
	 SELECT MAS.CaSistema
	      , @TIPO_MOVIMIENTO
		  , ltrim( ltrim( DET.CaSubyacente ) ) + rtrim( ltrim( DET.CaCVOpc ) )+ substring( DET.CaCallPut, 1, 1 )
		  , MAS.CaNumContrato
		  , DET.CaCodMon2 
		  , DET.CaCodMon1
      FROM CbMdbOpc..CaResEncContrato       MAS
     INNER JOIN
           CbMdbOpc..OpcionEstructura       OES
	    ON OES.OpcEstCod          =  MAS.CaCodEstructura 
     INNER JOIN
           CbMdbOpc..CaResDetContrato       DET
	    ON DET.CaDetFechaRespaldo = MAS.CaEncFechaRespaldo
	   AND DET.CaNumContrato      = MAS.CaNumContrato 
	   AND DET.CaNumEstructura    = @NUMERO_ESTRUCTURA
     WHERE MAS.CaEncFechaRespaldo = @FECHA
       AND MAS.CaEstado           = ''	
	   AND MAS.CaNumContrato      = @CONTRATO


	



     DECLARE CURSOR_CONTABLE CURSOR LOCAL FOR 
      SELECT PER.tipo_voucher
            ,PER.glosa_perfil
	        ,PER.folio_perfil
			,CON.id_sistema
			,CON.tipo_movimiento
			,CON.tipo_operacion
			,CON.operacion
			,CON.moneda_instrumento
			,'N'
        FROM BacParamSuda..PERFIL_CNT PER
       INNER JOIN
             @BAC_CNT_CONTABILIZA     CON
	      ON CON.id_sistema         = PER.id_sistema
	     AND CON.tipo_movimiento    = PER.tipo_movimiento
	     AND CON.tipo_operacion     = PER.tipo_operacion
	     AND CON.codigo_instrumento = PER.codigo_instrumento
	     AND CON.moneda_instrumento = PER.moneda_instrumento
		 AND CON.OPERACION          = @CONTRATO
        OPEN CURSOR_CONTABLE
       FETCH NEXT FROM CURSOR_CONTABLE INTO @CUR_TIPO_VOUCHER  
                                           ,@CUR_GLOSA_PERFIL  
		                                   ,@CUR_FOLIO_PERFIL  
										   ,@CUR_ID_SISTEMA          
                                           ,@CUR_TIPO_MOVIMIENTO       
										   ,@CUR_TIPO_OPERACION        
                                           ,@CUR_OPERACION  
										   ,@CUR_MONEDA_INSTRUMENTO           
										   ,@CUR_TIPO_MARCA






   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO POR FOLIO                                                   */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS = 0 BEGIN



	    /*================================================================*/
	    /*----------------------------------------------------------------*/
		/* SEGUN EL FOLIO SE DEBE EXTRAER EL DETALLE A CONTABILIZAR       */
		/*----------------------------------------------------------------*/
		/*================================================================*/
		 DECLARE CURSOR_DETALLES CURSOR LOCAL FOR
		  SELECT Codigo_Campo
                ,Tipo_Movimiento_Cuenta
                ,Perfil_Fijo
                ,Codigo_Cuenta
                ,Correlativo_Perfil
                ,Codigo_Campo_Variable
		        ,folio_perfil
            FROM BacParamSuda..PERFIL_DETALLE_CNT
           WHERE Folio_Perfil = @CUR_FOLIO_PERFIL
           ORDER BY Folio_Perfil 
		          , Correlativo_Perfil


			

            OPEN CURSOR_DETALLES
           FETCH NEXT FROM CURSOR_DETALLES INTO @DET_CODIGO_CAMPO    
	                                           ,@DET_TIPO_MOVIMIENTO_CUENTA 
                                               ,@DET_PERFIL_FIJO            
                                               ,@DET_CODIGO_CUENTA          
                                               ,@DET_CORRELATIVO_PERFIL     
                                               ,@DET_CAMPO_VARIABLE         
											   ,@DET_FOLIO_PERFIL    


           WHILE @@FETCH_STATUS = 0 BEGIN




			   /*---------------------------------------------------------*/
			   /* EN OPCIONES TODAS LA CUENTAS SON FIJAS                  */
			   /*---------------------------------------------------------*/
  			     SET @AUX_CODIGO_CUENTA = ''
                 SET @AUX_CODIGO_CUENTA = @DET_CODIGO_CUENTA
					
				 

			   /*---------------------------------------------------------*/
			   /* INGRESO DE REGISTROS                                    */
			   /*---------------------------------------------------------*/
			     INSERT INTO @SALIDA
				 (TIPO_VOUCHER                  ,GLOSA_PERFIL      
		         ,FOLIO_PERFIL                  ,ID_SISTEMA             
                 ,TIPO_MOVIMIENTO               ,TIPO_OPERACION        
                 ,OPERACION                     ,CORRELATIVO      
			     ,MONEDA_INSTRUMENTO            ,CUENTA_CONTABLE 
				 ,TIPO_MOVIMIENTO_CUENTA        ,COD_CAMPO
				 ,CAMPO_VARIABLE)
				 VALUES
				 (@CUR_TIPO_VOUCHER            ,@CUR_GLOSA_PERFIL  
		         ,@CUR_FOLIO_PERFIL            ,@CUR_ID_SISTEMA             
                 ,@CUR_TIPO_MOVIMIENTO         ,@CUR_TIPO_OPERACION        
                 ,@CUR_OPERACION               ,@DET_CORRELATIVO_PERFIL      
			     ,@CUR_MONEDA_INSTRUMENTO      ,@AUX_CODIGO_CUENTA
				 ,@DET_TIPO_MOVIMIENTO_CUENTA  ,@DET_CODIGO_CAMPO
				 ,@DET_PERFIL_FIJO)                 



                 FETCH NEXT FROM CURSOR_DETALLES INTO @DET_CODIGO_CAMPO    
	                                                 ,@DET_TIPO_MOVIMIENTO_CUENTA 
                                                     ,@DET_PERFIL_FIJO            
                                                     ,@DET_CODIGO_CUENTA          
                                                     ,@DET_CORRELATIVO_PERFIL     
                                                     ,@DET_CAMPO_VARIABLE         
											         ,@DET_FOLIO_PERFIL   

		   END
		   CLOSE CURSOR_DETALLES
           DEALLOCATE CURSOR_DETALLES
	    /*================================================================*/
	    /*----------------------------------------------------------------*/
		/* FIN DETALLES A CONTABILIZAR                                    */
		/*----------------------------------------------------------------*/
		/*================================================================*/






       FETCH NEXT FROM CURSOR_CONTABLE INTO @CUR_TIPO_VOUCHER  
                                           ,@CUR_GLOSA_PERFIL  
		                                   ,@CUR_FOLIO_PERFIL  
										   ,@CUR_ID_SISTEMA          
                                           ,@CUR_TIPO_MOVIMIENTO       
										   ,@CUR_TIPO_OPERACION        
                                           ,@CUR_OPERACION  
										   ,@CUR_MONEDA_INSTRUMENTO           
										   ,@CUR_TIPO_MARCA

     END
     CLOSE CURSOR_CONTABLE
     DEALLOCATE CURSOR_CONTABLE


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE DATOS                                                             */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @CONTABILIDAD 
     SELECT SAL.GLOSA_PERFIL           
		   ,SAL.FOLIO_PERFIL           
           ,SAL.ID_SISTEMA             
           ,SAL.TIPO_MOVIMIENTO        
           ,SAL.TIPO_OPERACION         
           ,SAL.OPERACION              
           ,SAL.CORRELATIVO            
		   ,SAL.MONEDA_INSTRUMENTO     
		   ,SAL.CUENTA_CONTABLE        
		   ,SAL.TIPO_MOVIMIENTO_CUENTA 
		   ,SAL.COD_CAMPO 
		   ,CUE.tipo_cuenta 
		   ,CUE.DESCRIPCION
		   ,SAL.CAMPO_VARIABLE 
       FROM @SALIDA 	                     SAL  
       Left JOIN
            BacParamSuda.dbo.PLAN_DE_CUENTA  CUE WITH(NOLOCK)
	     ON SAL.CUENTA_CONTABLE         = CUE.CUENTA 
      ORDER BY SAL.FOLIO_PERFIL,SAL.CORRELATIVO  





 Return

 END


GO
