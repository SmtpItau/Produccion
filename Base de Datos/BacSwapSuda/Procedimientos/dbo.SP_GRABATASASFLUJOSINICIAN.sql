USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABATASASFLUJOSINICIAN]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABATASASFLUJOSINICIAN]
	(   @numero_operacion	NUMERIC(10)  
	,   @numero_flujo		NUMERIC(10)  
	,   @valor_tasa			NUMERIC(21,6)  
	,   @tipo_flujo			NUMERIC(05)  
	,   @iSwSwapPromedio	INTEGER    = 0  
	)
AS
BEGIN
    -- dbo.SP_CONSULTAFLUJOSINICIAN 0, '20140528', '20140528'
	SET NOCOUNT ON

	DECLARE @CntDecimales		NUMERIC(02)

	declare @cCodTasa			numeric(3)   
	declare @cSpread			float  
	declare @cBase				integer  
	declare @fecInicioFlujo		datetime  
	declare @fecVenceFlujo		datetime  
	declare @cPeriodo			integer  
	declare @cInteres			float  
	declare @cSaldo				float  
	declare @cAmortiza			float  
	declare @cMoneda			numeric(3)  
	declare @Cextranjera		character(2)  
	declare @Tasa				float  

	declare @fechaFijacion      datetime -- PRD20732 o PRD20872
  
	IF @iSwSwapPromedio = 0
	BEGIN

		if @tipo_flujo = 1
			update CARTERA
			set    compra_valor_tasa = @valor_tasa
			,      compra_valor_tasa_hoy = @valor_tasa
			,      compra_zcr        = 1
			where  @numero_operacion = numero_operacion
			and    @numero_flujo     = numero_flujo
			and    @tipo_flujo       = tipo_flujo
		else
			update CARTERA
			set    venta_valor_tasa  = @valor_tasa
			,      venta_valor_tasa_hoy = @valor_tasa
			,      venta_zcr         = 1
			where  @numero_operacion = numero_operacion
			and    @numero_flujo     = numero_flujo
			and    @tipo_flujo       = tipo_flujo

		-- Actualiza Flujo de inmediato  
		-- Se asume qaue la tasa está grabada  

		if @Tipo_flujo = 1  
			select  @cCodTasa			= compra_codigo_tasa   
				,	@cSpread			= compra_spread  
				,	@cBase				= compra_base  
				,	@fecInicioFlujo		= fecha_inicio_flujo  
				,	@fecVenceFlujo		= fecha_vence_flujo  
				,	@cPeriodo			= Compra_codamo_interes  
				,	@cInteres			= 0.0  
				,	@cSaldo				= COmpra_saldo  
				,	@cAmortiza			= Compra_Amortiza  
				,	@Cmoneda			= Compra_moneda  
				,   @fechaFijacion      = fecha_fijacion_tasa    -- PRD20732 o PRD20872
			from	cartera				with(nolock)
			where	numero_operacion	= @numero_operacion   
			and		numero_flujo		= @Numero_flujo  
			and		tipo_flujo			= @Tipo_Flujo  
		else
			select  @cCodTasa			= venta_codigo_tasa   
				,	@cSpread			= venta_spread  
				,	@cBase				= venta_base  
				,	@fecInicioFlujo		= fecha_inicio_flujo  
				,	@fecVenceFlujo		= fecha_vence_flujo  
				,	@cPeriodo			= Venta_codamo_interes  
				,	@cInteres			= 0.0  
				,	@cSaldo				= Venta_saldo  
				,	@cAmortiza			= Venta_Amortiza  
				,	@CMoneda			= Venta_moneda  
				,   @fechaFijacion      = fecha_fijacion_tasa    -- PRD20732 o PRD20872
			from	cartera				with(nolock)
			where	numero_operacion	= @numero_operacion   
			and		numero_flujo		= @Numero_flujo  
			and		tipo_flujo			= @Tipo_Flujo  
  
  /* SEGÚN REQUERIMIENTO PRD21657  LA ACTUALIZACIÓN SE HA DEJADO NULA, DÍA 30-03-2015
  	    /* Grabar tasa en Valores de Tasa por moneda  -- PRD20732 o PRD20872 */
		
		
		Update BacParamSuda.dbo.MONEDA_TASA -- where numero_operacion = @numero_operacion 
		   set Tasa = @valor_tasa
		   where codTasa = @cCodTasa -- Ej. 10 para Tab 180 
		      and fecha =  @fechaFijacion 
			  and codMon = @CMoneda
			  and periodo = 1 
  	    /* Grabar tasa en Valores de Tasa por moneda  -- PRD20732 o PRD20872 */
