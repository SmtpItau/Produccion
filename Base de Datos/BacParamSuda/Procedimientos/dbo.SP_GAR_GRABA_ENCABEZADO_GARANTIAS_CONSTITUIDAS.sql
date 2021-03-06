USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GRABA_ENCABEZADO_GARANTIAS_CONSTITUIDAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GRABA_ENCABEZADO_GARANTIAS_CONSTITUIDAS]
	(	@NumeroOperacion	NUMERIC(10,0)
	,	@FactorAditivo		NUMERIC(18,8)
	,	@nRut			NUMERIC(10,0)
	,	@nCodigo		NUMERIC(05,0)
	,	@FechaOperacion		DATETIME	
	,	@sTipoMovimiento	VARCHAR(01)
	,	@dTotalGarantia		NUMERIC(21,0)
	,	@sEstado		VARCHAR(01)
	,	@sObservaciones 	VARCHAR(255)
	,	@sUsuario		VARCHAR(15)
	,	@dFechaVigencia		DATETIME	
	,	@iTipoGarantia		INTEGER
	)

AS
BEGIN

	SET NOCOUNT ON				;

	IF EXISTS ( SELECT * FROM bacparamsuda.dbo.tbl_mov_garantia WHERE NumeroOperacion = @NumeroOperacion )
	BEGIN
		UPDATE bacparamsuda.dbo.tbl_mov_garantia
		   SET  tipoGarantia  = @iTipoGarantia
		,       fechavigencia = @dFechaVigencia	
		,	FactorAditivo = @FactorAditivo
		 WHERE NumeroOperacion = @NumeroOperacion			;
	END ELSE 
	BEGIN 
		INSERT INTO bacparamsuda.dbo.tbl_mov_garantia
		(	NumeroOperacion		
		,	FactorAditivo
		,	RutCliente		
		,	CodCliente		
		,	Fecha			
		,	TipoMovimiento		
		,	TotalMovimiento		
		,	Estado			
		,	Observaciones		
		,	Usuario			
		,	FechaVigencia		
		,	TipoGarantia		
		) VALUES 
		(	@NumeroOperacion	
		,	@FactorAditivo
		,	@nRut			
		,	@nCodigo		
		,	@FechaOperacion		
		,	@sTipoMovimiento	
		,	@dTotalGarantia		
		,	@sEstado		
		,	@sObservaciones 	
		,	@sUsuario		
		,	@dFechaVigencia		
		,	@iTipoGarantia		
		)						;
	END
	IF @@ERROR<>0 
		SELECT -1, 'Problemas al grabar informacion del encabezado de garantias otorgadas' ;
	ELSE
		SELECT  0, 'OK' ;
	
END
GO
