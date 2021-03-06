USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_RECPINSTRUMENTO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_RECPINSTRUMENTO](@tipo_informe numeric(1) )
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
      
if @tipo_informe = 1 
         
/*-------------------------------------------------
  selecci¢n de instrumentos a recepcionar por dcv 
--------------------------------------------------*/
     select   
            'nombreentidad' =rcnombre    ,
             'hora'   = convert(varchar(10), getdate(), 108)       , 
             a.monumoper    ,
             a.moinstser    ,
             a.monominal    ,
            a.motir        ,
             a.mopvp        ,
            a.movpresen    ,
            a.moclave_dcv  ,
            b.clnombre     ,
             c.acnomprop    ,       
             'tipoper'=case motipoper when 'CI' then 'COMPRAS CON PACTO  '
                                   when 'CP' then 'COMPRAS DEFINITIVAS' end,
      'banco'  = @ACNOMPROP
        from   
   MDMO a, 
   VIEW_CLIENTE  b,
   MDAC c,  
   MDCP ,
   VIEW_ENTIDAD
        where     a.morutcli = b.clrut
   and a.mocodcli = b.clcodigo
   and a.modcv  = 'D'
   and a.moclave_dcv  <> ' '
   and  (a.motipoper = 'CI' or a.motipoper = 'CP' )
        order by clnombre 
else 
/*---------------------------------------------------
  selecci¢n de instrumentos a recepcionar f¡sicamente
-----------------------------------------------------*/
     select   
 'nombreentidad'=rcnombre    ,
        'hora' = convert(varchar(10), getdate(), 108)       , 
        a.monumoper    ,
        a.moinstser    ,
        a.monominal    ,
        a.motir        ,
        a.mopvp        ,
        a.movpresen    ,
       a.moclave_dcv  ,
       b.clnombre     ,
       c.acnomprop    ,    
       'tipoper'=case motipoper when 'CI' then 'COMPRAS CON PACTO  '
                                   when 'CP' then 'COMPRAS DEFINITIVAS' end,
 'banco'  = @ACNOMPROP
        
        from  
   MDMO a, 
   VIEW_CLIENTE  b,
          MDAC c, 
   MDCP ,
   VIEW_ENTIDAD
        where 
   a.morutcli       = b.clrut
  and a.modcv  = 'P'
  and (a.motipoper = 'CI' or a.motipoper = 'CP' )
  order by clnombre  
end
-- select * from  MDCI
-- select * from  VIEW_CLIENTE
-- select * from  MDCP
-- select * from  MDMO
-- sp_inf_recpinstrumento 1    
-- select * from MDAC


GO
