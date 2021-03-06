USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TcLeeCodigos1]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TcLeeCodigos1]	(
					@tccodtab1	NUMERIC	(03,0),
                                        @id_sistema     CHAR(3) = 'BTR'
					)

AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON


	IF @tccodtab1=1

           PRINT 'MAL'

	ELSE
		IF @tccodtab1 = 216 
		BEGIN
			SELECT	codigo	,
				glosa
			FROM	PERIODO_AMORTIZACION
			WHERE	sistema = @id_sistema
			ORDER BY codigo
		END


		IF @tccodtab1 = 217
		BEGIN
			SELECT Codigo_Tipo_Moneda	,
				Descripcion
			FROM	MONEDA_TIPO
			ORDER BY Codigo_Tipo_Moneda
		END


		IF @tccodtab1 = 219
		BEGIN
			SELECT Codigo_Tipo_Instrumento	,
				nemotecnico
			FROM	TIPO_INSTRUMENTO
			ORDER BY Codigo_Tipo_Instrumento
		END

		IF @tccodtab1 = 220
		BEGIN
			SELECT Codigo_Tipo_Fecha	,
				Descripcion
			FROM	TIPO_FECHA
			ORDER BY Codigo_Tipo_Fecha
		END

		IF @tccodtab1 = 221
		BEGIN
			SELECT Codigo_Tipo_Emision	,
				nemotecnico
			FROM	TIPO_EMISION
			ORDER BY Codigo_Tipo_Emision
		END

		IF @tccodtab1 = 3
		BEGIN
		
			SELECT	Codigo_Ciudad	,
				nombre
			FROM	CIUDAD
			ORDER BY Codigo_Ciudad
		END
		
		IF @tccodtab1 = 180
		BEGIN
		
			SELECT	Codigo_Pais	,
				nombre
			FROM	PAIS
			ORDER BY Codigo_Pais
		END

		IF @tccodtab1 = 212
		BEGIN
		
			SELECT	Codigo_Amortizacion	,
				Descripcion
			FROM	TIPO_AMORTIZACION
			ORDER BY Codigo_Amortizacion
		END

		IF @tccodtab1 = 1042
		BEGIN
		
			SELECT	Codigo_Tasa	,
				Descripcion
			FROM	TIPO_TASA
			ORDER BY Codigo_Tasa
		END

		IF @tccodtab1 = 1050
		BEGIN
		
			SELECT	Codigo_Producto	,
				Descripcion
			FROM	PRODUCTO
			ORDER BY Codigo_Producto
		END

		IF @tccodtab1 = 204
		BEGIN
		
			SELECT	Codigo_Cartera	,
				Descripcion
			FROM	TIPO_CARTERA
			ORDER BY Codigo_Cartera
		END

	
       RETURN

END



GO
