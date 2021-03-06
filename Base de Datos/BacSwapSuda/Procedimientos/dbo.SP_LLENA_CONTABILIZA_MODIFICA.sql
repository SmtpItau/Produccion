USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CONTABILIZA_MODIFICA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LLENA_CONTABILIZA_MODIFICA]
   (   @FECHAMODINI            DATETIME
      ,@FECHAMODFIN            DATETIME
	  ,@FECHAANTERIOR          DATETIME
   )  
AS      
BEGIN  

     --EXEC SP_LLENA_CONTABILIZA_MODIFICA '2015-12-30','2015-12-30','2015-12-29'
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS       : CONTABILIZACION DE MODIFICACION DE SWAP                   */
   /* AUTOR           : ROBERTO MORA DROGUETT                                     */
   /* FEC.DESCRIPCION : 29-09-2015                                                */
   /* DESCRIPCION     : SE TOMARA EL PERFILES DE MOV Y DEV Y ESTOS SE DARAN VUELTA*/
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   

    SET NOCOUNT ON  
  

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @Pais                 INT
            ,@Normativa            CHAR(1)
            ,@SubCartera           INT
			,@xCodigo              INT
			,@FechaCierreMod       Datetime
			,@FechaCierreCar       Datetime
			,@CUR_Numero_Operacion INT


   /*-----------------------------------------------------------------------------*/
   /* TABLA DE VALORES CONTABLES                                                  */
   /*-----------------------------------------------------------------------------*/
     DECLARE @VALOR_TC_CONTABLE_MOD TABLE
		(   vmfecha   DATETIME   NOT NULL DEFAULT('')        
		,   vmcodigo  INTEGER    NOT NULL DEFAULT(0)        
		,   vmvalor   FLOAT      NOT NULL DEFAULT(0.0))
			   


   /*-----------------------------------------------------------------------------*/
   /* TABLA DE VALORES CONTABLES                                                  */
   /*-----------------------------------------------------------------------------*/
     DECLARE @VALOR_TC_CONTABLE_CAR TABLE
		(   vmfecha   DATETIME   NOT NULL DEFAULT('')        
		,   vmcodigo  INTEGER    NOT NULL DEFAULT(0)        
		,   vmvalor   FLOAT      NOT NULL DEFAULT(0.0))




   /*-----------------------------------------------------------------------------*/
   /* CURSOR MODIFICACIONES SE PROPONE LA BUSQUEDA DE FECHAS DE ESTA FORMA        */
   /* DEBIDO A QUE ESTAS CONTIENE HORAS                                           */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_MODIFICACION CURSOR FOR
      SELECT DISTINCT 
	         Numero_Operacion
        FROM BacSwapSuda..CarteraModificadaHIS WITH(NOLOCK)
  	   WHERE FECHAMOD >= @FECHAMODINI 
		 AND FECHAMOD < DATEADD(DD,1,@FECHAMODFIN)


        OPEN CURSOR_MODIFICACION
       FETCH NEXT FROM CURSOR_MODIFICACION INTO @CUR_Numero_Operacion  




   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO POR FOLIO                                                   */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS = 0 BEGIN



	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* SE DEBE EXTRAER FECHA DE CIERRE DE OPERACION PARA CALCULAR    */
		  /* EN BASE A SUS FECHAS                                          */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
		    SELECT @FechaCierreMod =(SELECT TOP(01) FECHA_CIERRE FROM CarteraModificadaHIS WHERE Numero_Operacion = @CUR_Numero_Operacion)
			SELECT @FechaCierreCar =(SELECT TOP(01) FECHA_CIERRE FROM Cartera WHERE Numero_Operacion = @CUR_Numero_Operacion)


		    DELETE FROM @VALOR_TC_CONTABLE_MOD
		    INSERT INTO @VALOR_TC_CONTABLE_MOD
	        EXEC BACPARAMSUDA.dbo.SP_VALORES_CONTABILIDAD_MOD @FechaCierreMod


		    DELETE FROM @VALOR_TC_CONTABLE_CAR
		    INSERT INTO @VALOR_TC_CONTABLE_CAR
	        EXEC BACPARAMSUDA.dbo.SP_VALORES_CONTABILIDAD_MOD @FechaCierreCar

			


	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  1C                                              */
		  /* TIPO DE FLUJO 1 COMPRA                                        */
		  /* MODIFICACION                                                  */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 10000 + c.numero_flujo         
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                    ,'compra_capital_200'         = (c.compra_amortiza + c.compra_saldo)
					,'N'
               FROM CarteraModificada             c WITH(NOLOCK)       
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 1        
                AND c.Tipo_flujo                  = 1
                AND c.Estado_Flujo                = 1        
 		        

	      /*===============================================================*/
	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  1C                                              */
		  /* TIPO DE FLUJO 1 COMPRA                                        */
		  /* CARTERA                                                       */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 20000 + c.numero_flujo         
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                    ,'compra_capital_200'         = (c.compra_amortiza + c.compra_saldo)
					,'N'
               FROM Cartera                          c WITH(NOLOCK)       
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 1        
                AND c.Tipo_flujo                  = 1
                AND c.Estado_Flujo                = 1    







 
	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  1V                                              */
		  /* TIPO DE FLUJO 2 VENTA                                         */
		  /* MODIFICACION                                                  */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 10000 + c.numero_flujo         
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Venta_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                    ,'compra_capital_200'         = (c.venta_amortiza + c.venta_saldo)
					,'V'
               FROM CarteraModificada             c  WITH(NOLOCK)      
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 1        
                AND c.Tipo_flujo                  = 2
                AND c.Estado_Flujo                = 1        


	      /*===============================================================*/
	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  1V                                              */
		  /* TIPO DE FLUJO 2 VENTA                                         */
		  /* CARTERA                                                       */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 20000 + c.numero_flujo         
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Venta_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                    ,'compra_capital_200'         = (c.venta_amortiza + c.venta_saldo)
					,'V'
               FROM Cartera                          c  WITH(NOLOCK)      
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 1        
                AND c.Tipo_flujo                  = 2
                AND c.Estado_Flujo                = 1    




	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  2C                                              */
		  /* TIPO DE FLUJO 1 COMPRA                                        */
		  /* MODIFICACION                                                  */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 10000 + c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                    ,'compra_capital_200'         = (c.compra_amortiza + c.compra_saldo + c.compra_Flujo_adicional)  
					,'N'
               FROM CarteraModificada             c WITH(NOLOCK)       
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 2        
                AND c.Tipo_flujo                  = 1
                AND c.Estado_Flujo                = 1        


	      /*===============================================================*/
	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  2C                                              */
		  /* TIPO DE FLUJO 1 COMPRA                                        */
		  /* CARTERA                                                       */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 20000 + c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                    ,'compra_capital_200'         = (c.compra_amortiza + c.compra_saldo + c.compra_Flujo_adicional)  
					,'N'
               FROM Cartera                          c WITH(NOLOCK)       
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 2        
                AND c.Tipo_flujo                  = 1
                AND c.Estado_Flujo                = 1        






	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  2 2V                                            */
		  /* TIPO DE FLUJO 2 VENTA                                         */
		  /* MODIFICACION                                                  */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 10000 + c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Venta_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                    ,'compra_capital_200'         = (c.venta_amortiza + c.venta_saldo + c.venta_flujo_Adicional )
					,'N'
               FROM CarteraModificada             c  WITH(NOLOCK)     
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 2        
                AND c.Tipo_flujo                  = 2
                AND c.Estado_Flujo                = 1        



	      /*===============================================================*/
	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  2 2V                                            */
		  /* TIPO DE FLUJO 2 VENTA                                         */
		  /* CARTERA                                                       */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 20000 + c.tipo_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Venta_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                    ,'compra_capital_200'         = (c.venta_amortiza + c.venta_saldo + c.venta_flujo_Adicional )
					,'N'
               FROM Cartera                          c  WITH(NOLOCK)     
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 2        
                AND c.Tipo_flujo                  = 2
                AND c.Estado_Flujo                = 1 


	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  4                                               */
		  /* MODIFICACION                                                  */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,venta_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap)        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 10000 + c.numero_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                   ,'compra_capital_200'          = CASE WHEN c.compra_capital <> 0.0 THEN (c.compra_amortiza + c.compra_saldo  )        
                                                    ELSE                              (c.venta_amortiza  + c.venta_saldo   )         
                                                    END        
                   ,'venta_capital_201'           = CASE WHEN c.compra_capital <> 0.0 THEN (c.compra_amortiza + c.compra_saldo  )        
                                                    ELSE                              (c.venta_amortiza  + c.venta_saldo   )        
                                                    END * (SELECT vmvalor FROM @VALOR_TC_CONTABLE_MOD WHERE vmfecha = @FechaCierreMod AND vmcodigo = c.compra_moneda)        
                   ,'N'
               FROM CarteraModificada             c  WITH(NOLOCK)      
              WHERE numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 4        
                AND c.Tipo_flujo                  = 1
                AND c.Estado_Flujo                = 1        

	      /*===============================================================*/
	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* TIPO DE SWAP  4                                               */
		  /* CARTERA                                                       */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,compra_capital
			,venta_capital
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
			        'id_sistema'                  = 'PCS'        
                   ,'tipo_movimiento'             = 'MOV'        
                   ,'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap)        
                   ,'operacion'                   = c.Numero_Operacion        
                   ,'correlativo'                 = 20000 + c.numero_flujo        
                   ,'codigo_instrumento'          = ''        
                   ,'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)        
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                   ,'compra_capital_200'          = CASE WHEN c.compra_capital <> 0.0 THEN (c.compra_amortiza + c.compra_saldo  )        
                                                    ELSE                              (c.venta_amortiza  + c.venta_saldo   )         
                                                    END        
                   ,'venta_capital_201'           = CASE WHEN c.compra_capital <> 0.0 THEN (c.compra_amortiza + c.compra_saldo  )        
                                                    ELSE                              (c.venta_amortiza  + c.venta_saldo   )        
                                                    END * (SELECT vmvalor FROM @VALOR_TC_CONTABLE_CAR WHERE vmfecha = @FechaCierreCar AND vmcodigo = c.compra_moneda)        
                   ,'N'
               FROM Cartera                          c  WITH(NOLOCK)      
              WHERE c.numero_operacion              =  @CUR_Numero_Operacion
				AND c.tipo_swap                   = 4        
                AND c.Tipo_flujo                  = 1
                AND c.Estado_Flujo                = 1 


	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* DEVOLUCION DE VALOR RAZONBLE                                  */
		  /* SE USARA EL CORRELATIVO 99 PARA PODER GENERAR SOLO LOS CAMBIOS*/
		  /* HISTORICOS DE LA DEVOLUCION                                   */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
            INSERT INTO BAC_CNT_CONTABILIZA        
            (id_sistema     
	        ,tipo_movimiento 
	        ,tipo_operacion    
	        ,operacion        
	        ,correlativo     
	        ,codigo_instrumento 
	        ,moneda_instrumento
	        ,Monto_diferido_utilidad
			,Monto_diferido_perdida
			,TipOper)
             SELECT 
		           /*------------------------------------------------------*/
		           /* PERFILES                                             */
		           /*------------------------------------------------------*/			 
                   'id_sistema'                  = 'PCS'
                  ,'tipo_movimiento'             = 'DEV'        
                  ,'tipo_operacion'              = CASE WHEN c.tipo_swap = 2 THEN 'D' + LTRIM(RTRIM(c.tipo_swap))        
                                                   ELSE                      'D' + LTRIM(RTRIM(c.tipo_swap))        
                                                   END        
                  ,'operacion'                   = c.Numero_Operacion        
                  ,'correlativo'                 = 10001        
                  ,'codigo_instrumento'          = ''        
                  ,'moneda_instrumento'          = CASE WHEN c.tipo_swap = 1 THEN CONVERT(CHAR(03),c.Compra_Moneda)        
                                                   WHEN c.tipo_swap = 4 THEN CONVERT(CHAR(03),c.Compra_Moneda)        
                                                   WHEN c.tipo_swap = 2 THEN '999'        
                                                   ELSE                      ''        
                                                   END       
		           /*------------------------------------------------------*/
		           /* CAMPOS PARA CONTABILIZACION SEGUN PERFILES           */
		           /*------------------------------------------------------*/
                   ,'Monto_diferido_utilidad_206' = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END
                   ,'Monto_diferido_perdida_207'  = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END
				   ,'N'
			   FROM CARTERARES                    c WITH(NOLOCK)       
              WHERE Fecha_Proceso                  =  @FECHAANTERIOR
			    AND c.numero_operacion             =  @CUR_Numero_Operacion
				AND c.Tipo_Swap                   IN(1,2,4) 
                AND c.Tipo_flujo                  = 1
	            AND c.Estado_Flujo                = 1    



	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* ACTUALIZACION DE CAMPO CARTERA QUE DETERMINA CUENTA CONT      */
		  /* VARIABLE                                                      */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/
		    SELECT TOP(01)
	               @pais        = ISNULL(clpais,6) 
		          ,@Normativa   = CAR.car_Cartera_Normativa    
		          ,@SubCartera  = CAR.car_SubCartera_Normativa 
	          FROM CarteraModificada        CAR WITH(NOLOCK)
              LEFT JOIN 
			       BacParamSuda.dbo.CLIENTE CLI WITH(NOLOCK) 
				ON CAR.rut_cliente      = CLI.clrut   
			   AND CAR.codigo_cliente   = CLI.clcodigo 
	         WHERE CAR.numero_operacion = @CUR_Numero_Operacion


            EXECUTE BacParamSuda.dbo.SP_CON_CLASIFICACION_CARTERA_DERIVADOS 'PCS', @pais, @Normativa, @SubCartera, @xCodigo OUTPUT        

            UPDATE BAC_CNT_CONTABILIZA
	           SET SubCartera      = @xCodigo
	         WHERE OPERACION       = @CUR_Numero_Operacion
			   AND correlativo     > 10000 AND correlativo < 20000



		    SELECT TOP(01)
	               @pais        = ISNULL(clpais,6) 
		          ,@Normativa   = CAR.car_Cartera_Normativa    
		          ,@SubCartera  = CAR.car_SubCartera_Normativa 
	          FROM Cartera                 CAR WITH(NOLOCK)
              LEFT JOIN 
			       BacParamSuda.dbo.CLIENTE CLI WITH(NOLOCK) 
				ON CAR.rut_cliente      = CLI.clrut   
			   AND CAR.codigo_cliente   = CLI.clcodigo 
	         WHERE CAR.numero_operacion = @CUR_Numero_Operacion


            EXECUTE BacParamSuda.dbo.SP_CON_CLASIFICACION_CARTERA_DERIVADOS 'PCS', @pais, @Normativa, @SubCartera, @xCodigo OUTPUT        


            UPDATE BAC_CNT_CONTABILIZA
	           SET SubCartera      = @xCodigo
	         WHERE OPERACION       = @CUR_Numero_Operacion
			   AND correlativo     > 20000 






	      /*===============================================================*/
	      /*---------------------------------------------------------------*/
		  /* FIN CUENTA CONTABLE                                           */
		  /*---------------------------------------------------------------*/
	      /*===============================================================*/


	       FETCH NEXT FROM CURSOR_MODIFICACION INTO @CUR_Numero_Operacion  
	 END
	 CLOSE CURSOR_MODIFICACION
     DEALLOCATE CURSOR_MODIFICACION


    

  
	
	   

		
END 

GO
