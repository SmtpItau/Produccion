USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABADATOSRIESGOCLIENTE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABADATOSRIESGOCLIENTE]
   (   @RutCliente	NUMERIC(9)
   ,   @CodCliente	NUMERIC(5)
   ,   @nomRiesgo	VARCHAR(6)
   ,   @Seg_Comercial	CHAR(6)
   ,   @nomEjComercial	VARCHAR(40)
   ,   @cambioRiesgo	CHAR(2)
   )
AS
BEGIN

   SET NOCOUNT ON
   DECLARE @iClasOriginal   INTEGER
       SET @iClasOriginal   = -1
       SET @iClasOriginal   = isnull( (SELECT TOP 1 tbtasa
                                        FROM BacParamSuda.dbo.CLIENTE
                                             INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ON tbcateg = 103 and tbcodigo1 = clclsbif
                                       WHERE clrut    = @RutCliente
                                         AND clcodigo = @CodCliente), -1)

   DECLARE @iClasNueva      INTEGER
       SET @iClasNueva      = (SELECT TOP 1 tbtasa 
                                 FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE
                                WHERE tbcateg   = 103 
                                  AND tbcodigo1 = @nomRiesgo)

   IF NOT EXISTS(SELECT 1 FROM BacParamSuda.dbo.CLIENTE with(nolock) WHERE clrut = @RutCliente AND clcodigo = @CodCliente)
   BEGIN
      SELECT -1, 'El cliente no se encuentra.'
      RETURN
   END

   UPDATE BacParamSuda.dbo.CLIENTE
   SET    clclsbif	        = @nomRiesgo
   ,      seg_comercial         = @Seg_Comercial
   ,      ejecutivo_comercial   = @nomEjComercial
   WHERE  clrut                 = @RutCliente
   AND    clcodigo              = @CodCliente

   IF @CambioRiesgo = 'SI'
   BEGIN
      INSERT INTO BacParamSuda.dbo.TBLCLASIFICARIESGO
      SELECT @RutCliente, @CodCliente, GETDATE(), @nomRiesgo
   END

   IF @iClasNueva > @iClasOriginal and @iClasOriginal > -1
   BEGIN
      EXECUTE dbo.SP_APLICA_REDUCCION_THRESHOLD @RutCliente, @CodCliente
      SELECT 0, 'Cambio de Clasificación Se ha generado Reducción de Threshold.'

      UPDATE BacLineas.dbo.LINEA_GENERAL 
         SET Bloqueado      = 'S'
       WHERE Rut_Cliente    = @RutCliente 
         AND Codigo_Cliente = @CodCliente

      UPDATE BacParamSuda.dbo.CLIENTE    
         SET motivo_bloqueo = 'Linea de Cliente Bloqueada por Baja en la Clasificación'
       WHERE clrut          = @RutCliente 
         and clcodigo       = @CodCliente
            
   END ELSE
   BEGIN
      SELECT 0, 'Actualización ha finalizado correctamente'
   END

END
GO
