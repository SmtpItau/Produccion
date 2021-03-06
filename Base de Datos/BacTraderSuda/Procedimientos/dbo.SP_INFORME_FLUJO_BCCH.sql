USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_FLUJO_BCCH]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_FLUJO_BCCH]
as 
begin
set nocount on
declare @regs           integer    ,
        @fecha_hoy      datetime   ,
        @fecha_ayer     datetime   ,
        @vcamara        char(4)    ,
        @bcentral       char(4)    ,
        @depplazo       char(4)    ,
        @cajacon        char(4)    ,
        @saldo_inicio   float      ,
        @saldo_final    float      ,
        @saldo_camara   float
select @fecha_hoy  = acfecproc,
       @fecha_ayer = acfecante
  from MDAC
select @saldo_inicio = saldo_inicio from GEN_SALDO_BCCH
select @vcamara  = convert(char(4),folio) from GEN_FOLIOS where codigo = 'CAMARA'
select @bcentral = convert(char(4),folio) from GEN_FOLIOS where codigo = 'BCENTRAL'
select @depplazo = convert(char(4),folio) from GEN_FOLIOS where codigo = 'NDEPOSITOP'
select @cajacon  = convert(char(4),folio) from GEN_FOLIOS where codigo = 'CAJACON'
create table #FLUJO( camara          numeric(1) null default  0,
                     tipo_documento  char(20)   null default '',
                     recibido        float      null default 0 ,
                     enviado         float      null default 0 )
/* primera camara ------------------------------------------------------------------ */
insert into #FLUJO( camara,
                    tipo_documento,
                    recibido,
                    enviado )
             select 1,
                    mdfp.glosa,
                    (case tipo_canje when 'R' then monto_operacion else 0 end),
                    (case tipo_canje when 'E' then monto_operacion else 0 end)
               from GEN_PAGOS_OPERACION,
                    VIEW_FORMA_DE_PAGO MDFP
              where forma_pago <> @vcamara
                and forma_pago <> @bcentral
                and forma_pago  = ltrim(str(MDFP.codigo))
                and ((tipo_canje = 'R' and fecha_cobro = @fecha_hoy) or (tipo_canje = 'e' and fecha_pago = @fecha_ayer))
                and moneda      = '$$' or moneda='CLP' --o clp
                and (tipo_ingreso = 'A' or tipo_ingreso = 'M')
                and forma_pago <> @depplazo
                and forma_pago <> @cajacon
                and estado     <> 'N'
/* cuarta camara ------------------------------------------------------------------- */
insert into #FLUJO( camara,
                    tipo_documento,
                    recibido,
                    enviado )
             select 4,
                    mdfp.glosa,
                    (case tipo_canje when 'R' then monto_operacion else 0 end),
                    (case tipo_canje when 'E' then monto_operacion else 0 end)
               from GEN_PAGOS_OPERACION,
                    VIEW_FORMA_DE_PAGO MDFP
              where forma_pago  = @vcamara
                and forma_pago <> @bcentral
                and forma_pago  = ltrim(str(MDFP.codigo))
                and ((tipo_canje = 'R' and fecha_cobro = @fecha_hoy) or (tipo_canje = 'E'))
                and fecha_pago  = @fecha_hoy
                and moneda      = '$$' or moneda='CLP' --o clp
                and (tipo_ingreso = 'A' or tipo_ingreso = 'M')
                and forma_pago <> @depplazo
                and forma_pago <> @cajacon
                and estado     <> 'N'
/* segunda y tercera camara -------------------------------------------------------- */
insert into #FLUJO( camara,
                    tipo_documento,
                    recibido,
                    enviado )
             select convert(numeric(1), tipo_ingreso),
                    mdfp.glosa,
                    (case tipo_canje when 'R' then monto_operacion else 0 end),
                    (case tipo_canje when 'E' then monto_operacion else 0 end)
               from GEN_PAGOS_OPERACION,
                    VIEW_FORMA_DE_PAGO MDFP
              where forma_pago  = ltrim(str(MDFP.codigo))
                and fecha_pago  = @fecha_hoy
                and moneda      = '$$' or moneda='CLP'--O clp
                and (tipo_ingreso = '2' or tipo_ingreso = '3')
                and forma_pago <> @depplazo
                and forma_pago <> @cajacon
                and estado     <> 'N'
/* saldo camara -------------------------------------------------------------------- */
select @saldo_camara = (isnull(sum(enviado),0)-isnull(sum(recibido),0))
  from #FLUJO
/* banco central ------------------------------------------------------------------- */
 
insert into #FLUJO( camara,
                    tipo_documento,
                    recibido,
                    enviado )
             select 5,
                    mdfp.glosa,
                    (case tipo_canje when 'r' then monto_operacion else 0 end),
                    (case tipo_canje when 'e' then monto_operacion else 0 end)
               from GEN_PAGOS_OPERACION,
                    VIEW_FORMA_DE_PAGO MDFP
              where forma_pago = @bcentral
                and forma_pago = ltrim(str(MDFP.codigo))
                and fecha_pago = @fecha_hoy
                and moneda     = '$$' or moneda ='clp'--o clp
                and estado    <> 'n'
select @saldo_final = @saldo_inicio + (isnull(sum(enviado),0)-isnull(sum(recibido),0))
  from #FLUJO
update GEN_SALDO_BCCH set saldo_final  = @saldo_final,
                          saldo_camara = @saldo_camara
select @regs = count(*) from #FLUJO
if @regs > 0
   select camara,
          sum(recibido),
          sum(enviado),
          tipo_documento,
          @saldo_inicio,
          @saldo_final
     from #FLUJO
    group by camara, tipo_documento
else
   select 0,
          0.0,
          0.0,
          '',
          @saldo_inicio,
          @saldo_final
return 0
end   /* fin procedimiento */
--sp_informe_flujo_bcch
--select * from gen_saldo_bcch
--select * from gen_pagos_operacion


GO
