USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_Mantenedores_Eliminar]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_Mantenedores_Eliminar] (@idCampo INT)
AS
BEGIN
	
	/*
	dbo.MonitorFX_Mantenedores_Eliminar 20
	*/
	
	    DELETE FROM MonitorFX_TblCamposArchivo
	    WHERE idCampo = @idCampo
	        
END
GO
