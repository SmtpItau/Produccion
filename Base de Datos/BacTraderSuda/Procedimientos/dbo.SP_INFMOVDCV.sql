USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFMOVDCV]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFMOVDCV]
   (@entidad numeric(9))
as
begin
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop
  FROM MDAC 
if exists(select * 
 from MDAC
--  REQ. 7619    
   , MDMO RIGHT OUTER JOIN VIEW_CLIENTE ON clrut = morutcli 
                                         and clcodigo = mocodcli 
          RIGHT OUTER JOIN VIEW_EMISOR  ON emrut = morutemi
--    , VIEW_CLIENTE
    , VIEW_ENTIDAD
--  REQ. 7619    
--    , VIEW_EMISOR
    , VIEW_INSTRUMENTO
    , MDCP
 where motipoper='VP' 
 and ( @entidad = 0 or morutcart = @entidad )
  and rcrut = morutcart
--  REQ. 7619
/*      and clrut=*morutcli 
        and clcodigo=*mocodcli 
 and emrut=*morutemi 
*/
 and incodigo=mocodigo 
 and cpnumdocu=monumdocu 
 and cpcorrela=mocorrela
 and cpdcv= 'D'
)
begin
 select 'entidad'=isnull(acnomprop,'')         ,
  'rutpro'=isnull(rtrim(convert(char(9),acrutprop))+'-'+acdigprop,'')    ,
  'fecpro'=isnull(convert(char(10),acfecproc,103),'')       ,
  'cliente'=isnull(clnombre,'')         ,
  'cartera'=isnull(rcnombre,'')         ,
  'numdocu'=isnull((rtrim(convert(char(10),monumdocu))+'-'+convert(char(3),mocorrela)),'') ,
  'serie'=isnull(moinstser,'')         ,
  'emisor'=isnull(emgeneric,'')         ,
  'fecemi'=isnull(convert(char(10),mofecemi,103),'')      ,
  'fecven'=isnull(convert(char(10),mofecven,103),'')      ,
  'nominal'=isnull(monominal,0)         ,
  'tir'=isnull(motir,0)         ,
  -- sp_infmovdcv 0
  'vent'=isnull(case
      when motipoper='VI' then 'VENTA PACTO'
      when motipoper='VP' then 'VENTA TERMINO'
      end,'')         ,
  'numope'=isnull(monumoper,0)         ,
  'correla'=isnull(mocorrela,0)         ,
  'serie'=isnull(inserie,'') ,
  'hora'   = convert(varchar(10), getdate(), 108),
  'BANCO'  = @ACNOMPROP
  from MDAC
--  REQ. 7619
     , MDMO RIGHT OUTER JOIN VIEW_CLIENTE ON clrut = morutcli 
                                         and clcodigo = mocodcli 
            RIGHT OUTER JOIN VIEW_EMISOR  ON emrut = morutemi
                                         
--     , VIEW_CLIENTE  
     , VIEW_ENTIDAD
--  REQ. 7619
--     , VIEW_EMISOR
     , VIEW_INSTRUMENTO
     , MDCP
 where motipoper='VP' 
 and ( @entidad = 0 or morutcart = @entidad )
  and rcrut = morutcart
--  REQ. 7619
/*
  and clrut=*morutcli 
  and clcodigo=*mocodcli 
 and emrut=*morutemi 
*/
 and incodigo=mocodigo 
 and cpnumdocu=monumdocu 
 and cpcorrela=mocorrela
 and cpdcv= 'D'
 order by monumoper, monumdocu
end 
else
begin
 select 'entidad' = 'bactrader full',   
  'rutpro'  ='',
  'fecpro'  ='',
  'cliente' ='',
  'cartera' ='',
  'numdocu' ='',
  'serie'   ='',
  'emisor'  ='',
  'fecemi'  ='',
  'fecven'  ='',
  'nominal' ='',
  'tir'     ='',
  -- sp_infmovdcv 0
  'vent'    ='',
  'numope'  ='',
  'correla' ='',
  'serie'   ='' ,
  'hora'    = '',
  'BANCO'   = @ACNOMPROP
end 
--update MDMO set mocodcli = 1 where morutcart =3 and motipoper ='vp'
end
-- select *  from MDMO
--select * from mdin where morutcli = clrut and mocodcli = clcodigo
-- select * from MDCP


GO
