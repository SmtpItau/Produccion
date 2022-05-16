USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Parametros_Operador]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Trae_Parametros_Operador](
						@USUARIO      CHAR(15)
					     )					     
AS
BEGIN

	SET NOCOUNT ON

	SELECT	a.Punta                 	,
		a.Empresa               	,
		a.Moneda                	,
		a.Posicion              	,
		a.Vb21446               	,
		a.Cierre_Mesa 		,
		a.Costo_Fondo 		,
		a.Supervisor 		,
		a.Intraday_Minimo       	,
		a.Intraday_Maximo       	,
		a.Overnigth_Minimo      	,
		a.Overnigth_Maximo      	,
		a.Usuario         	,
		a.Lineas			,
		a.Swift			,
		b.short_circuit
	FROM 	VIEW_PARAMETROS_OPERADORES_SPT a,
		USUARIO b
	WHERE 	a.Usuario    =   @USUARIO AND
		b.Usuario    =   @USUARIO

	SET NOCOUNT OFF

END

-- SELECT * FROM VIEW_PARAMETROS_OPERADORES_SPT
-- EXECUTE SP_HELPTEXT Sp_Trae_Parametros_Operador 'ADMINISTRA'










GO
