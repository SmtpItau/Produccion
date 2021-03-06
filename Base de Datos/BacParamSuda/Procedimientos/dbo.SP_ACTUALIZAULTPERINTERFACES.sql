USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAULTPERINTERFACES]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZAULTPERINTERFACES]
	(	@Umes CHAR(2),
		@Uano CHAR(4)
	)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE Bacparamsuda..tbl_Parametros_Gral_Garantias
	SET UltPeriodoInterfaces = @Umes + @Uano
	IF @@ERROR <> 0
		SELECT 'ERROR'
	ELSE
		SELECT 'OK'
	SET NOCOUNT OFF
END
GO
