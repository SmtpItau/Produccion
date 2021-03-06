USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATCLIART84]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATCLIART84](@nrutcli     numeric(9,0),   
           @ncodcli     numeric(9,0)
          )
as
begin
 declare @ntipcli integer 
 declare @nporc  numeric(10,0)
 declare @nrutbcch numeric(10,0)
 declare @nrutinp numeric(10,0)
 declare @nruttgr numeric(10,0)
 declare @ccodfolio char(10)
 select @nrutbcch  = folio from  GEN_FOLIOS where codigo= 'RUTBCCH'
 select @nrutinp         = folio from  GEN_FOLIOS where codigo= 'RUTINP'
 select @nruttgr  = folio from  GEN_FOLIOS where codigo= 'RUTTGR'
 if  @nrutcli = @nrutbcch begin
  SELECT 'NO', 'BANCO CENTRAL NO TIENE RESTRICCI¢N'
  return
 end
 if  @nrutcli = @nruttgr  begin
  SELECT 'NO', 'TESORERIA GENERAL DE LA REPUBLICA NO TIENE RESTRICCI¢N'
  return
 end
 if  @nrutcli = @nrutinp  begin
  SELECT 'NO', 'INSTITUTO DE NORMALIZACI¢N PREVISIONAL NO TIENE RESTRICCI¢N'
  return
 end
 
 if exists( select * from VIEW_CLIENTE where clrut = @nrutcli and clcodigo = @ncodcli ) 
 begin 
--if not exists( select * from MD_ART84 where rut = @nrutcli and codigo = @ncodcli ) 
--begin
   
   select  @ntipcli  =  cltipcli from VIEW_CLIENTE where clrut = @nrutcli and clcodigo = @ncodcli 
   select  @ccodfolio = 'ART84' + case @ntipcli when 1 then 'B' else 'E' end
   select  @nporc  = folio from GEN_FOLIOS where codigo = @ccodfolio
    
      select  'SI'       ,
    clrut            ,
                  cldv                    ,
                  clcodigo                ,
    clnombre                ,
    'porcentaje'=@nporc ,
    cltipcli
    
   from   
    VIEW_CLIENTE    
   where 
    clrut    = @nrutcli
   and   clcodigo = @ncodcli
--end
--else
--begin
-- select 'NO', 'cliente ya tiene patrimonio asignado'
--end
 end
 else 
  SELECT 'NO', 'CLIENTE NO SE ENCUENTRA DEFINIDO'
   return
 
end
/*
art84e                  5 
art84b                 30 
                                                                                                   
select * from GEN_FOLIOS              
 
 select * from MDEM                               
 execute sp_datcliart84 97006000,1
*/
                                                                                                                     
                                                                                                                                       


GO
