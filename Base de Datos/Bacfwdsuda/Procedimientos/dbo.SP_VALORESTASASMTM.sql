USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORESTASASMTM]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORESTASASMTM] ( @xfecha  CHAR(8) )
AS 
BEGIN 
SET NOCOUNT ON
   DECLARE @fecha  DATETIME 
   DECLARE @nvalor_usd  FLOAT
   SELECT  @fecha = CONVERT (DATETIME, @xfecha)
   SELECT 'Moneda'     = b.glosa                         ,
          'Dias'       = CONVERT (CHAR(5),a.plazo)       ,
          'TasaCompra' = a.tasa_compra                   ,
          'TasaNominal'= a.tasa_nominal                  ,
          'TasaUF'     = a.tasa_uf                       ,
          'Hora'       = convert(char(8), getdate(),108) ,
          'Fecha'      = convert(char(10), a.fecha, 103) ,
          'Codigo'     = a.codigo                        ,
          'Observado'  = c.vmvalor    ,
          'Interbanca' = e.vmvalor    ,
          'nombrebanco' = d.acnomprop
   FROM VIEW_TASA_FWD a              ,
        view_monedas_tasas_fwd  b    ,
        view_valor_moneda   c        ,
        mfac                d      ,
        view_valor_moneda   e
   WHERE a.codigo   = b.codigo            AND
         a.fecha    = @fecha              AND
         ( c.vmcodigo = d.accodmondolobs  AND 
    c.vmfecha  =  @fecha  ) AND 
         ( e.vmfecha  = @fecha    AND
    e.vmcodigo = '988'  )
   ORDER BY a.codigo,
            a.plazo
SET NOCOUNT OFF
END

GO
