USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DETALLE_SALDOS_BANCOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_DETALLE_SALDOS_BANCOS]( @cuenta_corta     char(15) ,
                                            @fecha_operacion  datetime )
as
begin
create table #DETALLE( tipo_operacion   char(30)    ,
                       operacion        numeric(10) ,
                       glosa            char(30)    ,
                       forma_pago       char(30)    ,
                       monto            float       ,
                       fecha_operacion  datetime    )
/* movimientos de operaciones ------------------------------------------------------- */
insert #DETALLE select VIEW_MOVIMIENTO_CNT.glosa_operacion   ,
                       GEN_OPERACIONES.operacion            ,
                       VIEW_CLIENTE.clnombre                 ,  --  REQ. 7619
                       MDFP.glosa                           ,
                       (case 
                          when GEN_MOVIMIENTO_CTA_CTE.tipo_movimiento = 'A' then GEN_MOVIMIENTO_CTA_CTE.monto
                          when GEN_MOVIMIENTO_CTA_CTE.tipo_movimiento = 'C' then GEN_MOVIMIENTO_CTA_CTE.monto * -1.0
                       end),
                       GEN_OPERACIONES.fecha_operacion
                  from GEN_MOVIMIENTO_CTA_CTE, GEN_OPERACIONES, VIEW_CLIENTE, VIEW_FORMA_DE_PAGO MDFP, VIEW_MOVIMIENTO_CNT
                 where GEN_MOVIMIENTO_CTA_CTE.tipo_operacion   = GEN_OPERACIONES.tipo_operacion
                   and GEN_MOVIMIENTO_CTA_CTE.operacion        = GEN_OPERACIONES.operacion
                   and GEN_MOVIMIENTO_CTA_CTE.fecha_movimiento = @fecha_operacion
                   and GEN_OPERACIONES.rut_cliente             = VIEW_CLIENTE.clrut
                   and GEN_OPERACIONES.codigo_rut              = VIEW_CLIENTE.clcodigo
                   and GEN_MOVIMIENTO_CTA_CTE.cuenta_corta     = @cuenta_corta
                   and GEN_MOVIMIENTO_CTA_CTE.forma_pago       = ltrim(str(MDFP.codigo))
                   and GEN_MOVIMIENTO_CTA_CTE.tipo_operacion   = VIEW_MOVIMIENTO_CNT.tipo_operacion
/* movimientos de cargos, abonos o traspasos de cuentas ----------------------------- */
insert #DETALLE select (case 
                          when GEN_MOVIMIENTO_CTA_CTE.tipo_operacion = 'ING' then 'INGRESO TESORERIA'
                          when GEN_MOVIMIENTO_CTA_CTE.tipo_operacion = 'RET' then 'RETIRO TESORERIA'
                          when GEN_MOVIMIENTO_CTA_CTE.tipo_operacion = 'SAL' then 'SALDO INICIAL'
                       end),
                       GEN_MOVIMIENTO_CTA_CTE.operacion     ,
                       GEN_MOVIMIENTO_CTA_CTE.observacion   ,
                       MDFP.glosa                           , 
                       (case 
                          when GEN_MOVIMIENTO_CTA_CTE.tipo_movimiento = 'A' then GEN_MOVIMIENTO_CTA_CTE.monto
                          when GEN_MOVIMIENTO_CTA_CTE.tipo_movimiento = 'C' then GEN_MOVIMIENTO_CTA_CTE.monto * -1.0
                       end),
                       GEN_MOVIMIENTO_CTA_CTE.fecha_movimiento
                  from GEN_MOVIMIENTO_CTA_CTE, VIEW_FORMA_DE_PAGO MDFP
                 where GEN_MOVIMIENTO_CTA_CTE.fecha_movimiento = @fecha_operacion
                   and GEN_MOVIMIENTO_CTA_CTE.cuenta_corta     = @cuenta_corta
                   and GEN_MOVIMIENTO_CTA_CTE.forma_pago       = ltrim(str(MDFP.codigo))
                   and (GEN_MOVIMIENTO_CTA_CTE.tipo_operacion  = 'ING' 
                    or GEN_MOVIMIENTO_CTA_CTE.tipo_operacion   = 'RET'
                    or GEN_MOVIMIENTO_CTA_CTE.tipo_operacion   = 'SAL')
select * from #DETALLE order by fecha_operacion
            
drop table #DETALLE
return 0
end   /* fin procedimiento */


GO
