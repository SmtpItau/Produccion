USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_MOVIMIENTO_BANCOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_MOVIMIENTO_BANCOS] ( @folio      numeric(10) ,
                                         @fecha_hoy  datetime    )
as 
begin
declare @cuenta_origen char(15) ,
        @banco_origen  char(50) ,
        @nombre_banco  char(40)
select @cuenta_origen = cuenta_corta,
       @banco_origen  = MECC.cclbanco
  from GEN_MOVIMIENTO_CTA_CTE,
       MECC
 where operacion    = @folio
   and tipo_ingreso = 'M'
   and cuenta_corta = MECC.cclctacorta
select @nombre_banco = isnull(b.clnombre,'')
  from GEN_PAGOS_OPERACION a,
       VIEW_CLIENTE b
 where a.operacion    = @folio
   and a.fecha_pago   = @fecha_hoy
   and a.codigo_banco = b.cod_inst
   and a.codigo_banco > 0
   and a.tipo_ingreso = 'M'
select 'cuenta_destino' = '-',
       'cuenta_origen'  = isnull(@cuenta_origen,'-'),
       a.tipo_operacion,
       numero_documento,
       monto_operacion,
       a.glosa,
       forma_pago,
       'banco_destino' = '-',
       'banco_origen'  = isnull(@banco_origen,'-'),
       b.glosa_operacion,
       c.glosa,
       nombre_cliente,
       codigo_banco,
       'nombre_banco' = isnull(@nombre_banco,''),
       rut_cliente,
       estado
  from GEN_PAGOS_OPERACION a,
       VIEW_MOVIMIENTO_CNT b,
       VIEW_FORMA_DE_PAGO c
 where a.operacion      = @folio
   and a.fecha_pago     = @fecha_hoy
   and a.tipo_operacion = b.tipo_operacion
   and a.forma_pago     = convert(char(4),c.codigo)
   and a.tipo_ingreso   = 'M'
end   /* fin procedimiento */


GO
