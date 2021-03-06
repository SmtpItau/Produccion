USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPERACION_LIQUIDACION]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_OPERACION_LIQUIDACION]( @fecha_operacion datetime    ,
                                            @id_sistema      char(3)     ,
                                            @tipo_operacion  varchar(4)  ,
                                            @operacion       numeric(10) )
as
begin
set nocount on
select cerrada                      ,
       'glosa_operacion' = space(30),
       operacion                    ,
       'cliente' = space(40)        ,
       monto_operacion              ,
       moneda                       ,
       fecha_operacion              ,
       forma_pago                   ,
       retiro                       ,
       situacion                    ,
       'glosa_pago' = space(30)     ,
       tipo_operacion               ,
       rut_cliente                  ,
       codigo_rut                   ,
       correlativo
  into #TESORERIA
  from GEN_OPERACIONES
 where GEN_OPERACIONES.fecha_pago = @fecha_operacion
   and GEN_OPERACIONES.id_sistema = @id_sistema
   and (@tipo_operacion = '' or @tipo_operacion = GEN_OPERACIONES.tipo_operacion)
   and (@operacion      =  0 or @operacion      = GEN_OPERACIONES.operacion)
update #TESORERIA set glosa_operacion = VIEW_MOVIMIENTO_CNT.glosa_operacion
                 from VIEW_MOVIMIENTO_CNT
                where #TESORERIA.tipo_operacion = VIEW_MOVIMIENTO_CNT.tipo_operacion
update #TESORERIA set cliente = VIEW_CLIENTE.clnombre
                 from VIEW_CLIENTE VIEW_CLIENTE
                where #TESORERIA.rut_cliente = VIEW_CLIENTE.clrut
                  and #TESORERIA.codigo_rut  = VIEW_CLIENTE.clcodigo
update #TESORERIA set glosa_pago = MDFP.glosa
                 from VIEW_FORMA_DE_PAGO MDFP
                where #TESORERIA.forma_pago = ltrim(str(MDFP.codigo))
select cerrada                              ,
       tipo_operacion                       ,
       operacion                            ,
       cliente                              ,
       monto_operacion                      ,
       moneda                               ,
       convert(char(10),fecha_operacion,103),
       forma_pago                           ,
       retiro                               ,
       situacion                            ,
       glosa_pago                           ,
       glosa_operacion                      ,
       correlativo
 from #TESORERIA order by operacion
end   /* fin procedimiento */

GO
