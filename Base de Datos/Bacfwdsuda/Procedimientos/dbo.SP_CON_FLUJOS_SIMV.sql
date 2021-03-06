USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_FLUJOS_SIMV]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_CON_FLUJOS_SIMV]	(	@NroOPer		INT = 0
									,	@Cartera_Inv	INT = 0
					)
AS
BEGIN

	SET NOCOUNT ON 

	DECLARE	@dFechaProceso	AS DATETIME
	DECLARE @dHora		AS DATETIME

	SELECT	@dFechaProceso	= acfecproc
	,	@dHora		= GETDATE()
	FROM	MFAC

	SELECT	Ctf_Numero_OPeracion	
	,	cacodigo	-- RUT CLIENTE
	,	cacodcli	-- CODIGO CLIENTE
	,	catipoper
	,	cafecha
	,	Ctf_Numero_Credito
	,	Ctf_Correlativo
	,	Ctf_Numero_Dividendo
	,	Ctf_Plazo
	,	Ctf_Fecha_Vencimiento
	,	Ctf_Fecha_Fijacion
	,	Ctf_Monto_Principal
	,	Ctf_Precio_Contrato
	,	Ctf_Precio_Costo
	,	Ctf_Spread
	,	Ctf_Tasa_Moneda_Principal
	,	Ctf_Tasa_Moneda_Secundaria
	,	Ctf_Precio_Proyectado
	,	Ctf_Monto_Secundario
	,	Ctf_Valor_Razonable_Activo
	,	Ctf_Valor_Razonable_Pasivo
	,	Ctf_Valor_Razonable
	,	Ctf_Articulo84
	,	caoperador
	,	CONVERT(CHAR(10),@dFechaProceso,103)	as Fecha_Proc
	,	CONVERT(CHAR(10), @dHora,108)		as Hora
	,	'Cartera_Financiera'	= ISNULL((SELECT Distinct rcnombre FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = cacodpos1 and rcrut = cacodcart ),'No Especificado')
	,	'Cartera_Normativa'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1111' AND tbcodigo1 = cacartera_normativa),'No Especificado')	
	,	'SubCartera_Normativa'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1554' AND tbcodigo1 = casubcartera_normativa),'No Especificado')	
	,	'Libro'			= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1552' AND tbcodigo1 = calibro),'No Especificado') 
	,   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	FROM	MFCA			
	,	TBL_CARTERA_FLUJOS
	WHERE	(canumoper		= @NroOPer	OR @NroOPer	= 0)
	AND	(cacodcart		= @Cartera_Inv	OR @Cartera_Inv	= 0)
	AND	Ctf_Numero_OPeracion	= canumoper
	AND	Ctf_Fecha_Vencimiento	> @dFechaProceso 
	ORDER
	BY	canumoper
	,	Ctf_Correlativo

	SET NOCOUNT OFF

END


GO
