USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_PLANILLA_CAMARA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_PLANILLA_CAMARA]
as 
begin
set nocount on
declare @cont           integer    ,
        @regs           integer    ,
        @rut_cliente    numeric(10),
        @monto          float      ,
        @codigo_banco   numeric(3) ,
        @nombre_banco   char(40)   ,
        @vcamara        char(4)    ,
        @bcentral       char(4)    ,
        @depplazo       char(4)    ,
        @cajacon        char(4)    ,
        @fecha_hoy      datetime   ,
        @fecha_ayer     datetime   ,
        @fecha_prox     datetime   ,
        @estado         char(1)    ,
        @tipo_canje     char(1)    ,
        @fecha_pago     datetime   ,
        @camara         char(2)    ,
        @por_cobrar     float      ,
        @por_pagar      float      ,
        @forma_pago     char(4)    ,
        @tipo_ingreso   char(1)
select @vcamara  = convert(char(4),folio) from GEN_FOLIOS where codigo = 'camara'
select @bcentral = convert(char(4),folio) from GEN_FOLIOS where codigo = 'bcentral'
select @depplazo = convert(char(4),folio) from GEN_FOLIOS where codigo = 'ndepositop'
select @cajacon  = convert(char(4),folio) from GEN_FOLIOS where codigo = 'cajacon'
select @fecha_hoy  = acfecproc, 
       @fecha_ayer = acfecante,
       @fecha_prox = acfecprox
  from MDAC
create table #PLANILLA( por_cobrar   float      null default 0 ,
                        codigo       numeric(3) null default 0 ,
                        institucion  char(40)   null default '',
                        por_pagar    float      null default 0 ,
                        camara       char(2)    null default '')
select @regs = count(*) 
  from GEN_PAGOS_OPERACION
 where fecha_pago >= @fecha_ayer
   and moneda      = '$$' or moneda='clp'--o clp
   and forma_pago <> @depplazo
   and forma_pago <> @cajacon
   and estado     <> 'n'
select @cont = 1
while @cont <= @regs 
begin
   set rowcount @cont
   select @rut_cliente  = rut_cliente,
          @monto        = monto_operacion,
          @estado       = estado,
          @tipo_canje   = tipo_canje,
          @fecha_pago   = fecha_pago,
          @codigo_banco = codigo_banco,
          @forma_pago   = forma_pago,
          @tipo_ingreso = tipo_ingreso
     from GEN_PAGOS_OPERACION
    where fecha_pago >= @fecha_ayer
      and moneda      = '$$' or moneda='clp'--o clp
      and forma_pago <> @depplazo
      and forma_pago <> @cajacon
      and estado     <> 'n'
   set rowcount 0
   select @nombre_banco = ''
   select @nombre_banco = isnull(clnombre, '')
     from VIEW_CLIENTE  
    where cod_inst = @codigo_banco
   select @camara = 'no'
   if @fecha_pago = @fecha_ayer and @forma_pago <> @vcamara and @forma_pago <> @bcentral and (@tipo_ingreso = 'a' or @tipo_ingreso = 'm')
   begin
      if @tipo_canje = 'r' and @estado = 'c'
         select @camara = '1c'
      if @tipo_canje = 'e'
         select @camara = '1c'
   end
   if @fecha_pago = @fecha_hoy and (@tipo_ingreso = 'a' or @tipo_ingreso = 'm')
   begin
      if @forma_pago = @vcamara and @forma_pago <> @bcentral
      begin
         if @tipo_canje = 'r' and @estado = 'c'
            select @camara = '4c'
         if @tipo_canje = 'e'
            select @camara = '4c'
      end
      
      if @forma_pago <> @vcamara and @forma_pago <> @bcentral
      begin
         if @tipo_canje = 'e'
            select @camara = '5c'
      end
   end
   if (@tipo_ingreso = '2' or @tipo_ingreso = '3') and @fecha_pago = @fecha_hoy
   begin
      select @camara = @tipo_ingreso + 'c'
   end
   if @camara <> 'no'
   begin
      select @por_cobrar = 0.0
      select @por_pagar  = 0.0
      if @tipo_canje = 'r' 
         select @por_pagar  = @monto
      else
         select @por_cobrar = @monto
      if exists(select * from #PLANILLA where codigo = @codigo_banco and camara = @camara)
     
         update #PLANILLA set por_pagar  = por_pagar  + @por_pagar,
   por_cobrar = por_cobrar + @por_cobrar
          where codigo = @codigo_banco
            and camara = @camara
      else
         insert #PLANILLA( por_cobrar,
                           por_pagar,
                           codigo,
                           institucion,
                           camara )
                   values( @por_cobrar,
                           @por_pagar,
                           @codigo_banco,
                           @nombre_banco,
                           @camara )
   end
   select @cont = @cont + 1
end
select @regs = count(*) from #PLANILLA
if @regs = 0
   insert #PLANILLA values( 0, 0, '', 0, '5c' )
select codigo,
       institucion,
       por_cobrar,
       por_pagar,
       MDAC.acnomprop,
       '052',
       (case camara 
        when '1c' then '1a camara ' + convert(char(10),@fecha_hoy,103)
        when '2c' then '2a camara ' + convert(char(10),@fecha_hoy,103)
        when '3c' then '3a camara ' + convert(char(10),@fecha_hoy,103)
        when '4c' then '4a camara ' + convert(char(10),@fecha_hoy,103)
        when '5c' then '1a camara ' + convert(char(10),@fecha_prox,103)
       end),
       camara
  from #PLANILLA,
       MDAC
 order by camara
return 0
end   /* fin procedimiento */
--select * from gen_pagos_operacion


GO
