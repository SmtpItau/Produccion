USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_ADDON]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_ADDON]    
                        @SISTEMA           VARCHAR(03)
					   ,@NOMINAL           FLOAT
	                   ,@MONEDA_1          INT
			           ,@MONEDA_2          INT
                       ,@PRODUCTO          CHAR(05)  
			           ,@TIPO_OPERACION    CHAR(01)
					   ,@FECHA_EFECTIVA    DATETIME
					   ,@FECHA_VENCIMIENTO DATETIME
					   ,@SERIE             CHAR(12)

AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CALCULO DE FACTOR ADDON PARA FORWARD                        */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 17/10/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @LCRGRUMDACOD    CHAR(8)  
			,@COD_RIESGO      INT
			,@TIPOBIDASK      VARCHAR(03)
			,@PLAZO_1         FLOAT    
			,@POND_1          FLOAT
			,@PLAZO_2         FLOAT    
			,@POND_2          FLOAT
            ,@VALOR_MONEDA    FLOAT  
			,@FECHA_PROCESO   DATETIME
			,@FECHA_AYER      DATETIME
			,@MONTO_CALCULADO FLOAT  
			,@ADDON           FLOAT
            ,@INPUTPLAZO      FLOAT
			,@Duration_A      FLOAT
			,@Duration_P      FLOAT
			,@Plazo_A         FLOAT
			,@Plazo_P         FLOAT
			,@M_Durat         FLOAT

   /*-----------------------------------------------------------------------------*/
   /* FECHAS DE SISTEMA                                                           */
   /*-----------------------------------------------------------------------------*/
     SET @FECHA_PROCESO = (SELECT acfecproc FROM BacFwdSuda..MFAC with(nolock))  
     SET @FECHA_AYER    = (SELECT acfecante FROM BacFwdSuda..MFAC with(nolock))  


   /*-----------------------------------------------------------------------------*/
   /* SE EXTRAE COMBINACION DE MONEDAS EJEMPLO LA COMBINACION DE :                */
   /* MONEDA_1 =13 MONEDA_2 = 999 DARIA EL CODIGO DE PONDERACION USD_CLP          */
   /*-----------------------------------------------------------------------------*/
	SELECT @LCRGRUMDACOD = lcrgrumdacod   
      FROM BACLINEAS.DBO.LCRPARMDAGRUMDA  
     WHERE LCRParMda1 = @MONEDA_1  
       AND LCRParMda2 = @MONEDA_2  



	SET @Duration_A = CASE WHEN DATEDIFF(DAY, @FECHA_PROCESO, @FECHA_EFECTIVA) < 0 THEN 0 ELSE ROUND(DATEDIFF(DAY, @FECHA_PROCESO, @FECHA_EFECTIVA) / 365.0 ,4) END
	SET @Duration_P = CASE WHEN DATEDIFF(DAY, @FECHA_PROCESO, @FECHA_EFECTIVA) < 0 THEN 0 ELSE ROUND(DATEDIFF(DAY, @FECHA_PROCESO, @FECHA_EFECTIVA) / 365.0 ,4) END



	 IF @PRODUCTO = 7 BEGIN
        SET @Plazo_A   = CASE  WHEN DATEDIFF(DAY, @FECHA_PROCESO, @FECHA_VENCIMIENTO) < 0 THEN 0 ELSE DATEDIFF(DAY, @FECHA_PROCESO, @FECHA_VENCIMIENTO) END
        SET @Plazo_P   = CASE  WHEN DATEDIFF(DAY, @FECHA_PROCESO, @FECHA_VENCIMIENTO) < 0 THEN 0 ELSE DATEDIFF(DAY, @FECHA_PROCESO, @FECHA_VENCIMIENTO) END
		SET @Duration_A = @Plazo_A / 365.0
		SET @Duration_P = @Plazo_P / 365.0
     END


	 IF @M_Durat = 0 AND @PRODUCTO = 10 BEGIN
	    EXECUTE BACLINEAS..SP_BUSCA_DURATION  @SERIE
									        , @FECHA_PROCESO
                                            , @M_Durat   OUTPUT
            
		SET @M_Durat		= CASE WHEN @PRODUCTO	    = 10	THEN @M_Durat		ELSE @Duration_A END
		SET @Duration_A		= CASE WHEN @TIPO_OPERACION	= 'C'	THEN @M_Durat		ELSE @Duration_A END
		SET	@Duration_P		= CASE WHEN @TIPO_OPERACION	= 'C'	THEN @Duration_p	ELSE @M_Durat    END

	 END



   /*-----------------------------------------------------------------------------*/
   /* FECHAS DE SISTEMA                                                           */
   /*-----------------------------------------------------------------------------*/
     Select @INPUTPLAZO = case when @Duration_A > @Duration_P then @Duration_A else @Duration_P END   
	 



   /*-----------------------------------------------------------------------------*/
   /* CODIGO DE RIESGO DETERMINADO POR EL PRODUCTO Y SISTEMA                      */
   /*-----------------------------------------------------------------------------*/
     SELECT @COD_RIESGO =  Riesgo_Interno
	   FROM BacparamSuda..PRODUCTO 
      WHERE codigo_producto = @PRODUCTO 
	    AND id_sistema      = @SISTEMA

		
		SET @TIPOBIDASK = CASE
		                  WHEN @COD_RIESGO = 2 THEN 
						                       CASE
						                       WHEN @TIPO_OPERACION = 'C' THEN 'ASK'
											   WHEN @TIPO_OPERACION = 'V' THEN 'BID'
											   ELSE 'NA'
											   END
		                   ELSE 'NA'
						   END


   /*-----------------------------------------------------------------------------*/
   /* SE EXTRAE EL PLAZO MINIMO PERMITIDO                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT @PLAZO_1      = CALC.PLAZO
	       ,@POND_1       = CALC.FACTOR
       FROM (Select TOP(1) 
	                ROUND( PON.lcrpla * 365.0, 0)  AS CALCULO
				   ,PON.lcrpla                     AS PLAZO
				   ,lcrpon                         AS FACTOR
               FROM BACLINEAS..LCRRieParMdaPon    PON  
                  , BacParamSuda..Producto        PRO  
               WHERE PRO.Riesgo_Interno         = @COD_RIESGO  
	             AND PON.codigo_riesgo          = PRO.Riesgo_Interno  
                 AND PRO.Id_Sistema             = @SISTEMA 
                 AND Codigo_Producto            = (CASE WHEN @PRODUCTO = '14' THEN '1' ELSE @PRODUCTO END)  
                 AND PON.LCRGruMdaCod           = @LCRGRUMDACOD   
                 AND lcrpla                     < @INPUTPLAZO
		         AND PON.lcrTipoBID_ASK         = @TipoBidAsk  
               ORDER BY CALCULO DESC ) CALC

                  IF @@ROWCOUNT = 0 BEGIN
				     SET @PLAZO_1 = 0
					 SET @POND_1  = 0
				  END


   /*-----------------------------------------------------------------------------*/
   /* SE EXTRAE EL PLAZO MAXIMO PERMITIDO                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT @PLAZO_2      = CALC.PLAZO
	       ,@POND_2       = CALC.FACTOR
       FROM (Select TOP(1) 
	                ROUND( PON.lcrpla * 365.0, 0 ) AS CALCULO
				   ,PON.lcrpla                     AS PLAZO
				   ,lcrpon                         AS FACTOR
               FROM BACLINEAS..LCRRieParMdaPon    PON  
                  , BacParamSuda..Producto        PRO  
               WHERE PRO.Riesgo_Interno         = @COD_RIESGO  
	             AND PON.codigo_riesgo          = PRO.Riesgo_Interno  
                 AND PRO.Id_Sistema             = @SISTEMA 
                 AND Codigo_Producto            = (CASE WHEN @PRODUCTO = '14' THEN '1' ELSE @PRODUCTO END)  
                 AND PON.LCRGruMdaCod           = @LCRGRUMDACOD   
                 AND PON.lcrpla                >= @INPUTPLAZO
		         AND PON.lcrTipoBID_ASK         = @TipoBidAsk  
               ORDER BY CALCULO ASC ) CALC


	    /*------------------------------------------------------------------------*/
		/* SI EL PLAZO ES MAYOR AL ULTIMO EN TABLA SE DEBE CONSIDERAR EL ULTIMO   */
		/*------------------------------------------------------------------------*/
         IF @@ROWCOUNT = 0 BEGIN

            SELECT @PLAZO_2      = CALC.PLAZO
	              ,@POND_2       = CALC.FACTOR
              FROM (Select TOP(1) 
	                ROUND( PON.lcrpla * 365.0, 0 ) AS CALCULO
			       ,PON.lcrpla                     AS PLAZO
				   ,lcrpon                         AS FACTOR
               FROM BACLINEAS..LCRRieParMdaPon    PON  
                  , BacParamSuda..Producto        PRO  
               WHERE PRO.Riesgo_Interno         = @COD_RIESGO  
	             AND PON.codigo_riesgo          = PRO.Riesgo_Interno  
                 AND PRO.Id_Sistema             = @SISTEMA 
                 AND Codigo_Producto            = (CASE WHEN @PRODUCTO = '14' THEN '1' ELSE @PRODUCTO END)  
                 AND PON.LCRGruMdaCod           = @LCRGRUMDACOD   
		         AND PON.lcrTipoBID_ASK         = @TipoBidAsk  
               ORDER BY CALCULO DESC ) CALC

			      IF @@ROWCOUNT = 0 BEGIN
				     SET @PLAZO_2 = 0
					 SET @POND_2  = 0
				  END
		 END



   /*-----------------------------------------------------------------------------*/
   /* CALCULOS DE VALORES MONEDA                                                  */
   /*-----------------------------------------------------------------------------*/
     SET @VALOR_MONEDA   = ISNULL((SELECT vmvalor 
	                                 FROM BacParamSuda..VALOR_MONEDA   
                                    WHERE vmfecha  = @FECHA_PROCESO  
                                      AND vmcodigo = CASE WHEN @MONEDA_1 = 13 THEN 994 
									                 ELSE @MONEDA_1 
													 END), 1.0)  
    

       IF @MONEDA_1 != 998  BEGIN  
          SET @VALOR_MONEDA = ISNULL(( SELECT Tipo_Cambio 
		                                FROM BacParamSuda..VALOR_MONEDA_CONTABLE   
                                       WHERE fecha         = @FECHA_AYER   
                                         AND codigo_moneda = CASE WHEN @MONEDA_1 = 13 THEN 994 
										                     ELSE @MONEDA_1 
															 END), 1.0)  
	   END  





   /*-----------------------------------------------------------------------------*/
   /* CALCULO DE FACTORES                                                         */
   /*-----------------------------------------------------------------------------*/
     IF ((@PLAZO_2 - @PLAZO_1) ! = 0) BEGIN
         SET @ADDON = @POND_1 + (@INPUTPLAZO - @PLAZO_1) * (@POND_2 - @POND_1) / (@PLAZO_2 - @PLAZO_1) 
	 END
	 ELSE BEGIN
	     SET @ADDON =0
	 END

   /*-----------------------------------------------------------------------------*/
   /* CALCULO SOBRE MONTO ENVIADO                                                 */
   /*-----------------------------------------------------------------------------*/
     SET @MONTO_CALCULADO = @NOMINAL * @VALOR_MONEDA * @ADDON  
	 SET @ADDON = @ADDON * 100.0

   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE CALCULOS                                                          */
   /*-----------------------------------------------------------------------------*/
     SELECT ISNULL(@LCRGRUMDACOD,'N')        AS DEFINICION
		   ,@TIPOBIDASK                      AS TIPO
		   ,@COD_RIESGO                      AS RIESGO
		   ,ROUND(@INPUTPLAZO * 365.0, 0 )   AS PLAZO_EFECTIVO
		   ,ROUND(@PLAZO_1    * 365.0, 0 )   AS PLAZO_DESDE
		   ,ROUND(@PLAZO_2    * 365.0, 0 )   AS PLAZO_HASTA
	       ,@INPUTPLAZO                      AS FACTOR_PLAZO_EFECTIVO
		   ,@PLAZO_1                         AS PLAZO_FACTOR_DESDE
		   ,@PLAZO_2                         AS PLAZO_FACTOR_HASTA
		   ,@POND_1                          AS FACTOR_DESDE
		   ,@POND_2                          AS FACTOR_HASTA
		   ,@ADDON                           AS ADDON_CALCULADO
		   ,@NOMINAL                         AS NOMINAL
		   ,@VALOR_MONEDA                    AS VALOR_MONEDA
		   ,@MONTO_CALCULADO                 AS CALCULO_MONTO

		   




 

  

END

GO
