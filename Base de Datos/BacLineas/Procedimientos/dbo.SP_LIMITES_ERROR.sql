USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_ERROR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_ERROR]
                                    (
				    @cSistema CHAR (03) ,
				    @nNumoper NUMERIC (10,0)
				   )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @Estado_Limite CHAR(1)

	SELECT  @Estado_Limite = 'P'

	SELECT 	@Estado_Limite = ISNULL( ( CASE WHEN Operador_Ap_Limites <> '' THEN 'A' ELSE 'P' END ) , 'P' )
	FROM   	aprobacion_operaciones
	WHERE  	NumeroOperacion = @nNumoper
		AND Id_Sistema = @cSistema

	SELECT 	Mensaje, Monto 
	FROM 	LIMITE_TRANSACCION_ERROR
	WHERE  	NumeroOperacion = @nNumoper
		AND Id_Sistema = @cSistema
		AND @Estado_Limite = 'P'
  
	SET NOCOUNT OFF

END
GO
