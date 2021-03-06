USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODI_OPERACION_TESORERIA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MODI_OPERACION_TESORERIA]
                                          (  @id_sistema         char(3)     ,
                                         @fecha_operacion    datetime    ,
                                           @tipo_operacion     char(4)     ,
                                           @operacion          numeric(10) ,
                                         @rut_cliente        numeric(10) ,
                                           @codigo_rut         numeric(05) ,
                                           @monto_operacion    float       ,
                                           @moneda             char(4)     ,
                                           @pago_hoy           char(1)     ,
                                           @forma_pago         char(4)     ,
                                           @retiro             char(1)     ,
                                           @entidad            numeric(10) ,
                                           @moneda_mx          char(4)     ,
                                           @monto_mx           float       ,
                                           @forma_pago_mx      char(4)     )
as
begin
declare @fecha_vencimiento datetime  ,
        @fecha_pago        datetime  ,
        @fecha_vcto_mx     datetime  ,
        @dias              numeric(3),
        @tipo_movimiento   char(1)
/* graba operacion a tesoreria ---------------------------------------------------- */
update GEN_OPERACIONES set   fecha_operacion  = @fecha_operacion  ,
                         tipo_operacion   = @tipo_operacion    ,
                         rut_cliente      = @rut_cliente       ,
                         codigo_rut       = @codigo_rut        ,
                         monto_operacion  = @monto_operacion   ,
                         moneda           = @moneda            ,
                         forma_pago       = @forma_pago        ,
                         cerrada          =  'N'                ,
                         situacion        =  ''                 ,
                         entidad          =  @entidad           ,
                         moneda_mx        =  @moneda_mx         ,
                         monto_mx         =  @monto_mx          ,
                         forma_pago_mx    =  @forma_pago_mx     
   where id_sistema = @id_sistema and
         operacion  = @operacion 
                
                        
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO OPERACION DE TESORERIA.'
   return 1
end
/* graba flujo de caja ------------------------------------------------------------------ */
select @tipo_movimiento = isnull(tipo_movimiento_caja,'') from VIEW_MOVIMIENTO_CNT where tipo_operacion = @tipo_operacion
update GEN_FLUJO_CAJA set  fecha_operacion   = @fecha_operacion   ,
                         moneda            = @moneda            ,
                         operacion         = @operacion         ,
                         rut_cliente       = @rut_cliente       ,
                         codigo_rut        = @codigo_rut        ,
                         monto             = @monto_operacion   ,
                         forma_pago        = @forma_pago        ,
                         tipo_movimiento   = @tipo_movimiento   
   where    operacion  = @operacion and
                         tipo_operacion    = @tipo_operacion    
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO FLUJO DE CAJA.'
   return 1
end
return 0
end   /* fin procedimiento */


GO
