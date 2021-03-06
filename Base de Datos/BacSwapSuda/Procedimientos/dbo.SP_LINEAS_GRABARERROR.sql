USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRABARERROR]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_GRABARERROR](  
					@cSistema CHAR (03) ,
					@nNumoper NUMERIC (10,0)
					)
AS
BEGIN
	SET NOCOUNT ON
		DECLARE @Error CHAR(1)

		SELECT 	@Error = 'N'
		SELECT 	@Error = 'S'
		FROM 	VIEW_LINEA_TRANSACCION_DETALLE
		WHERE  	Error = 'S'
			AND NumeroOperacion = @nNumoper
			AND Id_Sistema = @cSistema

		IF @Error = 'S'
			BEGIN
				IF @cSistema = 'BTR'
					BEGIN
						UPDATE mdmo SET mostatreg = 'P' WHERE monumoper = @nNumoper

						IF EXISTS(SELECT * FROM MDCP WHERE cpnumdocu=@nNumoper)
							UPDATE MDCP SET Estado_Operacion_Linea = 'P' WHERE cpnumdocu=@nNumoper

						IF EXISTS(SELECT * FROM MDDI WHERE dinumdocu=@nNumoper)
							UPDATE MDDI SET Estado_Operacion_Linea = 'P' WHERE dinumdocu=@nNumoper

						IF EXISTS(SELECT * FROM MDCI WHERE cinumdocu=@nNumoper)
							UPDATE MDCI SET Estado_Operacion_Linea = 'P' WHERE cinumdocu=@nNumoper

					END

				IF @cSistema = 'BCC' UPDATE memo SET moestatus = 'P' WHERE monumope  = @nNumoper
	
				IF @cSistema = 'BFW' 
					BEGIN
						UPDATE mfmo SET moestado  = 'P' WHERE monumoper = @nNumoper
						UPDATE mfca SET caestado  = 'P' WHERE canumoper = @nNumoper
					END

				IF @cSistema = 'PCS' 
					BEGIN
						UPDATE movdiario SET Estado_oper_lineas  = 'P' WHERE numero_operacion = @nNumoper
						UPDATE cartera   SET Estado_oper_lineas  = 'P' WHERE numero_operacion = @nNumoper
					END


				SELECT 	Mensaje_Error,
					MontoExceso
				FROM 	VIEW_LINEA_TRANSACCION_DETALLE
				WHERE  	Error = 'S'
					AND NumeroOperacion = @nNumoper
					AND Id_Sistema = @cSistema
			 END

 SET NOCOUNT OFF
END
GO
