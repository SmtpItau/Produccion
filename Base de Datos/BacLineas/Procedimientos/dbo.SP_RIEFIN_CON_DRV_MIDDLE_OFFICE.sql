USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CON_DRV_MIDDLE_OFFICE]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CON_DRV_MIDDLE_OFFICE]
	(	@Sistema		VARCHAR(3)
	,	@Operacion		NUMERIC(9)
	)	
	
AS
BEGIN
	SET NOCOUNT ON
	SELECT	MddMod 
	,		MddNumOpe                               
	,		MddSujEarlyTerminationSN 
	,		MddSujEarlyTerminationFecha 
	,		MddSujEarlyTerminationPeriodo           
	,		MddTipPer                               
	,		MddModRel 
	,		MddOpeRel                               
	,		MddFecVcto	
	FROM	TBL_RIEFIN_DRV_MIDDLE_OFFICE
	WHERE	MddMod = @Sistema 
	AND		MddNumOpe = @Operacion
	
END
SET NOCOUNT OFF
GO
