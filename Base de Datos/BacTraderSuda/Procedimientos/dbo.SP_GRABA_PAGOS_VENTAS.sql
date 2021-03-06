USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PAGOS_VENTAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PAGOS_VENTAS]( @fecha_pago           datetime      ,
                                   @id_sistema           char(3)       ,
                                   @tipo_operacion       char(4)       ,
                                   @numero_operacion     numeric(10)   ,
                                   @rut_cliente          numeric(10)   ,
                                   @codigo_rut           numeric(5)    ,
                                   @monto_operacion      float         ,
                                   @moneda               char(3)       ,
                                   @numero_documento     numeric(10)   ,
                                   @forma_pago           char(4)       )
as 
begin
insert GEN_PAGOS_VENTAS( fecha_pago,
                         id_sistema,
                         tipo_operacion,
                         rut_cliente,
                         codigo_rut,
                         monto_operacion,
                         moneda,
                         numero_operacion,
                         numero_documento,
                         forma_pago )
                 values( @fecha_pago,
                         @id_sistema,
                         @tipo_operacion,
                         @rut_cliente,
                         @codigo_rut,
                         @monto_operacion,
                         @moneda,
                         @numero_operacion,
                         @numero_documento,
                         @forma_pago )
if @@error <> 0 
begin
   PRINT 'ERROR_PROC FALLA AGREGANDO DETALLE PAGOS VENTAS'
   return 1
end
update GEN_OPERACIONES set cerrada = 'S' where tipo_operacion = @tipo_operacion
                                           and operacion      = @numero_operacion
if @@error <> 0
begin
   PRINT 'ERROR_PROC FALLA ACTUALIZANDO MARCA CERRADA EN OPERACIONES'
   return 1
end 
return 0
end   /* fin procedimiento */
-- sp_help gen_pagos_ventas
-- delete gen_pagos_ventas

GO
