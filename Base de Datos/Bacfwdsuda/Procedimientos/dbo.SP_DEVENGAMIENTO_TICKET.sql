USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGAMIENTO_TICKET]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_DEVENGAMIENTO_TICKET]
	(	 @dFecPro      		DATETIME       	, -- 1 Fecha de Proceso
	         @dFecProAnt      	DATETIME       	, -- 2 Fecha Proceso Anterior
		 @dFecProxPro   	DATETIME       	, -- 3 Proxima Fecha Habil
		 @dFecUDMPro  	        DATETIME       	, -- 4 Ultimo D¡a Mes de Proceso
		 @dFecUDMAnt   	        DATETIME       	, -- 5 Ultimo D¡a Mes de Proceso Anterior
		 @cLastHabil            CHAR(2)  	, -- 6 Indica si es el Ultimo D¡a H bil
		 @cFirstHabil		CHAR(2)		, -- 7 Indica si es el Primer D¡a H bil
	         @nValorUF_Ant   	NUMERIC(12,04) 	, -- 8 Uf Dia Anterior
		 @nValorUF_Pro		NUMERIC(12,04) 	, -- 9 Uf de Proceso
	         @nValorUF_UDM	        NUMERIC(12,04) 	, -- 10 Uf Fin de Mes
		 @nValUsd_Pro		NUMERIC(12,4)	, -- 11 Valor D¢lar Observado Proceso
 		 @nValUsd_Ant		NUMERIC(12,4)	, -- 12 Valor D¢lar Observado Anterior
		 @nvalusd_udma	        NUMERIC(12,4)	, -- 13 Valor D¢lar Observado Ultimo Día Mes Anterior
                 @iEjecucionIniDia      INT      = 0
	)
