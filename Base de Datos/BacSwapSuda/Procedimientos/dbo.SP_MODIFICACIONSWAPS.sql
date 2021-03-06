USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICACIONSWAPS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_MODIFICACIONSWAPS]
   (   @numoperacion    NUMERIC(10)
   )
AS
BEGIN

   SET NOCOUNT ON


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : MODIFICACION DE SWAP                                        */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : PRD -21654 SWAP                                             */
   /* FECHA CRACION : 20/07/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/



   /*-----------------------------------------------------------------------------*/
   /* ELIMINO CARTERA VIGENTE                                                     */
   /*-----------------------------------------------------------------------------*/
     DELETE FROM CARTERA WHERE numero_operacion = @numoperacion

		 IF @@ERROR != 0 BEGIN
			RETURN 0
	     END

   /*-----------------------------------------------------------------------------*/
   /* MOVIMIENTO DIARIO                                                           */
   /*-----------------------------------------------------------------------------*/
	 DELETE FROM MOVDIARIO WHERE numero_operacion = @numoperacion

         IF @@ERROR != 0 BEGIN
			RETURN 0
	     END

		

	 RETURN 1


END


GO
