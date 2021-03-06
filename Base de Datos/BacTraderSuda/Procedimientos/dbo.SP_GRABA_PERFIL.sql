USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PERFIL]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PERFIL]( @crear_perfil           char(1)    ,
                             @folio_original         numeric(10),
                             @sistema                char(3)    ,
                             @tipo_movimiento        char(3)    ,
                             @tipo_operacion         char(3)    ,
                             @codigo_instrumento     char(4)    ,
                             @moneda                 char(4)    ,
                             @tipo_voucher           char(1)    ,
                             @glosa_perfil           char(40)   ,
                             @codigo_campo           numeric(3) ,
                             @movimiento_cuenta      char(1)    ,
                             @perfil_fijo            char(1)    ,
                             @codigo_cuenta          char(15)   ,
                             @correlativo            numeric(10),
                             @codigo_campo_variable  numeric(3) )
as 
begin
   set nocount on
declare @campo         char(30)   ,
        @folio_perfil numeric(10)
if @crear_perfil = 'S' 
begin
   if @folio_original > 0
      select @folio_perfil = @folio_original
   else     
      select @folio_perfil = isnull(max(folio_perfil),0) + 1 from VIEW_PERFIL_CNT
   insert VIEW_PERFIL_CNT(id_sistema   ,
    tipo_movimiento  ,
    tipo_operacion  ,
    folio_perfil   ,
    codigo_instrumento  ,
    moneda_instrumento  ,
    tipo_voucher   ,
    glosa_perfil           )
    values(@sistema               ,
                         @tipo_movimiento       ,
                         @tipo_operacion        , 
                         @folio_perfil          ,
                         @codigo_instrumento    ,
                         @moneda                ,
                         @tipo_voucher          ,
                         @glosa_perfil          ) 
   if @@error <> 0
   begin
      set nocount off
      PRINT 'ERROR_PROC FALLA AGREGANDO PERFIL.'
      SELECT 'ERR'
      return 1
   end
end
else
begin
   select @folio_perfil = folio_perfil 
     from VIEW_PERFIL_CNT
    where id_sistema         = @sistema
      and tipo_movimiento    = @tipo_movimiento
      and tipo_operacion     = @tipo_operacion
      and codigo_instrumento = @codigo_instrumento
      and moneda_instrumento = @moneda
end
select @campo = descripcion_campo 
  from VIEW_CAMPO_CNT
 where id_sistema      = @sistema
   and tipo_movimiento = @tipo_movimiento
   and tipo_operacion  = @tipo_operacion
   and codigo_campo    = @codigo_campo
insert VIEW_PERFIL_DETALLE_CNT ( folio_perfil          ,
    codigo_campo          , 
    tipo_movimiento_cuenta, 
    perfil_fijo           ,
    codigo_cuenta         ,
    correlativo_perfil    ,
    codigo_campo_variable )
                        values( @folio_perfil         ,
                                @codigo_campo         ,
                                @movimiento_cuenta    ,
                                @perfil_fijo          ,
                                @codigo_cuenta        ,
                                @correlativo          ,
                                @codigo_campo_variable)
if @@error <> 0
begin
   set nocount off
   PRINT 'ERROR_PROC FALLA AGREGANDO DETALLE PERFIL.'
   SELECT 'ERR'
   return 1
end
insert into VIEW_PERFIL_VARIABLE_CNT 
select  @folio_perfil ,
 @correlativo ,
 valor  ,
 cuenta  
from 
 VIEW_CNT_PASO 
 where fila = @correlativo
delete VIEW_PASO_CNT where fila =  @correlativo
set nocount off
SELECT 'OK'
return 0
end   /* fin procedimiento */
/*
 select * from paso_cnt
 select * from bac_cnt_campos
 select * from bac_cnt_perfil
 select * from bac_cnt_perfil_detalle
 select * from bac_cnt_perfil_variable
 select * from bac_cnt_paso
 truncate table bac_cnt_perfil
 truncate table bac_cnt_perfil_detalle
 truncate table bac_cnt_perfil_variable
*/

GO
