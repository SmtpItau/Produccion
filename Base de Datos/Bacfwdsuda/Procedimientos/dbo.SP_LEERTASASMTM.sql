USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERTASASMTM]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERTASASMTM]
AS
BEGIN
   SET NOCOUNT ON
   SELECT   'moneda'        = b.glosa        ,
            'periodo'       = a.plazo        ,
            'tasa compra'   = a.tasa_compra  ,
            'tasa nominal'  = a.tasa_nominal ,
            'tasa_uf'       = a.tasa_uf      ,
            'codigo moneda' = a.codigo
   FROM     view_tasa_fwd          a,
            view_monedas_tasas_fwd b,
            mfac                   c
   WHERE    a.fecha  = c.acfecproc AND
            a.codigo = b.codigo
   ORDER BY moneda ,
            periodo
   SET NOCOUNT OFF
END

GO
