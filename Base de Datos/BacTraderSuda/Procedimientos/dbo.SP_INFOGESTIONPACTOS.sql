USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOGESTIONPACTOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFOGESTIONPACTOS]
               (@entidad  numeric(9))
   
as
begin
set nocount on
 declare @dfecha  datetime ,
  @ni  integer  ,
  @ncontador numeric (19,0) ,
  @ctipoper char (03) ,
  @nrutcli numeric (09,0) ,
  @ntotinip numeric (19,0) ,
  @nnumoper numeric (10,0) ,
  @itipo   integer  ,
  @cnomemp char (40) ,
  @crutemp char (12) ,
  @cfecpro char (10) ,
  @cfecdes char (10) ,
  @cinfo  char (08) ,
  @ctipo  char (25) ,
  @clugar  char (25) ,
  @iforpag integer  ,
  @nano  integer  ,
  @nmes  integer
  
 create table #TMP1
   (
   nomemp  char (40) null ,
   rutemp  char (12) null ,
   fecpro  char (10) null ,
   fecdes  char (10) null ,
   info  char (08) null ,
   tipoper  char (17) null ,
   tipo  char (25) null ,
   monto  numeric (19,0) null ,
   totoper  integer  null ,
   lugar  char (10) null
   )
  if @entidad<>0
   begin 
 select @dfecha  = dateadd(month,-3,acfecproc)    ,
  @cnomemp = acnomprop      ,
  @crutemp = str(acrutprop)+'-'+acdigprop    ,
  @cinfo  = 'spinfgep'      ,
  @cfecpro = isnull(convert(char(10),acfecproc,103),char(10))
 from MDAC
 select @nano  = datepart(year ,@dfecha) ,
  @nmes  = datepart(month,@dfecha)
 select @dfecha  = convert(datetime,str(@nmes)+'/01/'+str(@nano))
 select @cfecdes = isnull(convert(char(10),@dfecha,103),char(10))
 select distinct 'numoper' = monumoper     ,
   'totinip' = convert(numeric(19,0),0)   ,
   'rutcli' = convert(numeric(9,0),0)   ,
   'tipoper' = motipoper     ,
   'forpag' = convert(numeric(5,0),0)
 into #TMP
 from MDMH
 where (motipoper='VI' or motipoper='CI') and mofecpro>=@dfecha and morutcart=@entidad
 update #TMP
 set totinip = (select sum(movalinip) from MDMH where numoper=monumoper and tipoper=motipoper) ,
  rutcli = morutcli          ,
  forpag = moforpagi
 from MDMH
 where numoper=monumoper
 select @ni  = 1 ,
  @ncontador = 0
 while @ni=1
 begin
  select @ctipoper = '*'
  set rowcount 1
  select  @ctipoper = tipoper ,
   @ntotinip = totinip ,
   @nrutcli = rutcli ,
   @iforpag = forpag ,
   @ncontador = numoper
  from #TMP
  where numoper>@ncontador
  order by numoper
  set rowcount 0
  if @ctipoper='*'
   break
  select @itipo = convert(integer,isnull(cltipcli,0)) from VIEW_CLIENTE    where clrut=@nrutcli
  if @itipo=2
   select @ctipo = 'instituciones financieras'
  else
   if @nrutcli<50000000
    select @ctipo = 'personas naturales'
   else
    select @ctipo = 'empresas'
  if @iforpag-9001<=0
   select @clugar = 'matriz'
  else
   select @clugar = 'sucursales'
  if exists(select * from #TMP1 where tipoper=@ctipoper and tipo=@ctipo and lugar=@clugar)
   update #TMP1
   set monto = monto + @ntotinip ,
    totoper = totoper + 1
   where tipoper=@ctipoper and tipo=@ctipo
  else
   insert into #TMP1
     (
     nomemp  ,
     rutemp   ,
     fecpro  ,
     fecdes  ,
     info  ,
     tipoper  ,
     tipo  ,
     monto  ,
     totoper  ,
     lugar
     )
   values
     (
     @cnomemp ,
     @crutemp ,
     @cfecpro ,
     @cfecdes ,
     @cinfo  ,
     @ctipoper ,
 
     @ctipo  ,
     @ntotinip ,
     1  ,
     @clugar
     )
  
 end
 update #TMP1
 set tipoper = case
    when tipoper='VI' then 'VENTAS CON PACTO'
    else 'COMPRAS CON PACTO'
     end
 select * from #TMP1 order by lugar,tipoper,tipo
  end else
    begin
select @dfecha  = dateadd(month,-3,acfecproc)    ,
  @cnomemp = acnomprop      ,
  @crutemp = str(acrutprop)+'-'+acdigprop    ,
  @cinfo  = 'spinfgep'      ,
  @cfecpro = isnull(convert(char(10),acfecproc,103),char(10))
 from MDAC
 select @nano  = datepart(year ,@dfecha) ,
  @nmes  = datepart(month,@dfecha)
 select @dfecha  = convert(datetime,str(@nmes)+'/01/'+str(@nano))
 select @cfecdes = isnull(convert(char(10),@dfecha,103),char(10))
 select distinct 'numoper' = monumoper     ,
   'totinip' = convert(numeric(19,0),0)   ,
   'rutcli' = convert(numeric(9,0),0)   ,
   'tipoper' = motipoper     ,
   'forpag' = convert(numeric(5,0),0)
 into #TMP2
 from MDMH
 where (motipoper='VI' or motipoper='CI') and mofecpro>=@dfecha 
 update #TMP2
 set totinip = (select sum(movalinip) from MDMH where numoper=monumoper and tipoper=motipoper) ,
  rutcli = morutcli          ,
  forpag = moforpagi
 from MDMH
 where numoper=monumoper
 select @ni  = 1 ,
  @ncontador = 0
 while @ni=1
 begin
  select @ctipoper = '*'
  set rowcount 1
  select  @ctipoper = tipoper ,
   @ntotinip = totinip ,
   @nrutcli = rutcli ,
   @iforpag = forpag ,
   @ncontador = numoper
  from #TMP2
  where numoper>@ncontador
  order by numoper
  set rowcount 0
  if @ctipoper='*'
   break
  select @itipo = convert(integer,isnull(cltipcli,0)) from VIEW_CLIENTE  where clrut=@nrutcli
  if @itipo=2
   select @ctipo = 'instituciones financieras'
  else
   if @nrutcli<50000000
    select @ctipo = 'personas naturales'
   else
    select @ctipo = 'empresas'
  if @iforpag-9001<=0
   select @clugar = 'matriz'
  else
   select @clugar = 'sucursales'
  if exists(select * from #TMP1 where tipoper=@ctipoper and tipo=@ctipo and lugar=@clugar)
   update #TMP1
   set monto = monto + @ntotinip ,
    totoper = totoper + 1
   where tipoper=@ctipoper and tipo=@ctipo
  else
   insert into #TMP1
     (
     nomemp  ,
     rutemp   ,
     fecpro  ,
     fecdes  ,
     info  ,
     tipoper  ,
     tipo  ,
     monto  ,
     totoper  ,
     lugar
     )
   values
     (
     @cnomemp ,
     @crutemp ,
     @cfecpro ,
     @cfecdes ,
     @cinfo  ,
     @ctipoper ,
      @ctipo  ,
     @ntotinip ,
     1  ,
     @clugar
     )
  
 end
 update #TMP1
 set tipoper = case
    when tipoper='VI' then 'VENTAS CON PACTO'
    else 'COMPRAS CON PACTO'
     end
 select * from #TMP1 order by lugar,tipoper,tipo
  end  
end
-- sp_infogestionpactos 1
--select * from MDMH where monumoper=24217 and motipoper='ci'
--select * from MDMH where monumoper=24309 and motipoper='vi'
-- select dateadd(month,-3,acfecproc) from MDAC
--sp_infogestionpactos 0
                                         


GO