*/


		select	@Cextranjera			= '1' -- Por def. las monedas son extranjeras
		select	@CntDecimales			= 4 --2

		SELECT	@Cextranjera			= mnextranj
			,	@CntDecimales			= mndecimal
		FROM	VIEW_MONEDA				with(nolock)
		WHERE	mncodmon				= @CMoneda   

		--<< Recalcula intereses de Venta  
		IF @cCodTasa > 0 AND @cCodTasa <> 13 AND @cCodTasa <> 21
		BEGIN    
			SELECT	@Tasa = @valor_tasa + @cSpread * 1.0
			EXECUTE SP_BASEINTERES @cBase
								,  @fecInicioFlujo
								,  @fecVenceFlujo
								,  @cPeriodo
								,  @Tasa
								,  @Tasa	OUTPUT  
			SELECT	@cInteres	= (@cSaldo + @cAmortiza) * @Tasa / 1.  
		--	IF @Cextranjera = '1'    
			SELECT @cInteres	= ROUND(@cInteres ,@CntDecimales)
		END
		--

		IF @tipo_flujo = 1  
			UPDATE CARTERA  
			SET    compra_Interes = @cInteres  
			WHERE  @numero_operacion = numero_operacion  
			AND    @numero_flujo     = numero_flujo  
			AND    @tipo_flujo       = tipo_flujo  
		ELSE  
			UPDATE cartera  
			SET    Venta_Interes  = @cInteres  
			WHERE  @numero_operacion = numero_operacion  
			AND    @numero_flujo     = numero_flujo  
			AND    @tipo_flujo       = tipo_flujo  

	-- Actualiza FLujo de inmediato  
	END ELSE  
	BEGIN
		IF @iSwSwapPromedio = 1					/*Marca para el ICP */
		BEGIN
			IF EXISTS(SELECT 1 FROM BacParamSuda.dbo.VALOR_MONEDA, SWAPGENERAL WHERE vmfecha = fechaproc and vmcodigo = 800)
			BEGIN  
				UPDATE BacParamSuda..VALOR_MONEDA  
				SET    vmvalor  = @valor_tasa  
				FROM   SWAPGENERAL  
				WHERE  vmfecha  = fechaproc  
				AND    vmcodigo = 800  
			END ELSE  
			BEGIN  
				INSERT INTO BacParamSuda.dbo.VALOR_MONEDA
				(      vmcodigo , vmvalor     , vmfecha   , vmparidad   )
				SELECT 800      , @valor_tasa , fechaproc , 0.0
				FROM   SWAPGENERAL
			END
		END
		IF @iSwSwapPromedio = 2				/*Marca para el IBR */
		BEGIN
			IF EXISTS(SELECT 1 FROM BacParamSuda.dbo.VALOR_MONEDA, SWAPGENERAL WHERE vmfecha = fechaproc and vmcodigo = 802)
			BEGIN  
				UPDATE BacParamSuda..VALOR_MONEDA  
				SET    vmvalor  = @valor_tasa  
				FROM   SWAPGENERAL  
				WHERE  vmfecha  = fechaproc  
				AND    vmcodigo = 802
			END ELSE  
			BEGIN  
				INSERT INTO BacParamSuda.dbo.VALOR_MONEDA
				(      vmcodigo , vmvalor     , vmfecha   , vmparidad   )
				SELECT 802		, @valor_tasa , fechaproc , 0.0
				FROM   SWAPGENERAL
			END
		END
	END
  
END  
GO
