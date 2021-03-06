USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTDOCCUSTO_DESPLIEGUE]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_MNTDOCCUSTO_DESPLIEGUE] (@NOPERA  NUMERIC(9)) 
as
begin
set nocount on
select  catipoper,
 --select * from VIEW_PRODUCTO
        'CodPro'=isnull((select Descripcion from VIEW_PRODUCTO where str(cacodpos1)=Codigo_Producto),''),
        cacodmon1,
        catipmoda,
       --select * FROM VIEW_MONEDA  --MNNEMO
 --select * FROM MFCA
 --       'DESCRIMONEDA'=SELECT isnull(VIEW_MONEDA.Mnnemo,'') FROM VIEW_MONEDA WHERE cacodmon1= VIEW_MONEDA.Mncodmon +
       'DESCRIMONEDA'= (SELECT isnull(ltrim(rtrim(VIEW_MONEDA.Mnnemo)),'') FROM VIEW_MONEDA WHERE cacodmon1= VIEW_MONEDA.Mncodmon) +
        '/'+(SELECT isnull(rtrim(ltrim(VIEW_MONEDA.Mnnemo)),'') FROM VIEW_MONEDA WHERE cacodmon2= VIEW_MONEDA.Mncodmon),
        isnull(camtomon1,0),
        isnull(catipcam,0),
        isnull(cafecha,''), 
        isnull(cafecvcto,''),
        isnull(Contrato_Entrega_Via,''),
        isnull(Contrato_Emitido_por,''),
        isnull(Contrato_Ubicado_en,''),
        isnull(NumeroContratoCliente,0),
        isnull(FechaEmision ,''),
        isnull(FechaRecepcion,''),
        isnull(FechaIngresocustodia,''),
        isnull(FechaFirmacontrato,''),
        isnull(FechaRetirocustodia,'')
              
       FROM MFCA       
       WHERE   MFCA.canumoper = @NOPERA 
  set nocount off
END

GO
