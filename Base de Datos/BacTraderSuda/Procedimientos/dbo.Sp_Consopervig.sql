USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Consopervig]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_consopervig    fecha de la secuencia de comandos: 05/04/2001 13:13:18 ******/
create procedure [dbo].[Sp_Consopervig]
    (
    @itipbus integer  ,
    @nrutcli numeric (10,0) ,
    @cnomcli char (50)
    )
as
begin
set nocount on
 declare @cdv  char (01) ,
  @cnombre char (50)
 if @itipbus=0
 begin
  select @cnombre = @cnomcli
  select @cnomcli = '%'+rtrim(@cnomcli)+'%' ,
   @nrutcli = 0    ,
   @cdv  = ''
  
  set rowcount 1
  select @nrutcli = clrut  ,
   @cdv  = cldv  ,
   @cnomcli = clnombre ,
   @cnombre = clnombre
  from VIEW_CLIENTE
  where clnombre like rtrim(@cnomcli)
  set rowcount 0
 end
 if exists(select * from VIEW_CLIENTE where clrut=@nrutcli) and @nrutcli>0
 begin
  select motipoper    ,
   monumoper    ,
   monumdocu    ,
   'movalinip' = isnull(movalinip,0) ,
   'movalvenp' = isnull(movalvenp,0) ,
   'movalcomp' = isnull(movalcomp,0) ,
   'movalven' = isnull(movalven,0) ,
   mofecinip    ,
   mofecvenp    ,
   mofecemi    ,
   mofecven    ,
   momascara    ,
   mohora
  into #TMP1
  from MDMH(index=mh02), MDAC
  where (mofecpro>=dateadd(year,-1,acfecproc) and (motipoper='VI' or motipoper='CI' or
   motipoper='CP' or motipoper='VP' or motipoper='IB')) and morutcli=@nrutcli and
   mostatreg=null
--sp_help MDMH
  select distinct 'tipoper' = motipoper+space(15)    ,
    'numoper' = monumoper     ,
    'totini' = space (30)     ,
    'totvcto' = space (30)     ,
    'monpact' = isnull(convert(char(05),momonpact),'999') ,
    'fecinip' = space (30)     ,
    'fecvcto' = space (30)     ,
    'hora'  = space (08)     ,
    'nomoper' = nombre     ,
    'instser' = space (10)
  into #TMP
  from MDMH(index=mh02), BACUSER, MDAC
  where (mofecpro>=dateadd(year,-1,acfecproc) and (motipoper='VI' or motipoper='CI' or
   motipoper='CP' or motipoper='VP' or motipoper='IB') and morutcli=@nrutcli) and
   mousuario=usuario and mostatreg=null
  update #TMP
  set tipoper = 'VENTA CON PACTO'           ,
   hora = substring(mohora,1,8)           ,
   totini = convert(char(30),(select sum(movalinip) from #TMP1 where numoper=monumoper and motipoper='VI')) ,
   totvcto = convert(char(30),(select sum(movalvenp) from #TMP1 where numoper=monumoper and motipoper='VI')) ,
   fecinip = isnull(convert(char(10),mofecinip,103),'')        ,
   fecvcto = isnull(convert(char(10),mofecvenp,103),'')        ,
   instser = ''
  from #TMP1
  where numoper=monumoper and motipoper='VI'
  update #TMP
  set tipoper = 'COMPRA PROPIA'           ,
   hora = substring(mohora,1,8)           ,
   totini = convert(char(30),(select sum(movalcomp) from #TMP1 where numoper=monumdocu and motipoper='CP')) ,
   fecinip = convert(char(10),mofecemi,103)         ,
   fecvcto = convert(char(10),mofecven,103)         ,
   totvcto = convert(char(30),0.0)
  from #TMP1
  where numoper=monumoper and motipoper='CP'
  update #TMP
  set tipoper = 'VENTA PROPIA'           ,
   hora = substring(mohora,1,8)           ,
   totini = convert(char(30),(select sum(movalcomp) from #TMP1 where numoper=monumoper and motipoper='VP')) ,
   totvcto = convert(char(30),(select sum(movalven) from #TMP1 where numoper=monumoper and motipoper='VP')) ,
   fecinip = isnull(convert(char(10),mofecemi,103),'')        ,
   fecvcto = isnull(convert(char(10),mofecven,103),'')
  from #TMP1
  where numoper=monumoper and motipoper='VP'
  update #TMP
  set tipoper = 'COMPRA CON PACTO'           ,
   hora = substring(mohora,1,8)           ,
   totini = convert(char(30),(select sum(movalinip) from #TMP1 where numoper=monumoper and motipoper='CI')) ,
   totvcto = convert(char(30),(select sum(movalvenp) from #TMP1 where numoper=monumoper and motipoper='CI')) ,
   fecinip = isnull(convert(char(10),mofecinip,103),'')        ,
   fecvcto = isnull(convert(char(10),mofecvenp,103),'')        ,
   instser = ''
  from #TMP1
  where numoper=monumoper and motipoper='CI'
  update #TMP
  set tipoper = 'CAPTACION'            ,
   hora = substring(mohora,1,8)           ,
   totini = convert(char(30),(select sum(movalinip) from #TMP1 where numoper=monumoper and motipoper='IB')) ,
   totvcto = convert(char(30),(select sum(movalvenp) from #TMP1 where numoper=monumoper and motipoper='IB')) ,
   fecinip = isnull(convert(char(10),mofecinip,103),'')        ,
   fecvcto = isnull(convert(char(10),mofecvenp,103),'')        ,
   instser = momascara
  from #TMP1
  where numoper=monumoper and motipoper='IB'
  update #TMP
  set tipoper = 'COLOCACION'
  where instser='ICOL'
  update #TMP
  set monpact  = mnnemo ,
   @cnomcli = clnombre ,
   @cdv  = cldv
  from VIEW_MONEDA, VIEW_CLIENTE
  where convert(integer,monpact)=mncodmon and @nrutcli=clrut
  if (select count(*) from #TMP)>0 
   select numoper,totini,totvcto,monpact,fecinip,fecvcto,hora,nomoper,tipoper,@nrutcli,@cdv,@cnomcli from #TMP order by numoper
  else
   select 'NO','NO EXISTEN OPERACIONES CON CLIENTE',@nrutcli,@cdv,@cnombre
 end
 else
  select 'NO','CLIENTE NO EXISTE',@nrutcli,@cdv,@cnombre
end
-- sp_consopervig 0,       0,'telex'
-- sp_consopervig 0,       0,'banco del estado'
-- sp_consopervig 1,97030000,''
-- sp_consopervig 1,84341600,''
-- sp_consopervig 1,96547310,''
-- sp_consopervig 1,87108000,''
-- sp_consopervig 1,94478000,''
-- sp_consopervig 1,79962380,''
-- sp_consopervig 1,7572376,''
--select * from BACUSER
GO
