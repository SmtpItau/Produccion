USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Limpia_Contabiliza_Mayor]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Limpia_Contabiliza_Mayor]
(@Fecha datetime)
as
begin
declare
@rows_deleted  int,
@total_rows  int,
@onError  int,
@str   varchar(250)
select @rows_deleted = 0
select @onError = 0
SET ARITHABORT OFF
 select @total_rows = (select count(*) from contabiliza_mayor where fecha < @fecha)
 while @total_rows > @rows_deleted
 begin
  set rowcount 10000
  BEGIN TRANSACTION
  delete contabiliza_mayor where fecha < @fecha
  select @rows_deleted = @rows_deleted + @@rowcount
  if @@error <> 0
  begin
   select @onError = 1
   goto Salida
  end
  else
  begin
   COMMIT TRANSACTION
   --> Dump Transaction PARAMETROS With NO_LOG 
  end
 end
Salida:
 if @onError = 1
 begin
  RAISERROR('¡ Error al Limpiar la base.... ! ',16,6,'ERROR.')
  --RAISERROR 20000 'Problemas al limpiar la BASE'
  ROLLBACK TRANSACTION
  RETURN 
 end
 else
 begin
  select 1, @rows_deleted
 end
SET ARITHABORT ON
end
GO
