USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_TASAMONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETORNA_TASAMONEDA]
   (   @MiTag     INTEGER
   ,   @CodMon    INTEGER   = 0
   ,   @CodTasa   INTEGER   = 0
   ,   @Periodo   INTEGER   = 0
   ,   @Producto  INTEGER   = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT convert(numeric(5) , tm.Codigo_Moneda )        as CodigoMoneda
   ,      convert(varchar(20),ltrim(rtrim(mn.mnglosa)))  as GlosaMoneda
   ,      convert(numeric(5) , tm.Codigo_Tasa )          as CodigoTasa 
   ,      convert(varchar(14),ltrim(rtrim(tb.tbglosa)))  as GlosaTasa 
   ,      convert(numeric(5) , tb.tbtasa )               as CodigoPariodo
   ,      convert(varchar(15),ltrim(rtrim(pa.glosa)))    as GlosaPariodo
   ,      convert(numeric(5),pa.meses)                   as Meses
   ,      convert(numeric(9),pa.dias)                    as Dias
   INTO   #TasaMoneda
   FROM   BacparamSuda..TASAS_MONEDA tm
          LEFT JOIN BacparamSuda..MONEDA mn                ON tm.Codigo_Moneda = mn.mncodmon
          LEFT JOIN BacparamSuda..TABLA_GENERAL_DETALLE tb ON tb.tbcateg       = 1042 and  tb.tbcodigo1 = tm.Codigo_Tasa
          LEFT JOIN BacparamSuda..PERIODO_AMORTIZACION  pa ON pa.tabla         = 1044 and (tb.tbtasa    = pa.codigo or tb.tbtasa = 0)
   WHERE  (tm.Codigo_Moneda  = @CodMon  or @CodMon  = 0)
   AND    (tm.Codigo_Tasa    = @CodTasa or @CodTasa = 0)
--   AND    (tb.tbtasa         = @Periodo or @Periodo = 0 or tb.tbtasa = 0) -- MAP 20080429 Mejoras Swap
   ORDER BY tm.Codigo_Moneda , tm.Codigo_Tasa , tb.tbtasa

   IF @MiTag = 0
   BEGIN
      IF @Producto <> 4
      BEGIN
         DELETE FROM #TasaMoneda WHERE GlosaTasa LIKE '%ICP%'
      END
      SELECT DISTINCT CodigoTasa , GlosaTasa FROM #TasaMoneda ORDER BY CodigoTasa
   END

END
GO
