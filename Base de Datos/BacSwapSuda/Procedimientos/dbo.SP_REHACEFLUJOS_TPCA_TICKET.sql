USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REHACEFLUJOS_TPCA_TICKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REHACEFLUJOS_TPCA_TICKET] (@iNumOperacion   NUMERIC(9))
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @iTipoFlujo		INTEGER
		, @iTCP				FLOAT    -- NUMERIC(21,4)
		, @Moneda			INTEGER
		, @dIniFlujo		DATETIME
		, @dFinFlujo		DATETIME
		, @TipoBase			INTEGER
		, @DolarObs			FLOAT    -- NUMERIC(21,4)
		, @CantFlujos		INTEGER
		, @RegiFlujos   	INTEGER
		, @Interes			FLOAT    -- NUMERIC(21,4)
		, @SaldoK			FLOAT    -- NUMERIC(21,4)
		, @Spread			FLOAT    -- NUMERIC(21,4)
		, @BaseInteres		FLOAT    -- INTEGER
		, @DifDias			FLOAT    -- NUMERIC(21,4)
		, @PeriBase			VARCHAR(5)
		, @PeriDias			VARCHAR(5)
		, @iPlazo			FLOAT    -- NUMERIC(21,4)
		, @Dolares			FLOAT    -- NUMERIC(21,4)
		, @Primera			CHAR(1)
		, @FechaProceso		DATETIME
		, @MinNumFlujo		INTEGER
	
	SELECT  @FechaProceso = fechaproc
	FROM    SwapGeneral

	--   Factor para Convertir Interes en Pesos a Dolares
	SELECT	@DolarObs         = ISNULL(vmvalor,1)
	FROM	bacparamsuda..VALOR_MONEDA
	WHERE	vmcodigo          = 994
	AND	vmfecha           = @FechaProceso

	SELECT  @MinNumFlujo       = MIN(numero_flujo)
	FROM    TBL_FLJTICKETSWAP
	WHERE   numero_operacion   = @iNumOperacion
	AND     fecha_vence_flujo >= @FechaProceso
	AND	Estado <> 'N'			

   --   Tipo de Flujo Indica que se tomaran valores de Compra o Venta 
	SELECT  @iTipoFlujo      = CASE WHEN compra_codigo_tasa = 13 THEN 1 ELSE 2 END
	FROM    TBL_FLJTICKETSWAP
	WHERE   numero_operacion = @iNumOperacion
	AND     numero_flujo     = @MinNumFlujo
	AND     tipo_flujo       = 1
	AND Estado <> 'N'			-- MAP 20071029 Descarta Flujo que liquida anticipo

	SELECT @iTipoFlujo = ( select distinct tipo_flujo 
	                       from TBL_FLJTICKETSWAP 
	                       where  numero_operacion = @iNumOperacion 
	                       and compra_Codigo_tasa + venta_codigo_tasa = 13  )

	SELECT @CantFlujos         = MAX(numero_flujo)
		 , @RegiFlujos         = MIN(numero_flujo)
	FROM    TBL_FLJTICKETSWAP
	WHERE   numero_operacion    = @iNumOperacion
	AND     tipo_flujo          = @iTipoFlujo
	AND     fecha_vence_flujo  >= @FechaProceso
	AND	Estado <> 'N'	

	SELECT @Primera = 'S'

   --   Ciclo que recalculara Intereses para y por cada uno de los flujos que esten vigentes
	WHILE @CantFlujos >= @RegiFlujos
	BEGIN
		SELECT @Moneda		= CASE WHEN @iTipoFlujo = 1 THEN Compra_moneda ELSE venta_moneda END
			, @dIniFlujo	= fecha_inicio_flujo
			, @dFinFlujo	= fecha_vence_flujo
			, @SaldoK		= CASE WHEN @iTipoFlujo = 1 THEN compra_saldo + Compra_Amortiza ELSE venta_saldo  + Venta_Amortiza END
			, @TipoBase     = CASE WHEN @iTipoFlujo = 1 THEN compra_base   ELSE venta_base   END
			, @Spread       = CASE WHEN @iTipoFlujo = 1 THEN compra_spread ELSE venta_spread END
		FROM   TBL_FLJTICKETSWAP
		WHERE  numero_operacion   = @iNumOperacion
		AND    tipo_flujo         = @iTipoFlujo
		AND    numero_flujo       = @RegiFlujos
		AND    fecha_vence_flujo >= @FechaProceso

		--   Factores para la Asignacion de la Base o Generación de la Diferencia de Dias
		SELECT @PeriDias  = Dias
			 , @PeriBase  = Base
		FROM   BASE
		WHERE  Codigo     = @TipoBase

		--   Asignación de Base 
		IF @PeriBase = 'A'
		BEGIN
			SELECT @BaseInteres = 365
		END
		ELSE
		BEGIN
			SELECT @BaseInteres = CONVERT(INTEGER,@PeriBase)
		END

		--   Generación de la Diferencia de Dias
		IF @PeriDias = 'A'
		BEGIN
			SELECT @DifDias = DATEDIFF(DAY,@dIniFlujo,@dFinFlujo)
		END
		ELSE
		BEGIN
			EXECUTE DIFDIAS30 @dIniFlujo , @dFinFlujo , @DifDias OUTPUT  
		END

		--   Generación del Plazo en funcion de la Base
		SELECT  @iPlazo = (@DifDias / @BaseInteres)
		IF @@ERROR <> 0
		BEGIN
			SELECT -1
			RETURN -1
		END
		IF @Primera = 'S'
		BEGIN
			SELECT  @iTCP = 0.0
			
			 DECLARE @RUT_CLIENTE NUMERIC(9,0)
					,@RUT_CODIGO  NUMERIC(9,0)
					,@NUMERO_OPERACION NUMERIC(7,0)
					,@NUMERO_FLUJO NUMERIC(3,0)
					,@TIPO_FLUJO NUMERIC(1,0)
				
         
			SELECT TOP 1 @RUT_CLIENTE = CAR.rut_cliente
					    ,@RUT_CODIGO = CAR.codigo_cliente
					    ,@NUMERO_OPERACION = CAR.numero_operacion
						,@NUMERO_FLUJO		= CAR.numero_flujo
						,@TIPO_FLUJO		= CAR.tipo_flujo
			FROM CARTERA CAR 
			WHERE CAR.numero_operacion = @iNumOperacion 
		      AND CAR.tipo_flujo         =  @ITipoFlujo
			  AND CAR.numero_flujo       =  @RegiFlujos
			  AND CAR.fecha_vence_flujo  >= @FechaProceso
		
         
			EXECUTE SRV_CALCULO_TPCA_DEV @Moneda , 
										 @dIniFlujo , 
										 @dFinFlujo , 
										 @iTCP OUTPUT, 
										 '19000101', 
										 '19000101', 
										 @RUT_CLIENTE, 
										 @RUT_CODIGO,
										 @NUMERO_OPERACION,
										 @NUMERO_FLUJO,
										 @TIPO_FLUJO
			
			IF @iTCP = -1
			BEGIN
				RETURN -1
			END
		END

		SELECT @Interes = @SaldoK  * ((@iTCP+@Spread)/100.0) * (@iPlazo)
		SELECT @Dolares = @Interes / @DolarObs

		IF @iTipoFlujo = 1
		BEGIN
			UPDATE	TBL_FLJTICKETSWAP
			SET	 compra_interes         = @Interes
				, compra_valor_tasa     = CONVERT(NUMERIC(21,4),@iTCP)
				, compra_valor_tasa_hoy = CONVERT(NUMERIC(21,4),@iTCP)
			WHERE	numero_operacion	= @iNumOperacion
			AND	tipo_flujo = @iTipoFlujo
			AND	numero_flujo >= @RegiFlujos
			AND	Estado <> 'N'

		END
		ELSE
		BEGIN
			UPDATE	TBL_FLJTICKETSWAP
			SET	  venta_interes         = @Interes
				, venta_valor_tasa      = CONVERT(NUMERIC(21,4),@iTCP)
				, venta_valor_tasa_hoy  = CONVERT(NUMERIC(21,4),@iTCP)
			WHERE	numero_operacion    = @iNumOperacion
			AND	tipo_flujo              = @iTipoFlujo
			AND	numero_flujo            >= @RegiFlujos
			AND	Estado <> 'N'
		END

		SELECT @RegiFlujos    = @RegiFlujos + 1
		SELECT @Primera       = 'N'
	END

	RETURN 0
END

GO
