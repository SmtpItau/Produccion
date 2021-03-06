USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_DESPLEGAR_ALERTAS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_DESPLEGAR_ALERTAS]
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @dFechaProceso		DATETIME
		SET @dFechaProceso		= ( SELECT dFechaProceso FROM DBO.SADP_Control )

	DECLARE @dHoraInicio		DATETIME
		SET @dHoraInicio		= '1900-01-01 ' + CONVERT(CHAR(10), DATEADD(MINUTE, 0, GETDATE()), 108)
	
	DECLARE @dHoraTermino		DATETIME
		SET @dHoraTermino		= '1900-01-01 ' + CONVERT(CHAR(10), DATEADD(MINUTE, 15, GETDATE()), 108)

	SELECT	id		= id_Alertas
		,	Nombre	= sNombre_Alerta
		,	Estado	= sEstado
		,	Hora	= cHora
		,	Desde	= dFecha_Desde
		,	Hasta	= dFecha_Hasta
		,	Desface	= DATEDIFF(minute, @dHoraInicio, cHora)  
	FROM	dbo.SADP_ALERTAS
	WHERE  (@dFechaProceso BETWEEN dfecha_desde AND dfecha_hasta)
	AND	   (sEstado	= 'P')
	AND    (cHora		BETWEEN @dHoraInicio AND @dHoraTermino)

	UPDATE	dbo.SADP_ALERTAS
	SET		sEstado			= 'E'
	WHERE	dfecha_hasta	< @dFechaProceso 

END
GO
