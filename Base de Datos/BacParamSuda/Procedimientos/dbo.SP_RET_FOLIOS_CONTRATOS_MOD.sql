USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RET_FOLIOS_CONTRATOS_MOD]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RET_FOLIOS_CONTRATOS_MOD]
				(
					 @Modulo	CHAR(3)
					,@FecIni	VARCHAR(10)
					,@FecFin	VARCHAR(10)
				)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE  @FechaInicial 	DATETIME
			,@FechaFinal	DATETIME
			
	SELECT 	 @FechaInicial = CONVERT(DATETIME, @FecIni)
			,@FechaFinal   = CONVERT(DATETIME, @FecFin)
			
	SELECT DISTINCT FolioContrato
	FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
	WHERE Modulo = @Modulo
	AND FechaModificacion BETWEEN @FechaInicial AND @FechaFinal
	SET NOCOUNT OFF
END
GO
