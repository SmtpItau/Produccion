USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacRiePais_Busca]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacRiePais_Busca] ( @codigo   NUMERIC (5),
				       @nombre   CHAR   (50))	

AS
BEGIN
	SET NOCOUNT ON
        SET DATEFORMAT dmy

	IF @codigo <> 0 BEGIN
	
		SELECT 
			codigo_pais,
			nombre
	
			FROM PAIS 
			WHERE codigo_pais = @codigo ORDER BY codigo_pais
	
	END
	
	IF @nombre <> "" BEGIN
	
		SELECT	
			codigo_pais,
			nombre
			
			FROM PAIS WHERE nombre = @nombre ORDER BY nombre
	
	END
	
	SET NOCOUNT OFF
END




GO
