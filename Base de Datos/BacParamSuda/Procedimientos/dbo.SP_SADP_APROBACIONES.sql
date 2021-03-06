USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_APROBACIONES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_SADP_APROBACIONES]
	(	@cOrigen	VARCHAR(4)
	,	@nContrato	NUMERIC(9)
	,	@nIdPago	NUMERIC(9)
	,	@cUsuario	VARCHAR(15)
	,	@iSecuencia  INT
	)
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE @iFoundError		SMALLINT
	DECLARE @oEstado			VARCHAR(5)
	DECLARE @oUsuario			VARCHAR(15)
	DECLARE @oFirma1			VARCHAR(15)
	DECLARE @oFirma2			VARCHAR(15)
	DECLARE @oError				VARCHAR(100)
	DECLARE @nFormaPago			INT
	
		SET	@iFoundError		= 0
		SET @oEstado			= ''
		SET @oUsuario			= ''
		SET @oFirma1			= ''
		SET @oFirma2			= ''
		SET @oError				= ''
		SET @nFormaPago			= 0

	SELECT  @oEstado			= cEstado
		,	@oUsuario			= sUsuario
		,	@oFirma1			= sFirma1
		,	@oFirma2			= sFirma2
		,	@oError				= ''
		,	@nFormaPago			= iFormaPago
	FROM	dbo.SADP_DETALLE_PAGOS
	WHERE	cModulo				= @cOrigen
	AND		nContrato			= @nContrato
	and     iSecuencia			= @iSecuencia  
	AND		Id_Detalle_Pago		= @nIdPago

	-->	Validacion por Medio de Pago
	IF @nFormaPago = 0 OR @nFormaPago = -1
	BEGIN	
		SELECT -10, 'No se puede aprobar operacion sin medio de pago.'
		RETURN
	END

	-->	Validacion por datos del beneficiario
		SET @iFoundError	= 0
	SELECT	@iFoundError	= 1
	FROM	dbo.SADP_DETALLE_PAGOS
	WHERE	cModulo				= @cOrigen
	AND		nContrato			= @nContrato
	and     iSecuencia			= @iSecuencia
	AND		Id_Detalle_Pago		= @nIdPago
	AND	(	iRutBeneficiario	= 0 
		 OR sDigBeneficiario	= '' 
		 OR sNomBeneficiario	= '' 	)
	AND iFormaPago <>222		 
	
	IF 	@iFoundError = 1
	BEGIN
		SELECT -9, 'Favor revisar los datos del Beneficiario.'
		RETURN
	END
	-->	Validacion por datos del beneficiario

	-->	Validacion por datos del Receptor para LBTR y COMBANC
		SET @iFoundError	= 0
	SELECT	@iFoundError	= 1
	FROM	dbo.SADP_DETALLE_PAGOS
	WHERE	cModulo				= @cOrigen
	AND		nContrato			= @nContrato
	and     iSecuencia			= @iSecuencia
	AND		Id_Detalle_Pago		= @nIdPago
	AND    ( (iFormaPago <> 5 AND iFormaPago <> 103 AND iFormaPago <> 105 AND iFormaPago <> 222)
				  AND	(	iRutCliente	= 0
				   OR ( LTRIM(RTRIM( sNomBanco	)) = ''     
				   OR (LTRIM(RTRIM( sSwift		)) = ''
				   OR (LTRIM(RTRIM( sCtaCte	)) = '')))))  
		
	
	IF 	@iFoundError = 1
	BEGIN
		SELECT -8, 'Favor revisar los datos del Receptor.'
		RETURN
	END
	-->	Validacion por datos del Receptor

	-->	Validacion Privilegios de aprobacion
	IF @cUsuario = @oUsuario 
	BEGIN
		SELECT -1, 'Usuario que cursa, no puede aprobar.'
		RETURN
	END
	IF @cUsuario = @oFirma1
	BEGIN
		SELECT -2, 'Usuario no puede aprobar, ya es firma 1.'
		RETURN	
	END

	IF @cUsuario = @oFirma2
	BEGIN
		SELECT -2, 'Usuario no puede aprobar, ya es firma 1.'
		RETURN	
	END

	-->	Cambios de estado <--
	IF @oEstado = 'PF1'
	BEGIN
		UPDATE	dbo.SADP_DETALLE_PAGOS 
		SET		sFirma1			= @cUsuario
		,		cEstado			= 'PF2'
		WHERE	cModulo			= @cOrigen
		AND		nContrato		= @nContrato
		and     iSecuencia			= @iSecuencia
		AND		Id_Detalle_Pago = @nIdPago
	END

	IF @oEstado = 'PF2'
	BEGIN
		UPDATE	dbo.SADP_DETALLE_PAGOS 
		SET		sFirma2			= @cUsuario
		,		cEstado			= 'P'
		WHERE	cModulo			= @cOrigen
		AND		nContrato		= @nContrato
		and     iSecuencia			= @iSecuencia
		AND		Id_Detalle_Pago = @nIdPago

		IF NOT EXISTS( SELECT 1 FROM SADP_DETALLE_PAGOS WHERE cModulo = @cOrigen AND nContrato = @nContrato and iSecuencia		 = @iSecuencia AND cestado IN('PF1', 'PF2') )
		BEGIN
			UPDATE	dbo.MDLBTR 
			SET		estado_envio	 = 'P' 
			WHERE	sistema			 = @cOrigen
			AND		numero_operacion = @nContrato
			and     Secuencia		 = @iSecuencia
		END
	END
	-->	Cambios de estado <--

	SELECT 0, 'Se ha actualizado el estado de la operaciÃ³n.'
	
END
GO
