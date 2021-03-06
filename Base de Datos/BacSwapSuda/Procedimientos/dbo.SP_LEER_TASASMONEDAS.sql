USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TASASMONEDAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_TASASMONEDAS]  
   (   @CodMon   INTEGER = 0
   ,   @CodTasa  INTEGER = 0
   ,   @Periodo  INTEGER = 0
   ,   @Fecha    CHAR(8) = ''
   ,   @Len      INTEGER = 8
   ,   @Producto INTEGER = 0
   )
AS
BEGIN
   SET NOCOUNT ON

   SELECT a.codmon                       , -- 1
          ISNULL(b.mnglosa,'')           , -- 2
          a.codtasa                      , -- 3
          ISNULL(c.tbglosa,'')           , -- 4
          a.periodo                      , -- 5
          ISNULL(d.glosa,'')             , -- 6
          CONVERT(CHAR(10),a.fecha,103)  , -- 7
          a.tasa                         , -- 8
          a.tasacap                      , -- 9
          a.tasacol                      , -- 10
          d.meses                        , -- 11
          d.dias                           -- 12
   FROM   VIEW_MONEDA_TASA 		a,
          VIEW_MONEDA           	b,
          VIEW_TABLA_GENERAL_DETALLE    c,
          VIEW_PERIODO_AMORTIZACION     d
   WHERE  a.codmon   = b.mncodmon                            -- Moneda
   AND   (c.tbcateg  = 1042    AND a.codtasa = c.tbcodigo1)  -- Tasa
   AND   (d.tabla    = 1044    AND a.periodo = d.codigo  )   -- Periodo
   AND   (SUBSTRING(CONVERT(CHAR(8),a.fecha,112),1,@Len) = SUBSTRING(@Fecha,1,@Len) OR @Fecha = '')
   AND   (a.codmon   = @CodMon  OR @CodMon  =  0)
   AND   (a.codtasa  = @CodTasa OR @CodTasa =  0)
   AND   (a.periodo  = @Periodo OR @Periodo =  0)
   ORDER BY fecha, codmon, codtasa, periodo

END
GO
