USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Subproducto]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Trae_Subproducto]
			( @Producto 	char(05)
			, @Sistema	Char(03) )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	SELECT Codigo_Subproducto, Descripcion, Id_Sistema FROM SUBPRODUCTO 
	WHERE 	Codigo_Producto = @Producto
	AND	Id_Sistema	= @Sistema


END


GO
