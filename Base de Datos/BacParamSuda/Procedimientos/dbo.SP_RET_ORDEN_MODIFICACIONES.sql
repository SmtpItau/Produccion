USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RET_ORDEN_MODIFICACIONES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RET_ORDEN_MODIFICACIONES]
				(
					 @Modulo	CHAR(3)
					,@NumOper	NUMERIC(10,0)
					,@Origen	CHAR(1)
					,@FInicio	VARCHAR(10)
					,@FTermino	VARCHAR(10)
				)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE	 @FechaInicio	DATETIME
			,@FechaTermino	DATETIME
	
	SELECT 	 @FechaInicio = CONVERT(DATETIME, @FInicio)
			,@FechaTermino= CONVERT(DATETIME, @FTermino)

	IF @Modulo = 'BFW'
	BEGIN
		SELECT DISTINCT FolioModificacion,FolioModificacion, CONVERT(VARCHAR(10),FechaModificacion,105) AS 'FechaMod', HoraModificacion
		FROM TBL_REG_MODIFICACIONES
		WHERE FolioContrato = @NumOper
		AND FolioModificacion > 0
		AND Modulo = @Modulo
		AND FechaModificacion BETWEEN @FechaInicio AND @FechaTermino
	END
	IF @Modulo = 'OPT'	---> Debe listar solo las Modificaciones!
	BEGIN
		CREATE TABLE #FolioTmpOpc(
		Orden		NUMERIC(10,0) IDENTITY,
		NumFolio	NUMERIC(9,0),
		FechaMod	VARCHAR(10),
		HoraMod		VARCHAR(8)
		)
		IF @Origen = 'M'
		BEGIN
			INSERT INTO #FolioTmpOpc(NumFolio, FechaMod, HoraMod)
			SELECT MoNumFolio, CONVERT(VARCHAR(10),MoFechaCreacionRegistro,105), CONVERT(VARCHAR(8),MoFechaCreacionRegistro,108) AS 'Hora'
			FROM lnkOpc.CbMdbOpc.dbo.MoEncContrato
			WHERE MoNumContrato = @NuMoper
			AND MoTipoTransaccion = 'MODIFICA'
			AND CONVERT(DATETIME, CONVERT(VARCHAR(10), MoFechaCreacionRegistro,112)) BETWEEN @FechaInicio AND @FechaTermino
		END
		ELSE	---> 'H'
		BEGIN
			INSERT INTO #FolioTmpOpc(NumFolio, FechaMod, HoraMod)
			SELECT MoNumFolio, CONVERT(VARCHAR(10),MoFechaCreacionRegistro,105), CONVERT(VARCHAR(8),MoFechaCreacionRegistro,108) AS 'Hora'
			FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato
			WHERE MoNumContrato = @NuMoper
			AND MoTipoTransaccion = 'MODIFICA'
			AND CONVERT(DATETIME, CONVERT(VARCHAR(10), MoFechaCreacionRegistro,112)) BETWEEN @FechaInicio AND @FechaTermino
		END	
		SELECT * FROM #FolioTmpOpc
		DROP TABLE #FolioTmpOpc
	END
END
GO
