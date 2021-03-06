USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MaximoFlujoSwap]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MaximoFlujoSwap]
   (   @numoperacion    NUMERIC(10)
      ,@tipo_flujo      int
   )
AS
BEGIN

   SET NOCOUNT ON


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : MAXIMO NUMERO DE FLUJOS SWAP                                */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : PRD -21654 SWAP                                             */
   /* FECHA CRACION : 21/07/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @NUMERO_FLUJO INT 


	
   /*-----------------------------------------------------------------------------*/
   /* SE OBTENDRA EL MAXIMO NUMERO DE FLUJO DE LA TABLA CARTERA                   */
   /*-----------------------------------------------------------------------------*/
     SELECT @NUMERO_FLUJO = ISNULL(MIN(numero_flujo),0)
	   FROM Cartera WITH(NOLOCK)
	  WHERE numero_operacion = @numoperacion
	    and tipo_flujo       = @tipo_flujo

	     IF @NUMERO_FLUJO = 0 OR @@ROWCOUNT =0 BEGIN
			SET @NUMERO_FLUJO = 1
		 END

   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE DATOS                                                             */
   /*-----------------------------------------------------------------------------*/
     SELECT @NUMERO_FLUJO AS MAX_FLUJO

END

GO
