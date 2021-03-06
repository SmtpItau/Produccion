USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAVCTO_TESORERIA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAVCTO_TESORERIA]
as
begin
      set nocount on
 declare @ncontrol1  integer  ,
  @ncontrol2 integer  ,
  @cmoneda  char(03) ,
  @ctipoper  char(04) ,
  @nforpago  char(04) ,
  @nnumoper  numeric(10,0) ,
  @nmtooper  numeric(19,0) ,
  @nrutcli   numeric(09,0) ,
  @ncodcli   numeric(09,0) ,
  @nrutent   numeric(09,0) ,
  @varpretorno numeric(01,0) ,
  @dfecpro datetime
 select 
  @dfecpro = acfecproc 
 from 
  MDAC
 create table #TEMP_VCTO 
 ( numoper numeric(10,0) , 
   tipoper char(05) ,
   mtooper float  ,
   moneda char(03) ,
   rutcli numeric(10,0) ,
   codcli numeric(10,0) ,
   rutent numeric(10,0) ,
   forpago  char(04) )
  
 insert into 
 #TEMP_VCTO(
  numoper ,
  tipoper,
  mtooper,
  moneda,
  rutcli,
  codcli,
  rutent,
  forpago)
 select 
  a.monumoper      , 
  a.motipoper      , 
  sum( a.movalvenp), 
  '$$'  ,
  a.morutcli ,
  a.mocodcli ,
  a.morutcart ,
  convert(char(04),a.moforpagv)
 from
  MDMO a
 where
  (motipoper = 'RC' 
 or  motipoper = 'RV')
 group by
  a.monumoper ,
  a.motipoper ,
  a.morutcli ,
  a.morutcart ,
  a.moforpagv ,
  a.mocodcli
 insert into 
 #TEMP_VCTO(
  numoper ,
  tipoper,
  mtooper,
  moneda,
  rutcli,
  codcli,
  rutent,
  forpago)
 select 
  'numoper' = r.rsnumoper , 
  'tipoper' = case     -- para el devengamiento.
     when r.rscartera = '111' and r.rstipoper = 'VC'  then 'DVVC'
                          when r.rscartera = '121' and r.rstipoper = 'VC' and rtrim(r.rsinstser) = 'ICAP' then 'vica'
                          when r.rscartera = '121' and r.rstipoper = 'VC' and rtrim(r.rsinstser) = 'ICOL' then 'vico'
                          when r.rscartera = '130' and r.rstipoper = 'VC' and rtrim(r.rsinstser) = 'ICAP' then 'vica'
                          when r.rscartera = '130' and r.rstipoper = 'VC' and rtrim(r.rsinstser) = 'ICOL' then 'vico'
     when r.rscartera = '114' and r.rstipoper = 'VC'  then 'DVVCI' else 'XXXX' end,
  'mtooper' = r.rsvppresenx , 
  'moneda' = case when r.rsmonpact=13 or r.rsmonemi = 13 then 'USD' else '$$' end,
  'rutcli' = r.rsrutcli ,
  'codcli' = r.rscodcli ,
  'rutent' = r.rsrutcart ,
  'forpago' = convert(char(04),r.rsforpagv)
 from
  MDRS r
 where 
  r.rstipoper = 'VC' 
/* 
if @@error<>0
begin
 select 'estado'='no', 'mgs'='problemas con informac¡¢n a enviar a tesoreria'
 return
end
*/
 
 select @ncontrol1 = count(*) from #TEMP_vcto 
 select @ncontrol2 = 1
 while @ncontrol2<=@ncontrol1
 begin
  select  @ctipoper = '*'
  
  set rowcount @ncontrol2
  select  
   @nnumoper = numoper ,
   @ctipoper = tipoper ,
   @nmtooper = mtooper ,
   @nrutcli  = rutcli ,
   @ncodcli  = codcli ,
   @nrutent  = rutent ,
   @nforpago = forpago ,
   @cmoneda  = moneda  
  from
   #TEMP_VCTO
  set rowcount 0
  select @ncontrol2 = @ncontrol2 + 1
  if @ctipoper = '*' break
/*  execute @varpretorno=sp_graba_operacion_tesoreria 
      'btr'  , 
      @dfecpro ,
      @ctipoper  ,
      @nnumoper ,
      @nrutcli ,
      @ncodcli ,
      @nmtooper ,
      @cmoneda  ,
      'h'  ,
      @nforpago ,
      'v'  ,
      @nrutent ,
      ' '  ,
      0  ,
      ' '  ,
      1
  if @varpretorno<> 0
  begin
   select 'estado'= 'no', 'msg'='problemas en actulalizaci½n en tesorer-a'
   return  
  end*/
 end  
        set nocount off
 SELECT 'ESTADO'= 'SI', 'MSG'='PROCESO DE ACTUALIZACI¢N DE VENCIMIENTOS EN TESORER¡A, REALIZADO CORRECTAMENTE'
 
end

GO
