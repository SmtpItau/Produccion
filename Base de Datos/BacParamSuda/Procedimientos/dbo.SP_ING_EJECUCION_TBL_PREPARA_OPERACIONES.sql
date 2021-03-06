USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ING_EJECUCION_TBL_PREPARA_OPERACIONES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ING_EJECUCION_TBL_PREPARA_OPERACIONES]
   (
	        @Sistema		char(3)		 	
	   ,	@NroOperacion	numeric(7,0)
	   ,	@Estado			CHAR(1)			
	   ,	@UserEjecuta	varchar(15)		
	   ,	@FechaEjecuta	datetime		
   )

AS
BEGIN
	UPDATE TBL_PREPARA_OPERACIONES SET USUARIO_EJECUTA = @UserEjecuta
			, FECHA_EJECUTA = @FechaEjecuta, ESTADO = @Estado
		WHERE ID_SISTEMA   = @Sistema
			AND NRO_OPERACION =  @NroOperacion
END

GO
