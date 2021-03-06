USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_OPE_INTRAMESAS_RTAFIJA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_RPT_OPE_INTRAMESAS_RTAFIJA 'CP', '20160229', 'T', 'T'

CREATE PROC [dbo].[SP_RPT_OPE_INTRAMESAS_RTAFIJA]
/*
Lista las operaciones intramesas de Renta Fija según condiciones definidas por el usuario
*/
@TipoBusca char(3),	-- CP / VP
@FechaBusca CHAR(8),	
@CarteraOrigen char(6),	-- codigo o T para Todas	
@MesaOrigen char(6)	-- codigo o T para Todas
AS

DECLARE 
	@nCarteraOrigen smallint,
	@nMesaOrigen smallint,
	@nomCarteraOrigen varchar(30),
	@nomMesaOrigen varchar(30),
	@nomProceso varchar(30)

		DECLARE @NomEntidad		VARCHAR(100)
	DECLARE @RutEntidad		NUMERIC(12)
	DECLARE	@DvEntidad		VARCHAR(1)
	DECLARE @CodEntidad		VARCHAR(2)
	DECLARE	@DirecEntidad	VARCHAR(100)
	DECLARE @FonoEntidad	VARCHAR(14)
	DECLARE @ComunaEntidad	VARCHAR(30)
	DECLARE @CiudadEntidad	VARCHAR(30)
	DECLARE @LOGO_BANCO VARBINARY(MAX)
	DECLARE @LOGO VARBINARY(MAX)
	DECLARE @DIRECC_PIE_FIRMA VARCHAR(100)
	DECLARE @URL_BANCO	VARCHAR(100)
	DECLARE @LOGO_BANCO_PIE_FIRMA VARBINARY(MAX)
	DECLARE @LOGO_LARGO_CONTRATO VARBINARY(MAX)

   	SELECT 
			@NomEntidad		=	RazonSocial	
	,		@RutEntidad		=	RutEntidad	
	,		@DvEntidad		=	DigitoVerificador
	,		@CodEntidad		=   CodigoEntidad
	,		@DirecEntidad	=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad
	,		@FonoEntidad	=	TelefonoLegal
	,		@ComunaEntidad  =	Comuna
	,		@CiudadEntidad  =	Ciudad
	,		@LOGO_BANCO		=	BannerLargoContrato
	,		@LOGO			=	Logo 
	,		@LOGO_LARGO_CONTRATO	=   BannerLargoContrato
	,		@DIRECC_PIE_FIRMA		=	DireccionLegalPieFirma
	,		@URL_BANCO				=	URLBanco
	,		@LOGO_BANCO_PIE_FIRMA	= BannerCorto
	FROM bacparamsuda..Contratos_ParametrosGenerales


IF @CarteraOrigen <> 'T'
	BEGIN
		SELECT @nCarteraOrigen = CONVERT(SMALLINT, @CarteraOrigen)
		SELECT @nomCarteraOrigen = tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=204 AND tbcodigo1 = @nCarteraOrigen
	END
ELSE
	BEGIN	
		SELECT @nCarteraOrigen = -9
		SELECT @nomCarteraOrigen = '< TODAS >'
	END

IF @MesaOrigen <> 'T'
	BEGIN
		SELECT @nMesaOrigen = CONVERT(SMALLINT, @MesaOrigen)
		SELECT @nomMesaOrigen = tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=245 AND tbcodigo1 = @nMesaOrigen
	END
ELSE
	BEGIN
		SELECT @nMesaOrigen = -9
		SELECT @nomMesaOrigen = '< TODAS >'
	END

IF RTRIM(LTRIM(@TipoBusca)) = 'CP'
	SELECT @nomProceso = 'COMPRAS'
ELSE
	SELECT @nomProceso ='VENTAS'

SET NOCOUNT ON

DECLARE @DATOS AS NUMERIC(3)
	SET @DATOS = (SELECT COUNT(*) FROM tbl_movticketrtafija m
	INNER JOIN bactradersuda.dbo.view_instrumento vis ON incodigo = m.CodigoInstrumento
	WHERE m.Tipo_Operacion = 'CP' --@TipoBusca
	AND m.Fecha_Operacion = CONVERT(DATETIME,'20160229',103)
	AND (m.CodCarteraOrigen = -9 OR -9 = -9)
	AND (m.CodMesaOrigen = -9 OR -9 = -9)
	AND Estado <> 'A')
	
