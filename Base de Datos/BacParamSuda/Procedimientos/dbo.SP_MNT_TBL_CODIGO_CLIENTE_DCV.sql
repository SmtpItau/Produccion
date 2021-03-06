USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_TBL_CODIGO_CLIENTE_DCV]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MNT_TBL_CODIGO_CLIENTE_DCV]
   (   @iTag           INTEGER
   ,   @RutCliente     NUMERIC(11)   = 0
   ,   @CodCliente     NUMERIC(3)    = 0
   ,   @CodDcv         INTEGER       = 0
   ,   @nTipCliente    INTEGER       = 0
   ,   @cNombre        VARCHAR(50)   = ''
   )
AS
BEGIN 

   SET NOCOUNT ON

   IF @iTag = 0
   BEGIN
      SELECT Codigo      = tbcodigo1
         ,   Descripcion = tbglosa
        FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE 
       WHERE tbcateg = 72
    ORDER BY tbglosa
   END

   IF @iTag = 1
   BEGIN
      SELECT Rut       = clrut
      ,      Codigo    = clcodigo
      ,      Nombre    = LTRIM(RTRIM( clnombre ))
      ,      DCV       = ISNULL( CodDcv, -1)
      FROM   BacParamSuda.dbo.CLIENTE 
             LEFT JOIN dbo.TBL_CODIGO_CLIENTE_DCV ON RutCliente = clrut and CodCliente = clcodigo
      WHERE (cltipcli  = @nTipCliente or @nTipCliente = 0)
        AND (clnombre like '%' + @cNombre + '%')
      ORDER BY clnombre
   END

   IF @iTag = 2
   BEGIN
      IF EXISTS(SELECT 1 FROM dbo.TBL_CODIGO_CLIENTE_DCV WHERE RutCliente = @RutCliente AND CodCliente = @CodCliente)
         UPDATE dbo.TBL_CODIGO_CLIENTE_DCV SET CodDcv = @CodDcv WHERE RutCliente = @RutCliente AND CodCliente = @CodCliente
      ELSE
         INSERT INTO dbo.TBL_CODIGO_CLIENTE_DCV SELECT @RutCliente, @CodCliente, @CodDcv
   END

   IF @iTag = 3
   BEGIN

      SELECT @RutCliente   = cacodigo
         ,   @CodCliente   = cacodcli 
      FROM   BacFwdSuda.dbo.MFCA with(nolock)
      WHERE  canumoper     = @RutCliente

      DECLARE @iCodDCV   INTEGER
          SET @iCodDCV   = -1
          SET @iCodDCV   = ISNULL( (SELECT ISNULL( CodDcv, -1) 
                                      FROM dbo.TBL_CODIGO_CLIENTE_DCV 
                                     WHERE RutCliente = @RutCliente 
                                       AND CodCliente = @CodCliente), -1)

       SELECT 'Codigo' = @iCodDCV
         ,    'Rut'    = @RutCliente
         ,    'Codigo' = @CodCliente

      SELECT * FROM dbo.TBL_CODIGO_CLIENTE_DCV 
              WHERE RutCliente = @RutCliente 
                AND CodCliente = @CodCliente
   END

END

GO
