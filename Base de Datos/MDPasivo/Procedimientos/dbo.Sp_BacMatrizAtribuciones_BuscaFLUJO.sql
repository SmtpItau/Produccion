USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMatrizAtribuciones_BuscaFLUJO]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacMatrizAtribuciones_BuscaFLUJO]
		(
		@Tipo_Usuario	CHAR(15),
		@Id_Sistema	CHAR(03),
		@Codigo_Producto CHAR(05)
		)

AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	SELECT DISTINCT	'DESDE'	= plazo_desde	,
			'HASTA'	= plazo_hasta	,
			'MONTO_INICIO'= montoinicio	,
			'MONTO_FINAL'	= montofinal
	FROM	MATRIZ_ATRIBUCION
	WHERE	Tipo_Usuario	= @Tipo_Usuario	AND
		Id_Sistema	= @Id_Sistema	AND
		Codigo_Producto	= @Codigo_Producto

SET NOCOUNT ON
END



GO
