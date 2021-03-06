USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_SETTLE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAR_SETTLE]( 
   @nrutcli numeric(9,0) ,
   @ncodcli numeric(9,0) ,
   @csistema char(3)  ,
   @fasignado float  ,
   @fdia0  float  ,
   @fdia1  float  ,
   @fdia2  float  ,
   @fdia3  float  ,
   @fdia4  float  )
as
begin
 if exists(select * from MD_SETTLEMENT where rut =@nrutcli and codigo = @ncodcli and productos = @csistema ) 
 begin
  update MD_SETTLEMENT
  set 
   monto_asignado = @fasignado,
   dia0_ocupado = @fdia0,
   dia1_ocupado = @fdia1,
   dia2_ocupado = @fdia2,
   dia3_ocupado = @fdia3,
   dia4_ocupado = @fdia4
  where 
   rut   = @nrutcli 
  and  codigo   = @ncodcli 
  and   productos  = @csistema 
  if @@error<>0 begin
   SELECT 'NO', 'PROBLEMAS EN ACTUALIZACIóN DE DATA'
   return
  end
 end
 else
 begin
  insert into 
  MD_SETTLEMENT(
   rut  ,  
   codigo  ,
   plazo_ini ,
   plazo_fin ,
   monto_asignado ,
   dia0_ocupado    ,
   dia1_ocupado    ,
   dia2_ocupado    ,
   dia3_ocupado    ,
   dia4_ocupado    ,
   productos )
  values
   (
   @nrutcli ,
   @ncodcli ,
   0  ,
   0  ,
   @fasignado ,
   @fdia0  ,
   @fdia1  ,
   @fdia2  ,
   @fdia3  ,
   @fdia4  ,
   @csistema )
  if @@error<>0 begin
   SELECT 'NO', 'PROBLEMAS EN INGRESO DE DATA'
   return
  end
 end  
 SELECT 'SI', 'GRABACI¢N OK'
end   /* fin procedimiento */

GO
