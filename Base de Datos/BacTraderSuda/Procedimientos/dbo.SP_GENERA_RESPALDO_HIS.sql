USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_RESPALDO_HIS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GENERA_RESPALDO_HIS]

AS
BEGIN

   SET NOCOUNT ON 

	DECLARE @acfecante   	DATETIME
	,	@acfecproc   	DATETIME
	
	SELECT  @acfecante   = acfecante 
	,       @acfecproc   = acfecproc
	FROM 	BacTraderSuda.dbo.MDAC WITH(NOLOCK)

	DELETE BacParamsuda..HAIRCUT_SOMA_HIS  WHERE Hct_Fecha_Proceso  = @acfecproc  

	INSERT INTO 	BacParamsuda..HAIRCUT_SOMA_HIS 
	(		Hct_Fecha_Proceso
	,		Hct_hcincodigo
	,		Hct_hcClasificacionRiesgo
	,		Hct_hctipoper
	,		Hct_hchaircut
	)  
	
	SELECT 		@acfecproc
	,		hcincodigo 
	,		hcClasificacionRiesgo
	,		hctipoper
	,		hchaircut 
	FROM  		BacParamsuda..HAIRCUT_SOMA WITH(NOLOCK)
                                  				

	DELETE BacParamsuda..MARGEN_INSTRUMENTO_SOMA_HIS WHERE Mgn_Fecha_proceso  = @acfecproc

	INSERT INTO 	BacParamsuda..MARGEN_INSTRUMENTO_SOMA_HIS
	(		Mgn_Fecha_proceso
	,		Mgn_Codigo_Instrumento
	,		Mgn_Clasificacion_Riesgo
	,		Mgn_Plazo_Desde
	, 		Mgn_Plazo_Hasta
	,		Mgn_Margen
	,		Mgn_Tipo_OpSoma 
	)
	SELECT 		@acfecproc
	,		Codigo_Instrumento
	,		Clasificacion_Riesgo
	,		Plazo_Desde
	,		Plazo_Hasta
	,		Margen
	,		Tipo_OpSoma 
	FROM  		BacParamsuda..MARGEN_INSTRUMENTO_SOMA WITH(NOLOCK)


	DELETE BacParamsuda..TASA_REFERENCIA_SOMA_HIS WHERE Rca_Fecha_Proceso  = @acfecproc 

	INSERT INTO 	BacParamsuda..TASA_REFERENCIA_SOMA_HIS
	(		Rca_Fecha_Proceso
	,		Rca_trincodigo
	,		Rca_trClasificacionriesgo
	,		Rca_trserie
	,		Rca_trDesde
	,		Rca_trHasta
	,		Rca_trtipoper
	,		Rca_trtasareferencial
	,		Rca_trrutemisor
	,		Rca_tricodemisor
	,		Rca_trgenericemisor 
	)
	SELECT 		@acfecproc
	,		trincodigo
	,		trClasificacionRiesgo
	,		trserie
	,		trDesde
	,		trHasta
	,		trtipoper
	,		trtasareferencial
	,		trrutemisor
	,		tricodemisor
	,		trgenericemisor 
	FROM  		BacParamsuda..TASA_REFERENCIA_SOMA WITH(NOLOCK)
		

------
	DELETE BacTraderSuda..CARTERA_CUENTA_HIS WHERE FechaProc = @acfecproc 

	INSERT INTO 	BacTraderSuda..CARTERA_CUENTA_HIS
	(		FechaProc
	,		Sistema
	,		t_movimiento
	,		t_operacion
	,		RutCartera
	,		NumDocu
	,		Correla
	,		NumOper
	,		CodigoInst
	,		Instrumento
	,		Mascara
	,		InstSer
	,		Moneda
	,		CMoneda
	,		Nominal
	,		Monto
	,		Variable
	,		Seriado
	,		CtaContable
	,		FolPerfil
	,		CorPerfil
	,		CodigoVariable
	,		Fijo
	,		CampoVariable
	,		RutCliente
	,		CodigoCliente
	,		RutEmisor
	,		tipobono
	,		ForPagI
	,		ForPagV
	,		TipoLinea
	,		TipoLetra
	,		FechaInip
	,		FechaVtop
	)
	SELECT 	@acfecproc
	,		Sistema
	,		t_movimiento
	,		t_operacion
	,		RutCartera
	,		NumDocu
	,		Correla
	,		NumOper
	,		CodigoInst
	,		Instrumento
	,		Mascara
	,		InstSer
	,		Moneda
	,		CMoneda
	,		Nominal
	,		Monto
	,		Variable
	,		Seriado
	,		CtaContable
	,		FolPerfil
	,		CorPerfil
	,		CodigoVariable
	,		Fijo
	,		CampoVariable
	,		RutCliente
	,		CodigoCliente
	,		RutEmisor
	,		tipobono
	,		ForPagI
	,		ForPagV
	,		TipoLinea
	,		TipoLetra
	,		FechaInip
	,		FechaVtop
	FROM  		BacTraderSuda..CARTERA_CUENTA WITH(NOLOCK)


	
	IF @@ERROR <> 0 
		BEGIN
		SELECT -1, 'Error: En  Generar respaldo HIS.'
		SET NOCOUNT OFF
		RETURN
	END

END
GO
