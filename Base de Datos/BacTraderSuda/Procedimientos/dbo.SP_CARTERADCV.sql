USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERADCV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARTERADCV]
                  (
                     @entidad numeric(9)
                  )
as
begin
set nocount on
 select 'nomemp' = isnull(a.acnomprop,'')          ,
  'rutemp' = isnull((rtrim(convert(char(9),c.rcrut))+'-'+ c.rcdv),'')      ,
  'fecpro' = convert(char(10),a.acfecproc,103)         ,
  'rutcart'  = b.cprutcart           ,
  'feccomp' = convert(char(10),b.cpfeccomp,103)         ,
  'numdocu' = rtrim(convert(char(10),isnull(b.cpnumdocu,0)))+'-'+convert(char(3),isnull(b.cpcorrela,0)) ,
  'numdoc' = isnull(cpnumdocu,0)           ,
  'correla' = isnull(cpcorrela,0)           ,
  'serie'  = isnull(b.cpinstser,'')          ,
  'codser' = isnull(b.cpcodigo,0)          ,
  'seriado' = convert(char(1),b.cpseriado)         ,
  'fecemi' = isnull(convert(char(10),b.cpfecemi,103),'')       ,
  'fecven' = isnull(convert(char(10),b.cpfecven,103),'')       ,
  'mascara' = cpmascara            ,
  'tasemi' = 0             ,
  'basemi' = 0             ,
  'monemi' = space(05)            ,
  'rutemi' = isnull(b.cpnumdocu,0)          ,
  'emisor' = space(05)            ,
  'codmon' = 0             ,
  'tir'  = isnull(b.cptircomp, 0)          ,
  'familia' = isnull(d.inserie,'')          ,
  'cartera' = isnull(c.rcnombre,'')          ,
  'vpresen' = isnull(b.cpvptirc,0)                                 ,
  'nominal' = isnull(b.cpnominal,0)
 into #TEMP
 from 
  MDAC a, 
  MDCP b, 
  VIEW_ENTIDAD c,
  VIEW_INSTRUMENTO d
 where    
  b.cpdcv='D'
 and  (@entidad=0 or b.cprutcart = @entidad )
        and  c.rcrut = b.cprutcart
        and  b.cpcodigo = d.incodigo 
 order by b.cpnumdocu, b.cpcorrela
 update #TEMP 
 set
  tasemi = isnull(setasemi,0)   ,
  basemi = isnull(sebasemi,0)   ,
  monemi = ''     ,
  codmon = semonemi    ,
  rutemi = serutemi
 from VIEW_SERIE
 where 
  seriado= 'S' 
 and  mascara = VIEW_SERIE.semascara
 update #TEMP 
 set fecemi = convert(char(10),nsfecemi,103) ,
  fecven = convert(char(10),nsfecven,103) ,
  tasemi = isnull(nstasemi,0)   ,
  basemi = isnull(nsbasemi,0)   ,
  monemi = ''     ,
  codmon = nsmonemi    ,
  rutemi = nsrutemi
 from VIEW_NOSERIE
 where seriado<> 'S' 
 and rutcart = nsrutcart 
 and  numdoc = nsnumdocu 
 and correla = nscorrela 
 and  codser = nscodigo 
 and seriado<> 'S'
 update #TEMP set 
   monemi = isnull(VIEW_MONEDA.mnnemo,'')  ,
  emisor = isnull( MDEM.emgeneric,'')
 from VIEW_MONEDA, VIEW_EMISOR MDEM
 where VIEW_MONEDA.mncodmon=codmon and rutemi=MDEM.emrut
 update #TEMP 
 set  nominal  = nominal  + vinominal    
 from  MDVI, 
  MDCV
 where   vinumdocu  = numdoc
 and  vicorrela  = correla
if exists(select *from 
  #TEMP
  )
begin
 select 
  nomemp  ,
  rutemp  ,
  fecpro  ,
  numdocu  ,  
  serie  ,
  fecven  ,
  monemi  ,
  tir  ,
  cartera  ,
  basemi  ,
  emisor  ,  
  codmon  ,
  feccomp  ,
  vpresen  ,
  nominal  ,
  'hora'   = convert(varchar(10), getdate(), 108)
 from 
  #TEMP
 where nominal >0
 order by #TEMP.serie, 
   #TEMP.numdoc, 
   #TEMP.correla
end
else
begin
 select 
  'nomemp '='' ,
  'rutemp '='' ,
  'fecpro '='' ,
  'numdocu'=''  ,  
  'serie '='' ,
  'fecven '='' ,
  'monemi '='' ,
  'tir '='' ,
  'cartera'=''  ,
  'basemi '='' ,
  'emisor '='' ,  
  'codmon '='' ,
  'feccomp'=''  ,
  'vpresen'=''  ,
  'nominal'=''  ,
  'hora'   = convert(varchar(10), getdate(), 108)
 from 
  #TEMP
end
end
/*
sp_carteradcv 0
select * from MDVI
select * from MDCP where cpdcv ='D'
select * from MDMH
execute sp_listadovctopap  '03/02/2000','03/02/2008',0
*/ 

GO
