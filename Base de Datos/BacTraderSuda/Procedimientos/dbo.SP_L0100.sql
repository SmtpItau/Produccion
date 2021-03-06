USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_L0100]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_l0100    fecha de la secuencia de comandos: 05/04/2001 13:13:35 ******/
CREATE PROCEDURE [dbo].[SP_L0100]
         (@tabla  integer  ,
   @nano  integer  ,
   @nrutcli numeric (9,0) )
as
begin
         set nocount on
 select  'tipoper' = 'VI'    ,   --1
  'rutcli' = morutcli   , --2
  'dvcli'  = VIEW_CLIENTE.cldv   , --3
  'moneda' = momonpact   , --4
  'nommon' = 'PESOS'   , --5
  'mes'  = datepart(month,mofecvenp) , --6
  'numoper' = monumoper   , --7
  'correla'  = mocorrela   , --8
  'instser' = moinstser   , --9
  'fecinip'   = mofecinip   ,
  'fecvtop' = mofecvenp   ,
  'moninip' = isnull(VIEW_VALOR_MONEDA.vmvalor,0) , --12
  'monvenp' = isnull(VIEW_VALOR_MONEDA.vmvalor,0) , --13
  'valinip' = movalinip   , --14
  'valvtop' = round(movalvenp,0)  , --15
  'interes' = isnull(mointpac,0)  , --16
  'reajuste' = isnull(moreapac,0)  , --17
  'intreal' = 0    , --18
  'nomcli' = VIEW_CLIENTE.clnombre   , --19
  'nomcart' = MDAC.acnomprop  , --20
  'rutcart' = MDAC.acrutprop  , --21
  'digcart' = MDAC.acdigprop  , --22
  'dircart' = space(40)   , --23
  'fecpro' = isnull(convert(char(10),MDAC.acfecproc,103),''),
  'ano'  = @nano
 into #TMP
 from   --  REQ. 7619
        MDMH   LEFT OUTER JOIN VIEW_VALOR_MONEDA ON  MDMH.mofecinip = VIEW_VALOR_MONEDA.vmfecha, 
--        VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA, 
        VIEW_CLIENTE, 
        MDAC
 where  MDMH.morutcli=@nrutcli and datepart(year,MDMH.mofecinip)=@nano and
  MDMH.motipoper='RC' and 998=VIEW_VALOR_MONEDA.vmcodigo  
--  REQ. 7619
-- and MDMH.mofecinip*= VIEW_VALOR_MONEDA.vmfecha)
  and VIEW_CLIENTE.clrut=@nrutcli
 update #TMP set monvenp = vmvalor 
 --  REQ. 7619 
 from VIEW_VALOR_MONEDA LEFT OUTER JOIN #TMP ON  fecvtop = VIEW_VALOR_MONEDA.vmfecha 
 where 998=VIEW_VALOR_MONEDA.vmcodigo -- and fecvtop*=VIEW_VALOR_MONEDA.vmfecha 

 update #TMP set intreal = isnull(round(valinip+interes-((monvenp/moninip)*valinip),0),0)
 update #TMP set nommon  = tbglosa from VIEW_TABLA_GENERAL_DETALLE where (moneda<>999 and moneda=convert(numeric(6),tbcodigo1))
 select 'mes'  = mes  ,
  'valinip' = sum(valinip) ,
  'valvtop' = sum(valvtop) ,
  'interes' = sum(interes) ,
  'reajuste' = sum(reajuste) ,
  'intreal' = sum(intreal) 
 into #TMP3
 from #TMP
 group by mes, moneda,tipoper
 select  'periodo' = datepart(month,vmfecha) ,
  'mesp'  = 'SEPTIEMBRE'   ,
  'intpos' = convert(numeric(19,0),0) ,
  'intneg' = convert(numeric(19,0),0) ,
  'facact' = convert(numeric(8,4),vmvalor) ,
  'iposcal' = convert(numeric(19,0),0) ,
  'inegcal' = convert(numeric(19,0),0) ,
  'rutcli' = @nrutcli   , 
  'dvcli'  = VIEW_CLIENTE.cldv   , 
  'nomcli' = VIEW_CLIENTE.clnombre   ,
  'nomcart' = MDAC.acnomprop  , 
  'rutcart' = MDAC.acrutprop  , 
  'digcart' = MDAC.acdigprop  , 
  'dircart' = space(40)   ,
  'fecpro' = isnull(convert(char(10),MDAC.acfecproc,103),''),
  'ano'  = @nano
 into #TMP1
 from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA, VIEW_CLIENTE, MDAC
 where 111=vmcodigo and
  VIEW_CLIENTE.clrut=@nrutcli
  --and datepart(year,vmfecha)=@nano
 update #TMP1 set intpos = intreal from #TMP3 where periodo=mes and intreal>0
 update #TMP1 set intneg = intreal from #TMP3 where periodo=mes and intreal<0
 update #TMP1 set iposcal = round(intpos*facact,0) where intpos>0
 update #TMP1 set inegcal = round(intneg*facact,0) where intpos<0
 update #TMP1 set mesp = case when periodo=1  then 'ENERO'
     when periodo=2  then 'FEBERO'
     when periodo=3  then 'MARZO'
     when periodo=4  then 'ABRIL'
     when periodo=5  then 'MAYO'
     when periodo=6  then 'JUNIO'
     when periodo=7  then 'JULIO'
     when periodo=8  then 'AGOSTO'
     when periodo=9  then 'SEPTIEMBRE'
     when periodo=10 then 'OCTUBRE'
     when periodo=11 then 'NOVIEMBRE'
     when periodo=12 then 'DICIEMBRE'
     end
               set nocount off
 if @tabla=1
  select  tipoper,
   rutcli,
   dvcli,
   moneda,
   nommon,
   mes,
   numoper,
   correla,
   instser,
   convert(char(10),fecinip,103),
   convert(char(10),fecvtop,103),
   moninip,
   monvenp,
   valinip,
   valvtop,
   interes,
   reajuste,
   intreal,
   nomcli,
   nomcart,
   rutcart,
   digcart,
   dircart,
   fecpro,
   ano
  from #TMP
 else
  select * from #TMP1 order by periodo
end
-- sp_l0100 1,2011,97029000
-- sp_l0100 2,1997,78182700
--sp_help MDMH
--select morutcli,momonpact,datepart(year,mofecvenp) from MDMH where motipoper='rv'
--sp_help MDMH
-- delete MDMH where monumoper = 5
--update MDMH set mofecvenp = mofecinip where mofecvenp = null
--select * into MDMHcert from MDMH
-- select * from MDAC


GO
