USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_OPT_REG_MOD]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRAR_OPT_REG_MOD]
	(
		@NumOper	NUMERIC(10, 0)
	)
AS 
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT 1 FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT WHERE Modulo = 'OPT' AND FolioContrato = @NumOper)
		DELETE FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT WHERE Modulo = 'OPT' AND FolioContrato = @NumOper

	SET NOCOUNT OFF	
END
GO
