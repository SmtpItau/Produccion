USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_ConfArchivo_Eliminar]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_ConfArchivo_Eliminar] (@idCampo INT)
AS
BEGIN
	
	
	DELETE FROM MonitorFX_TblConfArchivos WHERE idArchivo = @idCampo
	    
	        
END

GO
