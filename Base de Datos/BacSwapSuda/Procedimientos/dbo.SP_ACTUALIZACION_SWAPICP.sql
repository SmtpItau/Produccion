USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZACION_SWAPICP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZACION_SWAPICP]
   (   @FechaProceso DATETIME
   ,   @iOperacion   NUMERIC(10)
   ,   @iActLineas   INTEGER   = 0
   )
AS 
BEGIN

      DELETE BacParamSuda..MDLBTR 
      WHERE  fecha            = @FechaProceso
      AND    sistema          = 'PCS'
      AND    numero_operacion = @iOperacion
      AND    estado_envio     = 'P'

      EXECUTE SP_DEVENGAMIENTO @iOperacion 
      EXECUTE SP_VALORIZA      @iOperacion

      UPDATE SWAPGENERAL SET Vencimientos = 1

      IF @iActLineas = 1
      BEGIN
         EXECUTE BACSWAPSUDA..SP_RECALC_LINEAS_SWAP
      END

END

GO
