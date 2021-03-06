USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_OPEPACTO_INTRAMESAS_RTAFIJA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_RPT_OPEPACTO_INTRAMESAS_RTAFIJA]
/*
JBH, 02-12-2009.  SP para reportes de operaciones con Pacto de Intramesas Renta Fija
*/
@TipoBusca char(3),	-- CI / VI
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

IF RTRIM(LTRIM(@TipoBusca)) = 'CI'
	SELECT @nomProceso = 'COMPRAS CON PACTO'
ELSE
	SELECT @nomProceso ='VENTAS CON PACTO'

SET NOCOUNT ON

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
	m.Fecha_Emision,
	m.Fecha_Vencimiento,
	m.Moneda_Emision,
	(SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = m.Moneda_Emision) AS 'NemoMonedaEmision',
	(SELECT mnglosa FROM VIEW_MONEDA WHERE mncodmon = m.Moneda_Emision) AS 'NomMonedaEmision',
	(SELECT mnbase FROM VIEW_MONEDA WHERE mncodmon = m.Moneda_Emision) AS 'Base',
	m.Tasa_Emision,
	m.Base_Emision,
	m.Fecha_Activacion,
	m.Valor_Nominal,
	m.Tir,
	m.pvp,
	m.vpar,
	m.Valor_Compra,
	m.Valor_Compra_UM,
	m.Valor_InicialPacto,
	m.Valor_VencimientoPacto,
	m.Usuario,
	m.Estado,
	m.CodMesaOrigen,
	m.CodMesaDestino,
	m.CodCarteraOrigen,
	m.CodCarteraDestino,
	ISNULL((SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=245 AND tbcodigo1 = CodMesaOrigen),'CODIGO MESA NO ENCONTRADO') AS Nombre_Mesa_Origen,
	ISNULL((SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=245 AND tbcodigo1 = CodMesaDestino),'CODIGO MESA NO ENCONTRADO') AS Nombre_Mesa_Destino,
	ISNULL((SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=204 AND tbcodigo1 = CodCarteraOrigen),'CODIGO CARTERA NO ENCONTRADO') AS Nombre_Cartera_Origen,
	ISNULL((SELECT tbglosa FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg=204 AND tbcodigo1 = CodCarteraDestino),'CODIGO CARTERA NO ENCONTRADO') AS Nombre_Cartera_Destino
	FROM tbl_movticketrtafija m
	WHERE m.Tipo_Operacion = @TipoBusca
	AND m.Fecha_Operacion = CONVERT(DATETIME,@FechaBusca,103)
	AND (m.CodCarteraOrigen = @nCarteraOrigen OR @nCarteraOrigen = -9)
	AND (m.CodMesaOrigen = @nMesaOrigen OR @nMesaOrigen = -9)
	AND Estado <> 'A'
	ORDER BY m.Moneda_Emision, m.Numero_Documento, m.Correlativo

SET NOCOUNT OFF

GO
