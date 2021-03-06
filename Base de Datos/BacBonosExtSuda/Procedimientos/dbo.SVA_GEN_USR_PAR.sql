USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_GEN_USR_PAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_GEN_USR_PAR] 
AS
BEGIN

	DECLARE @nvaluf		NUMERIC(19,4)	,
		@nvaldol	NUMERIC(19,4)	,
		@diaspacto	INTEGER

	SET NOCOUNT ON

		
	SELECT  @nvaluf = ISNULL(vmvalor,0)
	FROM	VIEW_valor_moneda ,
		text_arc_ctl_dri
	WHERE	VIEW_valor_moneda.vmfecha	= acfecproc
	AND	VIEW_valor_moneda.vmcodigo	= 998

	SELECT	@nvaldol = ISNULL(vmvalor,0)
	FROM	VIEW_valor_moneda ,
		text_arc_ctl_dri
	WHERE	VIEW_valor_moneda.vmfecha 	=  acfecproc
	AND	VIEW_valor_moneda.vmcodigo =  994


	SET ROWCOUNT 1

	SELECT	'fecproc'	= CONVERT(CHAR(10),a.acfecproc,103)	, 
		a.acnomprop						,
		'fecprox'	= CONVERT(CHAR(10),a.acfecprox,103)	,
		a.acrutprop						,
		a.acdigprop						,
		0							, --a.acrutcomi
		0							, --a.accomision
		0							, --a.aciva 
		b.rcrut							,
		b.rcdv							,
		b.rcnombre 						,
		'valuf' 	= @nvaluf				,
		'valdol' 	= ISNULL(@nvaldol,0)				,
		'diasnobcch'	= 30 					,
		'fecante'	= CONVERT(CHAR(10),a.acfecante,103)	,
		acdirinterfaz						,
		fondos_banco_c						,
		fondos_cta_c						,
		fondos_pais_c						,
		fondos_ciud_c						,
		fondos_banco_v						,
		fondos_cta_v						,
		fondos_pais_v						,
		fondos_ciud_v						,
		dolarObsFinMes	
	FROM 	text_arc_ctl_dri	A,
		VIEW_entidad	b

	where	rcrut = acrutprop   
	
	SET ROWCOUNT 0


	SET NOCOUNT OFF
END

GO
