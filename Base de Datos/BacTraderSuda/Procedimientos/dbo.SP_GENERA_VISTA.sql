USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_VISTA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GENERA_VISTA]
as
begin
set nocount on
declare @regs   integer ,
        @vista  char(4) ,
        @camara char(4)
create table #VALEVISTA( tipo            char(2)     ,
                         estado          char(1)     ,
                         codigo_cliente  numeric(10) ,
                         sector          numeric(3)  ,
                         monto           float       )
select @vista  = ltrim(str(folio)) from GEN_FOLIOS where codigo = 'VISTA'
select @camara = ltrim(str(folio)) from GEN_FOLIOS where codigo = 'CAMARA'
insert #VALEVISTA( tipo,
                   estado,
                   codigo_cliente,
                   sector,
                   monto )
            select 'VV',
                   'i',
                   VIEW_CLIENTE.clcodfox,
                   VIEW_CLIENTE.clsector,
                   GEN_PAGOS_OPERACION.monto_operacion
              from GEN_PAGOS_OPERACION,
                   VIEW_CLIENTE  VIEW_CLIENTE
             where VIEW_CLIENTE.clrut                      = GEN_PAGOS_OPERACION.rut_cliente
               and VIEW_CLIENTE.clcodigo                   = 1
               and (VIEW_CLIENTE.cltipcli = 1 or VIEW_CLIENTE.cltipcli = 6)
               and GEN_PAGOS_OPERACION.forma_pago  = @vista
               and GEN_PAGOS_OPERACION.tipo_canje  = 'R'
               and GEN_PAGOS_OPERACION.estado      = 'A'
insert #VALEVISTA( tipo,
                   estado,
                   codigo_cliente,
                   sector,
                   monto )
            select 'VC',
                   'I',
                   VIEW_CLIENTE.clcodfox,
                   VIEW_CLIENTE.clsector,
                   GEN_PAGOS_OPERACION.monto_operacion
              from GEN_PAGOS_OPERACION,
                   VIEW_CLIENTE  VIEW_CLIENTE
             where VIEW_CLIENTE.clrut                      = GEN_PAGOS_OPERACION.rut_cliente
               and VIEW_CLIENTE.clcodigo                   = 1
               and (VIEW_CLIENTE.cltipcli = 1 or VIEW_CLIENTE.cltipcli = 6)
               and GEN_PAGOS_OPERACION.forma_pago  = @camara
               and GEN_PAGOS_OPERACION.tipo_canje  = 'R'
               and GEN_PAGOS_OPERACION.estado      = 'A'
/* ======================================================================================= */
/* envia informacion                                                                       */
/* ======================================================================================= */
select @regs = count(*) from #VALEVISTA
set nocount off
select @regs, 
       tipo,
       estado,
       codigo_cliente,
       sector,
       monto  
  from #VALEVISTA
return 0
end   /* fin procedimiento */

GO
