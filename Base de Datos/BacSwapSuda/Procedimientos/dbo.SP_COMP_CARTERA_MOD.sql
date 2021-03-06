USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMP_CARTERA_MOD]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_COMP_CARTERA_MOD]
   (   @numoperacion    NUMERIC(10)
      ,@fechacierre     Datetime
   )
AS
BEGIN

   SET NOCOUNT ON


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : VERIFICACIONES                                              */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : PRD -21654 SWAP                                             */
   /* FECHA CRACION : 20/07/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/




   /*-----------------------------------------------------------------------------*/
   /* LA CARTERA INGRESADA ES IGUAL A LA FECHA DE CIERRE ENVIADA                  */
   /*-----------------------------------------------------------------------------*/
    IF EXISTS (SELECT 1
	             FROM CARTERA WITH(NOLOCK)
			    WHERE numero_operacion  = @numoperacion
				  AND fecha_cierre     != @fechacierre) BEGIN

       UPDATE CARTERA
	      SET fecha_cierre      = @fechacierre
		WHERE numero_operacion  = @numoperacion

		   IF @@ERROR != 0 BEGIN
		      RETURN 0
		   END

	END

    RETURN 1
	  


END


GO
