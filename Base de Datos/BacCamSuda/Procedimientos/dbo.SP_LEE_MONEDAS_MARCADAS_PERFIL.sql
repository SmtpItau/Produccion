USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MONEDAS_MARCADAS_PERFIL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_MONEDAS_MARCADAS_PERFIL]
	(	@moUNegocios	CHAR(3)	)
AS
BEGIN
	SET NOCOUNT ON

	SELECT  DISTINCT 
			mn.mnrrda
		,	mn.mnglosa
        ,	mn.mnnemo
        ,	CONVERT(FLOAT,0)	as posini
        ,	CONVERT(FLOAT,0)	as posic
        ,	CONVERT(FLOAT,0)	as totco
        ,	CONVERT(FLOAT,0)	as totve
        ,	CONVERT(FLOAT,0)	as parmes
        ,	CONVERT(FLOAT,0)	as paridad
        ,	CONVERT(FLOAT,0)	as preini
        ,	mn.mncodmon
        ,	mn.mncodpais            -- pais para buscar feriados
        ,	LEFT(mn.mnsimbol,3) as mnsimbol
	INTO	#TMP_MONEDA_COMEX
    FROM	MONEDAS_COMEX					   mc
			INNER JOIN BacParamSuda.dbo.MONEDA mn ON mn.mncodmon = mc.mpcodmon
	WHERE   mc.mpUnegocio	= @moUNegocios	---> mn.mnmx = 'C'

	UPDATE	#TMP_MONEDA_COMEX
	SET		posini  = vmposini
    ,		posic   = vmposic
    ,		totco   = vmtotco
    ,		totve   = vmtotve
    ,		parmes  = vmparmes
    ,		paridad = vmparidad
    ,		preini  = vmpreini
	FROM	VIEW_POSICION_SPT
	,		MEAC
	WHERE	CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),acfecpro,112)
	AND		mnsimbol = vmcodigo

     SELECT * FROM #TMP_MONEDA_COMEX

END
GO
