USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDTCLeerCodi]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_MDTCLeerCodi]
       (
       @ncodtab	NUMERIC(03)
	 
       )
AS
BEGIN
set nocount on
SET DATEFORMAT dmy

   /*=======================================================================*/
   /*=======================================================================*/

IF @ncodtab = 3
BEGIN
	SELECT	codigo_ciudad	,
		nombre
	FROM	CIUDAD
	ORDER BY codigo_ciudad
END

IF @ncodtab = 180
BEGIN
	SELECT	codigo_pais	,
		nombre
	FROM	PAIS
	ORDER BY codigo_pais
END

IF @ncodtab = 212
BEGIN
	SELECT	Codigo_Amortizacion 	,
		Descripcion
	FROM	TIPO_AMORTIZACION
	ORDER BY Codigo_Amortizacion
END

IF @ncodtab = 1042
BEGIN
	SELECT	Codigo_Tasa	,
		Descripcion
	FROM	TIPO_TASA
	ORDER BY Codigo_Tasa
END

IF @ncodtab = 1050
BEGIN
	SELECT	Codigo_producto		,
		Descripcion
	FROM	PRODUCTO
	ORDER BY Codigo_producto
END

IF @ncodtab = 204
BEGIN
	SELECT	Codigo_Cartera		,
		Descripcion
	FROM	TIPO_CARTERA
	ORDER BY Codigo_Producto
END

   /*=======================================================================*/
   /*=======================================================================*/

   RETURN
set nocount off
END



GO
