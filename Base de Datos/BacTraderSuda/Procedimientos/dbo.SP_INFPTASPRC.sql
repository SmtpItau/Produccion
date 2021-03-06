USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFPTASPRC]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFPTASPRC]
  (@nopcion integer )
as
begin
 declare @dfecpro datetime   ,
  @dfecprox datetime   ,
  @cinstser char  (10)  ,
  @cgrupo  char  (07)  ,
  @cdcv  char  (01)  ,
  @ncontador numeric  (10,0)  ,
  @ix  integer    ,
  @nnominal numeric  (19,4)  ,
  @nnomstk numeric  (19,4)  ,
  @nnomibae numeric  (19,4)  ,
  @iano  integer    ,
  @imes  integer    ,
  @idia  integer    ,
  @cfecven char  (10)  ,
  @ipunta  integer    ,
  @cnomemp char  (30)  ,
  @crutemp char  (12)
  
 select @ncontador = 0.0    ,
  @ix  = 1
 create table #TMP1
   (
   punta  integer  null ,
   instser  char (10) null ,
   nomint  numeric (19,4) null ,
   fecvenp  char (10) null ,
   dcv  char (01) null ,
   contador numeric (10,0) identity(1,1) not null
   )
 create table #TMP3
   (
   nomemp  char (30) null ,
   rutemp  char (12) null ,
   info  char (15) null ,
   punta  integer  null ,
   instser  char (10) null ,
   nomint  numeric (19,4) null ,
   fecvenp  char (10) null ,
   nomidcv  numeric (19,4) null ,
   posdia  char (10) null ,
   postotal numeric (19,4) null ,
   fecprox  char (10) null
   )
 create table #TMP4
   (
   nomemp  char (30) null ,
   rutemp  char (12) null ,
   info  char (15) null ,
   punta  integer  null ,
   instser  char (10) null ,
   grupo  char (10) null ,
   nomidis  numeric (19,4) null ,
   fecven  char (10) null ,
   ano  integer  null ,
   mes  integer  null ,
   dia  integer  null ,
   nomstock numeric (19,4) null ,
   fecpro  char (10) null
   )
 select @dfecpro = acfecproc   ,
  @dfecprox = acfecprox   ,
  @cnomemp = acnomprop   ,
  @crutemp = str(acrutprop)+'-'+acdigprop
 from MDAC
 insert into #TMP1
    (
    instser    ,
    nomint    ,
    fecvenp    ,
    dcv
    )
 select
    viinstser   ,
    vinominal   ,
    convert(char(10),vifecvenp,103) ,
    isnull(cpdcv,'n')
 from MDVI, MDCP
 where vicodigo=4 and vinumdocu=cpnumdocu and vicorrela=cpcorrela
 
 select 'punta'  = convert(integer,0)            ,
  'numcup' = convert(integer,0)            ,
  'instser' = cpinstser             ,
  'nomidis' = cpnominal             ,
  'fecven' = cpfecven             ,
  'ano'  = datediff(year,@dfecpro,cpfecven)          ,
  'mes'  = datediff(month,@dfecpro,cpfecven)          ,
  'dia'  = datediff(day,@dfecpro,cpfecven)          ,
  'nomstock' = cpnominal+isnull((select sum(vinominal) from MDVI where cpnumdocu=vinumdocu and cpcorrela=vicorrela),0) ,
  'pervcup' = sepervcup             ,
  'contador' = cpnumdocu+cpcorrela
 into #TMP2
 from MDCP, VIEW_SERIE
 where (cpcodigo=4 and cprutcart>0) and cpmascara=semascara
 update #TMP2
 set mes = mes-(ano*12)
 update #TMP2
 set ano = ano - 1   ,
  mes = 12 + mes
 where mes<0
 update #TMP2
 set numcup = round(ano*(12/pervcup),0)
 update #TMP2
 set numcup = numcup+convert(integer,mes/pervcup)
 where mes>=pervcup
 update #TMP2
 set punta = case
    when numcup>6  and numcup<11 then 4
    when numcup>10 and numcup<13 then 5
    when numcup>12 and numcup<15 then 6
    when numcup>14 and numcup<19 then 8
    when numcup>18 and numcup<23 then 10
    when numcup>22 and numcup<31 then 14
    when numcup>30 and numcup<41 then 20
    else 0
     end         ,
  dia = datediff(day,fecven,dateadd(month,mes,dateadd(year,ano,@dfecpro)))
 update #TMP1
 set punta = #TMP2.punta
 from #TMP2
 where #TMP1.instser=#TMP2.instser
 while @ix=1
 begin
  select @cinstser = '*'
  set rowcount 1
  select @cinstser = instser   ,
   @ipunta  = punta    ,
   @nnominal = nomint   ,
   @cfecven = convert(char(10),fecvenp,103) ,
   @cdcv  = dcv    ,
   @nnomstk = nomint   ,
   @ncontador = contador
  from #TMP1
  where contador>@ncontador
  order by contador
  set rowcount 0
  if @cinstser='*'
   break
  if @cdcv='n'
   select @nnomstk = 0.0
  select @nnomibae = sum(nomidis) from #TMP2 where @ipunta=#TMP2.punta
  if exists(select * from #TMP3 where instser=@cinstser and punta=@ipunta and fecvenp=@cfecven)
   update #TMP3
   set nomint = nomint+@nnominal ,
    nomidcv = nomidcv+@nnomstk
   where instser=@cinstser and punta=@ipunta and fecvenp=@cfecven
  else
   insert into #TMP3
     (
     nomemp    ,
     rutemp    ,
     info    ,
     punta    ,
     instser    ,
     nomint    ,
     fecvenp    ,
     nomidcv    ,
     posdia    ,
     postotal   ,
     fecprox
     )
   values
     (
     @cnomemp   ,
     @crutemp   ,
     'Sp_Infptasprc'   ,
     @ipunta    ,
     @cinstser   ,
     @nnominal   ,
     @cfecven   ,
     @nnomstk   ,
     convert(char(10),@dfecpro,103) ,
     @nnomibae   ,
     convert(char(10),@dfecprox,103)
     )
 end
 update #TMP3
 set postotal = postotal+isnull(#TMP1.nomint,0)
 from #TMP1
 where convert(char(10),@dfecprox,103)=#TMP1.fecvenp and #TMP3.punta=#TMP1.punta
 select @ncontador = 0.0
 while @ix=1
 begin
  select @cinstser = '*'
  set rowcount 1
  select @cinstser = instser         ,
   @cgrupo  = stuff(substring(instser,4,10),charindex('-',substring(instser,4,10)),1,'') ,
   @ipunta  = punta          ,
   @nnominal = nomidis         ,
   @cfecven = convert(char(10),fecven,103)       ,
   @iano  = ano          ,
   @imes  = mes          ,
   @idia  = dia          ,
   @nnomstk = nomstock         ,
   @ncontador = contador
  from #TMP2
  where contador>@ncontador
  order by contador
  set rowcount 0
  if @cinstser='*'
   break
  if exists(select * from #TMP4 where instser=@cinstser and punta=@ipunta)
   update #TMP4
   set nomidis  = nomidis+@nnominal ,
    nomstock = nomstock+@nnomstk
   where instser=@cinstser and punta=@ipunta
  else
   insert into #TMP4
     (
     nomemp    ,
     rutemp    ,
     info    ,
     punta    ,
     instser    ,
     grupo    ,
     nomidis    ,
     fecven    ,
     ano    ,
     mes    ,
     dia    ,
     nomstock   ,
     fecpro
     )
   values
     (
     @cnomemp   ,
     @crutemp   ,
     'Sp_Infptasprc'   ,
     @ipunta    ,
     @cinstser   ,
     @cgrupo    ,
     @nnominal   ,
     @cfecven   ,
     @iano    ,
     @imes    ,
     @idia    ,
     @nnomstk   ,
     convert(char(10),@dfecpro,103)
     )
 end
 
 if @nopcion=1
  select * from #TMP3 order by punta,fecvenp,instser
 else
  select * from #TMP4 order by punta,instser
end
-- sp_infptasprc 1
-- sp_infptasprc 2


GO
