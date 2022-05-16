USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_GRUPOPRODUCTO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELI_GRUPOPRODUCTO]
	(			
		@grupo	CHAR(5)
	)
AS
BEGIN
	
	SET NOCOUNT ON

	DELETE	GRUPO_PRODUCTO
	WHERE	@grupo = Codigo_Grupo 

	SET NOCOUNT OFF

END

GO
