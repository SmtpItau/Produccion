USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DOCUMENTOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_busca_documentos    fecha de la secuencia de comandos: 05/04/2001 13:13:12 ******/
CREATE PROCEDURE [dbo].[SP_BUSCA_DOCUMENTOS]
          ( @tipo_docto    char(1)    ,
                                 @fecha_inicio  datetime   ,
                                 @fecha_termino datetime   ,
                                 @codigo_banco  numeric(3) )
as 
begin
declare @vista   numeric(3),
        @camara  numeric(3),
        @cheque  numeric(3)
select @vista  = folio from GEN_FOLIOS where codigo = 'VISTA'
select @camara = folio from GEN_FOLIOS where codigo = 'CAMARA'
select @cheque = folio from GEN_FOLIOS where codigo = 'CHEQUE'
select 'NOMBRE_BANCO' = (case when tipo_canje = 'R' then nombre_cliente else space(40) end),
       monto_operacion,
       estado,
       numero_documento,
       'forma_pago' = (case when forma_pago = '0' then 'DEP. PLAZO' else VIEW_FORMA_DE_PAGO.glosa end),
       fecha_pago,
       fecha_cobro,
       codigo_banco
  into #DOCTOS
  from 
--  REQ. 7619
  GEN_PAGOS_OPERACION LEFT OUTER JOIN VIEW_FORMA_DE_PAGO ON forma_pago = ltrim(str(codigo))
-- VIEW_FORMA_DE_PAGO 
 where fecha_pago >= @fecha_inicio
   and fecha_pago <= @fecha_termino
   and (@codigo_banco = 0 or codigo_banco = @codigo_banco) 
   and tipo_canje   = @tipo_docto
--  REQ. 7619
--   and forma_pago  *= ltrim(str(codigo))
   and moneda       = '$$' or moneda='CLP' --o clp
   and (forma_pago = ltrim(str(@vista)) or forma_pago = ltrim(str(@camara)) or forma_pago = ltrim(str(@cheque)))
if @tipo_docto = 'E'
   update #DOCTOS set nombre_banco = VIEW_CLIENTE.clnombre
                 from VIEW_CLIENTE VIEW_CLIENTE
                where codigo_banco  = VIEW_CLIENTE.cod_inst
                  and codigo_banco <> 0
select * from #DOCTOS
return 0
end   /* fin procedimiento */


GO
