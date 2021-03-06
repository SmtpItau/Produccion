USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_RetornaSumasHis_Swap]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_RetornaSumasHis_Swap](@NUMERO_OPERACION NUMERIC
                                               ,@TIPO_FLUJO       INT
											   ,@OPCION           INT)


  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns NUMERIC



 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA SWAP HISTORICA VENCIMIENTOS                         */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   /*-----------------------------------------------------------------------------*/
   /* CALCULOS HISTORICOS DE SWAP                                                 */
   /*-----------------------------------------------------------------------------*/
     DECLARE @RETORNO NUMERIC = 0


   /*-----------------------------------------------------------------------------*/
   /* TABLA TEMPORAL DE REGISTROS                                                 */
   /*-----------------------------------------------------------------------------*/
     DECLARE @CALCULOS TABLE
	 (INTERES           NUMERIC
	 ,MONTO             NUMERIC
	 ,MONEDA            INT
	 ,FECHA_VENCE_FLUJO DATETIME
	 ,INTERES_CLP       NUMERIC
	 ,MONTO_CLP         NUMERIC)



   /*-----------------------------------------------------------------------------*/
   /* PATA ACTIVA                                                                 */
   /*-----------------------------------------------------------------------------*/
     IF @TIPO_FLUJO = 1 BEGIN

	    
		INSERT INTO @CALCULOS
        SELECT compra_interes
		      ,(CASE WHEN tipo_swap = 3   THEN Compra_interes / ( 1 + DATEDIFF(DAY,Fecha_Inicio_Flujo,Fecha_Vence_Flujo)/ 360.0 * compra_mercado_tasa / 100.0 )    
                     WHEN Estado    = 'N' THEN Recibimos_Monto
                ELSE (Compra_Amortiza * intercprinc) + Compra_Flujo_Adicional    
                END)
			  ,compra_moneda 
			  ,fecha_vence_flujo  
			  ,0
			  ,0 
	      FROM BacSwapSuda.DBO.CARTERAHIS WITH(NOLOCK)
	     WHERE numero_operacion = @NUMERO_OPERACION
		   AND TIPO_FLUJO       = @TIPO_FLUJO 

	END

   /*-----------------------------------------------------------------------------*/
   /* PATA PASIVA                                                                 */
   /*-----------------------------------------------------------------------------*/
     IF @TIPO_FLUJO = 2 BEGIN

	    
		INSERT INTO @CALCULOS
        SELECT venta_interes
			  ,(CASE WHEN tipo_swap = 3   THEN venta_interes / ( 1 + DATEDIFF(DAY,Fecha_Inicio_Flujo,Fecha_Vence_Flujo)/ 360.0 * venta_mercado_tasa / 100.0 )    
                     WHEN Estado    = 'N' THEN pagamos_monto 
                ELSE (venta_amortiza * intercprinc) + Venta_Flujo_Adicional     
                END)  
			  ,venta_moneda 
			  ,fecha_vence_flujo 
			  ,0
			  ,0     
	      FROM BacSwapSuda.DBO.CARTERAHIS WITH(NOLOCK)
	     WHERE numero_operacion = @NUMERO_OPERACION
		   AND TIPO_FLUJO       = @TIPO_FLUJO 

	END

   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR MONTOS SEGUN SUS MONEDAS A CLP                                   */
   /*-----------------------------------------------------------------------------*/
     UPDATE @CALCULOS
	    SET INTERES_CLP   = BacParamSuda.dbo.fx_convierte_monto_25(FECHA_VENCE_FLUJO,MONEDA,INTERES,999) 
		   ,MONTO_CLP     = BacParamSuda.dbo.fx_convierte_monto_25(FECHA_VENCE_FLUJO,MONEDA,MONTO,999) 


   /*-----------------------------------------------------------------------------*/
   /* OPCION 1 ES EL MONTO                                                        */
   /*-----------------------------------------------------------------------------*/
    IF @OPCION = 1 BEGIN

	      SET @RETORNO = 0
	   SELECT @RETORNO = ISNULL(SUM(MONTO_CLP),0) 
	    FROM @CALCULOS

	END


   /*-----------------------------------------------------------------------------*/
   /* OPCION 2 ES EL INTERES                                                      */
   /*-----------------------------------------------------------------------------*/
    IF @OPCION = 2 BEGIN

	      SET @RETORNO = 0
	   SELECT @RETORNO = ISNULL(SUM(INTERES_CLP),0) 
	    FROM @CALCULOS

	END





 Return @RETORNO

 END


GO
