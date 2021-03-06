USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMEVCTOCI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_informevctoci    fecha de la secuencia de comandos: 05/04/2001 13:13:33 ******/
CREATE PROCEDURE [dbo].[SP_INFORMEVCTOCI]
               (@entidad numeric(10))
as
begin
   
set nocount on
  declare @rutprop  numeric (10,0)
  declare @dvprop char (1)
  declare @nomprop char (40)
  declare @fecpro char (10)
  declare @contador  numeric (10,0)
  select @rutprop = acrutprop,@dvprop = acdigprop, @nomprop = acnomprop, @fecpro = convert(char(10),acfecproc,103) from MDAC
  select @contador = 0
  select @contador = count(*) from MDCI where ciinstser <> 'ICOL' and ciinstser <> 'ICAP'
if @entidad <> 0
begin
  if @contador = 0
 select  @rutprop,
  @dvprop,
  @nomprop,
  @fecpro,
  ' ',
  ' ',
  ' ',
  'no existe infromacin',
  0,
  ' ',
  0,
  ' ',
  0,
  0,
  'financiamientos'
  else
 select  @rutprop,
  @dvprop,
  @nomprop,
  @fecpro,
  'entidad'=(select rcnombre from VIEW_ENTIDAD where rcrut = @entidad),
  convert(char(10),cifecinip,103),
  convert(char(10),cifecvenp,103),
  clnombre,
  datediff(day,cifecinip,cifecvenp),
  case when cimonpact=998 then 'uf +'
   else ' ' 
   end,
  citaspact,
  case when ciforpagi = 2 and ciforpagv = 2 then 'vv'
   when ciforpagi = 3 and ciforpagv = 3 then 'vc'
    when ciforpagi = 2 and ciforpagv = 3 then 'vv/vc'
    when ciforpagi = 3 and ciforpagv = 2 then 'vc/vv'
   else convert(char(3),ciforpagi) + '/ ' +  convert(char(3),ciforpagv)  ----  REQ. 7619 
   end,
  sum(cicapitalc),
  case when cimonpact=999 then sum(civalvenp)
   else 0 
   end,
  'financiamientos'
 from  --  REQ. 7619 
        MDCI  LEFT OUTER JOIN VIEW_CLIENTE  ON cirutcli = clrut  
--      VIEW_CLIENTE  
 where  ciinstser <> 'ICOL' 
    and ciinstser <> 'ICAP'
--  REQ. 7619
--    and cirutcli *= clrut 
    and cirutcart = @entidad 
 group by cinumdocu,clnombre,cifecinip,cifecvenp,cimonpact,ciforpagi,ciforpagv,citaspact,cirutcart
 order by cifecvenp,clnombre,cinumdocu
end
else
 begin
    if @contador = 0
 select  @rutprop,
  @dvprop,
  @nomprop,
  @fecpro,
  ' ',
  ' ',
  ' ',
  'no existe infromacin',
  0,
  ' ',
  0,
  ' ',
  0,
  0,
  'financiamientos'
  else
 select  @rutprop,
  @dvprop,
  @nomprop,
  @fecpro,
  'entidad'=(select rcnombre from VIEW_ENTIDAD where rcrut = cirutcart),
  convert(char(10),cifecinip,103),
  convert(char(10),cifecvenp,103),
  clnombre,
  datediff(day,cifecinip,cifecvenp),
  case when cimonpact=998 then 'uf +'
   else ' ' 
   end,
  citaspact,
  case when ciforpagi = 2 and ciforpagv = 2 then 'vv'
   when ciforpagi = 3 and ciforpagv = 3 then 'vc'
    when ciforpagi = 2 and ciforpagv = 3 then 'vv/vc'
    when ciforpagi = 3 and ciforpagv = 2 then 'vc/vv'
   else convert(char(2),ciforpagi) + '/ ' +  convert(char(2),ciforpagv)
   end,
  sum(cicapitalc),
  case when cimonpact=999 then sum(civalvenp)
   else 0 
   end,
  'financiamientos'
 from 
  --  REQ. 7619 
      MDCI LEFT OUTER JOIN VIEW_CLIENTE ON cirutcli = clrut 
  -- ,VIEW_CLIENTE  
 where  ciinstser <> 'ICOL' and ciinstser <> 'ICAP'
 --  REQ. 7619
 -- and cirutcli *= clrut 
 group by cinumdocu,clnombre,cifecinip,cifecvenp,cimonpact,ciforpagi,ciforpagv,citaspact,cirutcart
 order by cifecvenp,clnombre,cinumdocu
end
end
-- sp_informevctoci
-- select * from MDCI
-- sp_help
--sp_informevctoci 1


GO
