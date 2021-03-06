USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntmp_Producto]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_BacMntmp_Producto] 
					( 
					@sistema CHAR(3)
					)

AS

BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	IF EXISTS(SELECT 1 FROM PRODUCTO WHERE id_sistema = @sistema ) BEGIN
		SELECT 	codigo_producto,
			descripcion,
			id_sistema
 			
			FROM PRODUCTO
			WHERE id_sistema = @sistema
			ORDER BY descripcion 
	END
	ELSE BEGIN
		
		SELECT "ERROR"
	END

	SET NOCOUNT ON
END






GO
