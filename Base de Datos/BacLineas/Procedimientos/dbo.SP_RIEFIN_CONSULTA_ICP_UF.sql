USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_ICP_UF]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_ICP_UF]
	(	@Fecha	DATETIME	)
AS
BEGIN
	-- SP_RIEFIN_CONSULTA_ICP_UF '20110314'

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT	Fecha					= Tabla_ICP.vmfecha
	,		ICP						= Tabla_ICP.vmvalor
	,		UF						= Tabla_UF.vmvalor
	,		USD_OBS					= Tabla_USD_OBS.vmvalor

	,		IBR						= Tabla_IBR.vmvalor
	FROM	bacparamsuda.dbo.VALOR_MONEDA Tabla_ICP
	,		bacparamsuda.dbo.VALOR_MONEDA Tabla_UF
	,		bacparamsuda.dbo.VALOR_MONEDA Tabla_USD_OBS

	,		bacparamsuda.dbo.VALOR_MONEDA Tabla_IBR
	WHERE	Tabla_ICP.vmcodigo		= 800
	AND		Tabla_UF.vmcodigo		= 998
	AND		Tabla_USD_OBS.vmcodigo	= 994
	AND		Tabla_IBR.vmcodigo		= 802
	
	AND		Tabla_ICP.vmvalor		<> 0
	AND		Tabla_ICP.vmfecha		= Tabla_UF.vmfecha
	AND		Tabla_ICP.vmfecha		= Tabla_USD_OBS.vmfecha
   
	AND		Tabla_IBR.vmvalor		<> 0
	AND		Tabla_IBR.vmfecha		= Tabla_UF.vmfecha
	AND		Tabla_IBR.vmfecha		= Tabla_USD_OBS.vmfecha
    ORDER 
    BY		Tabla_ICP.vmfecha
    
END
GO
