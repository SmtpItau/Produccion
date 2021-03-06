USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRABARERROR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_GRABARERROR]
	(	@cSistema CHAR (03) 	,
		@nNumoper NUMERIC (10,0)
	)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Error CHAR(1)
	SELECT  @Error = 'N'
	SELECT  @Error = 'S'
	FROM  	LINEA_TRANSACCION_DETALLE
	WHERE   Error = 'S'
		AND NumeroOperacion 	= @nNumoper
		AND Id_Sistema 		= @cSistema

	IF @Error = 'S'
		BEGIN
			IF @cSistema = 'BTR'
				BEGIN
					UPDATE View_mdmo SET mostatreg = 'P' WHERE monumoper = @nNumoper

					IF EXISTS(SELECT * FROM VIEW_MDCP WHERE cpnumdocu=@nNumoper)
						UPDATE VIEW_MDCP SET Estado_Operacion_Linea = 'P' WHERE cpnumdocu=@nNumoper

					IF EXISTS(SELECT * FROM VIEW_MDDI WHERE dinumdocu=@nNumoper)
						UPDATE VIEW_MDDI SET Estado_Operacion_Linea = 'P' WHERE dinumdocu=@nNumoper

					IF EXISTS(SELECT * FROM VIEW_MDCI WHERE cinumdocu=@nNumoper)
						UPDATE VIEW_MDCI SET Estado_Operacion_Linea = 'P' WHERE cinumdocu=@nNumoper
				END

			IF @cSistema = 'BCC' 
				UPDATE VIEW_MEMO SET moestatus = 'P' WHERE monumope  = @nNumoper
 
			IF @cSistema = 'BFW' 
				BEGIN
					UPDATE VIEW_MFMO SET moestado  = 'P' WHERE monumoper = @nNumoper
					UPDATE VIEW_MFCA SET caestado  = 'P' WHERE canumoper = @nNumoper
				END

			IF @cSistema = 'PCS' 
				BEGIN
					UPDATE view_movdiario SET Estado_oper_lineas  = 'P' WHERE numero_operacion = @nNumoper
					UPDATE view_cartera   SET Estado_oper_lineas  = 'P' WHERE numero_operacion = @nNumoper
				END


			SELECT  Mensaje_Error,
				MontoExceso
			FROM  	LINEA_TRANSACCION_DETALLE
			WHERE   Error = 'S'
				AND NumeroOperacion = @nNumoper
				AND Id_Sistema = @cSistema
		END

	SET NOCOUNT OFF

END

-- select * from view_movdiario
-- select * from view_cartera
-- select * from sysobjects where type = 'V' order by name
GO