WITH RECOMPILE
AS
BEGIN 
	SET NOCOUNT ON
	DECLARE	@Numero_Operacion		NUMERIC(10,0),
		@Fecha_Operacion		DATETIME,
		@Numero_Operacion_Relacion	NUMERIC(10,0),
		@Codigo_Producto		SMALLINT,
		@Tipo_Operacion			VARCHAR(1),
		@CodMoneda1			SMALLINT,
		@MontoMoneda1			FLOAT,
		@Equivalente_CLP		FLOAT,
		@Precio1			FLOAT,
		@CodMoneda2			SMALLINT,
		@MontoMoneda2			FLOAT,
		@FechaVencimiento		DATETIME,
		@ReferenciaMercado		INT,
		@FechaFijRefMercado		DATETIME,
		@TipoCambio			FLOAT,
		@Modalidad			VARCHAR(1),
		@Mto_Inicial_Mon1		FLOAT,
		@Mto_Final_Mon1			FLOAT,
		@Mto_Inicial_Mon2		FLOAT,
		@Mto_Final_Mon2			FLOAT,
		@Valor_Obtenido        		FLOAT,
		@nPlazoVto			FLOAT,  --- Plazo al vencimiento
		@nPlazoVtoEfec			FLOAT,
		@dFecEfectiva  			DATETIME,
		@FechaCalculos			DATETIME,
		@ResultadoMTM    	    	FLOAT,
		@ValorRazonableActivo		FLOAT,
		@ValorRazonablePasivo		FLOAT,
		@iRefMercado			INT,
		@dFecVto			DATETIME,
		@nValorUF			NUMERIC(12,4),
	      	@PrecioFwd             		FLOAT,  
	      	@CaTasaSinteticaM1     		FLOAT,   
	      	@CaTasaSinteticaM2     		FLOAT,   
	      	@CaPrecioSpotVentaM1   		FLOAT,   
	      	@CaPrecioSpotVentaM2   		FLOAT,   
	      	@CaPrecioSpotCompraM1  		FLOAT,   
	      	@CaPrecioSpotCompraM2  		FLOAT,   
	      	@nTasa1                		FLOAT,   
	      	@nTasa2                		FLOAT,
		@iFound					INT,
		@cfuerte			CHAR(1),
		@preciospot			FLOAT,
		@nptofwdvcto			FLOAT,
		@valormtm_usd			FLOAT,
		@valorpte_usd			FLOAT,
		@nValorDia			NUMERIC(21,0)

	SET @FechaCalculos    = CASE WHEN DATEPART(MONTH, @dFecPro) = DATEPART(MONTH, @dFecProxPro) THEN @dFecPro
                                    ELSE @dFecUDMPro END

	SELECT @iFound      = -1

	SELECT @iFound      = 0
   	FROM   BacparamSuda..VALOR_MONEDA_CONTABLE
   	WHERE  Fecha        = CASE WHEN @iEjecucionIniDia = 1 THEN @dFecProAnt ELSE @dFecPro END
   	AND    Tipo_Cambio <> 0.0

   	IF @iFound = -1
   	BEGIN
      		SELECT -1 , 'No Existen Valores de Monedas Contables para Operaciones Intramesas a la Fecha de Proceso...'
		SET NOCOUNT OFF
      		RETURN
   	END

	SET @nPlazoVtoEfec = 0

	DECLARE Tmp_CarteraTicket   SCROLL CURSOR FOR  
	SELECT	Numero_Operacion,
		Fecha_Operacion,
		Numero_Operacion_Relacion,
		Codigo_Producto,
		Tipo_Operacion,
		CodMoneda1,
		MontoMoneda1,
		Equivalente_CLP,
		Precio1,
		CodMoneda2,
		MontoMoneda2,
		FechaVencimiento,
		ReferenciaMercado,
		FechaFijRefMerc,
		TipoCambio,
		Modalidad,
		Mto_Inicial_Mon1,
		Mto_Final_Mon1,
		Mto_Inicial_Mon2,
		Mto_Final_Mon2

	FROM	BACFWDSUDA..TBL_CARTICKETFWD
	WHERE	FechaVencimiento = CASE WHEN @iEjecucionIniDia = 1 THEN @dFecPro ELSE FechaVencimiento END

	BEGIN TRANSACTION
	
	OPEN Tmp_CarteraTicket
	FETCH FIRST FROM Tmp_CarteraTicket
	INTO 	@Numero_Operacion,
		@Fecha_Operacion,
		@Numero_Operacion_Relacion,
		@Codigo_Producto,
		@Tipo_Operacion,
		@CodMoneda1,
		@MontoMoneda1,
		@Equivalente_CLP,
		@Precio1,
		@CodMoneda2,
		@MontoMoneda2,
		@FechaVencimiento,
		@ReferenciaMercado,
		@FechaFijRefMercado,
		@TipoCambio,
		@Modalidad,
		@Mto_Inicial_Mon1,
		@Mto_Final_Mon1,
		@Mto_Inicial_Mon2,
		@Mto_Final_Mon2

	WHILE ( @@FETCH_STATUS = 0 )	
	BEGIN

		SELECT @nPlazoVto = 0

		IF @Codigo_Producto in (1,2,3)
		BEGIN
			--- Obtener el valor de Referencia de Mercado por defecto para el tipo de operación

			EXECUTE Bacparamsuda.dbo.SVC_ENTREGA_REFMER_DEFAULT @Codigo_Producto, @iRefMercado OUTPUT

			-- Si el movimiento no tiene valor de ReferenciaMercado (es igual a cero), actualizar con el valor por defecto

			UPDATE BACFWDSUDA..TBL_CARTICKETFWD
			SET ReferenciaMercado = @iRefMercado
			WHERE Numero_Operacion = @Numero_Operacion

			SELECT @ReferenciaMercado = @iRefMercado

			EXECUTE BacFwdSuda..SP_GENERA_FECHA_EFECTIVA @Codigo_Producto, @Modalidad, @ReferenciaMercado, @FechaVencimiento, @dFecEfectiva OUTPUT

			--- Almaceno la fecha efectiva en la tabla

			UPDATE BACFWDSUDA..TBL_CARTICKETFWD
			SET FechaFijRefMerc = @dFecEfectiva
			WHERE Numero_Operacion = @Numero_Operacion
		END
		/*----Plazo al Vencimiento--------*/
		IF @dFecVto < @dFecPro 
		BEGIN
			SET @nPlazoVto = 0
           		SET @nPlazoVtoEfec = 0
		END
		ELSE 
		BEGIN
			SET @nPlazoVto      = DATEDIFF(DAY, @FechaCalculos, @dFecVto)
           		SET @nPlazoVtoEfec  = DATEDIFF(DAY, @FechaCalculos, @dFecEfectiva) 
		END

      		/*
      		|---------------------------------------------------------------------|
      		| Valor UF a Utilizar en el Cálculo				    |
      		| Lo General es que la UF de Cálculo Sea la Misma del día, sin Embargo|
      		| a Fin de Mes se debe Utilizar la UF del Ultimo Día del Mes Excepto  |
      		| Para Aquellas Operaciones que Vencen ese Día			    |
      		|---------------------------------------------------------------------|
      		*/

      		SET @nValorUF = @nValorUF_Pro 

      		IF @dFecPro <> @FechaCalculos
         		SET @nValorUF = @nValorUF_UDM

      		IF @cLastHabil = 'SI' 
         		IF @dFecVto <> @dFecPro 
         			SELECT @nValorUF = @nValorUF_UDM		
         
		IF @FechaVencimiento < @dFecPro 
	           	SET @nPlazoVtoEfec = 0
        	ELSE 
	           	SET @nPlazoVtoEfec  = DATEDIFF(DAY, @FechaCalculos, @dFecEfectiva)

	   	IF @nPlazoVtoEfec <> 0
	   	BEGIN
			IF @Codigo_Producto = 10
				EXECUTE SP_C08_FORWARDBONDTRADES_IM @Numero_Operacion, @iEjecucionIniDia
			ELSE
			BEGIN
				-- Llamar al sp que valoriza los Tickets
				EXECUTE SP_MARKTOMARKET_TICKET
				    @Codigo_Producto
				,   @nPlazoVtoEfec
				,   @CodMoneda2
				,   @nValorUF
				,   @MontoMoneda1
				,   @dFecVto
				,   @Tipo_Operacion
				,   @TipoCambio
				,   @CodMoneda1
				,   @Numero_Operacion
				,   @PrecioFwd             OUTPUT
				,   @Valor_Obtenido        OUTPUT
			   	,   @ResultadoMTM          OUTPUT
			   	,   @Modalidad
			   	,   @CaTasaSinteticaM1     OUTPUT
			   	,   @CaTasaSinteticaM2     OUTPUT
			   	,   @CaPrecioSpotVentaM1   OUTPUT
			   	,   @CaPrecioSpotVentaM2   OUTPUT
		   		,   @CaPrecioSpotCompraM1  OUTPUT
			   	,   @CaPrecioSpotCompraM2  OUTPUT
			   	,   @ValorRazonableActivo  OUTPUT
			   	,   @ValorRazonablePasivo  OUTPUT
		   		,   @nTasa1                OUTPUT
			   	,   @nTasa2                OUTPUT
			   	,   0
	
				IF EXISTS (SELECT 1 FROM TBL_RESTICKETFWD WHERE Fecha = @dFecPro
				AND Numero_Operacion = @Numero_Operacion
				AND Numero_Operacion_Relacion = @Numero_Operacion_Relacion)
				BEGIN
					UPDATE TBL_RESTICKETFWD SET
					Valorizacion			= @MontoMoneda1,
					Val_Obtenido			= @Valor_Obtenido,
					Res_Obtenido			= @ResultadoMTM,
					ValorRazonableActivo		= @ValorRazonableActivo,
					ValorRazonablePasivo		= @ValorRazonablePasivo
					WHERE	Fecha 				= @dFecPro
					AND	Numero_Operacion		= @Numero_Operacion
					AND	Numero_Operacion_Relacion	= @Numero_Operacion_Relacion
				END
				ELSE
				BEGIN
					INSERT INTO TBL_RESTICKETFWD
					(Fecha,
					Numero_Operacion,					Numero_Operacion_Relacion,
					Valorizacion,
					Val_Obtenido,
					Res_Obtenido,
					ValorRazonableActivo,
					ValorRazonablePasivo)
					VALUES	(@dFecPro,
					@Numero_Operacion,
					@Numero_Operacion_Relacion,
					@MontoMoneda1,
					@Valor_Obtenido,
					@ResultadoMTM,
					@ValorRazonableActivo,
					@ValorRazonablePasivo)
			 	END
			END
  		END	-- @nPlazoVtoEfec <> 0
		FETCH NEXT FROM Tmp_CarteraTicket
		INTO 	@Numero_Operacion,
		@Fecha_Operacion,
		@Numero_Operacion_Relacion,
		@Codigo_Producto,
		@Tipo_Operacion,
		@CodMoneda1,
		@MontoMoneda1,
		@Equivalente_CLP,
		@Precio1,
		@CodMoneda2,
		@MontoMoneda2,
		@FechaVencimiento,
		@ReferenciaMercado,
		@FechaFijRefMercado,
		@TipoCambio,
		@Modalidad,
		@Mto_Inicial_Mon1,
		@Mto_Final_Mon1,
		@Mto_Inicial_Mon2,
		@Mto_Final_Mon2

	END   -- While
	IF @@error <> 0 
        BEGIN
		ROLLBACK TRANSACTION
		SELECT -1 , 'Error: al actualizar el registro en la tabla de cartera intramesa.'
		CLOSE Tmp_CurMFCA
		DEALLOCATE Tmp_CarteraTicket
		SET NOCOUNT OFF
		RETURN -1
	END

	CLOSE Tmp_CarteraTicket
	DEALLOCATE Tmp_CarteraTicket

	SET NOCOUNT OFF
	COMMIT TRANSACTION
	SELECT 'OK'
END

GO
