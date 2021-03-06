USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_DATOS_EMPRESA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_DATOS_EMPRESA]
                (
                    @nNumOper    NUMERIC(9,0)  ,   -- Numero DE Operacion
                    @ncodcli     NUMERIC(9,0)      -- Codigo Cliente 
                )
AS
BEGIN
   SET NOCOUNT ON
    select 'Fecha Liquidacion' = a.cafecha,          -- Fecha Liquidacion Oper  1
    'Mto Total Compra ' = a.camtomon1,       -- Monto Total de Compra   2      
    'Nemotec Compra   ' = (select mnnemo from VIEW_MONEDA where mncodmon =a.cacodmon1),
    'Glosa Mon Compra ' = (select mnglosa from VIEW_MONEDA where mncodmon =a.cacodmon1),
    'Mto Total Venta  ' = a.camtomon2,       -- Monto Total de venta    4 
    'Nemotec Venta    ' = (select mnnemo from VIEW_MONEDA where mncodmon =a.cacodmon2),
    'Glosa Mon Venta  ' = (select mnglosa from VIEW_MONEDA where mncodmon =a.cacodmon2),
    'Tpo Cambio       ' = a.catipcam,        -- Tipo Cambio             6 
    'Tpo Operacion    ' = a.catipoper,
    'Cumplimiento     ' = a.catipmoda,
    'Numero Operacion ' = a.canumoper,
    'valor mon Compra ' = a.capremon1,  
    'valor mon Venta  ' = a.capremon2  
    
        from  mfca a 
       where a.canumoper = @nNumOper
   
   SET NOCOUNT OFF
END

GO
