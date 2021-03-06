USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_ActualizaCOMEX]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MonitorFX_ActualizaCOMEX]( @fecha DATETIME)
AS
BEGIN 

DECLARE @SQLString		NVARCHAR(500);
DECLARE @ParmDefinition NVARCHAR(500);
DECLARE @PrVentaV		NUMERIC(18,4);
DECLARE @PrComprV		NUMERIC(18,4);
DECLARE @FechaV			CHAR(8);
DECLARE @valor			NUMERIC(18,4);
DECLARE @sDetalle		VARCHAR(100);
	
	BEGIN TRY

		--> 1.0 Se obtiene el ultimo precio el cual es actualizado tanto como Compra y como Venta 
		--> ===============================================================================================================================================
			SET @valor =( 		
						SELECT TblOper.Oper_fPrecio  
						  FROM dbo.MonitorFX_TblOperaciones TblOper 
						 INNER
						  JOIN (SELECT MAX(oper_hora) as Hora 
								  FROM dbo.MonitorFX_TblOperaciones mfto 
						         WHERE mfto.idArchivo = 2 
						        ) AS TblHora
							ON TblHora.Hora = TblOper.Oper_Hora 
						 WHERE TblOper.idArchivo = 2);

		--> 1.5 Asigno datos a variables a Grabar	
		--> ===============================================================================================================================================		
			SET @PrVentaV		= @valor;
			SET @PrComprV		= @valor;
			SET @fecha			= (SELECT CONVERT(CHAR(8),@fecha,112));
			 
			SET @SQLString		= N'EXECUTE baccamsuda.dbo.SP_ACTUALIZA_COSTOCOMEX_MONITOR @PrVenta,@PrCompr,@Fecha'
			SET @ParmDefinition = N'@PrVenta NUMERIC(18,4),@PrCompr  NUMERIC(18,4), @Fecha  CHAR(8)';

		--> 2.0 Ejecuto procedimiento de actualizacion de COMEX
		--> ===============================================================================================================================================		
			EXECUTE sp_executesql	@SQLString, @ParmDefinition, 
									@PrVenta = @PrVentaV,
									@PrCompr = @PrComprV,
									@Fecha	 = @FechaV

			SET @SQLString		= N'[MonitorFX_LOGServicio_Save] @idTipoMensaje,@LOG_sServicio,@LOG_sProceso,@LOG_sDetalle'
			SET @ParmDefinition = N'@idTipoMensaje	SMALLINT,@LOG_sServicio	VARCHAR(50),@LOG_sProceso VARCHAR(50),@LOG_sDetalle	VARCHAR(200)'
			SET @sDetalle		= N'se actualizo informacion'  + CONVERT(VARCHAR,@PrVentaV)
					
			EXECUTE sp_executesql	@SQLString, @ParmDefinition, 
									@idTipoMensaje = 1,
									@LOG_sServicio = 'Actualizacion de Costos COMEX',
									@LOG_sProceso  = 'Actualizacion desde Archivo Texto',
									@LOG_sDetalle  = @sDetalle		  

									

	END TRY
	BEGIN CATCH
			SET @SQLString		= N'[MonitorFX_LOGServicio_Save] @idTipoMensaje,@LOG_sServicio,@LOG_sProceso,@LOG_sDetalle'
			SET @ParmDefinition = N'@idTipoMensaje	SMALLINT,@LOG_sServicio	VARCHAR(50),@LOG_sProceso VARCHAR(50),@LOG_sDetalle	VARCHAR(200)'
			SET @sDetalle		= N'PROBLEMAS EN PROCEDIMIENTO ALMACENADO: '+ ERROR_LINE()   
			
			EXECUTE sp_executesql	@SQLString, @ParmDefinition, 
									@idTipoMensaje = 3,
									@LOG_sServicio = ERROR_PROCEDURE,
									@LOG_sProceso  = ERROR_MESSAGE,
									@LOG_sDetalle  = @sDetalle


		/* 
			SELECT
				ERROR_NUMBER() AS ErrorNumber,
				ERROR_SEVERITY() AS ErrorSeverity,
				ERROR_STATE() AS ErrorState,
				ERROR_PROCEDURE() AS ErrorProcedure,
				ERROR_LINE() AS ErrorLine,
				ERROR_MESSAGE() AS ErrorMessage
		*/
	END CATCH
	
	
END
GO
