USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_OPERACION_TESORERIA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_OPERACION_TESORERIA]( @id_sistema         char(3)     ,
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
                                          @entidad            numeric(10) )
as
begin
declare @fecha_vencimiento datetime  ,
        @fecha_pago        datetime  ,
        @dias              numeric(3),
        @tipo_movimiento   char(1)
/* busca fecha de pago ------------------------------------------------------------ */
if @pago_hoy = 'N'
   select @dias = 1
else
   select @dias = 0
execute SP_BUSCA_FECHA_HABIL @fecha_operacion, 1, @dias, @fecha_pago output
/* busca fecha de vencimiento ----------------------------------------------------- */
select @dias = 0
select @dias = isnull(diasvalor,0) from VIEW_FORMA_DE_PAGO where @forma_pago = ltrim(str(codigo))
execute SP_BUSCA_FECHA_HABIL @fecha_pago, @dias, @fecha_vencimiento output
/* graba operacion a tesoreria ---------------------------------------------------- */
insert GEN_OPERACIONES( id_sistema         ,
                        fecha_operacion    ,
                        tipo_operacion     ,
                        operacion          ,
                        rut_cliente        ,
                        codigo_rut         ,
                        monto_operacion    ,
                        moneda             ,
                        forma_pago         ,
                        retiro             ,
                        cerrada            ,
                        situacion          ,
                        fecha_pago         ,
                        fecha_vencimiento  ,
                        entidad            )
                values( @id_sistema        ,
                        @fecha_operacion   ,
                        @tipo_operacion    ,
                        @operacion         ,
                        @rut_cliente       ,
                        @codigo_rut        ,
                        @monto_operacion   ,
                        @moneda            ,
                        @forma_pago        ,
                        (case @retiro 
                         when 'V' then 'VAM'
                         else          'VIE'
                        end)               ,
                        'n'                ,
                        ''                 ,
                        @fecha_pago        ,
                        @fecha_vencimiento ,
                        @entidad           )
if @@error <> 0
begin
   PRINT 'ERROR_PROC FALLA AGREGANDO OPERACION A TESORERIA.'
   return 1
end
/* graba flujo de caja ------------------------------------------------------------------ */
select @tipo_movimiento = isnull(tipo_movimiento_caja,'') from view_movimiento_cnt where tipo_operacion = @tipo_operacion
insert gen_flujo_caja( fecha_operacion    ,
                       fecha_pago         ,
                       moneda             ,
                       tipo_operacion     ,
                       operacion          ,
                       rut_cliente        ,
                       codigo_rut         ,
                       monto              ,
                       forma_pago         ,
                       tipo_movimiento    )
 values( @fecha_operacion   ,
                       @fecha_vencimiento ,
                       @moneda            ,
                       @tipo_operacion    ,
                       @operacion         ,
                       @rut_cliente       ,
                       @codigo_rut        ,
                       @monto_operacion   ,
                       @forma_pago        ,
                       @tipo_movimiento   )
if @@error <> 0
begin
   PRINT 'ERROR_PROC FALLA AGREGANDO FLUJO DE CAJA.'
   return 1
end
return 0
end   /* fin procedimiento */
--sp_help gen_operaciones
--select * from mdfe
--select * from MDMO

GO
