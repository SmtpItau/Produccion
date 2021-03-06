USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_EMISOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LIMITES_EMISOR]
                                  ( @fecha_hoy       datetime    ,
                                    @tipo            char(3)     ,
                                    @rut_emisor      numeric(10) ,
                                    @instrumento     char(10)    ,
                                    @fecha_vcto      datetime    ,
        @monto           float       ,
        @operacion       numeric(10) )
as
begin
      set nocount on
declare @monto_disponible  float     ,
        @plazo             numeric(5) ,
        @plazo_ini             numeric(5) ,
 @nrutbcch  numeric(10,0) ,
 @nrutinp  numeric(10,0) ,
 @nruttgr  numeric(10,0) ,
 @ccliente  char(40) ,
 @fvaluedolar  float  ,
 @monto_dolar            float        ,
 @corigen  char(03) ,
 @sforigen  char(30) ,
 @linea_emisor  char(1)  ,
 @ccontrollinea  char(1)
select  @corigen = intiporig from VIEW_INSTRUMENTO where inserie = @instrumento
select  @sforigen = tbglosa  from VIEW_TABLA_GENERAL_DETALLE where tbcateg = 99 and tbcodigo1 = @corigen
/* vb +- 23/06/2000 se cambia para que el monto este expresado en dolares para todos los 
   casos posibles */
 
select @fvaluedolar = 1.0
select @fvaluedolar = isnull(vmvalor,1.0) from VIEW_VALOR_MONEDA where vmcodigo = 988 and vmfecha = @fecha_hoy 
if @fvaluedolar is null or @fvaluedolar = 0 
   select @fvaluedolar = 1.0
select @monto_dolar = round((@monto /@fvaluedolar ),2)
select @nrutbcch  = folio from  GEN_FOLIOS where codigo = 'RUTBCCH'
select @nrutinp         = folio from  GEN_FOLIOS where codigo = 'RUTINP'
select @nruttgr  = folio from  GEN_FOLIOS where codigo = 'RUTTGR'
select @ccliente  = clnombre  ,
       @ccontrollinea = clvalidalinea  
  from VIEW_CLIENTE 
 where clrut = @rut_emisor
/*
if @rut_emisor = @nrutbcch begin
   select 'msg' = 10, 'banco central no tiene restricci=n'
   return
end
if @rut_emisor= @nruttgr  begin
   select 'msg'= 10, 'tesoreria general de la republica no tiene restricci=n'
   return
end
if @rut_emisor= @nrutinp  begin
   select 'msg'=10, 'instituto de normalizaci=n previsional no tiene restricci=n'
   return
end
*/
/*
 se valida que el cliente si es que valida linea 
 if @ccontrollinea='n' begin
  select 'msg'=0, 'desc'='cliente no afecto a linea ok'
  return 0
 end
*/
-- vb+- 23/06/2000 se cambia el calul= del plazo para que este sea calculado en d¡as no en meses
-- select @plazo   = datediff(month, @fecha_hoy, @fecha_vcto)
select @plazo   = 0
select @plazo   = datediff(day, @fecha_hoy, @fecha_vcto)
select @ccliente = clnombre from VIEW_CLIENTE where clrut = @rut_emisor 
select @monto_disponible = monto_asignado - monto_ocupado
  from MD_EMISOR_INST_PLAZO
 where rut         = @rut_emisor
   and instrumento = @corigen 
   and @plazo     >= plazo_ini
   and @plazo     <= plazo_fin
 
select @linea_emisor = (case when @@rowcount = 0 then 'n' else 's' end)
if @tipo = 'VAL'
begin
   if @linea_emisor = 'N'
   begin
      set nocount off
      select 'MSG'=7, 'DESC'=rtrim(@ccliente) + ' ' + a.mensaje, 'SOBREGIRO'= @monto_dolar, @plazo from MD_MENSAJE_LIMITES a where codigo = 7
      return 0
   end
   if @monto_disponible < 0      
 select @monto_disponible = 0.0  
   if @monto_dolar > @monto_disponible
   begin
      set nocount off
      select 'MSG'=8, 'DESC'=rtrim(@ccliente) + ' ' + a.mensaje, 'SOBREGIRO'= (@monto_dolar - @monto_disponible), @plazo from MD_MENSAJE_LIMITES a where codigo = 8
      return 0
   end
   else
      select 'MSG'=0, 'DESC'='CONSULTA OK'
end
if @tipo = 'CAR' or @tipo = 'DES'
begin
   if @tipo = 'DES'
   begin
      select @monto_dolar = @monto_dolar * -1.0
      update MD_EXCESO_LIMITES set estado = 'A'
       where id_sistema   = 'BTR'
         and operacion    = @operacion
         and tipo_limites = 'EMIPLZ'
      if @@error <> 0
      begin
         set nocount off
         select -1, 'FALLA BORRANDO EXCESO LIMITES.'
         return -1
      end
   end
   if @linea_emisor = 'N' and @tipo = 'CAR'
   begin
      execute SP_PLAZO_INICIO_LIMITE 'EMISOR', @plazo, @rut_emisor, 1, @corigen, @plazo_ini OUTPUT
      insert MD_EMISOR_INST_PLAZO( rut,
                                   instrumento,
                                   plazo_ini,
                                   plazo_fin,
                                   monto_asignado,
                                   monto_ocupado )
                           values( @rut_emisor,
                                   @corigen,
                                   @plazo_ini,
                                   @plazo,
                                   0.0,
                                   @monto_dolar )
   end
   else 
      update MD_EMISOR_INST_PLAZO set monto_ocupado = monto_ocupado + @monto_dolar
                                where rut         = @rut_emisor
                                  and instrumento = @corigen 
                                  and @plazo     >= plazo_ini
                                  and @plazo     <= plazo_fin
   if @@error <> 0
   begin
      set nocount off
      select 'MSG'=-1, 'DESC'='FALLA ACTUALIZANDO LIMITE EMISOR.'
      return 0
   end
   if @tipo = 'DES'
   begin 
      delete MD_EMISOR_INST_PLAZO
       where rut            = @rut_emisor
         and instrumento    = @corigen 
  and monto_asignado = 0.0
  and monto_ocupado  = 0.0
         and @plazo        >= plazo_ini
         and @plazo        <= plazo_fin
      if @@error <> 0
      begin
         set nocount off
         select 'MSG'=-1, 'DESC'='FALLA BORRANDO LIMITE EMISOR.'
         return 0
      end
   end
   
   select 'MSG'=0, 'DESC'='ACTUALIZACI=N OK'
end
set nocount off
select 0, ''
end   /* fin procedimiento */

GO
