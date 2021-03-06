USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEVENCIMIENTOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEVENCIMIENTOS]
 as 
 begin
 select convert(numeric(10,0), MDMO.monumoper), convert(char(10), MDMO.mofecinip,103), VIEW_CLIENTE.clnombre, 
        VIEW_MONEDA.mnnemo, MDMO.movalinip, MDMO.motaspact, MDMO.movalvenp,
               MDFP.glosa, convert(numeric(5,0),MDMO.moforpagv)
        from   MDMO, VIEW_CLIENTE, VIEW_MONEDA , VIEW_FORMA_DE_PAGO MDFP
        where  (MDMO.motipoper = 'RC' or MDMO.motipoper= 'RV' or MDMO.motipoper = 'VCI') 
        and    MDMO.morutcli = VIEW_CLIENTE.clrut
        and    MDMO.momonpact = VIEW_MONEDA.mncodmon
        and    MDFP.codigo =MDMO.moforpagv
 order by MDMO.monumoper
 end

GO
