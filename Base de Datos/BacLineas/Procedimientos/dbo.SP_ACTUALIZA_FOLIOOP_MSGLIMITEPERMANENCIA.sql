USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_FOLIOOP_MSGLIMITEPERMANENCIA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_FOLIOOP_MSGLIMITEPERMANENCIA]
	(	@nIdRelacion	numeric(21)
	,	@nFolio			numeric(9)
	)
AS
BEGIN

	set nocount on

	if exists( select 1 from dbo.mensajes_limite_permanencia where nIdRelacion = @nIdRelacion )
	begin

		begin transaction

		update	dbo.mensajes_limite_permanencia 
		set		NumOperacion	= @nFolio 
		where	nIdRelacion		= @nIdRelacion

		if @@error <> 0 and @@rowcount > 1
		begin
			rollback transaction
			select -1, 'Error', -1
		end else
		begin
			commit transaction
			select 1, 'Ok', @nIdRelacion
		end

	end else
	begin
		select -1, 'Error', -1
	end

END
GO
