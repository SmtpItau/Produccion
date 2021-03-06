USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_ADDON_SWAP]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CONSULTA_ADDON_SWAP]    
                      @Duration_Activo  FLOAT  
                    , @Duration_Pasivo  FLOAT  
					, @PRODUCTO         CHAR(05)
					, @TIPO_OPERACION   CHAR(1)
					, @MONEDA_1         INT
					, @MONEDA_2         INT
					, @NOMINAL          FLOAT
AS    
BEGIN    


    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CALCULO DE FACTOR ADDON PARA SWAP                           */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/05/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     ---EXEC SP_CONSULTA_ADDON_SWAP 100,200,'2','C',999,999,10000



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @FECHA_PROCESO   DATETIME
	        ,@FECHA_AYER      DATETIME
			,@InputPlazo      FLOAT
			,@Sistema         CHAR(03)  
			,@COD_RIESGO      INT
			,@TipoBidAsk      VARCHAR(3) 
			,@PLAZO_1         FLOAT    
			,@POND_1          FLOAT
			,@PLAZO_2         FLOAT    
			,@POND_2          FLOAT
			,@LCRGRUMDACOD    CHAR(8) 
			,@VALOR_MONEDA    FLOAT
			,@ADDON           FLOAT
			,@MONTO_CALCULADO FLOAT
   /*-----------------------------------------------------------------------------*/
   /* SISTEMA SWAP                                                                */
   /*-----------------------------------------------------------------------------*/
     SET @Sistema ='PCS'


   /*-----------------------------------------------------------------------------*/
   /* FECHA DE PROCESO Y FECHA DE AYER                                            */
   /*-----------------------------------------------------------------------------*/
     SET @FECHA_PROCESO = (SELECT fechaproc FROM BacSwapSuda..SWAPGENERAL WITH(NOLOCK))
	 SET @FECHA_AYER    = (SELECT fechaant  FROM BacSwapSuda..SWAPGENERAL WITH(NOLOCK))


   /*-----------------------------------------------------------------------------*/
   /* SE EXTRAE COMBINACION DE MONEDAS EJEMPLO LA COMBINACION DE :                */
   /* MONEDA_1 =13 MONEDA_2 = 999 DARIA EL CODIGO DE PONDERACION USD_CLP          */
   /*-----------------------------------------------------------------------------*/
	SELECT @LCRGRUMDACOD = lcrgrumdacod   
      FROM BACLINEAS.DBO.LCRPARMDAGRUMDA  
     WHERE LCRParMda1 = @MONEDA_1  
       AND LCRParMda2 = @MONEDA_2  


   /*-----------------------------------------------------------------------------*/
   /* CALCULO DE PLAZO                                                            */
   /*-----------------------------------------------------------------------------*/
     SET @Duration_Activo = @Duration_Activo/ 365.0
	 SET @Duration_Pasivo = @Duration_Pasivo/ 365.0


     SET @InputPlazo = CASE 
	                   WHEN @Duration_Activo > @Duration_Pasivo then @Duration_Activo 
					   ELSE @Duration_Pasivo 
					   END   

   /*-----------------------------------------------------------------------------*/
   /* SEGUN PRODUCTO ENVIADO                                                      */
   /*-----------------------------------------------------------------------------*/
     SET @PRODUCTO = CASE 
	                  WHEN @PRODUCTO = '1' THEN 'ST'  
                      WHEN @PRODUCTO = '2' THEN 'SM'  
                      WHEN @PRODUCTO = '3' THEN 'FR'  
                      WHEN @PRODUCTO = '4' THEN 'SP'  
                      END  





   /*-----------------------------------------------------------------------------*/
   /* CODIGO DE RIESGO SEGUN PRODUCTO ENVIADO                                     */
   /*-----------------------------------------------------------------------------*/
	 SELECT @COD_RIESGO     = Riesgo_Interno
       FROM BacparamSuda..PRODUCTO 
      WHERE codigo_producto = @PRODUCTO
	    AND id_sistema      = @Sistema

   /*-----------------------------------------------------------------------------*/
   /* DEFINIR TIPO BID                                                            */
   /*-----------------------------------------------------------------------------*/
     SET @TipoBidAsk = CASE
                       WHEN @COD_RIESGO = 2 THEN 
					        CASE
					  		WHEN @Tipo_Operacion = 'C' THEN 'ASK'
							WHEN @Tipo_Operacion = 'V' THEN 'BID'
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
                 AND Codigo_Producto            = @PRODUCTO 
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
                 AND Codigo_Producto            = @PRODUCTO 
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
                 AND Codigo_Producto            = @PRODUCTO   
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
