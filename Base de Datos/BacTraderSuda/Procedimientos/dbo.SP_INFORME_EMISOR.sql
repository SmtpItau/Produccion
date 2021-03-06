USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_EMISOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_informe_emisor    fecha de la secuencia de comandos: 05/04/2001 13:13:33 ******/
CREATE PROCEDURE [dbo].[SP_INFORME_EMISOR]
as
begin
set nocount on
select rut,
       b.emnombre,
       (case instrumento 
        when 'FI' then 'FIXED INCOME'
        when 'MM' then 'MONEY MARKET'
        else           'SHORT TERM DEBT'
       end),
       plazo_ini,
       plazo_fin,
       (case when monto_asignado > 0 then monto_asignado/1000.0 else 0 end),
       (case when monto_ocupado > 0 then monto_ocupado/1000.0 else 0 end),
       (case when (monto_asignado-monto_ocupado) <> 0 then (monto_asignado-monto_ocupado)/1000.0 else 0 end),
       rtrim(isnull(clcrf,''))+ '/' +rtrim(isnull(clerf,''))
  from MD_EMISOR_INST_PLAZO a,
--  REQ. 7619
       VIEW_EMISOR b LEFT OUTER JOIN VIEW_CLIENTE c ON b.emrut = c.clrut
       -- VIEW_CLIENTE  c
 where rut = b.emrut 
--  REQ. 7619
--- and  b.emrut *= c.clrut
 order by rut,
          instrumento,
          plazo_ini,
          plazo_fin
end   /* fin procedimiento */
--sp_informe_emisor
--select * from VIEW_CLIENTE
--select * from VIEW_CLIENTE_relacion
--select * from MDEM


GO
