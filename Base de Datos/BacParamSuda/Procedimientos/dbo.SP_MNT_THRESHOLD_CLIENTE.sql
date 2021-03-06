USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_THRESHOLD_CLIENTE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_THRESHOLD_CLIENTE]
   (   @iTag          INTEGER     = 1
   ,   @nRutCliente   NUMERIC(12) = 0
   ,   @nCodCliente   INTEGER     = 0
   ,   @cThreshold    CHAR(1)     = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 1
   BEGIN
      SELECT oEstado = CASE WHEN Threshold = 'N' THEN 'False' ELSE 'True' END
         ,   Rut     = clrut
         ,   Codigo  = clcodigo
         ,   Nombre  = clnombre
         ,   Estado  = ISNULL(Threshold, 'S')
        FROM BacParamSuda.dbo.CLIENTE
             LEFT JOIN BacParamSuda.dbo.THRESHOLD_CLIENTE ON Rut_Cliente = clrut AND Cod_Cliente = clcodigo
   END


   IF @iTag = 2
   BEGIN
      IF EXISTS(SELECT 1 FROM BacParamSuda.dbo.THRESHOLD_CLIENTE 
                        WHERE Rut_Cliente = @nRutCliente AND Cod_Cliente = @nCodCliente)
      BEGIN
         UPDATE BacParamSuda.dbo.THRESHOLD_CLIENTE
            SET Threshold   = @cThreshold
          WHERE Rut_Cliente = @nRutCliente
            AND Cod_Cliente = @nCodCliente
      END ELSE
      BEGIN
         INSERT INTO BacParamSuda.dbo.THRESHOLD_CLIENTE
         (   Rut_Cliente
         ,   Cod_Cliente
         ,   Threshold
         )   
         VALUES
         (   @nRutCliente
         ,   @nCodCliente
         ,   @cThreshold
         )
      END

   END

END
GO
