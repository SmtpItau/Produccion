USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_ART84]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LIMITES_ART84]
  (
  @ctipo  char(1)  , -- q query , s save , d delete 
  @nrut        numeric(9,0) ,
  @fmonto      float  ,
  @cestado varchar(3) = '' OUTPUT ,
  @cmensaje varchar(50) = '' OUTPUT
  )
as begin
 declare @fmto_asig  float  ,
         @fmto_ocup  float  ,
  @nrutbcch numeric(10,0) ,
  @nrutinp numeric(10,0) ,
  @nruttgr numeric(10,0) ,
  @ccliente char(40) 
 select @nrutbcch  = folio from  GEN_FOLIOS where codigo= 'RUTBCCH'
 select @nrutinp         = folio from  GEN_FOLIOS where codigo= 'RUTINP'
 select @nruttgr  = folio from  GEN_FOLIOS where codigo= 'RUTTGR'
 select @ccliente = clnombre from  VIEW_CLIENTE where clrut = @nrut
 if  @nrut = @nrutbcch begin
  select @cestado = 'SI', @cmensaje = 'BANCO CENTRAL NO TIENE RESTRICCI = N'
  select @cestado , @cmensaje
  return
 end
 if  @nrut = @nruttgr  begin
  select @cestado = 'SI', @CMENSAJE = 'TESORERIA GENERAL DE LA REPUBLICA NO TIENE RESTRICCI = N'
  select @cestado, @cmensaje
  return
 end
 if  @nrut = @nrutinp  begin
  select @cestado = 'SI', @CMENSAJE = 'INSTITUTO DE NORMALIZACI = N PREVISIONAL NO TIENE RESTRICCI = N'
  select @cestado, @cmensaje
  return
 end
 if not exists( select * from MD_ART84 where rut = @nrut) 
 begin 
  select @cestado='NOQ' , @cmensaje= rtrim(@ccliente) + ' NO POSEE LIMITES ASIGNADOS'
  select 'ESTADO'='NOQ' , 'MSG'= rtrim(@ccliente) + ' NO POSEE LIMITES ASIGNADOS',0,0
  return -1
 end
 select  
  @fmto_asig = isnull(patrimonio,0.0), 
         @fmto_ocup = isnull(monto_ocupado,0.0)  
 from 
  MD_ART84
 where
  rut = @nrut
 if @ctipo = 'Q'   -- se esta consultando el monto
 begin
  if (@fmto_ocup+@fmonto) > @fmto_asig begin
   select  @cestado='NOQ',@cmensaje='OPERACIONES CON ' + rtrim(@ccliente) + ', SOBREPASA LIMITES ASIGNADOS '
   select  'estado'='NOQ', 'MSG' = 'OPERACIONES CON ' + rtrim(@ccliente) + ', SOBREPASA LIMITES ASIGNADOS ', 'M1' = (@fmto_ocup+@fmonto) ,  'M2' = @fmto_asig 
             return -1
  end else begin
   select @cestado = 'SI', @cmensaje = 'ESTADO OK'
   select @cestado , @cmensaje
   return 0
  end
 end
 if @ctipo = 'S' -- se graba informaci=n 
 begin
  update MD_ART84 set monto_ocupado =  monto_ocupado + @fmonto where  rut = @nrut
  if @@error<>0 begin
   select @cestado='NOS', @cmensaje='PROBLEMAS EN ACTUALIZACI=N DE LIMITES AUMENTANDO OCUPADO'
   select @cestado , @cmensaje
   return
  end
  select @cestado='SI', @cmensaje='ACTUALIZACION OK'
  select @cestado , @cmensaje
  return
 end
 if @ctipo = 'D' -- se graba informaci=n 
 begin
  update MD_ART84 set monto_ocupado =  monto_ocupado - @fmonto where  rut = @nrut
  if @@error<>0 begin
   select @cestado='NOD', @cmensaje='PROBLEMAS EN ACTUALIZACI=N DE LIMITES DISMINUYENDO OCUPADO'
   select @cestado , @cmensaje
   return
  end
  select @cestado='SI', @cmensaje='ACTUALIZACION OK'
  select @cestado , @cmensaje
  return
 end
end


GO
