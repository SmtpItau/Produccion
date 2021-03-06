USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PAGOS_SETTLEMENT]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PAGOS_SETTLEMENT]( @sistema     char(3)     ,
                                       @operacion   numeric(10) ,
                                       @correlativo numeric(5)  ,
                                       @moneda      char(5)     ,
                                       @forma_pago  char(4)     ,
                                       @accion      char(1)     ,
                                       @monto       float       ,
           @estado      char(1) )
as
begin
declare @retorno      integer     ,
        @codmoneda    numeric(4)  ,
        @telex_hoy    numeric(3)  ,
        @rut_cliente  numeric(10) ,
        @codigo_rut   numeric(5)  ,
        @moneda_op    char(5)     ,
        @monto_op     float
select @retorno = 0
select @rut_cliente = rut_cliente,
       @codigo_rut  = codigo_rut,
       @moneda_op   = moneda,
       @monto_op    = monto_operacion
  from GEN_OPERACIONES
 where id_sistema  = @sistema
   and operacion   = @operacion
   and correlativo = @correlativo
update GEN_OPERACIONES
   set liq_settle  = @estado
 where id_sistema  = @sistema
   and operacion   = @operacion
   and correlativo = @correlativo
if @@error <> 0
   select @retorno = 1
else
begin
   select @telex_hoy = folio from GEN_FOLIOS where codigo = 'TELEX_HOY'
   if (@moneda <> '$$' or @moneda='CLP') and convert(numeric(3),@forma_pago) <> @telex_hoy and @sistema <> 'BTR'--O clp
   begin
      select @codmoneda = mncodmon from VIEW_MONEDA  where mnnemo = @moneda
      insert GEN_RECEPCION_PAGOS( tipo_operacion,
                                  operacion,
                                  correlativo,
                                  moneda,
                                  monto,
                                  forma_pago )
                          values( (case when @accion = 'r' then 'trac' else 'trav' end),
                                  @operacion,
                                  @correlativo,
                                  @codmoneda,                                
                                  @monto,
                                  @forma_pago )
      if @@error <> 0
         select @retorno = 1
   end
end
/* libera monto ocupado de lineas settlement ------------------------------- */
if @estado = 'S'
   update MD_SETTLEMENT 
      set dia0_ocupado = dia0_ocupado - (case when @moneda <> 'USD' then @monto_op else @monto end)
    where rut       = @rut_cliente
      and codigo    = @codigo_rut
      and productos = @sistema
else
begin
   delete GEN_RECEPCION_PAGOS 
    where tipo_operacion = (case when @accion = 'R' then 'TRAC' else 'TRAV' end)
      and operacion      = @operacion
      and correlativo    = @correlativo
   if @@error <> 0
      select @retorno = 1
   update MD_SETTLEMENT 
      set dia0_ocupado = dia0_ocupado + (case when @moneda <> 'usd' then @monto_op else @monto end)
    where rut       = @rut_cliente
      and codigo    = @codigo_rut
      and productos = @sistema
end
if @@error <> 0
   select @retorno = 1
select @retorno 
end   /* fin procedimiento */
--select * from gen_operaciones
--select * from gen_pagos_operacion

GO
