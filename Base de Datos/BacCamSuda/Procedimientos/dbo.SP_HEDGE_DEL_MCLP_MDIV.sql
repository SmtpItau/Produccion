USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_DEL_MCLP_MDIV]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_DEL_MCLP_MDIV]
	--@fecha_proceso DATETIME
AS
BEGIN
 	SET NOCOUNT ON

	DELETE TBL_HEDGE_MCLP --WHERE fecha_proceso = @fecha_proceso
	IF @@ERROR>0
	BEGIN
		SELECT -1,'Error: al limpiar tabla de interfaz Hedge'
		RETURN -1
	END
	DELETE TBL_HEDGE_MDIV ---WHERE fecha_proceso = @fecha_proceso
	IF @@ERROR>0
	BEGIN
		SELECT -1,'Error: al limpiar tabla de interfaz Hedge'
		RETURN -1
	END
 	SET NOCOUNT OFF
	SELECT 'OK'

END

GO
