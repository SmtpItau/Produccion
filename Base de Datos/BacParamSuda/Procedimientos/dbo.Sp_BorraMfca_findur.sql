USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BorraMfca_findur]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BorraMfca_findur]
(
	@Fecha_proceso		AS DATETIME	
)
AS
BEGIN
	SET NOCOUNT OFF
	
	IF EXISTS (SELECT 1 FROM mfca_findur WHERE Fecha_proceso = @Fecha_proceso)
	BEGIN
		DELETE FROM mfca_findur WHERE Fecha_proceso = @Fecha_proceso		
	END
	
	SET NOCOUNT ON;
END
GO
