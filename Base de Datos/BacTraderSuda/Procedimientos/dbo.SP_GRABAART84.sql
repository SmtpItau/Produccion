USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAART84]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAART84]( @nrutcli numeric(9,0),
    @ncodcli numeric(9,0),
    @dpatrimonio float  ,
    @dporc  float  , 
    @dgarantias float  ,
    @docupado  float ) 
as
begin
 declare @cgrabagar char(1)
 select  @cgrabagar =' '
 if exists(select * from MD_ART84 where rut =@nrutcli and codigo = @ncodcli ) 
 begin
  update MD_ART84 
  set 
   patrimonio     = @dpatrimonio ,
   porcentaje     = @dporc ,
   usa_garantias  = @cgrabagar ,   
   garantias = @dgarantias ,
   monto_ocupado   = @docupado 
  where 
   rut =@nrutcli 
  and  codigo = @ncodcli 
  if @@error<>0 begin
   SELECT 'NO', 'PROBLEMAS EN ACTUALIZACI_N DE DATA'
   return
  end
 end
 else
 begin
  insert into 
  MD_ART84(
   rut  ,  
   codigo  ,
   patrimonio ,
   porcentaje ,
   usa_garantias ,
   garantias ,
   monto_ocupado            
   )
  values
   (
   @nrutcli ,
   @ncodcli ,
   @dpatrimonio ,
   @dporc  ,
   @cgrabagar ,
   @dgarantias ,
   @docupado 
   )
  if @@error<>0 begin
   SELECT 'NO', 'PROBLEMAS EN INGRESO DE DATA'
   return
  end
 end  
 SELECT 'SI', 'GRABACI_N OK'
end
                                                                                                   
-- select * from md_art84

GO
