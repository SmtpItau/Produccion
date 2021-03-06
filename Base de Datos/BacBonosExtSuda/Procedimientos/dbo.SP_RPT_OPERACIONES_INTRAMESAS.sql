USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_OPERACIONES_INTRAMESAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RPT_OPERACIONES_INTRAMESAS]
@TipoBusca char(3),		-- CP / VP
@FechaBusca CHAR(8),	-- era DATETIME
@CarteraOrigen char(6),		
@MesaOrigen char(6)
AS
DECLARE 
	@nCarteraOrigen smallint,
	@nMesaOrigen smallint,
	@nomCarteraOrigen varchar(30),
	@nomMesaOrigen varchar(30),
	@nomProceso varchar(30)

IF @CarteraOrigen <> 'T'
BEGIN
	SELECT @nCarteraOrigen = CONVERT(SMALLINT, @CarteraOrigen)
	SELECT @nomCarteraOrigen = tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=204 AND tbcodigo1 = @nCarteraOrigen
END
ELSE
	SELECT @nCarteraOrigen = -9,
		 @nomCarteraOrigen = 'TODAS'

IF @MesaOrigen <> 'T'
BEGIN
	SELECT @nMesaOrigen = CONVERT(SMALLINT, @MesaOrigen)
	SELECT @nomMesaOrigen = tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=245 AND tbcodigo1 = @nMesaOrigen
END
ELSE
	SELECT @nMesaOrigen = -9,
		 @nomMesaOrigen = 'TODAS'

IF RTRIM(LTRIM(@TipoBusca)) = 'CP'
	SELECT @nomProceso = 'COMPRAS'
ELSE
	SELECT @nomProceso ='VENTAS'

SET NOCOUNT ON

SELECT 	
	@nomCarteraOrigen AS 'nomCarteraOrigen',
	@nomMesaOrigen AS 'nomMesaOrigen',
	@nomProceso AS 'NombreProceso',
	m.mofecpro,
	m.morutcart,
	m.monumoper,
	m.monumdocu,
	m.mocorrelativo,
	m.motipoper,
	m.cod_nemo,
	m.cod_familia,
	m.id_instrum,
	m.morutcli,
	m.mocodcli,
	m.mofecemi,
	m.mofecven,
	m.mofecneg,
	m.momonemi,
	m.momonpag,
	m.momontoemi,
	m.motasemi,
	m.mobasemi,
	m.morutemi,
	m.mofecpago,
	m.monominal,
	m.movpresen,
	m.movalvenc,
	m.momtps,
	m.momtum,
	m.motir,
	m.mopvp,
	m.movpar,
	m.moint_compra,
	m.moprincipal,
	m.movalcomp,
	m.movalcomu,
	m.mointeres,
	m.moreajuste,
	m.moutilidad,
	m.moperdida,
	m.movalven,
	m.monumpcup,
	m.mousuario,
	m.mostatreg,
	m.moobserv,
	m.basilea,
	m.tipo_tasa,
	m.encaje,
	m.monto_encaje,
	m.codigo_carterasuper,
	m.tipo_cartera_financiera,
	m.sucursal,
	m.operador_Banco,
	m.tipo_inversion,
	m.forma_pago,
	m.base_tasa,
	m.cod_emi,
	m.mofecpcup,
	m.mohoraop,
	m.cusip,
	m.CapitalPeso,
	m.InteresPeso,
	m.SwImpresion,
	m.movpressb,
	m.modifsb,
	m.Hora,
	m.DurMacaulay,
	m.DurModificada,
	m.Convexidad,
	m.Id_Area_Responsable,
	m.Id_Libro,
	m.mesa_origen,
	ISNULL((SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=245 AND tbcodigo1 = mesa_origen),'INDEFINIDA') AS Nombre_Mesa_Origen,
	m.mesa_destino,
	ISNULL((SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=245 AND tbcodigo1 = mesa_destino),'INDEFINIDA') AS Nombre_Mesa_Destino,
	ISNULL((SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=204 AND tbcodigo1 = tipo_cartera_financiera),'INDEFINIDA') AS Nombre_Cartera_Origen,
	m.cartera_destino,
	ISNULL((SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=204 AND tbcodigo1 = cartera_destino),'INDEFINIDA') AS Nombre_Cartera_Destino,
	m.correl_relacion

	FROM MOV_ticketbonext m
	WHERE m.motipoper = @TipoBusca
	AND m.mofecpro = CONVERT(DATETIME,@FechaBusca,103)
	AND (m.tipo_cartera_financiera = @nCarteraOrigen OR @nCarteraOrigen = -9)
	AND (m.mesa_origen = @nMesaOrigen OR @nMesaOrigen = -9)
	ORDER BY m.mofecpro, m.tipo_cartera_financiera, m.mesa_origen, m.monumdocu, m.mocorrelativo

SET NOCOUNT OFF

GO
