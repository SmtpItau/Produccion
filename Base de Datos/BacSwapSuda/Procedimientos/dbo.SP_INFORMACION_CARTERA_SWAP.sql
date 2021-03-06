USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMACION_CARTERA_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INFORMACION_CARTERA_SWAP]
   (   @numoperacion    NUMERIC(10)
      ,@fechaProceso    Datetime
   )
AS
BEGIN

   SET NOCOUNT ON


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : VERRIFICACIONES                                             */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : PRD -21654 SWAP                                             */
   /* FECHA CRACION : 20/07/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
    DECLARE @MODIFICABLE  VARCHAR(01)
	       ,@FECHA_CIERRE DATETIME


   /*-----------------------------------------------------------------------------*/
   /* SE VERIFICARA SI LA CARTERA SE PUEDE MODIFICAR EN ESTA FECHA DE PROCESO     */
   /*-----------------------------------------------------------------------------*/
   SET @MODIFICABLE = 'S'
    IF EXISTS (SELECT 1
	             FROM CARTERA WITH(NOLOCK)
			    WHERE numero_operacion  = @numoperacion
				  AND FECHA_VENCE_FLUJO = @fechaProceso) BEGIN

       SET @MODIFICABLE = 'N'
	END


   /*-----------------------------------------------------------------------------*/
   /* FECHA DE CIERRE DE OPERACION                                                */
   /*-----------------------------------------------------------------------------*/
	SELECT @FECHA_CIERRE    = FECHA_CIERRE
	  FROM CARTERA WITH(NOLOCK)
	 WHERE numero_operacion = @numoperacion

	    IF @FECHA_CIERRE IS NULL OR @@ROWCOUNT =0 BEGIN
		   
		   SELECT @FECHA_CIERRE    = FECHA_CIERRE
			 FROM CARTERAHIS WITH(NOLOCK)
	        WHERE numero_operacion = @numoperacion
		   
		       IF @FECHA_CIERRE IS NULL OR @@ROWCOUNT =0 BEGIN
			      SET @FECHA_CIERRE = @fechaProceso
			   END
		    
		END 
   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT @MODIFICABLE  AS MODIFICA
	       ,@FECHA_CIERRE AS FECHA_CIERRE
	


END
GO
