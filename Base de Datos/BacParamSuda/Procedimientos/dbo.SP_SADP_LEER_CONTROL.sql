USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_CONTROL]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_CONTROL]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	dFechaAnterior	= dFechaAnterior
		,	dFechaProceso	= dFechaProceso
		,	dFechaProxima	= dFechaProxima
		,	bSwCargaFFMM	= CASE WHEN bSwCargaFFMM	= 1 THEN 'TRUE' ELSE 'FALSE' END 
		,	bSwCargaCDB		= CASE WHEN bSwCargaCDB		= 1 THEN 'TRUE' ELSE 'FALSE' END
		,	bEnvioLBTR		= CASE WHEN bEnvioLBTR		= 1 THEN 'TRUE' ELSE 'FALSE' END
		,	bEnvioVVista	= CASE WHEN	bEnvioVVista	= 1 THEN 'TRUE' ELSE 'FALSE' END
		,	bEnvioCtaCte	= CASE WHEN bEnvioCtaCte	= 1 THEN 'TRUE' ELSE 'FALSE' END
		,	idTx_Manual		= CASE WHEN idTx_Manual		= 1 THEN 'TRUE' ELSE 'FALSE' END
		,	bListener		= CASE WHEN bConeccionListener = 1 THEN 'TRUE' ELSE 'FALSE' END
	FROM	dbo.SADP_CONTROL	with(nolock)
	
END
GO
