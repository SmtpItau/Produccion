USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[ContabilidadSwapMovimientosHIS_NY]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ContabilidadSwapMovimientosHIS_NY](@OPERACION  NUMERIC)



  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @BAC_CNT_CONTABILIZA TABLE
	 (ID_SISTEMA          CHAR(03)
	 ,TIPO_MOVIMIENTO     CHAR(03)
	 ,TIPO_OPERACION      CHAR(05)
	 ,OPERACION           NUMERIC
	 ,CORRELATIVO         NUMERIC
	 ,CODIGO_INSTRUMENTO  CHAR(10)
	 ,MONEDA_INSTRUMENTO  INT
	 ,SUBCARTERA          INT)







 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA SWAP CONTABLE                                       */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/





	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  1C                                              */
		  /* TIPO DE FLUJO 1 COMPRA                                        */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO @BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
			,SubCartera)
             SELECT TOP(01)
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda) 
				   ,0       
               FROM BacSwapNY.dbo.CARTERAHIS    c WITH(NOLOCK)       
              WHERE c.numero_operacion            =  @OPERACION
				AND c.tipo_swap                   = 1        
                AND c.Tipo_flujo                  = 1

	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  1V                                              */
		  /* TIPO DE FLUJO 2 VENTA                                         */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO @BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
			,SubCartera)
             SELECT TOP(01)
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.venta_moneda) 
				   ,0       
               FROM BacSwapNY.dbo.CARTERAHIS    c WITH(NOLOCK)       
              WHERE c.numero_operacion            =  @OPERACION
				AND c.tipo_swap                   = 1        
                AND c.Tipo_flujo                  = 2
       



	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  2C                                              */
		  /* TIPO DE FLUJO 1 COMPRA                                        */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO @BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
			,SubCartera)
             SELECT TOP(01)
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)   
				   ,0     
               FROM BacSwapNY.dbo.CARTERAHIS    c WITH(NOLOCK)       
              WHERE c.numero_operacion            =  @OPERACION
				AND c.tipo_swap                   = 2        
                AND c.Tipo_flujo                  = 1
     


	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  2 2V                                            */
		  /* TIPO DE FLUJO 2 VENTA                                         */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO @BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
			,SubCartera)
             SELECT TOP(01)
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Venta_Moneda)        
					,0
               FROM BacSwapNY.dbo.CARTERAHIS    c WITH(NOLOCK)       
              WHERE c.numero_operacion            =  @OPERACION
				AND c.tipo_swap                   = 2        
                AND c.Tipo_flujo                  = 2
       



	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  4                                               */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO @BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
			,SubCartera)
             SELECT TOP(01)
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap)        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)        
			       ,0
               FROM BacSwapNY.dbo.CARTERAHIS    c WITH(NOLOCK)       
              WHERE c.numero_operacion            =  @OPERACION
				AND c.tipo_swap                   = 4        
                AND c.Tipo_flujo                  = 1
       


          /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* DETERMINAR CUENTA DE CARTERA                                  */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
		  DECLARE @xContraparte INTEGER        
                , @xCartera     CHAR(1)        
                , @xSubCartera  INTEGER        
                , @xCodigo      INTEGER
				, @IdSistema    CHAR(03)
   

		    SELECT TOP(01)
			       @IdSistema    ='PCS'
			      ,@xContraparte = CLI.CLPAIS
				  ,@xCartera     = CAR.chi_Cartera_Normativa
				  ,@xSubCartera  = CAR.chi_SubCartera_Normativa
			  FROM BacSwapNY.dbo.CarteraHIS    CAR WITH(NOLOCK)       
			 INNER JOIN
			       BacParamSuda.dbo.CLIENTE      CLI WITH(NOLOCK)       
				ON CLI.clrut     = CAR.rut_cliente 
			   AND CLI.clcodigo  = CAR.codigo_cliente        
             WHERE CAR.numero_operacion  =  @OPERACION

				     
          /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* CODIGO DE CARTERA                                             */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
		    SET @xContraparte = CASE WHEN @xContraparte = 6 THEN 2 ELSE 1 END

		    SET @xCodigo = ISNULL((SELECT TOP 1 CodigoCartera 
                                    FROM BacParamSuda..TBL_CLASIFICACION_CARTERA_INSTRUMENTO with(nolock)
                                   WHERE Id_sistema          = @IdSistema
                                     AND Contraparte         = @xContraparte
                                     AND CarteraNormativa    = @xCartera
                                     AND SubcarteraNormativa = @xSubcartera
							         AND CasaMatriz          = 0 
										   ), 9999)


            UPDATE @BAC_CNT_CONTABILIZA
			   SET SUBCARTERA = @xCodigo 


 Return

 END


GO
