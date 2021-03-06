USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DOCTOS_TESORERIA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_busca_doctos_tesoreria    fecha de la secuencia de comandos: 05/04/2001 13:13:12 ******/
CREATE proc [dbo].[SP_BUSCA_DOCTOS_TESORERIA]( @tipo_canje    char(1)    ,
                                       @fecha_inicio  datetime   ,
                                       @fecha_termino datetime   ,
                                       @codigo_banco  numeric(3) )
as 
begin
declare @vista   char(4),
        @camara  char(4),
        @cheque  char(4)
select @vista  = ltrim(str(folio)) from GEN_FOLIOS where codigo = 'VISTA'
select @camara = ltrim(str(folio)) from GEN_FOLIOS where codigo = 'CAMARA'
select @cheque = ltrim(str(folio)) from GEN_FOLIOS where codigo = 'CHEQUE'
select 'NOMBRE_BANCO' = (case when tipo_canje = 'R' then nombre_cliente else space(40) end),
       a.monto_operacion,
       a.estado,
       a.numero_documento,
       'glosa_pago' = (case when a.forma_pago = '0' then 'DEP. PLAZO' else a.glosa end),
       'fecha_pago' = convert(char(10),a.fecha_pago,103),
       'fecha_cobro' = (case when estado = 'C' then convert(char(10),fecha_cobro,103) else space(10) end),
       codigo_banco,
       tipo_ingreso,
       forma_pago
  into #DOCTOS
  from 
  --  REQ. 7619 
  GEN_PAGOS_OPERACION a  LEFT OUTER JOIN view_forma_de_pago b ON a.forma_pago = ltrim(str(b.codigo))
  --     view_forma_de_pago b
 where a.fecha_pago >= @fecha_inicio
   and a.fecha_pago <= @fecha_termino
   and (@codigo_banco = 0 or a.codigo_banco = @codigo_banco) 
   and a.tipo_canje   = @tipo_canje
--  REQ. 7619
--   and a.forma_pago  *= ltrim(str(b.codigo))
   and a.moneda       = '$$' or a.moneda ='CLP' --o clp
   and a.estado      <> 'N'
   and (a.forma_pago = @vista or a.forma_pago = @camara or a.forma_pago = @cheque)
update #DOCTOS set nombre_banco = clnombre
              from VIEW_CLIENTE
             where codigo_banco  = cod_inst
               and codigo_banco <> 0
               and (@tipo_canje = 'E' or (@tipo_canje = 'R' and charindex(tipo_ingreso,'23') > 0) )
if @tipo_canje = 'R'
   update #DOCTOS set estado = (case 
                                when forma_pago = @camara then '4'
                                when forma_pago <> @camara and charindex(tipo_ingreso,'23') = 0 then '1'
                                else tipo_ingreso
                               end)
select * from #DOCTOS
return 0
end   /* fin procedimiento */


GO
