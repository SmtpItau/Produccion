USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_VCTO_TESORERIA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_VCTO_TESORERIA]( @fecha_hoy datetime ,
                                     @moneda    char(5)  ,
         @estado    char(1) )
as 
begin
set nocount on
create table #VCTO( glosa       char(40)    null default '' ,
                    operacion   numeric(10) null default  0 ,
                    cliente     char(50)    null default '' ,
                    moneda      char(5)     null default '' ,
                    monto       float       null default  0 ,
                    accion      char(10)    null default '' ,
                    id_sistema  char(3)     null default '' ,
                    correlativo numeric(5)  null default  0 ,
                    forma_pago  char(4)     null default '' )
/* ========================================================================== */
/* compras arbitrajes                                                         */
/* ========================================================================== */
insert #VCTO( glosa,
              operacion,
              cliente,
              moneda,
              monto,
              accion,
              id_sistema,
              correlativo,
              forma_pago )
       select glosa_operacion,
              operacion,
              clnombre,
              moneda_mx,
              monto_mx,
              'RECIBIR',
              GEN_OPERACIONES.id_sistema,
              correlativo,
              forma_pago_mx
         from GEN_OPERACIONES, VIEW_MOVIMIENTO_CNT, VIEW_CLIENTE VIEW_CLIENTE
        where fecha_vcto_mx = @fecha_hoy 
          and GEN_OPERACIONES.tipo_operacion  = VIEW_MOVIMIENTO_CNT.tipo_operacion
          and GEN_OPERACIONES.rut_cliente     = VIEW_CLIENTE.clrut
          and GEN_OPERACIONES.codigo_rut      = VIEW_CLIENTE.clcodigo
          and GEN_OPERACIONES.liq_settle      = @estado
          and GEN_OPERACIONES.tipo_movimiento = 'C'
          and GEN_OPERACIONES.id_sistema      = 'BCC'
          and GEN_OPERACIONES.cerrada         = 'S'
          and GEN_OPERACIONES.tipo_operacion  = 'AMC'
/* ========================================================================== */
/* ventas arbitrajes                                                          */
/* ========================================================================== */
insert #VCTO( glosa,
              operacion,
              cliente,
              moneda,
              monto,
              accion,
              id_sistema,
              correlativo,
              forma_pago )
       select glosa_operacion,
              operacion,
              clnombre,
              moneda,
              monto_operacion,
              'RECIBIR',
              GEN_OPERACIONES.id_sistema,
              correlativo,
              forma_pago
         from GEN_OPERACIONES, VIEW_MOVIMIENTO_CNT, VIEW_CLIENTE VIEW_CLIENTE
        where fecha_vencimiento = @fecha_hoy 
          and GEN_OPERACIONES.tipo_operacion  = VIEW_MOVIMIENTO_CNT.tipo_operacion
          and GEN_OPERACIONES.rut_cliente     = VIEW_CLIENTE.clrut
          and GEN_OPERACIONES.codigo_rut      = VIEW_CLIENTE.clcodigo
          and GEN_OPERACIONES.liq_settle      = @estado
          and GEN_OPERACIONES.tipo_movimiento = 'A'
          and GEN_OPERACIONES.id_sistema      = 'BCC'
          and GEN_OPERACIONES.cerrada         = 'S'
          and GEN_OPERACIONES.tipo_operacion  = 'AMV'
/* ========================================================================== */
/* usd (compras y ventas trader)                                              */
/* ========================================================================== */
insert #VCTO( glosa,
              operacion,
              cliente,
              moneda,
              monto,
              accion,
              id_sistema,
              correlativo,
              forma_pago )
       select glosa_operacion,
              operacion,
              clnombre,
              moneda,
              monto_operacion,
              'RECIBIR',
              GEN_OPERACIONES.id_sistema,
              correlativo,
              forma_pago
         from GEN_OPERACIONES, VIEW_MOVIMIENTO_CNT, VIEW_CLIENTE VIEW_CLIENTE
        where fecha_vencimiento = @fecha_hoy 
          and GEN_OPERACIONES.tipo_operacion  = VIEW_MOVIMIENTO_CNT.tipo_operacion
          and GEN_OPERACIONES.rut_cliente     = VIEW_CLIENTE.clrut
          and GEN_OPERACIONES.codigo_rut      = VIEW_CLIENTE.clcodigo
          and GEN_OPERACIONES.liq_settle      = @estado
          and GEN_OPERACIONES.id_sistema      = 'BTR'
          and GEN_OPERACIONES.tipo_operacion <> 'ICO'
          and GEN_OPERACIONES.cerrada         = 'S'
          and GEN_OPERACIONES.moneda         <> '$$' or GEN_OPERACIONES.moneda ='CLP' --o clp
/* ========================================================================== */
/* usd (compras spot y empresas)                                              */
/* ========================================================================== */
insert #VCTO( glosa,
              operacion,
              cliente,
              moneda,
              monto,
              accion,
              id_sistema,
              correlativo,
              forma_pago )
       select glosa_operacion,
              operacion,
              clnombre,
              moneda_mx,
              monto_mx,
              'RECIBIR',
              GEN_OPERACIONES.id_sistema,
              correlativo,
              forma_pago_mx
         from GEN_OPERACIONES, VIEW_MOVIMIENTO_CNT, VIEW_CLIENTE VIEW_CLIENTE
        where fecha_vcto_mx = @fecha_hoy 
          and GEN_OPERACIONES.tipo_operacion  = VIEW_MOVIMIENTO_CNT.tipo_operacion
          and GEN_OPERACIONES.rut_cliente     = VIEW_CLIENTE.clrut
          and GEN_OPERACIONES.codigo_rut      = VIEW_CLIENTE.clcodigo
          and GEN_OPERACIONES.liq_settle      = @estado
          and GEN_OPERACIONES.tipo_movimiento = 'C'
          and GEN_OPERACIONES.id_sistema      = 'BCC'
          and (GEN_OPERACIONES.tipo_operacion <> 'AMC' and GEN_OPERACIONES.tipo_operacion <> 'AMV')
          and GEN_OPERACIONES.cerrada         = 'S'
select * from #VCTO 
 where (@moneda = '' or @moneda = moneda)
 order by accion, moneda
 
return 0
 
end   /* fin procedimiento */


GO
