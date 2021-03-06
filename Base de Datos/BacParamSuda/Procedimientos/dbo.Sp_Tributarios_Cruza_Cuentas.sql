USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributarios_Cruza_Cuentas]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Tributarios_Cruza_Cuentas]
	(	@dFechaAnalisis		DATETIME	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT	Trib.Origen
		,	Trib.FolioContrato
		,	Trib.Producto
		,	Trib.TipoOperacion
		,	'Valor Razonable'
		,	Trib.nMontoAVRNeto
		,	Trib.nMontoAVRProceso
		,	Trib.nMontoResultado
		,	Trib.nSignoAvr
		,	Trib.CtaAVR
		,	'-'
		,	Ctas.Cuenta_AVR_Activo
		,	Ctas.Cuenta_AVR_Pasivo
		,	'Liquidaciones'
		,	Trib.nMontoLiquidacion
		,	Trib.CtaResultado
		,	'-'
		,	Utilidades  = ltrim(rtrim( Ctas.Utilidad_Real )) + '-' + ltrim(rtrim( Ctas.Utilidad_AVR ))
		,	Perdidas	= ltrim(rtrim( Ctas.Perdida_Real  )) + '-' + ltrim(rtrim( Ctas.Perdida_AVR ))

		,	Ctas.Canumoper
		,	Ctas.CaCodPos1
		,	Trib.nMonedaOperacion 
		,	Trib.nMonedaConversion
	FROM	dbo.TBL_TRIBUTARIOS		Trib
			left join dbo.Tmp_Cuentas_Tributarios Ctas ON Ctas.Id_Sistema	= Trib.Origen
													  and Ctas.Canumoper	= case when Trib.Origen = 'OPT' then (Trib.FolioContrato * 100) + Trib.Correlativo
																				   else Trib.FolioContrato end
	WHERE	Trib.FechaAnalisis	= @dFechaAnalisis
	AND		Trib.Origen			= 'OPT'
	AND     Trib.CtaAVR		   <>  ''
	ORDER BY Trib.FolioContrato, Trib.NewRegistro

END
GO