IF @DATOS > 0 
BEGIN
SELECT 	
	@nomCarteraOrigen AS 'nomCarteraOrigen',
	@nomMesaOrigen AS 'nomMesaOrigen',
	@nomProceso AS 'NombreProceso',
	m.Fecha_Operacion,
	m.Rut_Emision,
	m.Numero_Operacion,
	m.Numero_Documento,
	m.Correlativo,
	m.Tipo_Operacion,
	m.Nemotecnico,
	m.CodigoInstrumento,
	m.Fecha_Emision,
	m.Fecha_Vencimiento,
	m.Moneda_Emision,
	m.Tasa_Emision,
	m.Base_Emision,
	m.Fecha_Activacion,
	m.Valor_Nominal,
	m.Tir,
	m.pvp,
	m.vpar,
	m.Valor_Compra,
	m.Valor_Compra_UM,
	m.Valor_VencimientoPacto,
	m.Usuario,
	m.Estado,
	m.CodMesaOrigen,
	m.CodMesaDestino,
	m.CodCarteraOrigen,
	m.CodCarteraDestino,
	(SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=245 AND tbcodigo1 = CodMesaOrigen) AS Nombre_Mesa_Origen,
	(SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=245 AND tbcodigo1 = CodMesaDestino) AS Nombre_Mesa_Destino,
	(SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=204 AND tbcodigo1 = CodCarteraOrigen) AS Nombre_Cartera_Origen,
	(SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=204 AND tbcodigo1 = CodCarteraDestino) AS Nombre_Cartera_Destino,
	vis.Inserie

	, 'Razon_Social_Banco'				= @NomEntidad
	,	'BannerCorto'						= @LOGO_BANCO_PIE_FIRMA	
	, 'DireccionEntidad'	= @DirecEntidad

	FROM tbl_movticketrtafija m
	INNER JOIN bactradersuda.dbo.view_instrumento vis ON incodigo = m.CodigoInstrumento
	WHERE m.Tipo_Operacion = @TipoBusca
	AND m.Fecha_Operacion = CONVERT(DATETIME,@FechaBusca,103)
	AND (m.CodCarteraOrigen = @nCarteraOrigen OR @nCarteraOrigen = -9)
	AND (m.CodMesaOrigen = @nMesaOrigen OR @nMesaOrigen = -9)
	AND Estado <> 'A'
	ORDER BY vis.Inserie, m.Numero_Documento, m.Correlativo, m.Nemotecnico
END
ELSE
BEGIN
SELECT
	'nomCarteraOrigen' = '',
	'nomMesaOrigen' = '', 
	'NombreProceso' = '',
	'Fecha_Operacion' = '',
	'Rut_Emision' = '',
	'Numero_Operacion' = 0,
	'Numero_Documento' = 0,
	'Correlativo' = 0,
	'Tipo_Operacion' = '',
	'Nemotecnico' = '',
	'CodigoInstrumento' = '',
	'Fecha_Emision' = '',
	'Fecha_Vencimiento' = '',
	'Moneda_Emision' = '',
	'Tasa_Emision' = '',
	'Base_Emision' = 0,
	'Fecha_Activacion' = '',
	'Valor_Nominal' = 0,
	'Tir' = 0,
	'pvp' = 0,
	'vpar' = 0,
	'Valor_Compra' = 0,
	'Valor_Compra_UM' = 0,
	'Valor_VencimientoPacto' = 0,
	'Usuario' = '',
	'Estado' = '',
	'CodMesaOrigen' = '',
	'CodMesaDestino' = '',
	'CodCarteraOrigen' = '',
	'CodCarteraDestino' = '',
	'Nombre_Mesa_Origen' = '',
	'Nombre_Mesa_Destino' = '',
	'Nombre_Cartera_Origen' = '',
	 'Nombre_Cartera_Destino' = '',
	'Inserie' = ''
		, 'Razon_Social_Banco'				= @NomEntidad
	,	'BannerCorto'						= @LOGO_BANCO_PIE_FIRMA	
	, 'DireccionEntidad'	= @DirecEntidad
END

SET NOCOUNT OFF

GO
