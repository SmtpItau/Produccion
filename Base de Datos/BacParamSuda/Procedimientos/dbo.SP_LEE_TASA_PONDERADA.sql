USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_TASA_PONDERADA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_TASA_PONDERADA]
   (   @Fecha      DATETIME
   ,   @Modulo     CHAR(3)
   ,   @Serie      VARCHAR(15)
   ,   @Emisor     VARCHAR(15)
   ,   @nTasa      FLOAT       OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   SET    @nTasa = ISNULL(( SELECT Tasa 
                              FROM dbo.TASA_MERCADO_BOLSA 
                             WHERE Fecha       = @Fecha 
                               AND Modulo      = @Modulo 
                               AND Instrumento = @Serie
                               AND Emisor      = CASE WHEN @Modulo  = 'IRF' THEN '' ELSE @Emisor END),0.0)

END




GO
