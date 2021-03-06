USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_MATRIZ_ATRIBUCION_PRODUCTOS]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_MATRIZ_ATRIBUCION_PRODUCTOS]
		(
		@tipo_usuario		CHAR	(15),
		@Id_Sistema		CHAR	(03),
		@Codigo_Producto	CHAR	(05),
		@Plazo_Desde		NUMERIC	(05),
		@Plazo_Hasta		NUMERIC	(05),
		@MontoInicio		NUMERIC	(19,4),
		@MontoFinal		NUMERIC	(19,4),
		@InCodigo		NUMERIC	(05),
		@Moneda			NUMERIC	(03)=0
		)
AS BEGIN 
SET NOCOUNT ON
SET DATEFORMAT dmy
		INSERT INTO MATRIZ_ATRIBUCION
			(
			tipo_usuario	,
			Id_Sistema	,
			Codigo_Producto	,
			Plazo_Desde	,
			Plazo_Hasta	,
			MontoInicio	,
			MontoFinal	,
			Moneda		,
			InCodigo
			)
		VALUES
			(
			@tipo_usuario	,
			@Id_Sistema	,
			@Codigo_Producto,
			@Plazo_Desde	,
			@Plazo_Hasta	,
			@MontoInicio	,
			@MontoFinal	,
			@Moneda		,
			@InCodigo
			)
SET NOCOUNT OFF
END





GO
