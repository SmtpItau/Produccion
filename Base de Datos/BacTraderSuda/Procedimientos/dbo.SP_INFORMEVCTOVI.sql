USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMEVCTOVI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORMEVCTOVI]
as
begin
set nocount on
 declare @rutprop numeric (10,0)  ,
  @dvprop  char (01)  ,
  @nomprop char (40)  ,
  @fecpro  char (10)  ,
  @fecpp  datetime  ,
  @prc  numeric(19,0)  ,
  @prbc  numeric(19,0)  ,
  @pcdus  numeric(19,0)  ,
  @pcduf  numeric(19,0)  ,
  @ptf  numeric(19,0)  ,
  @pdbc  numeric(19,0)  ,
  @prc_ter numeric(19,0)  ,
  @pdbc_ter numeric(19,0)  ,
  @prd  numeric(19,0)  ,
  @prcpp  numeric(19,0)  ,
  @prbcpp  numeric(19,0)  ,
  @pcduspp numeric(19,0)  ,
  @pcdufpp numeric(19,0)  ,
  @ptfpp  numeric(19,0)  ,
  @pdbcpp  numeric(19,0)  ,
  @prdpp  numeric(19,0)  ,
  @prc_terpp numeric(19,0)  ,
  @pdbc_terpp numeric(19,0)
 select @prc  = 0   ,
  @prbc  = 0   ,
  @pcdus  = 0   ,
  @pcduf  = 0   ,
  @ptf  = 0   ,
  @pdbc  = 0   ,
  @prd  = 0   ,
  @prc_ter = 0   ,
  @pdbc_ter = 0   ,
  @prcpp  = 0   ,
  @prbcpp  = 0   ,
  @pcduspp = 0   ,
  @pcdufpp = 0   ,
  @ptfpp  = 0   ,
  @pdbcpp  = 0   ,
  @prdpp  = 0   ,
  @prc_terpp = 0   ,
  @pdbc_terpp = 0
 select @rutprop = acrutprop    ,
  @dvprop  = acdigprop    ,
  @nomprop  = acnomprop    ,
  @fecpro  = convert(char(10),acfecproc,103) ,
  @fecpp  = acfecprox
 from MDAC
 select @prc  = isnull(sum(dinominal),0) from MDDI where diserie='PRC'    and ditipoper='CP'
 select @prbc  = isnull(sum(dinominal),0) from MDDI where diserie='PRBC'   and ditipoper='CP'
 select @pcdus  = isnull(sum(dinominal),0) from MDDI where diserie='PCDUS$' and ditipoper='CP'
 select @pcduf  = isnull(sum(dinominal),0) from MDDI where diserie='PCDUF'  and ditipoper='CP'
 select @ptf  = isnull(sum(dinominal),0) from MDDI where diserie='PTF'    and ditipoper='CP'
 select @pdbc  = isnull(sum(dinominal),0) from MDDI where diserie='PDBC'   and ditipoper='CP'
 select @prd  = isnull(sum(dinominal),0) from MDDI where diserie='PRD'    and ditipoper='CP'
 select @prc_ter = isnull(sum(dinominal),0) from MDDI where diserie='PRC'    and ditipoper='CI'
 select @pdbc_ter = isnull(sum(dinominal),0) from MDDI where diserie='PDBC'   and ditipoper='CI'
 select @prc  = @prc     + isnull(sum(vinominal),0) from MDVI where vicodigo=4  and vitipoper='CP'
 select @prbc  = @prbc    + isnull(sum(vinominal),0) from MDVI where vicodigo=7  and vitipoper='CP'
 select @pcdus  = @pcdus   + isnull(sum(vinominal),0) from MDVI where vicodigo=1  and vitipoper='CP'
 select @pcduf  = @pcduf   + isnull(sum(vinominal),0) from MDVI where vicodigo=2  and vitipoper='CP'
 select @ptf  = @ptf     + isnull(sum(vinominal),0) from MDVI where vicodigo=5  and vitipoper='CP'
 select @pdbc  = @pdbc    + isnull(sum(vinominal),0) from MDVI where vicodigo=6  and vitipoper='CP'
 select @prd  = @prd     + isnull(sum(vinominal),0) from MDVI where vicodigo=31 and vitipoper='CP'
 select @prc_ter = @prc_ter + isnull(sum(vinominal),0) from MDVI where vicodigo=4  and vitipoper='CI'
 select @pdbc_ter = @pdbc_ter + isnull(sum(vinominal),0) from MDVI where vicodigo=6 and vitipoper='CI'
 select @prcpp  = @prcpp     + isnull(sum(vinominal),0) from MDVI where vicodigo = 4 and vitipoper='CP' and vifecvenp=@fecpp
 select @prbcpp  = @prbcpp    + isnull(sum(vinominal),0) from MDVI where vicodigo = 7 and vitipoper='CP' and vifecvenp=@fecpp
 select @pcduspp = @pcduspp   + isnull(sum(vinominal),0) from MDVI where vicodigo = 1 and vitipoper='CP' and vifecvenp=@fecpp
 select @pcdufpp = @pcdufpp   + isnull(sum(vinominal),0) from MDVI where vicodigo = 2 and vitipoper='CP' and vifecvenp=@fecpp
 select @ptfpp  = @ptfpp     + isnull(sum(vinominal),0) from MDVI where vicodigo = 5 and vitipoper='CP' and vifecvenp=@fecpp
 select @pdbcpp  = @pdbcpp    + isnull(sum(vinominal),0) from MDVI where vicodigo = 6 and vitipoper='CP' and vifecvenp=@fecpp
 select @prdpp  = @prdpp     + isnull(sum(vinominal),0) from MDVI where vicodigo =21 and vitipoper='CP' and vifecvenp=@fecpp
 select @prc_terpp = @prc_terpp + isnull(sum(vinominal),0) from MDVI where vicodigo = 4 and vitipoper='CI' and vifecvenp=@fecpp
 select @pdbc_terpp = @pdbc_terpp + isnull(sum(vinominal),0) from MDVI where vicodigo = 6 and vitipoper='CI' and vifecvenp=@fecpp
 select cartera  = rcnombre ,
  fechav  = vifecvenp ,
  prc =  case
    when vicodigo=4 and vitipoper='CP' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end   ,
  prbc =  case
    when vicodigo=7 and vitipoper='CP' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end   ,
  pcdus = case
    when vicodigo=1 and vitipoper='CP' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end   ,
  pcduf = case
    when vicodigo=2 and vitipoper='CP' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end   ,
  ptf =  case
    when vicodigo=5 and vitipoper='CP' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end   ,
  pdbc =  case
    when vicodigo=6 and vitipoper='CP' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end   ,
  prd =  case
    when vicodigo=31 and vitipoper='CP' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end   ,
  prc_ter=case
    when vicodigo=4 and vitipoper='CI' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end   ,
  pdbc_ter=case
    when vicodigo=6 and vitipoper='CI' and vifecvenp>@fecpp then isnull(sum(vinominal),0)
    else 0
   end
 into #TEMP
 from MDVI, VIEW_ENTIDAD
 where rcrut=virutcart and vifecvenp>@fecpp
 group by vifecvenp,vicodigo,vitipoper,rcnombre
 select 'rutprop' = @rutprop   ,
  'dvprop' = @dvprop   ,
  'nomprop' = @nomprop   ,
  cartera      ,
  'fecpro' = @fecpro   ,
  'fechav' = convert(char(10),fechav,103) ,
  'sumprc' = sum(prc)   ,
  'prc'  = @prc    ,
  'sumprbc' = sum(prbc)   ,
  'prbc'  = @prbc    ,
  'sumpcdus' = sum(pcdus)   ,
  'pcdus'  = @pcdus   ,
  'sumpcduf' = sum(pcduf)   ,
  'pcduf'  = @pcduf   ,
  'sumptf' = sum(ptf)   ,
  'ptf'  = @ptf    ,
  'sumpdbc' = sum(pdbc)   ,
  'pdbc'  = @pdbc    ,
  'sumprc_ter' = sum(prc_ter)   ,
  'prc_ter' = @prc_ter   ,
  'fecpp'  = convert(char(10),@fecpp,103) ,
  'prcpp'  = @prcpp   ,
  'prbcpp' = @prbcpp   ,
  'pcduspp' = @pcduspp   ,
  'pcdufpp' = @pcdufpp   ,
  'ptfpp'  = @ptfpp   ,
  'pdbcpp' = @pdbcpp   ,
  'prc_terpp' = @prc_terpp   ,
  'sumpdbc_ter' = sum(pdbc_ter)   ,
  'pdbc_ter' = @pdbc_ter   ,
  'pdbc_terpp' = @pdbc_terpp   ,
  'sumprd' = sum(prd)   ,
  'prd'  = @prd    ,
  'prdpp'  = @prdpp
 from #TEMP
 group by cartera,fechav
-- order by fechav
end
-- sp_informevctovi
-- select * from mdin
-- update MDAC set acfecprox='01/03/1998'
GO
