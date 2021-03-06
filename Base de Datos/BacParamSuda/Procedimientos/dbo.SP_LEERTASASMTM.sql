USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERTASASMTM]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEERTASASMTM]
AS
BEGIN
   SET NOCOUNT ON
   SELECT   'moneda'        = b.glosa      ,
            'periodo'       = a.plazo      ,
            'tasa compra'   = a.tasa_compra,
            'tasa venta'    = a.tasa_venta ,
            'codigo moneda' = a.codigo
   FROM     tasa_fwd          a,
            monedas_tasas_fwd b,
            view_mfac                   c
   WHERE    a.fecha  = c.acfecproc AND
            a.codigo = b.codigo
   ORDER BY moneda ,
            periodo
   SET NOCOUNT OFF
END
---select * from monedas_tasas_fwd

GO
