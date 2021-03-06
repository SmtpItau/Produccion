USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_ANULA_MODIFICACION]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_ANULA_MODIFICACION]
	(	@cOrigen	VARCHAR(5)
	,	@nContrato	NUMERIC(9)
	,	@cUsuario	VARCHAR(15)
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @iMaxMarca	NUMERIC(9)
		SET @iMaxMarca	= 0
		SET @iMaxMarca	= ISNULL(( SELECT	ISNULL( max(sEnviadoPor) , 0) FROM BacParamSuda.dbo.SADP_DETALLE_PAGOS 
									WHERE	cModulo		= @cOrigen 
									AND		nContrato	= @nContrato
									AND		cestado		= 'APM'
									GROUP BY  cModulo, nContrato, cestado), 0) 

	UPDATE	BacParamSuda.dbo.SADP_DETALLE_PAGOS
	SET		cEstado		= 'APM'
	WHERE	cModulo		= @cOrigen 
	AND		nContrato	= @nContrato 
	AND		cestado		IN('PF1', 'PF2', 'P') 

	INSERT INTO BacParamSuda.dbo.SADP_DETALLE_PAGOS
	(		nContrato
	,		cModulo
	,		iMoneda
	,		iFormaPago
	,		nMonto
	,		iRutBeneficiario
	,		sDigBeneficiario
	,		sNomBeneficiario
	,		sNomBanco
	,		sSwift
	,		sCtaCte
	,		sUsuario
	,		sFirma1
	,		sFirma2
	,		cEstado
	,		cObservaciones
	,		iRutCliente
	,		iCodigo
	,		iRutBanco
	,		sDvBanco
	,		vNumTransferencia
	,		sEnviadoPor
	)
	SELECT	nContrato
	,		cModulo
	,		iMoneda
	,		iFormaPago
	,		nMonto
	,		iRutBeneficiario
	,		sDigBeneficiario
	,		sNomBeneficiario
	,		sNomBanco
	,		sSwift
	,		sCtaCte
	,		sUsuario	= @cUsuario
	,		sFirma1		= @cUsuario
	,		sFirma2		= ''
	,		cEstado		= 'PF2'
	,		cObservaciones
	,		iRutCliente
	,		iCodigo
	,		iRutBanco
	,		sDvBanco
	,		vNumTransferencia
	,		sEnviadoPor = 0
	FROM	BacParamSuda.dbo.SADP_DETALLE_PAGOS
	WHERE	cModulo		= @cOrigen 
	AND		nContrato	= @nContrato
	AND		sEnviadoPor	= CONVERT(VARCHAR(15), @iMaxMarca)

END
GO
