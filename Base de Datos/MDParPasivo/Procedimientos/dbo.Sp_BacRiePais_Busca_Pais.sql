USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacRiePais_Busca_Pais]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacRiePais_Busca_Pais] ( @nombre   CHAR(50))


AS

BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	IF EXISTS (SELECT 1 FROM PAIS WHERE nombre = @nombre) BEGIN

		SELECT 	codigo_pais,
			nombre

 			FROM PAIS WHERE nombre = @nombre

	END

	ELSE BEGIN

		SELECT "ERROR"

	END

	SET NOCOUNT OFF

END















GO
