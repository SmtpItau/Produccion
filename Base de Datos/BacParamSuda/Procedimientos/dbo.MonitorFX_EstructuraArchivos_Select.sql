USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_EstructuraArchivos_Select]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_EstructuraArchivos_Select] (@idArchivo SMALLINT)
AS 

	SELECT ea.* , td.sDescripcion as TipoDato, Ca.sCampoFisico as sNombreCampo

	  FROM dbo.MonitorFX_TblEstructuraArchivos  EA
 
	 INNER 

	  JOIN dbo.MonitorFX_TblTipoDatos td 

	    on td.idTipoDato = Ea.idTipoDato

     left 
	 
	  JOIN DBO.MonitorFX_TblCamposArchivo  Ca

	    ON ca.idCampo  = ea.idcampo 



	 WHERE idArchivo = @idArchivo 
	 order by idposicion
GO
