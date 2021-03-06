USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntcr_BuscaProducto]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_BacMntcr_BuscaProducto]
AS
BEGIN
	SET NOCOUNT ON
        SET DATEFORMAT dmy
	IF EXISTS (SELECT 1 FROM PRODUCTO) BEGIN
		SELECT 	codigo_producto,
			descripcion,
			id_sistema
			 FROM PRODUCTO 
			 WHERE GESTION = 'N'	
			 ORDER BY descripcion
	END
	ELSE BEGIN
		SELECT "ERROR"
	END
	SET NOCOUNT OFF
END

GO
