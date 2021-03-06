USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[ContabilidadNominalSwap]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ContabilidadNominalSwap](@Fecha_Hoy DATETIME ,@Numero_operacion NUMERIC)


  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @CONTABILIDAD TABLE
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




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA SWAP CONTABLE                                       */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @iiMoneda                   NUMERIC(21,4)
			,@AUX_CODIGO_CUENTA          CHAR(20)
			,@SUBCARTERA                 INT
			,@Nombre_Campo               VARCHAR(100)


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
   /* BAC CONTABILIZA                                                             */
   /*-----------------------------------------------------------------------------*/
     DECLARE @BAC_CNT_CONTABILIZA TABLE
	 (ID_SISTEMA          CHAR(03)
	 ,TIPO_MOVIMIENTO     CHAR(03)
	 ,TIPO_OPERACION      CHAR(05)
	 ,OPERACION           NUMERIC
	 ,CORRELATIVO         NUMERIC
	 ,CODIGO_INSTRUMENTO  CHAR(10)
	 ,MONEDA_INSTRUMENTO  CHAR(06)
	 ,SUBCARTERA          INT)



   /*-----------------------------------------------------------------------------*/
   /* TABLA DE DETALLES VOUCHER                                                   */
   /*-----------------------------------------------------------------------------*/
    DECLARE @BAC_CNT_DETALLE_VOUCHER TABLE 
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
	,GLOSA_PERFIL        CHAR(70))



   /*-----------------------------------------------------------------------------*/
   /* REPRESENTACION DE MODELO DE CONTABILIZACION PARA MOVIMIENTOS                */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @BAC_CNT_CONTABILIZA
     SELECT ID_SISTEMA         
	       ,TIPO_MOVIMIENTO    
	       ,TIPO_OPERACION     
	       ,OPERACION          
	       ,CORRELATIVO        
	       ,CODIGO_INSTRUMENTO 
	       ,MONEDA_INSTRUMENTO 
		   ,SUBCARTERA     
	   FROM REPORTES.DBO.ContabilidadSwapMovimientos(@Fecha_Hoy ,@Numero_operacion)







     DECLARE CURSOR_CONTABLE CURSOR LOCAL FOR 
      SELECT PER.tipo_voucher
            ,PER.glosa_perfil
	        ,PER.folio_perfil
			,CON.id_sistema
			,CON.tipo_movimiento
			,CON.tipo_operacion
			,CON.operacion
			,CON.correlativo
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
		 AND CON.OPERACION          = @Numero_operacion
        OPEN CURSOR_CONTABLE
       FETCH NEXT FROM CURSOR_CONTABLE INTO @CUR_TIPO_VOUCHER  
                                           ,@CUR_GLOSA_PERFIL  
		                                   ,@CUR_FOLIO_PERFIL  
										   ,@CUR_ID_SISTEMA          
                                           ,@CUR_TIPO_MOVIMIENTO       
										   ,@CUR_TIPO_OPERACION        
                                           ,@CUR_OPERACION  
										   ,@CUR_CORRELATIVO
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
			   /* CAMPO CONTABLE                                          */
			   /*---------------------------------------------------------*/
			        SET @Nombre_Campo             = '' 
			     SELECT @Nombre_Campo             = Nombre_Campo_Tabla
                   FROM BACSWAPSUDA.DBO.VIEW_CAMPO_CNT 
                  WHERE ID_Sistema                = @CUR_ID_SISTEMA
                    AND Tipo_Movimiento           = @CUR_TIPO_MOVIMIENTO
                    AND Tipo_Operacion            = @CUR_TIPO_OPERACION
                    AND Codigo_Campo              = @DET_CODIGO_CAMPO
                    AND Tipo_Administracion_Campo = 'F'


		        /*-------------------------------------------------------*/
				/* PERFIL FIJO                                           */
				/*-------------------------------------------------------*/
                  IF @DET_PERFIL_FIJO = 'N' BEGIN
               


				    SELECT @SUBCARTERA      = SUBCARTERA
				      FROM @BAC_CNT_CONTABILIZA 
				     WHERE ID_SISTEMA      = @CUR_ID_SISTEMA
				       AND TIPO_MOVIMIENTO = @CUR_TIPO_MOVIMIENTO
				       AND TIPO_OPERACION  = @CUR_TIPO_OPERACION
				       AND OPERACION       = @CUR_OPERACION 
				       AND CORRELATIVO     = @CUR_CORRELATIVO



                     SELECT @AUX_CODIGO_CUENTA = Codigo_Cuenta
					   FROM BacSwapSuda.DBO.VIEW_PERFIL_VARIABLE_CNT 
					  WHERE Folio_Perfil       = @DET_FOLIO_PERFIL
						AND Valor_Dato_Campo   = @SUBCARTERA
						AND Correlativo_Perfil = @DET_CORRELATIVO_PERFIL



                     
                  END
				  ELSE BEGIN
					SET @AUX_CODIGO_CUENTA = @DET_CODIGO_CUENTA
				  END
		        /*-------------------------------------------------------*/
				/* FIN PERFIL FIJO                                       */
				/*-------------------------------------------------------*/
                   SET @iiMoneda  = CASE WHEN @DET_CODIGO_CAMPO IN(200,210,211,212,222,208,209,214,215,216,217) THEN @CUR_MONEDA_INSTRUMENTO 
                                    ELSE 999
                                    END


		        /*-------------------------------------------------------*/
				/* INGRESO DE DETALLE                                    */
				/*-------------------------------------------------------*/
                  INSERT INTO @BAC_CNT_DETALLE_VOUCHER
                  (Cuenta                ,Tipo_Monto   
				  ,Moneda    	         ,ID_SISTEMA
				  ,TIPO_MOVIMIENTO       ,TIPO_OPERACION
				  ,OPERACION             ,CORRELATIVO_PER
				  ,MONEDA_INSTRUMENTO    ,Nombre_Campo  
				  ,FOLIO_PERFIL          ,CODIGO_CAMPO 
				  ,CODIGO_CAMPO_VAR      ,GLOSA_PERFIL
				  ,CORRELATIVO)
                  VALUES
				  (@AUX_CODIGO_CUENTA     ,@DET_TIPO_MOVIMIENTO_CUENTA 
				  ,@iiMoneda  		      ,@CUR_ID_SISTEMA 
				  ,@CUR_TIPO_MOVIMIENTO   ,@CUR_TIPO_OPERACION 
				  ,@CUR_OPERACION         ,@DET_CORRELATIVO_PERFIL
				  ,@CUR_MONEDA_INSTRUMENTO,@Nombre_Campo
				  ,@DET_FOLIO_PERFIL      ,@DET_CODIGO_CAMPO   
				  ,@DET_CAMPO_VARIABLE    ,@CUR_GLOSA_PERFIL
				  ,@CUR_CORRELATIVO)




           


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
											,@CUR_CORRELATIVO  
											,@CUR_MONEDA_INSTRUMENTO 
											,@CUR_TIPO_MARCA
     END
     CLOSE CURSOR_CONTABLE
     DEALLOCATE CURSOR_CONTABLE


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE DATOS                                                             */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @CONTABILIDAD
     SELECT DET.Cuenta              
	       ,DET.Tipo_Monto          
	       ,DET.Moneda              
           ,DET.ID_SISTEMA          
           ,DET.TIPO_MOVIMIENTO     
           ,DET.TIPO_OPERACION      
           ,DET.OPERACION           
           ,DET.MONEDA_INSTRUMENTO  
           ,DET.CORRELATIVO         
           ,DET.CORRELATIVO_PER     
	       ,DET.Nombre_Campo        
	       ,DET.FOLIO_PERFIL        
	       ,DET.CODIGO_CAMPO        
	       ,DET.CODIGO_CAMPO_VAR    
	       ,DET.GLOSA_PERFIL        
		   ,CUE.tipo_cuenta 
		   ,CUE.DESCRIPCION
	  FROM @BAC_CNT_DETALLE_VOUCHER          DET
      Left JOIN
            BacParamSuda.dbo.PLAN_DE_CUENTA  CUE WITH(NOLOCK)
	     ON DET.CUENTA         = CUE.CUENTA 
	   

	 


 Return

 END


GO
