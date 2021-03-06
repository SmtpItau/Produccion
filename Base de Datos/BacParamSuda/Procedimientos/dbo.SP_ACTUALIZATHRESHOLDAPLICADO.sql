USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZATHRESHOLDAPLICADO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZATHRESHOLDAPLICADO]
   (   @Sistema		        CHAR(3)
   ,   @Producto		VARCHAR(5)
   ,   @RutCliente		NUMERIC(9)
   ,   @CodCliente		INTEGER
   ,   @Numero_Operacion	NUMERIC(9)
   ,   @Threshold_Aplicado	FLOAT
   ,   @AplicaThreshold         CHAR(1)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS(SELECT 1 FROM BacParamSuda.dbo.TBL_THRESHOLD_OPERACION
                     WHERE Sistema 	    = @Sistema
                       AND Producto 	    = @Producto
                       AND Rut_Cliente	    = @RutCliente
                       AND Cod_Cliente	    = @CodCliente
                       AND Numero_Operacion = @Numero_Operacion)
   BEGIN

      UPDATE Bacparamsuda.dbo.TBL_THRESHOLD_OPERACION
      SET    Threshold_Aplicado   = @Threshold_Aplicado
      WHERE  Sistema 		  = @Sistema
      AND    Producto             = @Producto
      AND    Rut_Cliente          = @RutCliente
      AND    Cod_Cliente          = @CodCliente
      AND    Numero_Operacion 	  = @Numero_Operacion

      IF @Sistema = 'BFW'
      BEGIN
         UPDATE BacFwdSuda.dbo.MFCA SET Threshold = @AplicaThreshold WHERE canumoper = @Numero_Operacion
         UPDATE BacFwdSuda.dbo.MFMO SET Threshold = @AplicaThreshold WHERE monumoper = @Numero_Operacion
      END
      IF @Sistema = 'PCS'
      BEGIN
         UPDATE BacSwapSuda.dbo.CARTERA   SET Threshold = @AplicaThreshold WHERE numero_operacion = @Numero_Operacion
         UPDATE BacSwapSuda.dbo.MOVDIARIO SET Threshold = @AplicaThreshold WHERE numero_operacion = @Numero_Operacion
      END
   END

END
GO
