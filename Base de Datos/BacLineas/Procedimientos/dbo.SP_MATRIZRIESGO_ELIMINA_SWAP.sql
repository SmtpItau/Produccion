USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_ELIMINA_SWAP]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_ELIMINA_SWAP]
   (   @Codpro   CHAR(5)
   ,   @ModPag   CHAR(5)
   )
AS 
BEGIN

   SET NOCOUNT ON

   DELETE MATRIZ_RIESGO_SWAP 
   WHERE codigo_producto = @codpro
   AND   Moneda          = @ModPag

END
GO
