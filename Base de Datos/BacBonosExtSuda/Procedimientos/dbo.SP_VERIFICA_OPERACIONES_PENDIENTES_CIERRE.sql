USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_OPERACIONES_PENDIENTES_CIERRE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VERIFICA_OPERACIONES_PENDIENTES_CIERRE]
(
	@fechaProceso	DATETIME    
)
AS
BEGIN 
	SET NOCOUNT ON
	DECLARE @numeroOperPendiente as INT
	
	SELECT @numeroOperPendiente = COUNT(*) FROM text_mvt_dri where mostatreg = 'P' and mofecpro = @fechaProceso
	
	SELECT @numeroOperPendiente
END
GO
