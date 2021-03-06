USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_GRUPOPRODUCTO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_GRUPOPRODUCTO]
	(	
		@accion	INTEGER	= 0	,
		@grupo	CHAR(5)	= ' '
		
	)
AS
BEGIN
	
	SET NOCOUNT ON

	IF @accion = 0
		BEGIN

			SELECT DISTINCT
				Codigo_Grupo	,
				Glosa_Grupo	
			FROM 	GRUPO_PRODUCTO
		END
	ELSE
		BEGIN
			SELECT	Codigo_Grupo	,
				Id_Sistema	,
				Codigo_Producto	,
				Glosa_Grupo              
			FROM 	GRUPO_PRODUCTO
			WHERE	@grupo = Codigo_Grupo 
		END

	SET NOCOUNT OFF

END

GO
