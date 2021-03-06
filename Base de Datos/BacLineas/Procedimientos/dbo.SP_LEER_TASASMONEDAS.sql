USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TASASMONEDAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_TASASMONEDAS]( @CodMon  INTEGER = 0 ,
                                       @CodTasa INTEGER = 0 ,
                                       @Periodo INTEGER = 0 ,
                                       @Fecha   CHAR(8) = '',
                                       @Len     INTEGER = 8 )
AS
BEGIN
     SELECT  a.codmon                      , -- 1
            isnull(b.mnglosa,'')           , -- 2
            a.codtasa                      , -- 3
            isnull(c.tbglosa,'')           , -- 4
            a.periodo                      , -- 5
            isnull(d.glosa,'')             , -- 6
            convert(char(10),a.fecha,103)  , -- 7
            a.tasa                         , -- 8
            a.tasacap                      , -- 9
            a.tasacol                      , -- 10
            d.meses                        , -- 11
            d.dias                           -- 12
       FROM MONEDA_TASA a,
            MONEDA           b,
            TABLA_GENERAL_DETALLE           c,
            PERIODO_AMORTIZACION      d
      WHERE (a.codmon  = @codmon  or @codmon  =  0)
        and (a.codtasa = @codtasa or @codtasa =  0)
        and (a.periodo = @periodo or @periodo =  0)
        and (substring(convert(char(8),a.fecha,112),1,@len) = substring(@fecha,1,@len) or @fecha = '')
        and  a.codmon   = b.mncodmon                      -- moneda
        and (c.tbcateg = 1042 and a.codtasa = c.tbcodigo1)  -- tasa
        and (d.tabla    = 1044 and a.periodo = d.codigo  )  -- periodo
      ORDER BY fecha, codmon, codtasa, periodo
        
END
GO
