USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMEDEP]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_INFORMEDEP]
as
begin
set nocount on
 declare @rutprop numeric (10,0) ,
  @dvprop  char (01) ,
  @nomprop char (40) ,
  @fecpro  char (10) ,
  @contador  numeric (10,0)
 select @rutprop = acrutprop ,
  @dvprop  = acdigprop ,
  @nomprop  = acnomprop ,
  @fecpro  = convert(char(10),acfecproc,103)
 from MDAC
 select @contador = 0
 select @contador = count(*) from MDCP where (cpcodigo=9 or cpcodigo=11 or cpcodigo=12) and cpnominal>0
         
 if @contador=0
  
            select @rutprop    ,
   @dvprop     ,
   @nomprop    ,
   @fecpro     ,
   ' '     ,
   ' '     ,
   ' '     ,
   'no existe infromaci½n'   ,
   0     ,
   ' '     ,
   0     ,
   ' '     ,
   0     ,
   0     ,
   'depositos'
 else
               select @rutprop    ,
   @dvprop     ,
   @nomprop    ,
   @fecpro     ,
   rcnombre    ,
   convert(char(10),cpfeccomp,103)  ,
   convert(char(10),cpfecven,103)  ,
   emnombre    ,
   datediff(day,cpfeccomp,cpfecven) ,
    case when nsmonemi=998 then 'uf'
    else '$' 
    end    ,
   cptircomp    ,
   d.inserie    ,
   cpcapitalc    ,
   cpnominal    ,
   'depositos'
  FROM MDCP a LEFT OUTER JOIN VIEW_ENTIDAD c ON cprutcart = rcrut 
					LEFT OUTER JOIN VIEW_INSTRUMENTO d ON cpcodigo = incodigo ,
				VIEW_NOSERIE e LEFT OUTER JOIN VIEW_EMISOR b ON nsrutemi = emrut 
  where  (cpcodigo=9 or cpcodigo=11 or cpcodigo=12)
    and nsnumdocu = cpnumdocu 
	and nscorrela = cpcorrela 
	and cpnominal > 0
  order by cpfecven,emnombre

--  from MDCP a, VIEW_EMISOR b, VIEW_ENTIDAD c, VIEW_INSTRUMENTO d, VIEW_NOSERIE e
--  where  (cpcodigo=9 or cpcodigo=11 or cpcodigo=12) and
--   nsnumdocu=cpnumdocu and nscorrela=cpcorrela and
--   nsrutemi*=emrut and cprutcart*=rcrut and
--   cpcodigo*=incodigo and cpnominal>0
--  order by cpfecven,emnombre
               
 end
-- sp_informedep


GO
