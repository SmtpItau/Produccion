USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECUPERA_RUTA_DESCARGA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RECUPERA_RUTA_DESCARGA] (@idAmbiente VARCHAR(50))
AS
	/*
	dbo.SP_RECUPERA_RUTA_DESCARGA 7
	*/
	SELECT Arch_sRutaFisica
		  , cA.Arch_sNombreFisico
	FROM   [dbo].[MonitorFX_TblConfArchivos] cA
	       LEFT JOIN dbo.MonitorFX_TblTipoArchivos tA
	            ON  Ta.idTipoArchivo = cA.idTipoArchivo
	       INNER JOIN dbo.MonitorFX_TblSeparadores tS
	            ON  tS.idSeparador = cA.idSeparador
	WHERE  [Arch_bHabilitado]     = 1
	       AND idAmbiente         = 7 ;       
	       
	       
GO
