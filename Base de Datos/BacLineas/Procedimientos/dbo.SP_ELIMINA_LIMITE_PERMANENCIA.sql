USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_LIMITE_PERMANENCIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_LIMITE_PERMANENCIA]
	(	@nId	numeric(21)	)
AS
BEGIN

	DELETE FROM BacLineas.dbo.MENSAJES_LIMITE_PERMANENCIA 
		  WHERE nIdRelacion = @nId

	if @@error <> 0
	begin
		select -1, 'Error'
	end else
	begin
		select 0, 'Ok'
	end

END
GO
