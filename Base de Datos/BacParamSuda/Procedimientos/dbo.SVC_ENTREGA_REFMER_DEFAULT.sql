USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_ENTREGA_REFMER_DEFAULT]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SVC_ENTREGA_REFMER_DEFAULT]
   (   @nProducto   INTEGER
   ,   @nRefMercado INTEGER OUTPUT
   )
AS
BEGIN
   
   SET NOCOUNT ON

   SET @nRefMercado = -1

   CREATE TABLE #TMP_REF_MER
   (   Codigo   INTEGER
   ,   Glosa    VARCHAR(250)
   ,   Defecto  INTEGER
   )
   
   INSERT INTO #TMP_REF_MER
   EXECUTE dbo.SP_REFERENCIA_MERCADO_PRODUCTO 0, @nProducto

   SET @nRefMercado = (SELECT TOP 1 codigo FROM #TMP_REF_MER WHERE Defecto = 1)

   IF @nRefMercado IS NULL
   BEGIN
      IF (SELECT COUNT(1) FROM #TMP_REF_MER) = 1
         SET @nRefMercado = (SELECT TOP 1 codigo FROM #TMP_REF_MER)
      ELSE
         SET @nRefMercado = -1
   END

END

GO
