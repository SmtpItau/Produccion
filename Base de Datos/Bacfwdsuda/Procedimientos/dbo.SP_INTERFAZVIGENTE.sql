USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZVIGENTE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZVIGENTE] 
AS
BEGIN
SET NOCOUNT ON
Declare @nMonto NUMERIC (21)
Select 'Registro'   = case when  a.cafecha=c.acfecproc then 1 else 2 end,
       'CtaContable'= case when cacodpos1 =3 then '9899635008' else '8990980005' end,
       'Unidad'     = 2119,
       'NumOpe'     = a.canumoper,
       'Monto'      = a.cautildiferir,
       'Fecha'      = convert(char(10),c.acfecproc,103),
       'Rut'        = b.clrut    ,
       'Dv'         = b.cldv     ,
       'Cliente'    = b.clnombre ,
       'Sector'     = CASE WHEN b.cltipcli = 1 OR b.cltipcli = 2 THEN 40 ELSE 21 END ,
       'PoMenor'    = case when a.catipoper='C' then 'COMPRA A FUTURO'+space(15) else 'VENTA A FUTURO'+space(15) end,
       'Despacha'   = 7149,
       'Destino'    = 7149,
       'CodPro'     = a.cacodpos1,
       'Pais'       =b.clpais
into   #tpmpaso
From    mfca a, VIEW_CLIENTE b, mfac c
Where  (a.cacodigo=b.clrut and a.cacodcli=b.clcodigo and b.clpais = 6 ) and a.cacodpos1<>7 and a.cautildiferir>0 and
       (a.cafecha=c.acfecproc or a.cafecvcto<=c.acfecproc)
--campo ultimo no esta identificado
insert into #tpmpaso
Select 'Registro'   = case when a.corultimo='S'  then 2 else 1 end,
       'CtaContable'= '2115910208',
       'Unidad'     = 2119,
       'NumOpe'     = d.canumoper,
       'Monto'      = a.corsaldo,
       'Fecha'      = convert(char(10),c.acfecproc,103),
       'Rut'        = b.clrut    ,
       'Dv'         = b.cldv     ,
       'Cliente'    = b.clnombre ,
       'Sector'     = CASE WHEN b.cltipcli = 1 OR b.cltipcli = 2 THEN 40 ELSE 21 END ,
       'PoMenor'    = case when d.catipoper='C' then 'COMPRA COMPENSACION PARCIAL' else 'VENTA COMPENSACION PARCIAL' end,
       'Despacha'   = 7149,
       'Destino'    = 7149,
       'CodPro'     = d.cacodpos1,
       'Pais'       =b.clpais
From    cortes a, VIEW_CLIENTE b, mfac c ,mfca d
Where  (d.cacodigo=b.clrut and d.cacodcli=b.clcodigo and b.clpais = 6 ) and  d.cacodpos1=7 and 
       (a.cornumoper=d.canumoper and  a.cornumoper > 0) and a.corfecvcto=d.cafecvcto 
--inserta modificaciones de la log 
insert into #tpmpaso
Select 'Registro'   =  2,
       'CtaContable'= case when a.cacodpos1 =3 then '9899635008' else '8990980005' end,
       'Unidad'     = 2119,
       'NumOpe'     = a.canumoper,
       'Monto'      = a.cautildiferir,
       'Fecha'      = convert(char(10),c.acfecproc,103),
       'Rut'        = b.clrut    ,
       'Dv'         = b.cldv     ,
       'Cliente'    = b.clnombre ,
       'Sector'     = CASE WHEN b.cltipcli = 1 OR b.cltipcli = 2 THEN 40 ELSE 21 END ,
       'PoMenor'    = case when a.catipoper='C' then 'COMPRA A FUTURO'+space(15) else 'VENTA A FUTURO'+space(15) end,
       'Despacha'   = 7149,
       'Destino'    = 7149,
       'CodPro'     = a.cacodpos1,
       'Pais'       = b.clpais
from  mfca_log a,view_cliente b,mfac c
Where (a.cacodigo=b.clrut and a.cacodcli=b.clcodigo and b.clpais = 6 ) and a.cacodpos1<>7 and a.caestado='M' and  a.cafecmod=c.acfecproc and 
      a.caprimero='S' and a.cafecha > c.acfecproc and a.cautildiferir > 0
--inserta operaciondes de cartera modificadas
insert into #tpmpaso
Select 'Registro'   =  2,
       'CtaContable'= case when a.cacodpos1 =3 then '9899635008' else '8990980005' end,
       'Unidad'     = 2119,
       'NumOpe'     = a.canumoper,
       'Monto'      = a.cautildiferir,
       'Fecha'      = convert(char(10),c.acfecproc,103),
       'Rut'        = b.clrut    ,
       'Dv'         = b.cldv     ,
       'Cliente'    = b.clnombre ,
       'Sector'     = CASE WHEN b.cltipcli = 1 OR b.cltipcli = 2 THEN 40 ELSE 21 END ,
       'PoMenor'    = case when a.catipoper='C' then 'COMPRA A FUTURO'+space(15) else 'VENTA A FUTURO'+space(15) end,
       'Despacha'   = 7149,
       'Destino'    = 7149,
       'CodPro'     = a.cacodpos1,
       'Pais'       = b.clpais
from  mfca a,view_cliente b,mfac c, mfca_log d
Where (a.cacodigo=b.clrut and a.cacodcli=b.clcodigo and b.clpais = 6 ) and a.cacodpos1<>7 and  a.cautildiferir > 0 and 
      a.cafecha > c.acfecproc  and  d.cafecmod=c.acfecproc and  a.canumoper=d.canumoper and  d.caprimero='S' and d.caestado='M'
select * from #tpmpaso
SET NOCOUNT OFF
END

GO
