USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Limpia_Resultado_Contable]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Limpia_Resultado_Contable]
	(	@Fecha	datetime	)
AS
BEGIN

	declare @rows_deleted	int,
			@total_rows		int,
			@onError		int,
			@str			varchar(250)

	select	@rows_deleted	= 0
	select	@onError		= 0

	SET ARITHABORT OFF

	select @total_rows = (select count(*) from Resultado_Contable where fecha_proceso < @fecha)

	while @total_rows > @rows_deleted
	begin
 
		set rowcount 10000
		BEGIN TRANSACTION
  
		delete Resultado_Contable where fecha_proceso < @fecha
		select @rows_deleted = @rows_deleted + @@rowcount

		if @@error <> 0
		begin
			select @onError = 1
			goto Salida
		end else
		begin
			COMMIT TRANSACTION
			--Dump Transaction MdParPasivo With NO_LOG 
		end
	end

Salida:

	if @onError = 1
	begin
		RAISERROR('¡ Error al intentar limpiar la base.... ! ',16,6,'ERROR.')
		ROLLBACK TRANSACTION
		RETURN 
	end else
	begin
		select 1, @rows_deleted
	end

	SET ARITHABORT ON

end
GO
