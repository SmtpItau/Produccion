USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRASEGMENTOTABLASDEREDUCCION]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRASEGMENTOTABLASDEREDUCCION]
   (   @Segmento   INTEGER   )
AS
BEGIN

   SET NOCOUNT ON

   DELETE FROM Bacparamsuda.dbo.TBL_TABLAS_DE_REDUCCION
         WHERE Segmento = @Segmento

   IF @@Error = 0
      SELECT 0, 'OK'
   ELSE
      SELECT -1, 'Error al eliminar segmento'

END
GO
