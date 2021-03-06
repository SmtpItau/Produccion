USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_TASAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_TASAS]
	(
		@cSistema CHAR (03) ,
		@nNumoper NUMERIC (10,0)
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @Estado_Linea CHAR(1)

	SELECT @Estado_Linea = 'P'

	SELECT 	@Estado_Linea = ISNULL( ( CASE WHEN Operador_Ap_Tasas = '' THEN 'P' ELSE 'A' END ) , 'P' )
	FROM   	aprobacion_operaciones
	WHERE  	NumeroOperacion = @nNumoper
		AND Id_Sistema = @cSistema

	SELECT 	Mensaje_Error	,
		MontoExceso
	FROM 	LINEA_TRANSACCION_DETALLE
	WHERE  	Error 		= 'S'		AND 
		NumeroOperacion = @nNumoper	AND 
		Id_Sistema 	= @cSistema	AND 
		@estado_linea 	= 'P'		AND
		Linea_Transsaccion IN( 'CTRLTA' )

	SET NOCOUNT OFF

END
GO
