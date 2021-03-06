USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_PERFIL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINA_PERFIL]
         (@folio_perfil     numeric(9))
as 
begin
      
      set nocount off
   declare @control_error  integer
   begin transaction
   select @control_error = 0
   delete VIEW_PERFIL_CNT where    folio_perfil    = @folio_perfil
if @@error <> 0
begin
   set nocount off
   select @control_error = 1
   PRINT 'ERROR_PROC FALLA ELIMINACION DE PERFIL.'
   goto fin_procedimiento
end
delete VIEW_PERFIL_DETALLE_CNT where folio_perfil = @folio_perfil
if @@error <> 0
begin
   set nocount off
   select @control_error = 1
   PRINT 'ERROR_PROC FALLA ELIMINACION DE DETALLE PERFIL.'
   goto fin_procedimiento
end
delete  VIEW_PERFIL_VARIABLE_CNT where folio_perfil = @folio_perfil
if @@error <> 0
begin
   set nocount off
   select @control_error = 1
   PRINT 'ERROR_PROC FALLA ELIMINACION DE DETALLE PERFIL VARIABLE.'
end
fin_procedimiento:
if @control_error = 0 begin
   set nocount off
   select 'OK'
   commit
end
else
   begin
   
   set nocount off
   select 'ERR'
   rollback
end
return @control_error
end   /* fin procedimiento */

GO
