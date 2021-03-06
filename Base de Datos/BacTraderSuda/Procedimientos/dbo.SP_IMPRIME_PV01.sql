USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIME_PV01]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_IMPRIME_PV01]
as
begin
 declare @id_sistema  char(3),
    @i float
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
 create table #TEM (years  char(10) ,
     pv01_act_uf float    ,                                     
     pv01_act_clp  float  ,                                      
     pv01_act_usd  float  , 
     cinco float  ,
     pv01_pas_uf float    ,                                     
     pv01_pas_clp  float  ,                                      
     pv01_pas_usd  float  ,
     nueve float  ,
     id_sistema char(3)  ,
     BANCO CHAR(40))
  set @i = 1
   while @i < 4 begin
  select @id_sistema = case @i when 1 then 'CON'
                       when 2 then 'BTR'
                when 3 then 'BFW'    
               end 
  insert into #TEM 
  select   rango  ,
    pv01_act_uf     ,                                     
    pv01_act_clp    ,                                      
    pv01_act_usd    , 
    (pv01_act_uf+pv01_act_clp+pv01_act_usd),
    pv01_pas_uf     ,                                     
    pv01_pas_clp    ,                                      
    pv01_pas_usd    ,
    (pv01_pas_uf+pv01_pas_clp+pv01_pas_usd),
    id_sistema ,
    BANCO = @ACNOMPROP
  from 
   BAC_INTER_PV03,
   BAC_PLAZOS_INTER
  where   id_sistema = @id_sistema
   and rango = descripcion 
   and codigo_inter = 'PV01'
   order by orden
  set @i = @i +1
  end
 select * from #TEM
end

GO
