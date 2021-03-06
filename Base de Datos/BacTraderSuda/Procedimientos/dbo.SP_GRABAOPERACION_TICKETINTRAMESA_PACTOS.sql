USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAOPERACION_TICKETINTRAMESA_PACTOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE 
[dbo].[SP_GRABAOPERACION_TICKETINTRAMESA_PACTOS] 
	( 	@nNumOper 		NUMERIC(10,0)
	,	@sTipoper		VARCHAR(03)
	,	@nNumoperRel		NUMERIC(10,0)
	,	@dFechaOperacion	DATETIME
	,	@iCodCarteraOrigen	SMALLINT
	,	@iCodMesaOrigen		SMALLINT
	,	@iCodCarteraDestino	SMALLINT
	,	@iCodMesaDestino	SMALLINT
	,	@nMoneda		NUMERIC(3)
	,	@nMontoInicialCLP	NUMERIC(21,4)
	,	@nTasa			NUMERIC(09,4)	
	,	@nMontoInicial		NUMERIC(21,4)
	,	@nPlazo			SMALLINT
	,	@dFechaVencimiento	DATETIME
	,	@nMontoFinal		NUMERIC(21,4)
	,	@sUsuario		VARCHAR(10)
	)
AS 
BEGIN 

	SET NOCOUNT ON 	;


	DECLARE @sTipoperRelacion	VARCHAR(03)	;
	    SET @sTipoperRelacion	= CASE @sTipoper WHEN 'VI' THEN 'CI' 
							 ELSE 'VI' END ;


	INSERT INTO 
	dbo.tbl_movTicketRtaFija(
		Fecha_Operacion
	,	Numero_Documento
	, 	Correlativo
	,	Numero_Documento_Relacion
	,	Correlativo_Relacion
	,	Numero_Operacion
	,	Correlativo_Operacion
	, 	CodCarteraOrigen
	,	CodMesaOrigen
	,	CodCarteraDestino
	,	CodMesaDestino
	,	Tipo_Operacion
	,	Nemotecnico
	,	Mascara
	,	CodigoInstrumento
	,	Seriado
	,	Fecha_Emision
	,	Fecha_Vencimiento
	,	Moneda_Emision
	,	Tasa_Emision
	,	Base_Emision
	,	Rut_Emision
	,	Valor_Nominal
	,	Tir
	,	pvp
	,	vpar
	,	Tir_Estimada
	,	Valor_Presente
	,	Valor_Compra
	,	Valor_Compra_UM
	,	Valor_Tasa_Emision
	,	Valor_PrimaDescto
	,	Valor_InicialPacto
	,	Valor_VencimientoPacto
	,	Hora
	,	Usuario
	,	Pagohoy
	,	Fecha_Activacion
	)
	VALUES (
		@dFechaOperacion
	,	@nNumoper
	,	1
	,	0
	,	0	
	,	@nNumoper
	,	1
	,	@iCodCarteraOrigen
	,	@iCodMesaOrigen
	,	@iCodCarteraDestino
	,	@iCodMesaDestino
	,	@sTipoper
	,	''
	,	''
	,	0
	,	''
	,	@dFechaOperacion
	,	@dFechaVencimiento
	,	@nMoneda
	,	0
	,	0
	,	0
	,	0
	,	@nTasa
	,	0
	,	0
	,	0
	,	@nMontoInicialCLP
	,	0
	,	0	
	,	0
	,	0
	,	@nMontoInicial
	,	@nMontoFinal
	,	CONVERT(CHAR(08), GETDATE(),108)
	,	@sUsuario
	,	'S'
	,	@dFechaOperacion
	)
	

	IF @@ERROR <> 0 RETURN -1

	INSERT INTO 
	dbo.tbl_movTicketRtaFija(
		Fecha_Operacion
	,	Numero_Documento
	, 	Correlativo
	,	Numero_Documento_Relacion
	,	Correlativo_Relacion
	,	Numero_Operacion
	,	Correlativo_Operacion
	, 	CodCarteraOrigen
	,	CodMesaOrigen
	,	CodCarteraDestino
	,	CodMesaDestino
	,	Tipo_Operacion
	,	Nemotecnico
	,	Mascara
	,	CodigoInstrumento
	,	Seriado
	,	Fecha_Emision
	,	Fecha_Vencimiento
	,	Moneda_Emision
	,	Tasa_Emision
	,	Base_Emision
	,	Rut_Emision
	,	Valor_Nominal
	,	Tir
	,	pvp
	,	vpar
	,	Tir_Estimada
	,	Valor_Presente
	,	Valor_Compra
	,	Valor_Compra_UM
	,	Valor_Tasa_Emision
	,	Valor_PrimaDescto
	,	Valor_InicialPacto
	,	Valor_VencimientoPacto
	,	Hora
	,	Usuario
	,	Pagohoy
	,	Fecha_Activacion
	)
	VALUES (
		@dFechaOperacion
	,	@nNumoperRel
	,	1
	,	@nNumoper
	,	1	
	,	@nNumoperRel
	,	1
	,	@iCodCarteraDestino	---JBH, 18-12-2009  @iCodCarteraOrigen
	,	@iCodMesaDestino	---JBH, 18-12-2009  @iCodMesaOrigen
	,	@iCodCarteraOrigen	---JBH, 18-12-2009  @iCodCarteraDestino
	,	@iCodMesaOrigen		---JBH, 18-12-2009  @iCodMesaDestino
	,	@sTipoperRelacion
	,	''
	,	''
	,	0
	,	''
	,	@dFechaOperacion
	,	@dFechaVencimiento
	,	@nMoneda
	,	0
	,	0
	,	0
	,	0
	,	@nTasa
	,	0
	,	0
	,	0
	,	@nMontoInicialCLP
	,	0
	,	0	
	,	0
	,	0
	,	@nMontoInicial
	,	@nMontoFinal
	,	CONVERT(CHAR(08), GETDATE(),108)
	,	@sUsuario
	,	'S'
	,	@dFechaOperacion
	)

	IF @@ERROR <> 0 RETURN -1

	INSERT INTO dbo.tbl_carTicketRtaFija( 
		Fecha_Operacion
	,	Numero_Documento
	, 	Correlativo
	,	Numero_Documento_Relacion
	,	Correlativo_Relacion		
	,	Numero_Operacion		
	, 	CodCarteraOrigen		
	,	CodMesaOrigen			
	,	Tipo_Operacion			
	,	Nemotecnico			
	,	Mascara				
	,	CodigoInstrumento	
	,	Moneda	
	,	Seriado				
	,	Valor_Nominal			
	,	Tir				
	,	pvp				
	,	vpar				
	,	Tir_Estimada			
	,	Valor_Presente			
	,	Valor_Compra			
	,	Valor_Compra_UM			
	,	Valor_Tasa_Emision		
	,	Valor_PrimaDescto		
	,	Duration			
	,	DurationMod			
	,	Convexidad			
	,	Valor_InicialPacto		
	,	Valor_VencimientoPacto		
	,	Fecha_Vencimiento		
	,	NumeroUltCupon			
	,	FechaUltCupon			
	,	FechaProxCupon			
	,	PagoHoy				
	) 
	  VALUES
	(
		@dFechaOperacion	
	,	@nNumoper
	,	1
	,	0
	,	0
	,	@nNumoper
	,	@iCodCarteraOrigen
	,	@iCodMesaOrigen
	,	@sTipoper
	,	''
	,	''
	,	0
	,	@nmoneda
	,	''
	,	0
	,	@nTasa
	,	0
	,	0
	,	0
	,	@nMontoInicialCLP
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	@nMontoInicial
	,	@nMontoFinal
	,	@dFechaVencimiento			
	,	0		
	,	''
	,	''
	,	'S'
	)

	IF @@ERROR <> 0 RETURN -1

	INSERT INTO dbo.tbl_carTicketRtaFija( 
		Fecha_Operacion
	,	Numero_Documento
	, 	Correlativo
	,	Numero_Documento_Relacion
	,	Correlativo_Relacion		
	,	Numero_Operacion		
	, 	CodCarteraOrigen		
	,	CodMesaOrigen			
	,	Tipo_Operacion			
	,	Nemotecnico			
	,	Mascara				
	,	CodigoInstrumento	
	,	Moneda	
	,	Seriado				
	,	Valor_Nominal			
	,	Tir				
	,	pvp				
	,	vpar				
	,	Tir_Estimada			
	,	Valor_Presente			
	,	Valor_Compra			
	,	Valor_Compra_UM			
	,	Valor_Tasa_Emision		
	,	Valor_PrimaDescto		
	,	Duration			
	,	DurationMod			
	,	Convexidad			
	,	Valor_InicialPacto		
	,	Valor_VencimientoPacto		
	,	Fecha_Vencimiento		
	,	NumeroUltCupon			
	,	FechaUltCupon			
	,	FechaProxCupon			
	,	PagoHoy				
	) 
	  VALUES
	(
		@dFechaOperacion	
	,	@nNumoperRel
	,	1
	,	@nNumoper
	,	1
	,	@nNumoperRel
	,	@iCodCarteraDestino	---JBH, 18-12-2009  @iCodCarteraOrigen
	,	@iCodMesaDestino	---JBH, 18-12-2009  @iCodMesaOrigen
	,	@sTipoperRelacion
	,	''
	,	''
	,	0
	,	@nmoneda
	,	''
	,	0
	,	@nTasa
	,	0
	,	0
	,	0
	,	@nMontoInicialCLP
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	@nMontoInicial
	,	@nMontoFinal
	,	@dFechaVencimiento			
	,	0		
	,	''
	,	''
	,	'S'
	)

	IF @@ERROR=0 SELECT 1
	ELSE SELECT -1



END

GO
