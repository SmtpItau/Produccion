USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GRABA_DETALLE_GARANTIAS_CONSTITUIDAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GRABA_DETALLE_GARANTIAS_CONSTITUIDAS]
	(	@NumeroOperacion	NUMERIC(10,0)
	,	@FactorMultiplicativo	NUMERIC(18,8)
	,	@Correlativo		NUMERIC(05,00)	
	,	@Instrumento		VARCHAR(12)	
	,	@Mascara		VARCHAR(12)	
	,	@Codigo			NUMERIC(05)	
	,	@Seriado		VARCHAR(1)	
	,	@FechaEmision		DATETIME	
	,	@FechaVencimiento	DATETIME	
	,	@MonedaEmision		NUMERIC(3)	
	,	@BaseEmision		NUMERIC(3)	
	,	@RutEmision		NUMERIC(09,00)	
	,	@Nominal		NUMERIC(21,4)	
	,	@TIR			NUMERIC(9,6)	
	,	@VPAR			NUMERIC(9,6)	
	,	@Vpvp			NUMERIC(9,6)	
	,	@ValorPresente		NUMERIC(21,0)	
	,	@Duration		FLOAT		
	,	@DurationMod		FLOAT		
	,	@Convexidad		FLOAT		
	)
AS 
BEGIN


	
	INSERT INTO dbo.tbl_mov_garantia_detalle
	(	NumeroOperacion		
	,	Correlativo		
	,	Instrumento		
	,	Mascara			
	,	Codigo			
	,	Seriado			
	,	FechaEmision		
	,	FechaVencimiento	
	,	MonedaEmision		
	,	BaseEmision		
	,	RutEmision		
	,	Nominal			
	,	TIR			
	,	VPAR			
	,	Vpvp			
	,	ValorPresente		
	,	ValorPresenteAyer
	,	Duration		
	,	DurationMod	
	,	Convexidad	
	,	FactorMultiplicativo
	) VALUES
	(	@NumeroOperacion		
	,	@Correlativo		
	,	@Instrumento		
	,	@Mascara			
	,	@Codigo			
	,	@Seriado			
	,	@FechaEmision		
	,	@FechaVencimiento	
	,	@MonedaEmision		
	,	@BaseEmision		
	,	@RutEmision		
	,	@Nominal			
	,	@TIR			
	,	@VPAR			
	,	@Vpvp			
	,	@ValorPresente		
	,	0
	,	@Duration		
	,	@DurationMod	
	,	@Convexidad
	,	@FactorMultiplicativo
	)

	IF @@ERROR<>0 
	BEGIN
		SELECT -1, 'Problemas al grabar detalle de garantias constituidas' ;
		RETURN
	END		
	

	INSERT INTO dbo.tbl_cartera_garantia
	(	NumeroOperacion		
	,	Correlativo		
	,	Instrumento		
	,	Mascara			
	,	Nominal			
	,	TIR			
	,	VPAR			
	,	Vpvp			
	,	ValorPresente		
	,	ValorPresenteAyer	
	,	Duration		
	,	DurationMod		
	,	Convexidad		
	) VALUES
	(	@NumeroOperacion		
	,	@Correlativo		
	,	@Instrumento		
	,	@Mascara			
	,	@Nominal			
	,	@TIR			
	,	@VPAR			
	,	@Vpvp			
	,	@ValorPresente		
	,	0	
	,	@Duration		
	,	@DurationMod		
	,	@Convexidad		
	)

	IF @@ERROR<>0 
		SELECT -1, 'Problemas al grabar cartera de garantias constituidas' ;
	ELSE
		SELECT  0, 'OK' ;

END 
GO
