USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Pais]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_Mostrar_Pais]
	( @codigo_pais CHAR(5)='')
AS
BEGIN

   SET DATEFORMAT dmy

	IF @codigo_pais ='' 
	BEGIN
		SELECT codigo_pais, nombre, codigo_pais_super,codigo_pais_Espana FROM PAIS ORDER BY nombre
	END
	ELSE 
	BEGIN
		SELECT codigo_pais, nombre, codigo_pais_super,codigo_pais_Espana FROM PAIS
		WHERE codigo_pais = @codigo_pais
		ORDER BY nombre
	END
END


GO
