USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CRG_TBL_OPERACIONES_OMA_EXTERNAS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CRG_TBL_OPERACIONES_OMA_EXTERNAS]
	(	@Fecha				DATETIME					--> Fecha de la Transacción					: yyyymmdd  
	,	@FolioContrato		NUMERIC(9)					--> Folio de la Transacción					: 999999999  
	,	@TipoTransaccion	CHAR(1)						--> Tipo de Transaccion						: C=Compra; V=venta  
	,	@MtoDolares			NUMERIC(21,4)				--> Monto en Dolares						:   
	,	@TipoCambio			NUMERIC(21,4)				--> Tipo de Cambio Dolar/Peso				:  
	,	@MtoPesos			NUMERIC(21,0)				--> Monto conversion en Pesos				:  
	,	@CodigoOMA			NUMERIC(5)					--> Codigo OMA Asociado a la Transacción	:  
	,	@Estado				CHAR(1)						--> Estado de la operacion					: ''=Vigente; 'A'=Anulada  
	,	@RutCliente			NUMERIC(9)					--> Rut Cliente sin digito					: 1.111.111   
	,	@NombreCliente		VARCHAR(50)					--> Nombre Cliente							: JUAN PEREZ  
	,	@NemoCliente		VARCHAR(100)				--> Nemotécnico del Segmento del Cliente	: ‘INMO’  
	,	@Origen				VARCHAR(20)	= 'TEFUSDWEB'	-->	Origen de la Divisa	: Dolar Web='TEFUSDWEB'; DolarNY='TEFCBNY'
	)  
AS  
BEGIN  
  
	SET NOCOUNT ON  

	INSERT INTO dbo.TBL_CONTROL_OMA_EXT
	SELECT 	@Fecha
		,	@FolioContrato
		,	@TipoTransaccion
		,	@MtoDolares
		,	@TipoCambio
		,	@MtoPesos
		,	@CodigoOMA
		,	@Estado
		,	@RutCliente
		,	@NombreCliente
		,	@NemoCliente
		,	@Origen
		,	FechaControl	= getdate()


	--Se reduce la precisión de la fecha para armar PK con el FolioContrato  
	--Con esto se evita que entren dos operaciones con mismo folio.  
	SET @Fecha				= CONVERT(DATETIME,CONVERT(CHAR(10), @Fecha, 112), 112)  
	SET @TipoTransaccion	= CASE WHEN @TipoTransaccion = 'C' THEN 'V' ELSE 'C' END  
	SET @TipoTransaccion	= CASE WHEN @Origen = 'TEFCBNY' THEN 'C' ELSE @TipoTransaccion END  
	SET @NemoCliente		= LTRIM(RTRIM( @NemoCliente ))  

	INSERT INTO dbo.TBL_CONTROL_OMA_EXT
	SELECT 	@Fecha
		,	@FolioContrato
		,	@TipoTransaccion
		,	@MtoDolares
		,	@TipoCambio
		,	@MtoPesos
		,	@CodigoOMA
		,	@Estado
		,	@RutCliente
		,	@NombreCliente
		,	@NemoCliente
		,	@Origen
		,	FechaControl	= getdate()

	
	IF EXISTS ( SELECT 1 FROM dbo.TBL_OPERACIONES_OMA_EXTERNAS WHERE Fecha = @Fecha AND FolioContrato = @FolioContrato )  
	BEGIN  
		UPDATE	dbo.TBL_OPERACIONES_OMA_EXTERNAS
		SET		TipoTransaccion = @TipoTransaccion
		,		MtoDolares		= @MtoDolares
		,		TipoCambio		= @TipoCambio
		,		MtoPesos		= @MtoPesos
		,		CodigoOMA		= @CodigoOMA
		,		Estado			= @Estado
		,		RutCliente		= @RutCliente
		,		NombreCliente	= @NombreCliente
		,		Origen			= @Origen
		WHERE	Fecha			= @Fecha
		AND		FolioContrato	= @FolioContrato
	END ELSE  
	BEGIN  
		INSERT INTO dbo.TBL_OPERACIONES_OMA_EXTERNAS
		(	Fecha
		,	FolioContrato
		,	TipoTransaccion
		,	MtoDolares
		,	TipoCambio
		,	MtoPesos
		,	CodigoOMA
		,	Estado
		,	RutCliente
		,	NombreCliente
		,	Origen
		)  
		VALUES
		(	@Fecha
		,	@FolioContrato
		,	@TipoTransaccion
		,	@MtoDolares
		,	@TipoCambio
		,	@MtoPesos
		,	@CodigoOMA
		,	@Estado
		,	@RutCliente
		,	@NombreCliente
		,	@Origen
		)
	END

	--Esto debería estar en un TRANSACTION  
	DECLARE @SpreadTrading		AS NUMERIC(18,4);  
		SET @SpreadTrading		= 0;  

	DECLARE @SpreadComercial	AS NUMERIC(18,4);  
		SET @SpreadComercial	= 0;  
  
	SELECT	@SpreadTrading		= CASE @TipoTransaccion WHEN 'C' THEN Spread_Trading_Compra	ELSE Spread_Trading_Venta	END
		,	@SpreadComercial	= CASE @TipoTransaccion WHEN 'C' THEN Spread_Compra			ELSE Spread_Venta			END
	FROM	dbo.COSTOS_COMEX_IBS
	WHERE	Fecha				= (SELECT acfecpro FROM dbo.MEAC with(nolock) )
	AND		nemo				= LTRIM(RTRIM( @NemoCliente ))
	AND		codmoneda			= 13
	AND		@MtoDolares			BETWEEN ENTRE_DESDE AND ENTRE_HASTA

	UPDATE	dbo.TBL_OPERACIONES_OMA_EXTERNAS
	SET		SpreadTrading		= @SpreadTrading
		,	SpreadComercial		= @SpreadComercial
		,	Notificada			= ''
	WHERE	Fecha				= @Fecha
	AND		FolioContrato		= @FolioContrato
  
END
GO
