USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_EstructuraArchivo_Eliminar]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MonitorFX_EstructuraArchivo_Eliminar] (@idTipoArchivo int, @idCodigoArchivo int)
AS
BEGIN
	
	/*
	*/
	
	DELETE FROM MonitorFX_TblEstructuraArchivos WHERE idArchivo = @idTipoArchivo AND idPosicion = @idCodigoArchivo
	
	    
	        
END

GO
