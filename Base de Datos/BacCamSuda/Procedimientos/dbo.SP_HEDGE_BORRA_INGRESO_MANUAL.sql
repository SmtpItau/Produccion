USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_BORRA_INGRESO_MANUAL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_BORRA_INGRESO_MANUAL] (
	 @Fecha_Proceso DATETIME               
)
AS BEGIN
   SET NOCOUNT ON
	DELETE TBL_HEDGE_INGRESO_MANUAL WHERE Fecha_Proceso = @Fecha_Proceso
	IF @@ERROR > 0
	BEGIN
		SELECT -1,'Error: al borrar tabla TBL_HEDGE_INGRESO_MANUAL'
		RETURN -1	
	END
   SET NOCOUNT OFF
END

GO
