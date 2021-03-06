USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_leertasasmtm]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_leertasasmtm]
AS
BEGIN
   SET NOCOUNT ON
   SELECT   "moneda"        = b.glosa      ,
            "periodo"       = a.plazo      ,
            "tasa compra"   = a.tasa_compra,
            "tasa venta"    = a.tasa_venta ,
            "codigo moneda" = a.codigo
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
