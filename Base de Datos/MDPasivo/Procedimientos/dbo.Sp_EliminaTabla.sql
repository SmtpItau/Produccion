USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_EliminaTabla]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_EliminaTabla]
		(
		@tbcateg   NUMERIC(05),
		@tbcodigo1 CHAR   (06)
		)
                 	
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	IF @tbcateg = 3 BEGIN
		DELETE CIUDAD
		WHERE  codigo_ciudad = @tbcodigo1
	END


	IF @tbcateg = 180 BEGIN
		DELETE PAIS
		WHERE  codigo_pais = @tbcodigo1
	END

	IF @tbcateg = 212 BEGIN
		DELETE TIPO_AMORTIZACION
		WHERE  Codigo_Amortizacion = @tbcodigo1
	END

	IF @tbcateg = 1042 BEGIN
		DELETE TIPO_TASA
		WHERE  Codigo_tasa = @tbcodigo1
	END

	IF @tbcateg = 1050 BEGIN
		DELETE PRODUCTO
		WHERE  Codigo_Producto = @tbcodigo1
	END

	IF @tbcateg = 204 BEGIN
		DELETE TIPO_CARTERA
		WHERE  Codigo_Cartera = @tbcodigo1
	END
END

GO
