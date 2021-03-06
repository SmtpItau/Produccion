USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_SETTLEMENT]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LIMITES_SETTLEMENT]
                                      ( @sistema          char(3)     ,
                                        @fecha_hoy        datetime    ,
                                        @tipo             char(3)     ,
                                        @rut_cliente      numeric(10) ,
                                        @codigo_rut       numeric(5)  ,
                                        @tipo_operacion   char(5)     ,
                                        @operacion        numeric(10) ,
                                        @correlativo      numeric(5)  ,
                                        @forma_pago       numeric(4)  ,
                                        @monto_operacion  float       )
as
begin
      set nocount on
declare @monto_disponible float    ,
        @monto_ocupado    float    ,
        @dia              integer  ,
        @valor_dolar      float    ,
        @fecha_pago       datetime ,
 @cliente          char(40) ,
        @linea_settle     char(1)  ,
 @ccontrollinea    char(1)  ,
        @dia0_ocupado     float    ,
        @dia1_ocupado     float    ,
        @dia2_ocupado     float    ,
        @dia3_ocupado     float    ,
 @coperdolar    char(01)
select @cliente = clnombre, @ccontrollinea = clvalidalinea from VIEW_CLIENTE where clrut = @rut_cliente and clcodigo = @codigo_rut 
if @ccontrollinea ='N' begin
   set nocount off
   select 0, 'OK', 0, 0
   return 0
end
/* busca dolar interbancario para el calculo del valor de mercado ------------------- */
select @valor_dolar = 1.0
select @valor_dolar = isnull(vmvalor, 1.0)
  from VIEW_VALOR_MONEDA
 where VIEW_VALOR_MONEDA.vmcodigo = 988  /* dolar interbancario */
   and VIEW_VALOR_MONEDA.vmfecha  = @fecha_hoy
 
if @valor_dolar is null or @valor_dolar = 0 select @valor_dolar = 1.0
/* busca dias forma de pago --------------------------------------------------------- */
select @dia = 0
select @dia = isnull(diasvalor,0) from VIEW_FORMA_DE_PAGO where codigo = @forma_pago
/* busca limites asociados al cliente ----------------------------------------------- */
select @monto_disponible = monto_asignado - (case @dia 
                                             when 0 then dia0_ocupado
                                             when 1 then dia1_ocupado
                                             when 2 then dia2_ocupado
                                             else        dia3_ocupado
                                             end) 
  from MD_SETTLEMENT
 where rut         = @rut_cliente
   and codigo      = @codigo_rut
   and productos   = @sistema
select @linea_settle = (case when @@rowcount = 0 then 'N' else 'S' end)
if @sistema <> 'BCC' 
   select @monto_operacion = round(@monto_operacion / @valor_dolar, 2)
if @tipo = 'VAL'
begin
   if @linea_settle = 'N' 
   begin
      set nocount off
      select 'MSG'=5, 'DESC'=rtrim(@cliente)+' '+ a.mensaje, 'MONTO'= @monto_operacion, 'DIA'=@dia from MD_MENSAJE_LIMITES a where codigo = 5
      return 5
   end 
   if @operacion > 0
   begin
      select @monto_ocupado = 0.0
      if @sistema = 'BCC' 
         select @monto_ocupado = momonmo from VIEW_MEMO where monumope = @operacion and morutcli = @rut_cliente and mocodcli = @codigo_rut
      if @sistema = 'BTR' 
      begin
         select @monto_ocupado = sum(movpresen) from MDMO where monumoper = @operacion and morutcli = @rut_cliente and mocodcli = @codigo_rut
         select @monto_ocupado = round(@monto_ocupado / @valor_dolar, 2)
      end
      select @monto_disponible = @monto_disponible + @monto_ocupado
   end
   if @monto_operacion > @monto_disponible
   begin
      if @monto_disponible < 0
         select @monto_disponible = 0
      set nocount off      
      select 'MSG'=6, 'DESC'=rtrim(@cliente)+' '+ a.mensaje,  'MONTO'= (@monto_operacion - @monto_disponible), 'DIA'=0 from MD_MENSAJE_LIMITES a where codigo = 6
      return 6
   end
end
if @tipo = 'CAR' or @tipo = 'DES'
begin
   select @dia0_ocupado = @monto_operacion
   select @dia1_ocupado = (case when @dia > 0 then @monto_operacion else convert(float,0) end)
   select @dia2_ocupado = (case when @dia > 1 then @monto_operacion else convert(float,0) end)
   select @dia3_ocupado = (case when @dia > 2 then @monto_operacion else convert(float,0) end)
   if @tipo = 'DES'
   begin
      select @dia0_ocupado = @dia0_ocupado * -1.0
      select @dia1_ocupado = @dia1_ocupado * -1.0
      select @dia2_ocupado = @dia2_ocupado * -1.0
      select @dia3_ocupado = @dia3_ocupado * -1.0
      update MD_EXCESO_LIMITES set estado = 'A'
       where id_sistema   = @sistema 
         and operacion    = @operacion
         and tipo_limites = 'SETTLE'
      if @@error <> 0
      begin
         set nocount off
         select -1, 'FALLA BORRANDO EXCESO LIMITES.'
         return -1
      end
      
   end
   if @linea_settle = 'N'
      insert MD_SETTLEMENT
                          ( rut,
                            codigo,
                            plazo_ini,
                            plazo_fin,
                            productos,
                            monto_asignado,
                            dia0_ocupado,
                            dia1_ocupado,
                            dia2_ocupado,
                            dia3_ocupado )
                    values( @rut_cliente,
                            @codigo_rut,
                            0,
                            0,
                            @sistema,
                            0.0,
                            @dia0_ocupado,
                            @dia1_ocupado,
                            @dia2_ocupado,
                            @dia3_ocupado )
   else
      update MD_SETTLEMENT set dia0_ocupado = dia0_ocupado + @dia0_ocupado,
                               dia1_ocupado = dia1_ocupado + @dia1_ocupado,
                               dia2_ocupado = dia2_ocupado + @dia2_ocupado,
                               dia3_ocupado = dia3_ocupado + @dia3_ocupado
                         where rut         = @rut_cliente
                           and codigo      = @codigo_rut
                           and productos   = @sistema
   if @@error <> 0
   begin
      set nocount off
      select -1, 'FALLA ACTUALIZANDO LIMITE SETTLEMENT.'
      return -1
   end
   if @tipo = 'DES'
   begin
      delete MD_SETTLEMENT where rut            = @rut_cliente
                             and codigo         = @codigo_rut
                             and productos      = @sistema
                             and (dia0_ocupado + dia1_ocupado + @dia2_ocupado) = 0.0
                             and monto_asignado = 0.0
      if @@error <> 0
      begin
         set nocount off
         select -1, 'FALLA BORRANDO LIMITE SETTLEMENT.'
         return -1
      end
   end
end
set nocount off
select 0, 'OK', 0, 0
return 0
end   /* fin procedimiento */


GO
