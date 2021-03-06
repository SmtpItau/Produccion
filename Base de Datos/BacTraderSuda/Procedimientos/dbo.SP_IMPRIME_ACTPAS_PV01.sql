USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIME_ACTPAS_PV01]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_IMPRIME_ACTPAS_PV01]
                     (@id_sistema char(03) ,
      @copcion  char(03) )
as
begin
 declare @ntotact float ,
    @ntotpas float 
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
 select  @ntotact = sum(mto_act_uf)+sum(mto_act_clp)+sum(mto_act_usd)
        from  BAC_INTER_PV03
 where   id_sistema = @id_sistema
  select  @ntotpas = sum(mto_pas_uf)+sum(mto_pas_clp)+sum(mto_pas_usd) 
  from  BAC_INTER_PV03
  where   id_sistema = @id_sistema
   if @copcion  = 'act'
    select  rango   ,
       mto_act_uf      ,                    
                           dur_act_uf      ,                                      
    pv01_act_uf     ,                                     
       mto_act_clp     ,                                      
       dur_act_clp     ,                                    
       pv01_act_clp    ,                                      
       mto_act_usd     ,                                      
       dur_act_usd     ,                                      
       pv01_act_usd    ,
    id_sistema  ,
    'act'   ,
    round(((mto_act_uf+mto_act_clp+mto_act_usd)/@ntotact)*100,4),
    'BANCO' = @ACNOMPROP
     from 
       BAC_INTER_PV03 ,
       BAC_PLAZOS_INTER
      where   id_sistema = @id_sistema
       and rango = descripcion 
       and codigo_inter = 'PV01'
      order by orden
  else 
   select  rango   ,
    mto_pas_uf    ,                                      
    dur_pas_uf    ,                                      
    pv01_pas_uf   ,                                     
    mto_pas_clp   ,                                      
    dur_pas_clp   ,           
    pv01_pas_clp    ,                                      
       mto_pas_usd     ,                                      
       dur_pas_usd     ,                                      
    pv01_pas_usd    ,
    id_sistema ,
    'pas'  ,
    round(((mto_pas_uf+mto_pas_clp+mto_pas_usd)/@ntotpas)*100,4),
    'BANCO' = @ACNOMPROP
    from  BAC_INTER_PV03 ,
   BAC_PLAZOS_INTER
    where   id_sistema = @id_sistema
     and rango = descripcion 
     and codigo_inter = 'PV01'
    order by orden
end


GO
