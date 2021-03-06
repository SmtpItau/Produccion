USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAETABLASDEREDUCCION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAETABLASDEREDUCCION]
   (   @Segmento   INTEGER   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT Segmento           = tr.Segmento
   ,      Internacional      = tr.Internacional
   ,      'nomInternacional' = tg1.tbcodigo1
   ,      Nacional           = tr.Nacional
   ,      'nomNacional'      = tg2.tbcodigo1
   ,      Porcentaje         = tr.Porcentaje
   ,      Monto              = tr.Monto
   FROM   Bacparamsuda.dbo.TBL_TABLAS_DE_REDUCCION tr
          INNER JOIN Bacparamsuda.dbo.TABLA_GENERAL_DETALLE tg1 on tg1.tbcateg = 103 and tg1.tbvalor = tr.Internacional
          INNER JOIN Bacparamsuda.dbo.TABLA_GENERAL_DETALLE            tg2 on tg2.tbcateg = 103 and tg2.tbvalor = tr.Nacional
   WHERE  tr.Segmento = @Segmento
   ORDER BY tr.Segmento, tr.Internacional, tr.Nacional

END
GO
