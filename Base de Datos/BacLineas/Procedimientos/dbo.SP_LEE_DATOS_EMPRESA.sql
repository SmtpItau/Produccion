USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_DATOS_EMPRESA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_DATOS_EMPRESA]
       (
        @nrutcli     NUMERIC(9,0)  ,   -- RUT Cliente
        @ncodcli     NUMERIC(9,0)      -- Codigo Cliente 
       )
AS
BEGIN
   SET NOCOUNT ON
    select 'Fecha Liquidacion ' = a.cafecha, 
    'Tipo Moneda Compra' =  (select mnnemo from moneda where a.cacodmon = m.mncodmon),
    'Tipo Moneda venta ' =  (select mnnemo from moneda where a.cacodmon2 = m.mncodmon), 
    'Monto Extranjero  ' = a.camtomon1,
    'Monto Moneda Pe   ' = a.camtomon2,
    'Tipo Moneda Extr  ' =  (select mnglosa from moneda where a.cacodmon = m.mncodmon),
    'Tipo Moneda Pag   ' =  (select mnglosa from moneda where a.cacodmon2 = m.mncodmon),
    'Tipo Cambio       ' = a.catipcam
 
        from  mfca a ,
       moneda m
       where a.aprutcli=  @nrutcli
   
   SET NOCOUNT OFF
END
GO
