USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_BuscaSubproducto]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_BuscaSubproducto]
(@iCodigo_Producto CHAR(5))
AS
BEGIN
	SET NOCOUNT ON
        SET DATEFORMAT dmy
	IF EXISTS (SELECT 1 FROM SUBPRODUCTO) BEGIN
		SELECT 	Codigo_Subproducto,
			Descripcion,
			Id_sistema
		 FROM SUBPRODUCTO 
		 WHERE Gestion = 'N'	
		 AND   codigo_producto = @iCodigo_Producto
		 ORDER BY Descripcion
	END
	ELSE BEGIN
		SELECT "NO TIENE"
	END
	SET NOCOUNT OFF	
END

GO
