USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCUCP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_listadocucp    fecha de la secuencia de comandos: 05/04/2001 13:13:39 ******/
CREATE PROCEDURE [dbo].[SP_LISTADOCUCP]
               ( 
                  @entidad numeric(09,0) 
               )
as
begin
 select 
                'acnomprop'     = acnomprop                          ,     
                'entidad' = isnull(rcnombre,' ')    ,
  'numdocu' = convert(char(05),cpnumdocu)+convert(char(05),cpcorrela),
  'serie'  = isnull(cpinstser,'')    ,
  'moneda' = '     '     ,
  'nominal' = cpnominal     ,
  'tir'  = cptircomp     ,
  'ncorte'  = isnull(cocantcorto,0)    ,
  'mtocorte' = isnull(comtocort,0)    ,
  'dcv'  = case cpdcv when 'P' then  'CUSTODIA PROPIA' when 'D' then 'CUSTODIA DCV' when 'C' then 'CUSTODIA CLIENTE ' else 'SIN CUSTODIA ' end ,
  'seriado' = cpseriado     ,
  'numdoc' = cpnumdocu     ,
  'correla' = cpcorrela      ,
  'mascara' = cpmascara     ,
  'emisor' = '                   '    ,
  'origen' = 'CP'
 into 
  #TEMP
 from 
  MDCP , 
  MDCO ,
  VIEW_ENTIDAD MDRC    ,
                MDAC   
                    
 where 
  cprutcart= rcrut 
 and (@entidad= 0 or @entidad = cprutcart)
 and corutcart = cprutcart 
 and conumdocu  = cpnumdocu 
 and cocorrela  = cpcorrela
 and rcrut = corutcart
 update #TEMP set  nominal  = nominal  + vinominal    
/*     ncorte   = ncorte   + cvcantcort   ,
     mtocorte = mtocorte + cvmtocort  */
 from  MDVI, MDCV
 where   cvnumdocu = vinumdocu 
 and  cvcorrela = vicorrela 
 and  vinumdocu  = numdoc
 and  vicorrela  = correla
 insert into #TEMP 
 select  
                acnomprop           ,     
                isnull(rcnombre,' ')    ,
  convert(char(05),cinumdocu)+convert(char(05),cicorrela),
  isnull(ciinstser,''),
  '     ',
  cinominal     ,
  citircomp     ,
  isnull(cocantcorto,0)    ,
  isnull(comtocort,0)    ,
  case cidcv when 'P' then  'CUSTODIA PROPIA' when 'D' then 'CUSTODIA DCV' when 'C' then 'CUSTODIA CLIENTE ' else 'SIN CUSTODIA ' end ,
  ciseriado     ,
  cinumdocu     ,
  cicorrela      ,
  cimascara     ,
  '                   '    ,
  'CI'
 from 
  MDCI , 
  MDCO ,
  VIEW_ENTIDAD MDRC    ,
                MDAC    
 where 
  cirutcart= rcrut 
 and (@entidad= 0 or @entidad = cirutcart)
 and corutcart = cirutcart 
 and conumdocu  = cinumdocu 
 and cocorrela  = cicorrela
 and rcrut = corutcart
 
/* seteo de moneda */
 update #TEMP 
 set  moneda = mnnemo ,
  emisor = isnull(emgeneric,'')  
 from  VIEW_MONEDA ,
 --  REQ. 7619
 --  VIEW_SERIE , 
 VIEW_EMISOR MDEM  RIGHT OUTER JOIN VIEW_SERIE ON MDEM.emrut = VIEW_SERIE.serutemi
 where  VIEW_SERIE.semascara = #TEMP.mascara 
 and VIEW_SERIE.semonemi = VIEW_MONEDA.mncodmon 
 and  #TEMP.seriado = 'S' 
--  REQ. 7619
-- and  MDEM.emrut =* VIEW_SERIE.serutemi
 update #TEMP set moneda = mnnemo ,
  emisor = isnull(emgeneric,'')
 from VIEW_MONEDA ,
--  REQ. 7619
--  VIEW_NOSERIE , 
  VIEW_EMISOR MDEM RIGHT OUTER JOIN VIEW_NOSERIE ON MDEM.emrut = VIEW_NOSERIE.nsrutemi
 where  VIEW_NOSERIE.nsserie = #TEMP.serie 
 and VIEW_NOSERIE.nsmonemi = VIEW_MONEDA.mncodmon 
 and  #TEMP.seriado = 'N' 
--  REQ. 7619
-- and  MDEM.emrut =* VIEW_NOSERIE.nsrutemi
                     
                 
 select  acnomprop, 
  entidad ,
  numdocu , 
  serie ,
  moneda , 
  nominal , 
  tir , 
  ncorte ,  
  mtocorte,
  dcv ,
  emisor  ,
  origen ,
  'hora'   = convert(varchar(10), getdate(), 108)
 from #TEMP
 where nominal <> 0
end
-- select * from MDAC
-- select * from MDRC
-- sp_listadocucp 78221830


GO
