USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_MOVIMIENTO_BANCOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_MOVIMIENTO_BANCOS] ( @tipo_movimiento      char(1)       ,
                                         @forma_pago           char(4)       ,
                                         @numero_cheque        numeric(10)   ,
                                         @cuenta_corta_origen  char(6)       ,
                                         @cuenta_corta_destino char(6)       ,
                                         @afecta_caja          char(1)       ,
                                         @monto                numeric(18,2) ,
                                         @fecha_operacion      datetime      ,
                                         @observacion          char(40)      )
as 
begin
declare @tipo_operacion    char(4)   ,
        @traspaso_cuentas  char(1)   ,
        @control_error     numeric(1),
        @folio             numeric(10)
begin transaction
select @traspaso_cuentas = 'N'
select @control_error    = 0
if @tipo_movimiento = 'C'
   select @tipo_operacion = 'RET'
if @tipo_movimiento = 'A' 
   select @tipo_operacion = 'ING'
if @tipo_movimiento = 'T' 
begin
   select @traspaso_cuentas = 'S'
   select @tipo_movimiento  = 'C'
   select @tipo_operacion   = 'RET'
   select @observacion      = 'TRASPASO DE FONDOS A ' + @cuenta_corta_destino
end
select @folio = folio from GEN_FOLIOS where codigo = 'MOVTES'
insert GEN_MOVIMIENTO_CTA_CTE( cuenta_corta         ,
                               tipo_movimiento      ,
                               numero_cheque        ,
                               fecha_movimiento     ,
                               monto                ,
                               tipo_operacion       ,
                               conciliado           ,
                               estado               ,
                               forma_pago           ,
                               observacion          ,
                               tipo_ingreso         ,
                               operacion            )
                       values( @cuenta_corta_origen ,
                               @tipo_movimiento     ,
                               @numero_cheque       ,
                               @fecha_operacion     ,
                               @monto               ,
                               @tipo_operacion      ,
                               'n'                  ,
                               'a'                  ,
                               @forma_pago          ,
                               @observacion         ,
                               'm'                  ,
                               @folio               )
if @@error <> 0
begin
   select @control_error = 1
   PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTO CUENTA BANCO'
   goto fin_procedimiento
end
if @traspaso_cuentas = 'S' 
begin
   select @folio = @folio + 1
   insert GEN_MOVIMIENTO_CTA_CTE( cuenta_corta         ,
                                  tipo_movimiento      ,
                                  numero_cheque        ,
                                  fecha_movimiento     ,
                                  monto                ,
                                  tipo_operacion       ,
                                  conciliado           ,
                                  estado               ,
                                  forma_pago           ,
                                  observacion          ,
                                  tipo_ingreso         ,
                                  operacion            )
                          values( @cuenta_corta_destino,
                                  'A'                  ,
                                  @numero_cheque       ,
                                  @fecha_operacion     ,
                                  @monto               ,
                                  @tipo_operacion      ,
                           'N'                  ,
                                  'A'                  ,
                                  @forma_pago          ,
                                  @observacion         ,
                                  'M'                  ,
                                  @folio               )
   if @@error <> 0
   begin
      select @control_error = 1
      PRINT 'ERROR_PROC FALLA AGREGANDO MOVIMIENTO CUENTA BANCO'
      goto fin_procedimiento
   end
end
select @folio = @folio + 1
update GEN_FOLIOS set folio = @folio where codigo = 'MOVTES'
if @@error <> 0
begin
   select @control_error = 1
   PRINT 'ERROR_PROC FALLA ACTUALIZANDO FOLIO MOVIMIENTO.'
   goto fin_procedimiento
end
/*
if @afecta_caja = 's' 
begin
   insert rfi_flujo_caja  ( fecha           , 
                            tipo_operacion  ,
                            monto_movimiento,
                            observacion     ,
                            tipo_liquidacion,
                            estado          )
                   values ( @fecha_operacion ,
                            @tipo_operacion  ,
                            @monto           ,
                            @observacion     ,
                            'ph'             ,
                            'a'             )
   if @@error <> 0 
   begin
      select @control_error = 1
      print 'error_proc error al actualizar flujo de caja'
      goto fin_procedimiento
   end
end
*/
  
fin_procedimiento:
if @control_error <> 0
   rollback
else
   commit
  
return @control_error
 
end   /* fin procedimiento */
-- select * from gen_movimiento_cuenta_corriente
-- delete gen_movimiento_cta_cte
-- delete gen_pagos_operacion
-- select * from mdfp

GO
