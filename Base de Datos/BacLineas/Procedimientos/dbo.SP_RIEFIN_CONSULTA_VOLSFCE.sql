USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_VOLSFCE]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_VOLSFCE] 
(   @Fecha DATETIME 
  , @Numero_Simulaciones int  )

AS
BEGIN
-- SP_RIEFIN_CONSULTA_VOLSFCE '20110311', 301


	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Set @Numero_Simulaciones = @Numero_Simulaciones + 1
	-- Consulta de Fechas
	SELECT TOP (@Numero_Simulaciones) -- MAP: antes era 301
		Fecha = acfecproc
	INTO #TEMP_FECHA
    FROM
		BactraderSuda.dbo.fechas_proceso  -- select * from BactraderSuda.dbo.fechas_proceso order by fecha desc
    WHERE
		fecha <= @Fecha
    ORDER BY
		acfecproc
	DESC
	-- Consulta de Fechas
	
	-- Tabla que contiene las volatilidades ATM
	SELECT
		smlfecha
	,	smlparfor
	,	smldias
	,	smlmid
	INTO	#ATM
	FROM
		lnkopc.cbmdbopc.dbo.smile -- MAP: antes era Parametros.dbo.SMILE  select * from lnkopc.cbmdbopc.dbo.smile
	,	#TEMP_FECHA TEMP_FECHA	
	WHERE
		smlfecha = TEMP_FECHA.Fecha
	AND	smlestructura = 1
	
	-- Tabla que contiene las volatilidades RR25
	SELECT
		smlfecha
	,	smlparfor
	,	smldias
	,	smlmid
	INTO	#RR25
	FROM
		lnkopc.cbmdbopc.dbo.smile -- MAP: antes era Parametros.dbo.SMILE 
	,	#TEMP_FECHA TEMP_FECHA		
	WHERE
		smlfecha = TEMP_FECHA.Fecha
	AND	smlestructura = 2
	AND	smldelta = 25
	
	-- Tabla que contiene las volatilidades BF25
	SELECT
		smlfecha
	,	smlparfor
	,	smldias
	,	smlmid
	INTO	#BF25
	FROM
		lnkopc.cbmdbopc.dbo.smile -- MAP: antes era Parametros.dbo.SMILE 
	,	#TEMP_FECHA TEMP_FECHA		
	WHERE
		smlfecha = TEMP_FECHA.Fecha
	AND	smlestructura = 3
	AND	smldelta = 25
	
	-- Tabla que contiene las volatilidades RR10
	SELECT
		smlfecha	
	,	smlparfor
	,	smldias
	,	smlmid
	INTO	#RR10
	FROM
		lnkopc.cbmdbopc.dbo.smile -- MAP: antes era Parametros.dbo.SMILE 
	,	#TEMP_FECHA TEMP_FECHA		
	WHERE
		smlfecha = TEMP_FECHA.Fecha
	AND	smlestructura = 2
	AND	smldelta = 10
	
	-- Tabla que contiene las volatilidades BF10
	SELECT
		smlfecha
	,	smlparfor
	,	smldias
	,	smlmid
	INTO	#BF10
	FROM
		lnkopc.cbmdbopc.dbo.smile -- MAP: antes era Parametros.dbo.SMILE 
	,	#TEMP_FECHA TEMP_FECHA		
	WHERE
		smlfecha = TEMP_FECHA.Fecha
	AND	smlestructura = 3
	AND	smldelta = 10
	
	SELECT
		'Fecha' = ATM.smlfecha
	,	'Correlativo' = PARAMETRIZA.Codigo_Vol
	,	'Moneda' = PARAMETRIZA_MONEDA.Codigo
	,	'rd' = RD.Codigo
	,	'rf' = RF.Codigo
	,	'Plazo' = ATM.smldias
	,	'PUT10D' = ATM.smlmid + BF10.smlmid - 0.5 * RR10.smlmid
	,	'PUT25D' = ATM.smlmid + BF25.smlmid - 0.5 * RR25.smlmid
	,	'ATM' = ATM.smlmid
	,	'CALL25D' = ATM.smlmid + BF25.smlmid + 0.5 * RR25.smlmid
	,	'CALL10D' = ATM.smlmid + BF10.smlmid + 0.5 * RR10.smlmid
	FROM
		#ATM ATM
	,	#RR25 RR25
	,	#BF25 BF25
	,	#RR10 RR10
	,	#BF10 BF10
	,	ParametrosdboParametrizacion_Opciones_FX PARAMETRIZA     -- select  * from ParametrosdboParametrizacion_Opciones_FX
	,	ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA  -- select * from ParametrosdboParametrizacion_Monedas
	,	ParametrosdboParametrizacion_Curvas RD                   -- select * from ParametrosdboParametrizacion_Curvas
	,	ParametrosdboParametrizacion_Curvas RF  -- select * from ParametrosdboParametrizacion_Curvas where Curva like '%SWAP%'
	WHERE
		ATM.smldias = RR25.smldias
	AND	ATM.smldias = BF25.smldias
	AND	ATM.smldias = RR10.smldias
	AND	ATM.smldias = BF10.smldias
	AND	ATM.smlparfor = PARAMETRIZA.Par_Monedas
	AND	ATM.smlparfor = RR25.smlparfor
	AND	ATM.smlparfor = BF25.smlparfor
	AND	ATM.smlparfor = RR10.smlparfor
	AND	ATM.smlparfor = BF10.smlparfor
	AND	PARAMETRIZA.Tipo_Cambio = PARAMETRIZA_MONEDA.Codigo_BAC
	AND	PARAMETRIZA.Curva_1 = RD.Curva
	AND	PARAMETRIZA.Curva_2 = RF.Curva
	AND	RD.Producto = 'Opciones'
	AND	RF.Producto = 'Opciones'
	AND	ATM.smlfecha = RR25.smlfecha
	AND	ATM.smlfecha = BF25.smlfecha
	AND	ATM.smlfecha = RR10.smlfecha
	AND	ATM.smlfecha = BF10.smlfecha
	ORDER BY
		ATM.smlfecha DESC
	,	PARAMETRIZA.Codigo_Vol
	,	ATM.smldias
    
END

GO
