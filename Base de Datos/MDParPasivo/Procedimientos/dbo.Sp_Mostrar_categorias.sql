USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_categorias]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Mostrar_categorias]
	( @codigo_categoria CHAR(1)='')
AS
BEGIN

   SET DATEFORMAT dmy

	IF @codigo_categoria ='' BEGIN
	   SELECT codigo_carterasuper, nombre_carterasuper FROM CATEGORIA_CARTERASUPER ORDER BY codigo_carterasuper
	END
	ELSE BEGIN
	   SELECT codigo_carterasuper, nombre_carterasuper FROM CATEGORIA_CARTERASUPER 
		WHERE codigo_carterasuper = @codigo_categoria
			ORDER BY codigo_carterasuper
	END
END






GO
