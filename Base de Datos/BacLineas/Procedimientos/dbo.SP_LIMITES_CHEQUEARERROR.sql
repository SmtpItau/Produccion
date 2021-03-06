USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_CHEQUEARERROR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_CHEQUEARERROR]
	(	@cSistema CHAR (03) 	,
		@nNumoper NUMERIC (10,0)
	)
AS
BEGIN

	SET NOCOUNT ON

--	IF EXISTS(SELECT * FROM LIMITE_TRANSACCION_ERROR WHERE NumeroOperacion=@nNumoper AND Id_Sistema=@cSistema)
--		BEGIN

			--===========Determina si es operación generada en CHile o NY=============--
			DECLARE @EsOperacionNY as char(2)
			SET @EsOperacionNY = 'No'
 			IF exists (select 1 from BACBONOSEXTNY..text_mvt_dri where monumoper = @nNumoper)
				set @EsOperacionNY = 'Si'

			IF exists (select 1 from BacFWDNY..mfmo where monumoper = @nNumoper)
				set @EsOperacionNY = 'Si'

						
			--=======================================================================--

			IF @cSistema = 'BTR'
				BEGIN
					UPDATE VIEW_MDMO SET mostatreg  = 'P' WHERE monumoper=@nNumoper

					IF EXISTS(SELECT * FROM VIEW_MDCP WHERE cpnumdocu=@nNumoper)
						UPDATE VIEW_MDCP SET Estado_Operacion_Linea = 'P' WHERE cpnumdocu=@nNumoper

					IF EXISTS(SELECT * FROM VIEW_MDDI WHERE dinumdocu=@nNumoper)
						UPDATE VIEW_MDDI SET Estado_Operacion_Linea = 'P' WHERE dinumdocu=@nNumoper

					IF EXISTS(SELECT * FROM VIEW_MDCI WHERE cinumdocu=@nNumoper)
						UPDATE VIEW_MDCI SET Estado_Operacion_Linea = 'P' WHERE cinumdocu=@nNumoper
			END

			IF @cSistema='BCC'
				UPDATE VIEW_MEMO SET moestatus = 'P' WHERE monumope=@nNumoper

			IF @cSistema='BFW'
				BEGIN

				IF @EsOperacionNY = 'No'
						BEGIN
					UPDATE VIEW_MFMO SET moestado  = 'P' WHERE monumoper=@nNumoper
					UPDATE VIEW_MFCA SET caestado  = 'P' WHERE canumoper=@nNumoper
				END
				IF @EsOperacionNY = 'Si'
						BEGIN
					UPDATE VIEW_MFMO_NY SET moestado  = 'P' WHERE monumoper=@nNumoper
					UPDATE VIEW_MFCA_NY SET caestado  = 'P' WHERE canumoper=@nNumoper
				END



			END



			IF @cSistema='BEX'
				BEGIN
					IF @EsOperacionNY = 'No'
						BEGIN
							UPDATE VIEW_Text_Mvt_Dri SET mostatreg  = 'P' WHERE monumoper = @nNumoper
						end else
						BEGIN
							UPDATE VIEW_text_mvt_dri_NY SET mostatreg = 'P' WHERE monumoper = @nNumoper
					END

				END

--		END

	IF @cSistema='BEX'
		SELECT  Mensaje, Monto 
		FROM  	LIMITE_TRANSACCION_ERROR
		WHERE   NumeroOperacion=@nNumoper 
			AND Id_Sistema=@cSistema

	SET NOCOUNT OFF

END

GO
