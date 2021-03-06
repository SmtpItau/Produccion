USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_CARTERAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_CARTERAS]
   (   @nCodigo   INTEGER   )
AS
BEGIN

   SET NOCOUNT ON

   IF @nCodigo = 204
   BEGIN

      SELECT DISTINCT 
             tbcodigo1
           , tbglosa
       FROM BacParamSuda..TABLA_GENERAL_DETALLE 
            INNER JOIN BacParamSuda.dbo.TIPO_CARTERA ON rcsistema = 'BTR' AND LTRIM(RTRIM(CONVERT(CHAR,rcrut))) = tbcodigo1
      WHERE tbcateg     = @nCodigo
	AND tbcodigo1	= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
   END ELSE
   BEGIN
      SELECT tbcodigo1, tbglosa 
       FROM BacParamSuda..TABLA_GENERAL_DETALLE 
      WHERE tbcateg = @nCodigo

   END

END


GO
