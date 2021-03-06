USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INS_LEE_TAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_INS_LEE_TAS]
( 
    @CodMon  INTEGER = 0 ,
    @CodTasa INTEGER = 0 ,
    @Periodo INTEGER = 0 ,
    @Fecha   CHAR(8) = '',
    @Len     INTEGER = 8 
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

       FROM View_Moneda_Tasa 		a,
            view_moneda           	b,
            view_tabla_general_detalle  c,
            View_Periodo_Amortizacion   d

      WHERE (a.codmon  = @CodMon  OR @CodMon  =  0)
        AND (a.codtasa = @CodTasa OR @CodTasa =  0)
        AND (a.periodo = @Periodo OR @Periodo =  0)
        AND (SUBSTRING(CONVERT(CHAR(8),a.fecha,112),1,@Len) = SUBSTRING(@Fecha,1,@Len) OR @Fecha = '')
        AND  a.codmon   = b.mncodmon                      -- Moneda
        AND (c.tbcateg = 1042 AND a.codtasa = c.tbcodigo1)  -- Tasa
        AND (d.tabla    = 1044 AND a.periodo = d.codigo  )  -- Periodo
      ORDER BY fecha, codmon, codtasa, periodo

SET NOCOUNT OFF
END

GO
