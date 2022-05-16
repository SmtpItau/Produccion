USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacRiePais_Busca_Codigo]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacRiePais_Busca_Codigo] ( @codigo   NUMERIC (5))


AS
BEGIN
	SET NOCOUNT ON
        SET DATEFORMAT dmy

	IF EXISTS (SELECT nombre FROM PAIS WHERE codigo_pais = @codigo) BEGIN
		
		SELECT nombre FROM PAIS WHERE codigo_pais = @codigo

	END

	ELSE BEGIN

		SELECT "ERROR"

	END

	SET NOCOUNT OFF

END













GO
