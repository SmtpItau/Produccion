USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERASALDOSCUENTAS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GENERASALDOSCUENTAS]( @nObsMesAnt NUMERIC(10,2),@nValorUf Numeric(12,4))
AS
BEGIN
SET NOCOUNT ON
Declare @nValorObs as Numeric (10,2 )
Declare @dFecProc  as datetime 
Select  @dFecProc   = (Select acfecproc from mfac )
Select  @nValorObs  = (Select vmvalor   from view_valor_moneda,mfac where vmcodigo=994 and vmfecha =@dFecProc)
--cuentas seguros de cambios
update saldo_cuentas  set saldo_bac=isnull((select abs(sum(caperdsaldo))  from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='C' and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127634109'     --Perdida diferida compras
update saldo_cuentas  set saldo_bac=isnull((select round(sum(camtomon2*@nValorUF),0) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='C' and cacodmon2=998 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='4127630114' ----acredores compras UF
update saldo_cuentas  set saldo_bac=isnull((select sum(camtomon2) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='C' and cacodmon2=999 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='4127630106'  --acredores compras $
update saldo_cuentas  set saldo_bac=isnull((select sum(cautilsaldo) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='C' and cafecvcto > @dFecProc ),0) where rtrim(cuenta)='4127634101'  --utilidad diferida comprada
update saldo_cuentas  set saldo_bac=isnull((select round(sum(camtomon1*@nValorObs),0) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='C' and cafecvcto > @dFecProc ) - (select round(sum(camtomon1*@nValorObs),0) from mfca where cacodpos1=1 and catipoper='V' and cafecvcto > @dFecProc ),0) where cuenta='4510630063'  --cambio
update saldo_cuentas  set saldo_bac=isnull((select sum(camtomon1) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='C' and  cafecvcto > @dFecProc ) - (select sum(camtomon1) from mfca where cacodpos1=1 and catipoper='V' and  cafecvcto > @dFecProc),0)   where cuenta='2510630087'  --conversion de compra y ventas
update saldo_cuentas  set saldo_bac=isnull((select sum(camtomon1) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='C' and  cafecvcto > @dFecProc),0) where cuenta='2127630189'  
update saldo_cuentas  set saldo_bac=isnull((select round(sum(camtomon2*@nValorUF),0) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='V' and cacodmon2=998 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127630014'
update saldo_cuentas  set saldo_bac=isnull((select sum(camtomon2) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='V' and cacodmon2=999 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127630006'
update saldo_cuentas  set saldo_bac=isnull((select abs(sum(caperdsaldo))  from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='V' and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127634001'
update saldo_cuentas  set saldo_bac=isnull((select sum(cautilsaldo) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='V' and cafecvcto > @dFecProc ),0) where rtrim(cuenta)='4127634004'
update saldo_cuentas  set saldo_bac=isnull((select sum(camtomon1) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='V' and  cafecvcto > @dFecProc),0) where rtrim(cuenta)='4127630084'  
--cuentas de arbitrajes
--mercado local 
update saldo_cuentas  set saldo_bac=(isnull((select sum( round((camtomon1 * vmvalor)/@nObsMesAnt,2)) from mfca,view_valor_moneda,view_cliente where  cacodpos1=2 and catipoper='C' and 
                     (cacodmon1=vmcodigo and vmfecha=@dFecProc)and (cacodigo=clrut and cacodcli=clcodigo and clpais=6) and  cafecvcto > @dFecProc),0)   
                      + isnull((select sum(camtomon2 ) from mfca,view_valor_moneda,view_cliente  where  cacodpos1=2 and catipoper='V' and 
                     (cacodmon1=vmcodigo and vmfecha=@dFecProc)and (cacodigo=clrut and cacodcli=clcodigo and clpais=6) and  cafecvcto > @dFecProc),0))    where rtrim(cuenta)='2127631088' 
update saldo_cuentas  set saldo_bac=(isnull((select sum( round((camtomon1* vmvalor)/@nObsMesAnt,2)) from mfca,view_valor_moneda,view_cliente where  cacodpos1=2 and catipoper='V' and 
                     (cacodmon1=vmcodigo and vmfecha=@dFecProc)and (cacodigo=clrut and cacodcli=clcodigo and clpais=6)  and  cafecvcto > @dFecProc),0)   
                      + isnull((select sum(camtomon2 ) from mfca,view_valor_moneda,view_cliente  where  cacodpos1=2 and catipoper='C' and 
                     (cacodmon1=vmcodigo and vmfecha=@dFecProc)and (cacodigo=clrut and cacodcli=clcodigo and clpais=6) and  cafecvcto > @dFecProc),0))    where rtrim(cuenta)='4127631080'
update saldo_cuentas  set saldo_bac=isnull((select sum(cavalordia) from mfca,view_cliente  where cavalordia >= 0 and (cacodigo=clrut and cacodcli=clcodigo and clpais=6) and cacodpos1=2 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127631002'
update saldo_cuentas  set saldo_bac=isnull((select sum( abs(cavalordia)) from mfca,view_cliente  where cavalordia < 0 and (cacodigo=clrut and cacodcli=clcodigo and clpais=6) and cacodpos1=2 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='4127631005'
--mercado externo Mas Fuerte
update saldo_cuentas  set saldo_bac=(isnull((select sum( round((camtomon1* vmvalor ) /@nObsMesAnt,2)) from mfca,view_valor_moneda,view_cliente where  cacodpos1=2 and catipoper='C' and 
                     (cacodmon1=vmcodigo and vmfecha=@dFecProc)and (cacodigo=clrut and cacodcli=clcodigo and clpais<>6)  and  cafecvcto > @dFecProc),0)   
                      + isnull((select sum(camtomon2 ) from mfca,view_valor_moneda,view_cliente  where  cacodpos1=2 and catipoper='V' and 
                     (cacodmon1=vmcodigo and vmfecha=@dFecProc)and (cacodigo=clrut and cacodcli=clcodigo and clpais<>6) and  cafecvcto > @dFecProc),0))    where rtrim(cuenta)='2127631282'
update saldo_cuentas  set saldo_bac=(isnull((select sum( round((camtomon1* vmvalor)/@nObsMesAnt,2)) from mfca,view_valor_moneda,view_cliente where  cacodpos1=2 and catipoper='V' and 
                     (cacodmon1=vmcodigo and vmfecha=@dFecProc)and (cacodigo=clrut and cacodcli=clcodigo and clpais<>6)  and  cafecvcto > @dFecProc),0)
                      + isnull((select sum(camtomon2 ) from mfca,view_valor_moneda,view_cliente  where  cacodpos1=2 and catipoper='C' and 
                     (cacodmon1=vmcodigo and vmfecha=@dFecProc)and (cacodigo=clrut and cacodcli=clcodigo and clpais<>6) and  cafecvcto > @dFecProc),0))    where rtrim(cuenta)='4127631285'
update saldo_cuentas  set saldo_bac=isnull((select sum(cavalordia) from mfca,view_cliente  where cavalordia >= 0 and (cacodigo=clrut and cacodcli=clcodigo and clpais<>6) and cacodpos1=2 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127631207'
update saldo_cuentas  set saldo_bac=isnull((select sum( abs(cavalordia)) from mfca,view_cliente  where cavalordia < 0 and (cacodigo=clrut and cacodcli=clcodigo and clpais<>6) and cacodpos1=2 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='4127631202'
--cuentas de seguros de inflacion
update saldo_cuentas  set saldo_bac=isnull((select abs(sum(caperdsaldo)) from mfca where cacodpos1=3 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127633005'
update saldo_cuentas  set saldo_bac=isnull((select sum(cautilsaldo) from mfca where cacodpos1=3 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127635000'
update saldo_cuentas  set saldo_bac=isnull((select round(sum(camtomon1* @nValorUF),0) from mfca where cacodpos1=3 and catipoper='C' and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127633013'
update saldo_cuentas  set saldo_bac=isnull((select round(sum(camtomon1* catipcam ),0) from mfca where cacodpos1=3 and catipoper='C' and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127633008'
update saldo_cuentas  set saldo_bac=isnull((select sum(cautildiferir) from mfca where cacodpos1=3 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='9700633001'
update saldo_cuentas  set saldo_bac=isnull((select abs(sum(caperddiferir)) from mfca where cacodpos1=3 and cafecvcto > @dFecProc),0) where rtrim(cuenta)='9899635008'
update saldo_cuentas  set saldo_bac=isnull((select round(sum(camtomon2*@nValorUF),0) from mfca where cacodpos1=3 and catipoper='V' and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127635019'
update saldo_cuentas  set saldo_bac=isnull((select round(sum(camtomon1* catipcam),0) from mfca where cacodpos1=3 and catipoper='V' and cafecvcto > @dFecProc),0) where rtrim(cuenta)='2127635008'
update saldo_cuentas  set saldo_bac = ABS( saldo_bac )
SET NOCOUNT OFF
END
-- select isnull((select sum(camtomon1) from mfca where ( cacodpos1=1 OR cacodpos1=7 ) and catipoper='C' and  cafecvcto > '20010831' ) - (select sum(camtomon1) from mfca where cacodpos1=1 and catipoper='V' and  cafecvcto > '20010831'),0)   where cuenta=2510630087  --conversion de compra y ventas
-- sp_GeneraSaldosCuentas 664.38, 16015.78
-- select * from view_valor_moneda where vmfecha = '20010830'

GO
