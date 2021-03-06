USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORESTASASMTM]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORESTASASMTM] ( @xfecha  CHAR(8) )
AS 
BEGIN 
SET NOCOUNT ON
   DECLARE @fecha datetime 
   declare @nvalor_usd float
   SELECT  @fecha = CONVERT (DATETIME, @xfecha)
   SELECT 'Moneda'     = b.glosa                         ,
          'Dias'       = CONVERT (CHAR(5),a.plazo)       ,
          'TasaCompra' = a.tasa_compra                   ,
          'TasaVenta'  = a.tasa_venta                    ,
          'TasaNominal'= a.tasa_nominal                  ,
          'TasaUF'     = a.tasa_uf                       ,
          'TasaVar'    = a.tasa_var                      ,
          'Hora'       = convert(char(8), getdate(),108) ,
          'Fecha'      = convert(char(10), a.fecha, 103) ,
          'Codigo'     = a.codigo                        ,
          'Observado'  = c.vmvalor, vmcodigo
   FROM TASA_FWD a              ,
        monedas_tasas_fwd  b    ,
        valor_moneda   c        ,
        view_mfac                d
   WHERE a.codigo   = b.codigo            AND
         a.fecha    = @fecha              AND
         c.vmcodigo = d.accodmondolobs    AND 
         c.vmfecha  = @fecha
   ORDER BY a.codigo,
            a.plazo
SET NOCOUNT OFF
END
----SELECT * FROM TASA_FWD
GO
