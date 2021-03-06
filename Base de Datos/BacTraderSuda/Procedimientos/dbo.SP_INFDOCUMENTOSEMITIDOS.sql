USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFDOCUMENTOSEMITIDOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado DBO.SP_INFDOCUMENTOSEMITIDOS    fecha de la secuencia de comandos: 05/04/2001 13:13:31 ******/
CREATE PROCEDURE [dbo].[SP_INFDOCUMENTOSEMITIDOS]( @correla_interno  numeric(10) ,
        @fecha_inicio     datetime    ,
        @fecha_termino    datetime    ,
        @criterio         char   (1)  )
as
begin
set nocount on
declare @folio_inicio numeric(19)
declare @folio_actual numeric(19)
declare @folio_termino numeric(19)
declare @estado  char(10)
declare @emitidos numeric(5)
declare @anulados numeric(5)
declare @no_emitidos numeric(5)
 
create table #DOCUMENTOSEMITIDOS( correla_interno numeric(10) null default 0 ,
      folio_inicio  numeric(10) null default 0 ,
      folio_docto   numeric(10) null default 0 ,
      folio_termino  numeric(10) null default 0 ,
      numero_operacion numeric(10) null default 0 ,
      tipo_operacion char(20) null default '',
      nombre_cliente char(50) null default '',
      estado  char(15) null default '',
      estado_folio  char(15) null default '',
      fecha_pago  char(10) null default '',
      forma_pago  char(30) null default '')
 
if @criterio = 'c'
begin
select @folio_inicio = folio_inicio  ,
 @folio_termino = folio_termino   ,
 @estado  = case estado 
    when 'A' then 'OCUPADO'
         when 'N'    then 'NULO'
         when 'C'    then 'CERRADO'
        else          'DISPONIBLE'
    end
 from BAC_TESORERIA_FOLIOS 
 where correla_interno = @correla_interno
 order by correla_interno
insert #DOCUMENTOSEMITIDOS( correla_interno   ,
    folio_inicio   ,
    folio_docto   ,
    folio_termino   ,
    numero_operacion  ,
    tipo_operacion   ,
    nombre_cliente   ,
    estado    ,
    estado_folio   ,
    fecha_pago   ,
    forma_pago   )
 select @correla_interno   ,
  @folio_inicio    ,
  gen_pagos_operacion.numero_documento ,
  @folio_termino    ,
  gen_pagos_operacion.operacion  ,
  view_movimiento_cnt.glosa_operacion ,
  nombre_cliente    ,
  case estado  when 'N' then 'NULO'
        when 'A' then ' ' 
        else ' '      
  end     ,
  @estado     ,
  convert(char(10),gen_pagos_operacion.fecha_pago,103),
  (case when forma_pago = '0' then 'DEP. PLAZO' else mdfp.glosa end)
 from
      --  REQ. 7619
      GEN_PAGOS_OPERACION  LEFT OUTER JOIN VIEW_FORMA_DE_PAGO mdfp ON gen_pagos_operacion.forma_pago = ltrim(str(mdfp.codigo))
    , VIEW_MOVIMIENTO_CNT
--  REQ. 7619  
--  , VIEW_FORMA_DE_PAGO mdfp
 where gen_pagos_operacion.numero_documento >= @folio_inicio   and
       gen_pagos_operacion.numero_documento <= @folio_termino   and
       gen_pagos_operacion.tipo_operacion    = view_movimiento_cnt.tipo_operacion and
       gen_pagos_operacion.tipo_canje        = 'R'    and
--  REQ. 7619
--     gen_pagos_operacion.forma_pago       *= ltrim(str(mdfp.codigo))  and
       (gen_pagos_operacion.tipo_ingreso = 'A' or gen_pagos_operacion.tipo_ingreso = 'M')
        
end
else
begin
insert #DOCUMENTOSEMITIDOS( correla_interno   ,
    folio_inicio   ,
    folio_docto   ,
    folio_termino   ,
    numero_operacion  ,
    tipo_operacion   ,
    nombre_cliente   ,
    estado    ,
    estado_folio   ,
    fecha_pago   ,
    forma_pago   )
 select a.correla_interno    ,
  a.folio_inicio     ,
  gen_pagos_operacion.numero_documento ,
  a.folio_termino    ,
  gen_pagos_operacion.operacion  ,
  view_movimiento_cnt.glosa_operacion ,
  nombre_cliente    ,
  case gen_pagos_operacion.estado  when 'N' then 'NULO'
        when 'A' then ' ' 
        else ' '      
    end   ,
  (case a.estado  when 'A' then 'OCUPADO'
    when 'N'    then 'NULO'
         when 'C'    then 'CERRADO'
    else          'DISPONIBLE'
    end)             ,
  convert(char(10),gen_pagos_operacion.fecha_pago,103),
  (case when forma_pago = '0' then 'DEP. PLAZO' else mdfp.glosa end)
 from --  REQ. 7619
      GEN_PAGOS_OPERACION LEFT OUTER JOIN VIEW_FORMA_DE_PAGO mdfp ON gen_pagos_operacion.forma_pago  = ltrim(str(mdfp.codigo))
    , VIEW_MOVIMIENTO_CNT
--  REQ. 7619
--    , VIEW_FORMA_DE_PAGO mdfp
    , BAC_TESORERIA_FOLIOS a
 where gen_pagos_operacion.fecha_pago >= @fecha_inicio and gen_pagos_operacion.fecha_pago <= @fecha_termino and
       gen_pagos_operacion.tipo_operacion    = view_movimiento_cnt.tipo_operacion and
       gen_pagos_operacion.tipo_canje        = 'R'    and
--  REQ. 7619
--       gen_pagos_operacion.forma_pago       *= ltrim(str(mdfp.codigo))  and
       (gen_pagos_operacion.tipo_ingreso = 'A' or gen_pagos_operacion.tipo_ingreso = 'M') and
       (gen_pagos_operacion.numero_documento >= a.folio_inicio  and gen_pagos_operacion.numero_documento <= (a.folio_termino)) 
 
  select distinct @folio_inicio = bac_tesoreria_folios.folio_inicio,@folio_termino = bac_tesoreria_folios.folio_termino  from #documentosemitidos, bac_tesoreria_folios where #documentosemitidos.correla_interno = bac_tesoreria_folios.correla_interno and bac_tesoreria_folios.estado = 'a'
  
                                            
end
select @emitidos    = count(*) from #DOCUMENTOSEMITIDOS
select @anulados    = count(*) from #DOCUMENTOSEMITIDOS where estado = 'NULO'
select @no_emitidos = @folio_termino - (@folio_inicio + @emitidos)
select *, @emitidos, @anulados, @no_emitidos from #DOCUMENTOSEMITIDOS order by folio_docto
end   /* fin procedimiento */
-- select * from bac_tesoreria_folios
-- sp_infdocumentosemitidos 3,'20000926','20000930','f'
  
-- select * from bac_tesoreria_folios
-- select * from gen_pagos_operacion where tipo_canje = 'r' order by numero_documento 
-- select * from gen_pagos_operacion



GO
