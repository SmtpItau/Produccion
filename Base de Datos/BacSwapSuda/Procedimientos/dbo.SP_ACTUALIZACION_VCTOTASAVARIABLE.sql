USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZACION_VCTOTASAVARIABLE]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZACION_VCTOTASAVARIABLE]
   (   @FechaProceso DATETIME
   ,   @iOperacion   NUMERIC(10)
   ,   @iActLineas   INTEGER   = 0
   )
AS 
BEGIN

   SET NOCOUNT ON

   DELETE BacParamSuda..MDLBTR
   WHERE  Fecha            = @FechaProceso
   AND    Sistema          = 'PCS'
   AND    Numero_Operacion = @iOperacion
   AND    Estado_Envio     = 'P'

   EXECUTE SP_DEVENGAMIENTO @iOperacion

   IF @@ERROR <> 0
   BEGIN
      SELECT @@ERROR
      RETURN
   END
   EXECUTE SP_VALORIZA      @iOperacion

   UPDATE SWAPGENERAL SET ActTasaVarVcto = 1

   IF @iActLineas = 1
   BEGIN
      EXECUTE BacSwapSuda..SP_RECALC_LINEAS_SWAP
   END

END

GO
