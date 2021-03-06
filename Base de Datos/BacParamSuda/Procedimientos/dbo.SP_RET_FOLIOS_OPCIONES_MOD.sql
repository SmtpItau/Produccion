USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RET_FOLIOS_OPCIONES_MOD]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RET_FOLIOS_OPCIONES_MOD]
				(
					 @FecIni	VARCHAR(10)
					,@FecFin	VARCHAR(10)
				)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE  @FechaInicial 	DATETIME
			,@FechaFinal	DATETIME
			,@fechaProc 	DATETIME
			,@Origen		CHAR(1)
			
	---SELECT	@fechaProc = fechaproc FROM lnkOpc.CbMdbOpc.dbo.OPCIONESGENERAL
	SELECT 	@fechaProc = acfecproc FROM BacParamsuda.dbo.VIEW_MDAC with(nolock)
			
	SELECT 	 @FechaInicial = CONVERT(DATETIME, @FecIni)
			,@FechaFinal   = CONVERT(DATETIME, @FecFin)

	IF @fechaProc > @FechaFinal
		SELECT @Origen = 'H'	---> Solo Historico de Movimientos
	ELSE
		SELECT @Origen = 'M'	---> Maestro de Movimientos + Historicos			

	IF @Origen = 'M'	---> Movimientos + Historicos
	BEGIN
		SELECT DISTINCT MoNumContrato, 'H'
		FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato
		WHERE MoTipoTransaccion = 'MODIFICA'
		AND CONVERT(DATETIME, CONVERT(VARCHAR(10), MoFechaCreacionRegistro,112)) BETWEEN @FechaInicial AND @FechaFinal
		UNION
		SELECT DISTINCT MoNumContrato, 'M'
		FROM lnkOpc.CbMdbOpc.dbo.MoEncContrato
		WHERE MoTipoTransaccion = 'MODIFICA'
		AND CONVERT(DATETIME, CONVERT(VARCHAR(10), MoFechaCreacionRegistro,112)) BETWEEN @FechaInicial AND @FechaFinal
	END
	ELSE	---> Solo Historicos
		SELECT DISTINCT MoNumContrato, 'H'
		FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato
		WHERE MoTipoTransaccion = 'MODIFICA'
		AND CONVERT(DATETIME, CONVERT(VARCHAR(10), MoFechaCreacionRegistro,112)) BETWEEN @FechaInicial AND @FechaFinal

	SET NOCOUNT OFF
END
GO
