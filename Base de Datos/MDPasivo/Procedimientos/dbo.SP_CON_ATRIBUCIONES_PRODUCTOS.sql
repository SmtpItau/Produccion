USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_ATRIBUCIONES_PRODUCTOS]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CON_ATRIBUCIONES_PRODUCTOS]
		(
		@Tipo_Usuario	CHAR(15),
		@Id_Sistema	CHAR(03),
		@Codigo_Producto CHAR(05),
		@InCodigo	NUMERIC(05),
		@moneda		NUMERIC(03)
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
		Codigo_Producto	= @Codigo_Producto	AND
		moneda		= @moneda	AND
		InCodigo	= @InCodigo


SET NOCOUNT ON
END








GO
