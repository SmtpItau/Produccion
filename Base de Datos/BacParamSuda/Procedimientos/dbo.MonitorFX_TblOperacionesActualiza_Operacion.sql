USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_TblOperacionesActualiza_Operacion]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_TblOperacionesActualiza_Operacion]( @idPosicion BIGINT,  @iNumeroBAC INT )
AS 
BEGIN 
	
	UPDATE dbo.MonitorFX_TblOperaciones
	SET NUMEROBAC = @iNumeroBAC
	WHERE idPosicion = @idPosicion 
	
end
GO
