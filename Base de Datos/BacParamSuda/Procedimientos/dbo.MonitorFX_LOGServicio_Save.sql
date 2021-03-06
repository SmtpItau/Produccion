USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_LOGServicio_Save]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_LOGServicio_Save] ( 
													@idTipoMensaje	SMALLINT,
													@LOG_sServicio	VARCHAR(50),
													@LOG_sProceso	VARCHAR(50),
													@LOG_sDetalle	VARCHAR(200)
												)
AS 
BEGIN
	DECLARE @LOG_sEquipo	VARCHAR(50)
	DECLARE @LOG_sIP		VARCHAR(50)
 
	SET @LOG_sEquipo = (SELECT host_name());
 
	SET @LOG_sIP= (SELECT client_net_address
					 FROM sys.dm_exec_connections
					 WHERE session_id = @@spid);
 

	BEGIN TRY

		INSERT INTO [dbo].[MonitorFX_TblLOGServicio]
				   (
					[LOG_dFecha]
				   ,[idTipoMensaje]
				   ,[LOG_sEquipo]
				   ,[LOG_sIP]
				   ,[LOG_sServicio]
				   ,[LOG_sProceso]
				   ,[LOG_sDetalle]
				   
				   )
			 VALUES
					(	GETDATE(),
						@idTipoMensaje,
						@LOG_sEquipo,
						@LOG_sIP,
						@LOG_sServicio,
						@LOG_sProceso,
						@LOG_sDetalle
					)
			SELECT 0	as CodError, 'OK' as Mensaje
	END TRY
	BEGIN CATCH
			SELECT	ERROR_NUMBER() AS CodError,
					ERROR_MESSAGE() AS Mensaje;

	END CATCH;

END 

GO
