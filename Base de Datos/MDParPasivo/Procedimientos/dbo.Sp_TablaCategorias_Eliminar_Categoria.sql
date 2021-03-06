USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaCategorias_Eliminar_Categoria]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaCategorias_Eliminar_Categoria](@codigo_cartera CHAR (01))AS 
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF EXISTS(SELECT codigo_carterasuper FROM CATEGORIA_CARTERASUPER  WHERE	codigo_carterasuper	= @codigo_cartera)
   BEGIN

	-- ESTA TABLA SE VA A ELIMINAR

	   IF EXISTS(SELECT 1 FROM PRODUCTO_CUENTA WHERE codigo_carterasuper = @codigo_cartera  )

		SELECT 'RELACIONADA'

	   ELSE

		DELETE CATEGORIA_CARTERASUPER WHERE	codigo_carterasuper	= @codigo_cartera
	
   END ELSE BEGIN

	SELECT 'NO EXISTE'

   END

END


GO
