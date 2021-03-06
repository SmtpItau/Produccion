USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_BENEFICIARIOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_BENEFICIARIOS]
	(	@nRutBeneficiario	NUMERIC(10)	)
AS
BEGIN
	
	SET NOCOUNT ON
	
	SELECT	Rut					=	LTRIM(RTRIM( nRutBeneficiario )) + '-' + LTRIM(RTRIM( cDvBeneficiario ))
	,		Nombre				=	cNomBeneficiario
	,		CtaCte				=	cCtaCte 
	,		cNomBanco			=	LTRIM(RTRIM( SUBSTRING(clnombre, 1, 50) ))
	,		CodSwift			=	ISNULL( cl.Clswift, '')
	,		nRutBanco			=	nRutBanco
	,		nCodBanco			=	nCodBanco
	FROM	dbo.SADP_BENEFICIARIOS
			LEFT JOIN BacParamSuda.dbo.CLIENTE cl ON cl.clrut = nRutBanco AND cl.Clcodigo = nCodBanco   
	WHERE	nRutBeneficiario	=	@nRutBeneficiario 
	
END
GO
