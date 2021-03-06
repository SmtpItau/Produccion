USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICA_FORMA_PAGO_ANTICIPO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_MODIFICA_FORMA_PAGO_ANTICIPO]
   (   @nnumoper      NUMERIC(10), 
       @nforpag       NUMERIC(03) 
    )
AS
BEGIN
	-- @nnumoper corresponde al número de oepracion original
   SET NOCOUNT ON

   BEGIN TRANSACTION

    DECLARE @Fecha_proceso DATETIME
    DECLARE @cBanco        CHAR (60)

    SELECT  @Fecha_proceso = acfecproc 
    ,       @cBanco=acnomprop     
    FROM MFAC


       UPDATE MFCA SET caAntForPagMdaComp = @nforpag
       WHERE numerocontratocliente = @nnumoper -- Se utiliza el número de la operacion Original
       AND   cafecvcto = @Fecha_proceso 
       AND   caantici ='A'

	delete   bacparamsuda..MDLBTR  
                 WHERE numero_operacion = @nnumoper
                 AND estado_envio <>  'E'  -- Si no esta enviada la borra
                 AND sistema      = 'BFW'	
 

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Actualizar Forma de Pago.'      
      SET NOCOUNT OFF
      RETURN
   END

 

   COMMIT TRANSACTION
   SET NOCOUNT OFF

END

GO
