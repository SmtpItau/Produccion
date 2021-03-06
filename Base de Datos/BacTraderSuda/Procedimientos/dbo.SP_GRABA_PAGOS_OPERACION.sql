USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PAGOS_OPERACION]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PAGOS_OPERACION]( @fecha_pago           datetime      ,
                                      @id_sistema           char(3)       ,
                                      @tipo_operacion       char(4)       ,
                                      @operacion            numeric(10)   ,
                                      @correlativo          numeric(5)    ,
                                      @tipo_movimiento      char(1)       ,
                                      @rut_cliente          numeric(10)   ,
                                      @codigo_rut           numeric(5)    ,
                                      @monto_operacion      float         ,
                                      @moneda               char(3)       ,
                                      @numero_documento     numeric(10)   ,
                                      @forma_pago           char(4)       ,
                                      @nombre_cliente       char(40)      ,
                                      @tipo_canje           char(1)       ,
                                      @codigo_banco         numeric(3)    ,
                                      @correla_pago         numeric(5)    )
as 
begin
declare @fecha_cobro datetime 
select @fecha_cobro = fecha_vencimiento 
  from GEN_OPERACIONES 
 where id_sistema  = @id_sistema
   and operacion   = @operacion
   and correlativo = @correlativo
   and fecha_pago  = @fecha_pago
insert GEN_PAGOS_OPERACION( fecha_pago,
                            id_sistema,
                            tipo_operacion,
                            operacion,
                            correlativo,
                            tipo_movimiento,
                            rut_cliente,
                            codigo_rut,
                            monto_operacion,
                            moneda,
                            numero_documento,
                            forma_pago,
                            nombre_cliente,
                            estado,
                            tipo_canje,
                            codigo_banco,
                            tipo_ingreso,
                            correla_pago,
                            fecha_cobro )
                    values( @fecha_pago,
                            @id_sistema,
                            @tipo_operacion,
                            @operacion,
                            @correlativo,
                            @tipo_movimiento,
                            @rut_cliente,
                            @codigo_rut,
                            @monto_operacion,
                            @moneda,
                            @numero_documento,
                            @forma_pago,
                            @nombre_cliente,
                            (case when @tipo_canje = 'R' then 'A' else 'C' end),
                            @tipo_canje,
                            @codigo_banco,
                            'a',
                            @correla_pago,
                            (case when @tipo_canje = 'R' then '' else @fecha_cobro end) )
if @@error <> 0 
begin
   PRINT 'ERROR_PROC FALLA AGREGANDO DETALLE PAGOS OPERACION'
   return 1
end
update GEN_OPERACIONES set cerrada = 's' where tipo_operacion = @tipo_operacion
                                           and operacion      = @operacion
                                           and correlativo    = @correlativo
if @@error <> 0
begin
   PRINT 'ERROR_PROC FALLA ACTUALIZANDO MARCA CERRADA EN OPERACIONES'
   return 1
end 
return 0
end   /* fin procedimiento */
-- sp_help gen_pagos_operacion
-- delete gen_pagos_operacion
-- select * from gen_pagos_operacion
-- select * from gen_operaciones

GO
