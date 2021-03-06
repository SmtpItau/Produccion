USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_PFE_CCE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAR_PFE_CCE]( 
   @nrutcli numeric(9,0) ,
   @ncodcli numeric(9,0) ,
   @ccodlim char(3)  ,
   @csistema char(3)  ,
   @rangodesde numeric(10,0) ,
   @rangohasta numeric(10,0) ,
   @fasignado float  ,
   @focupado float  )
as
begin
/* if exists(select * from MD_PFE_CCE where rut =@nrutcli and codigo = @ncodcli and tipo_limite = @ccodlim and  productos = @csistema ) 
 begin
  update MD_PFE_CCE
  set 
   monto_asignado = @fasignado ,
   monto_ocupado = @focupado 
  where 
   rut   = @nrutcli 
  and  codigo   = @ncodcli 
  and tipo_limite  = @ccodlim 
  and   productos  = @csistema 
  if @@error<>0 begin
   select 'no', 'problemas en actualización de data'
   return
  end
 end
 else
 begin
*/
  insert into 
  MD_PFE_CCE(
   rut  ,  
   codigo  ,
   tipo_limite ,
   plazo_ini ,
   plazo_fin ,
   monto_asignado ,
   monto_ocupado ,
   productos )
  values
   (
   @nrutcli ,
   @ncodcli ,
   @ccodlim ,
   @rangodesde ,
   @rangohasta ,
   @fasignado ,
   @focupado ,
   @csistema )
  if @@error<>0 begin
   SELECT 'NO', 'PROBLEMAS EN INGRESO DE DATA'
   return
  end
-- end  
 SELECT 'SI', 'GRABACI¢N OK'
end

GO
