USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGAMIENTO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DEVENGAMIENTO] (@Numero_Operacion NUMERIC(7) /*,
									   @Sistema			 VARCHAR(255) = '' */ )

AS
BEGIN
	-- select compra_valor_tasa, venta_valor_tasa ,* from cartera where fecha_inicio_Flujo = '20150620' and compra_codigo_tasa + venta_codigo_tasa = 13
	-- 
	-- select  venta_codigo_tasa, fecha_inicio_flujo, fecha_vence_Flujo, venta_valor_tasa ,  Pasivo_MO_C08, numero_Flujo , fechaliquidacion, venta_interes from carteraRES where fecha_proceso = '20150622' and  venta_codigo_tasa = 13 and numero_operacion = 5061
	/* 
	   SP_DEVENGAMIENTO       9727
	   SP_CALCULO_ACTPAS_C08_MAP '20150623', 5061, 0 */
	/****************************************************
	* Modificacion por funcionalidad de Anticipos
	* Cambios marcados con MAP 20071029
	* Descartar de este proceso los flujos que liquidan el 
	* anticipo
    * Redefinir el flujo vigente
	*****************************************************/
   
   -- TAG MAP 20061205 Obliga a calcular el flujo cuando se fecha fijación tasa 
   -- Swap: Guardar Como

   SET NOCOUNT ON

   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos
   DECLARE @FechaCalculos    DATETIME
    SELECT @FechaCalculos    = CASE WHEN DATEPART(MONTH, fechaproc) = DATEPART(MONTH, fechaprox) THEN fechaproc
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, fechaproc)) *-1, DATEADD(MONTH, 1, fechaproc) )
                               END
      FROM BacSwapSuda..SWAPGENERAL
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos


   DECLARE @Oper VARCHAR(20)

   -------------------------------------<< Asignacion General
   DECLARE @Cextranjera       CHAR(1)
   ,       @Vextranjera       CHAR(1)

   ------<< Parametros del dia (Fechas)
   DECLARE @Fecha_Proceso     CHAR(8)
   ,       @Fecha_Anterior    CHAR(8)
   ,       @Fecha_Proximo     CHAR(8)
   ,       @Fecha_Devengo     CHAR(8)
   ,       @Fecha_DevengoA    CHAR(8)
   ,       @PrimerDiaMes      CHAR(8)
   ,       @UltimoDiaMes      CHAR(8)
   ,       @PrimerDiaHabilMes CHAR(8)
   ,       @UltimoDiaHabilMes CHAR(8)
   ,       @Fecha_Ant_Ant     CHAR(8)		-- Fecha dos dias antes habiles fecha de proceso 
   ,       @nPlazoRes         INTEGER
   ,       @vpmtm             FLOAT
   ,       @cCurva            CHAR(20)
   ,       @Monto_MTM         FLOAT	-- Devengos MTM
   ,       @Tasa_MTM          FLOAT 
   ,       @Cotizacion        CHAR(6)


   SELECT @Oper = ' Oper.' + CONVERT(VARCHAR(10),@Numero_Operacion) + ' '

   SET    @Cotizacion = 'NoEsta'  
   SELECT @Cotizacion = Estado FROM CARTERA WHERE numero_operacion  =  @Numero_Operacion  

   IF @Cotizacion = 'NoEsta' 
   BEGIN
      SELECT -1 , 'No Existe ' + @Oper + ' en Cartera.-'
      RETURN
   END

   IF @Cotizacion = 'N'  --<== Es Anticipo, no hará nada con la operación 
   BEGIN
      -- Swap: Guardar Como
      RETURN
   END


   -- Recalculo de Flujos para las Operaciones Swap Promedio Camara --
   DECLARE @iEstado        INTEGER
   ,       @dFechaInicio   DATETIME
--   IF (SELECT DISTINCT tipo_swap FROM CARTERA WHERE numero_operacion = @Numero_Operacion) = 4
   IF exists( SELECT (1) 
              FROM  CARTERA 
              WHERE numero_operacion = @Numero_Operacion 
                and Compra_Codigo_Tasa + Venta_Codigo_Tasa = 13 )
   BEGIN
      EXECUTE @iEstado = SP_REHACEFLUJOS_TPCA @Numero_Operacion

      IF @iEstado <> 0 
      BEGIN
         SELECT -1 , 'Problemas en el Recalculo de los Flijos para Swap Promedio Camara.'
         RETURN -1
      END
   END

   IF exists( SELECT (1) FROM CARTERA WHERE numero_operacion = @Numero_Operacion 
              and Compra_Codigo_Tasa + Venta_Codigo_Tasa = 21 )
   BEGIN  
      EXECUTE @iEstado = SP_REHACEFLUJOS_IBR @Numero_Operacion

      IF @iEstado <> 0 
      BEGIN
         SELECT -1 , 'Problemas en el Recalculo de los Flujos para Swap COP IBR.'
         RETURN -1
      END
   END

   -- Recalculo de Flujos para las Operaciones Swap Promedio Camara --

   -->   *********************************************************************************************************   
   -->   Recalculo de Los Flujos Para Las Operaciones Con Tasas Que Se Recalculen Diariamente
   -->   Ejemplo.: SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 AND nemo = 'S'
   -->   *********************************************************************************************************   
   DECLARE @iMensaje   VARCHAR(100)
   ,       @iError     INTEGER

     
   EXECUTE @iError     = SP_REHACEFLUJOS @Numero_Operacion , @iMensaje OUTPUT

   IF @iError = -1
   BEGIN
      RAISERROR(@iMensaje,16,1,@iMensaje)
      RETURN
   END
   -->   *********************************************************************************************************   

   SELECT @Fecha_Proceso  = CONVERT(CHAR(8),fechaproc,112)
   ,      @Fecha_Devengo  = CONVERT(CHAR(8),fechaproc,112)
   ,      @Fecha_DevengoA = CONVERT(CHAR(8),fechaant ,112)
   ,      @Fecha_Anterior = CONVERT(CHAR(8),fechaant ,112)
   ,      @Fecha_Proximo  = CONVERT(CHAR(8),fechaprox,112)
   FROM   SWAPGENERAL

   SELECT @PrimerDiaMes   = SUBSTRING(@Fecha_Proceso ,1,6) + '01'
   SELECT @UltimoDiaMes   = SUBSTRING(CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,35,@PrimerDiaMes)),112),1,6) + '01'
   SELECT @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@UltimoDiaMes)),112)

   ----<< Chequea si es el ultimo dia del Mes
   IF SUBSTRING(@UltimoDiaMes,5,2) <> SUBSTRING(@Fecha_Proximo,5,2)
   BEGIN
   --     PRINT 'Hoy es el Ultimo dia del Mes'
      SELECT @Fecha_Devengo = @UltimoDiaMes
   END

   ----<< Chequea si es el Primer dia del Mes
   IF SUBSTRING(@PrimerDiaMes,5,2) <> SUBSTRING(@Fecha_Anterior,5,2)  
   BEGIN
   --     PRINT 'Hoy es el Primer dia del Mes'
 SELECT @Fecha_DevengoA = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)
   END

   --------------------------------------<< Estado de Flujos
   -- MAP 20071213 Se reformula el reconocimiento del flujo vigente  
   -- para que no se modifique la tasa y flujo de interes de flujos
   -- que aún no parten, lo que se da comunmente cuando la fecha
   -- efectiva es posterior a la fecha de proceso y al hacer unwind
   -- el Swap queda con fecha de inicio de proximo cupón posterior
   -- a la fecha de proceso, pese a esto tal flujo debe ser 
   -- considerado como flujo vigente.
   --------------------------------------<< Estado de Flujos



   -- INICIO PRD21657 
   EXECUTE SP_FLUJO_VIGENTE @Numero_Operacion
   IF @@ERROR <> 0
   BEGIN
      SELECT -1, 'No se puede establecer el estado de los Flujos de ' + @Oper
      RETURN
   END
   -- PRD21657 
   EXECUTE dbo.SP_ACTUALIZA_FECHAS_REFERENCIA_MERCADO_SWAP  @Numero_Operacion
   IF @@ERROR <> 0
   BEGIN
      SELECT -1, 'No se puede establecer Fechas Ref. Mercado ' + @Oper
      RETURN
   END
   -- PRD21657
   IF @Cotizacion = 'C'  --<== Es cotización , llega hasta acá no más.
   BEGIN
      -- Swap: Guardar Como
      RETURN
   END

   -- FIN PRD21657 


/*** Eliminar de producción
   declare @PrimerFlujoCompra numeric(10)
   declare @PrimerFlujoVenta numeric(10)
   set     @PrimerFlujoCompra = 0 
   set     @PrimerFlujoVenta  = 0
   select  @PrimerFlujoCompra = min( numero_Flujo )
           from Cartera where numero_operacion =  @Numero_Operacion 
                              and tipo_flujo = 1 and estado <> 'N'
   select  @PrimerFlujoVenta = min( numero_Flujo )
           from Cartera where numero_operacion =  @Numero_Operacion 
                              and tipo_flujo = 2 and estado <> 'N'

   UPDATE  CARTERA
   SET 	   estado_flujo     = (CASE WHEN fecha_vence_flujo = @Fecha_Proceso 
                                         and estado <> 'N' 
                                         THEN 2 -- Flujo vencimiento natural
                                    WHEN fecha_vence_flujo > @Fecha_Proceso                                         
                                         AND @Fecha_Proceso >= fecha_inicio_flujo
                                         and estado <> 'N'
                                         or  numero_Flujo = @PrimerFlujoCompra 
                                         THEN 1  -- <= Define el Flujo Vigente                                      
                 ELSE 0
                              END),
	   fecha_valoriza   = @Fecha_Proceso
   WHERE   numero_operacion = @Numero_Operacion 
           and tipo_flujo = 1


   UPDATE  CARTERA
   SET 	   estado_flujo     = (CASE WHEN fecha_vence_flujo = @Fecha_Proceso
                 and estado <> 'N'  
                                   THEN 2 -- Flujo vencimiento natural
                                    WHEN fecha_vence_flujo > @Fecha_Proceso                                         
                                         AND @Fecha_Proceso >= fecha_inicio_flujo
                                         and estado <> 'N'
                                         or  numero_Flujo = @PrimerFlujoVenta 
                                         THEN 1  -- <= Define el Flujo Vigente 
                                    ELSE 0
                              END),
	   fecha_valoriza   = @Fecha_Proceso
   WHERE   numero_operacion = @Numero_Operacion 
           and tipo_flujo = 2


   IF @@ERROR <> 0
   BEGIN
      SELECT -1, 'No se puede establecer el estado de los Flujos de ' + @Oper
      RETURN
   END
***/
   ----<< Flujos Vigentes
   --select estado_flujo, fecha_vence_flujo from cartera
   
DECLARE @CapitalVigenteCompra	NUMERIC(19,4),
		@CapitalVigenteVenta	NUMERIC(19,4),
		@Periodo		NUMERIC(03,0),
		@ControlErr		INT	     ,
		@FlujoMinCompra		NUMERIC(10,0),
		@FlujoMinVenta		NUMERIC(10,0)  

DECLARE @FlujoVigente    	INTEGER,
        @Flujos          	INTEGER,
        @Flujo           	NUMERIC(03,0)

DECLARE @ValorDolarObsDia	FLOAT, --NUMERIC(10,6),
		@ValorDolarObsDiaANT	FLOAT,--NUMERIC(10,6),
		@ValorDolarObsDiaORI	FLOAT,--NUMERIC(10,6),
		@cValorMonedaAnt	FLOAT,-- NUMERIC(10,6),
		@vValorMonedaAnt	FLOAT-- NUMERIC(10,6)

SELECT 	@FlujoVigente  = MIN(numero_flujo),
       	@Flujos        = COUNT(*)
FROM 	cartera
WHERE 	numero_operacion = @Numero_Operacion 
   	AND estado_flujo     = 1
	and estado <> 'N'  -- MAP 20071029

SELECT @ControlErr = 0

/* Es porque ya no existen flujos Vigentes y el que esta esta venciendo*/
If @Flujos = 0  BEGIN
	
	SELECT @FlujoVigente  = MIN(numero_flujo),
       		@Flujos        = COUNT(1)
	  FROM cartera
	 WHERE numero_operacion = @Numero_Operacion 
	   AND estado_flujo     = 2
	and estado <> 'N'  -- MAP 20071029
END

SELECT @Flujo = @FlujoVigente

--<< Cursor
DECLARE @Producto         	NUMERIC(01,0),
        @Estado           	NUMERIC(01,0),
        @TipOpe     		CHAR   	(01)  ,
        @Moneda           	NUMERIC(03,0),
        @Cartera          	NUMERIC(10,0),
        @fecCalculo       	CHAR   (08)  ,
        @fecCierre        	CHAR   (08)  ,
        @fecInicio        	CHAR   (08)  ,
        @fecTermino       	CHAR   (08)  ,
        @fecInicioFlujo   	CHAR   (08)  ,
        @fecVenceFlujo    	CHAR   (08)  ,
        @Tenor            	INTEGER      ,
        @cMoneda          	NUMERIC(03,0),
        @cAmortiza        	NUMERIC(19,4),
        @cSaldo           	NUMERIC(19,4),
        @cInteres         	NUMERIC(19,4),
        @cCodTasa         	NUMERIC(03,0),
        @cValTasa         	NUMERIC(10,6), --> 
        @cValTasaHoy      	NUMERIC(10,6),
		@cValMonHoy       	NUMERIC(10,4),
        @cSpread          	NUMERIC(10,6),
        @cPeriodo         	NUMERIC(03,0),
        @cBase     	  		NUMERIC(03,0),
        @cDevengo         	NUMERIC(19,4),
        @cDevAcum         	NUMERIC(19,4),
        @cDevAcumAyer     	NUMERIC(19,4),
        @cMonedaPago      	NUMERIC(03,0),
        @cPago            	NUMERIC(19,4),
        @cPagoUSD         	NUMERIC(19,4),
        @cPagoCLP         	NUMERIC(19,4),
        @vMoneda          	NUMERIC(03,0),
        @vAmortiza        	NUMERIC(19,4),
        @vSaldo           	NUMERIC(19,4),
        @vInteres         	NUMERIC(19,4),
        @vCodTasa         	NUMERIC(03,0),
        @vValTasa         	NUMERIC(10,6),
        @vValTasaHoy      	NUMERIC(10,6),
		@vValMonHoy       	NUMERIC(10,4),
        @vSpread          	NUMERIC(10,6),
        @vPeriodo         	NUMERIC(03,0),
        @vBase            	NUMERIC(03,0),
        @vDevengo         	NUMERIC(19,4),
		@vDevAcum         	NUMERIC(19,4),
        @vDevAcumAyer     	NUMERIC(19,4),
		@vMonedaPago      	NUMERIC(03,0),
		@vPago            	NUMERIC(19,4),
        @vPagoUSD         	NUMERIC(19,4),
        @vPagoCLP         	NUMERIC(19,4),
        @devMonto         	NUMERIC(19,4),
        @devMtoAcum       	NUMERIC(19,4),
        @devMtoAcumAyer   	NUMERIC(19,4),
        @devMontoPeso     	NUMERIC(20,0),
        @devDias          	INTEGER,
        @devDiasA         	INTEGER,
		@cValorHoy  		NUMERIC(19,2),
        @cVariaHoy        	NUMERIC(19,2),
        @vValorHoy        	NUMERIC(19,2),
        @vVariaHoy        	NUMERIC(19,2),
        @Valorizacion     	NUMERIC(19,2),
        @Modalidad        	CHAR   (01)  ,
        @tipoFlujo        	NUMERIC(01,0),
		@fecha_tasa	  		CHAR(08)	,
		@CapitalVigentePesos_H	NUMERIC(21,00)	,
		@CapitalVigentePesos_A	NUMERIC(21,00)	,
		@cAct_Tasa				NUMERIC(05,00)	,
		@vAct_Tasa				NUMERIC(05,00)  ,
        @cMontoSpread           NUMERIC(19,4),     --  nuevo
		@vMontoSpread           NUMERIC(19,4)      --  nuevo


----<< Variables Control y Calculo
DECLARE @Cont      	 INTEGER,
        @DiasFlujo 	 INTEGER,
        @Tasa        FLOAT,      -- Calculo de New Interest
        @Vcto      	 NUMERIC(01,0)    -- Indica si hubo vencimiento de Flujo

SELECT  @Cont = 0,
        @Vcto = 0

----<< Crea Cursor   
SELECT *
 INTO #CarteraCur FROM Cartera
                      	  WHERE numero_operacion = @Numero_Operacion 
				and estado <> 'N'  -- MAP 20071029
                      	  ORDER BY numero_flujo


DECLARE curOperacion  CURSOR

    FOR SELECT tipo_swap,
               numero_flujo,
			   Tipo_flujo,   	
               estado_flujo,
               tipo_operacion,
               CASE tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END,
               cartera_inversion,
	           @fecha_proceso,     
	           convert(char(8),fecha_cierre,112),
               convert(char(8),fecha_inicio,112),
               convert(char(8),fecha_termino,112),
               convert(char(8),fecha_inicio_flujo,112),
               convert(char(8),fecha_vence_flujo,112),
               DATEDIFF(day, @FechaCalculos, fecha_vence_flujo), --> DATEDIFF(day, @Fecha_Proceso,fecha_vence_flujo),
	           compra_moneda,
               compra_amortiza,
               compra_saldo,
               compra_interes,
               compra_codigo_tasa,
               compra_valor_tasa,
               compra_valor_tasa_hoy,
               compra_spread,
               compra_codamo_interes ,
               compra_base,
               devengo_compra,
               devengo_compra_acum,
               devengo_compra_ayer,
               recibimos_moneda,
               recibimos_monto,
               recibimos_monto_USD,
               recibimos_monto_CLP,		
               venta_moneda,
               venta_amortiza,
               venta_saldo,
               venta_interes,
               venta_codigo_tasa,
               venta_valor_tasa,
               venta_valor_tasa_hoy,
               venta_spread,
               venta_codamo_interes ,
               venta_base,
               devengo_venta,
               devengo_venta_acum,
               devengo_venta_ayer,
               pagamos_moneda,
               pagamos_monto,
               pagamos_monto_USD,
               pagamos_monto_CLP,
               devengo_monto,
               devengo_monto_acum,
               devengo_monto_ayer,
	           ISNULL(devengo_monto_peso,0),
               ABS(DATEDIFF(day,fecha_inicio_flujo, @FechaCalculos)), --> @Fecha_Devengo)),
               compra_valorizada,
               compra_variacion,          
               venta_valorizada,
               venta_variacion,          
               valorizacion_dia,
               modalidad_pago,
               CONVERT(CHAR(8),fecha_fijacion_tasa,112),
			   compra_zcr,
	           venta_zcr
         FROM #CarteraCur

--<< Abre Cursor
OPEN curOperacion

--<< Captura Primer Flujo
FETCH NEXT FROM curOperacion
		   INTO @Producto       ,
				@Flujo          ,
				@TipoFlujo		,
				@Estado			,
				@TipOpe         ,
				@Moneda         ,
				@Cartera        ,
				@fecCalculo     ,
				@fecCierre      ,
				@fecInicio      ,
				@fecTermino     ,
				@fecInicioFlujo ,
				@fecVenceFlujo  ,
				@Tenor          ,
				@cMoneda        ,
				@cAmortiza      ,
				@cSaldo         ,
				@cInteres		,
				@cCodTasa       ,
				@cValTasa       ,
				@cValTasaHoy    ,
				@cSpread        ,
				@cPeriodo       ,
				@cBase          ,
				@cDevengo       ,
				@cDevAcum       ,
				@cDevAcumAyer   ,
				@cMonedaPago	,
				@cPago          ,
				@cPagoUSD       ,
				@cPagoCLP       ,
				@vMoneda        ,
				@vAmortiza      ,
				@vSaldo         ,
				@vInteres       ,
				@vCodTasa       ,
				@vValTasa       ,
				@vValTasaHoy    ,
				@vSpread        ,
				@vPeriodo       ,
				@vBase          ,
				@vDevengo       ,
				@vDevAcum       ,
				@vDevAcumAyer   ,
				@vMonedaPago    ,
				@vPago          ,
				@vPagoUSD       ,
				@vPagoCLP       ,
				@devMonto       ,
				@devMtoAcum		,
				@devMtoAcumAyer ,
				@devMontoPeso   ,
				@devDias        ,
				@cValorHoy      ,
				@cVariaHoy      ,
				@vValorHoy      ,
				@vVariaHoy      ,
				@Valorizacion   ,
				@Modalidad      ,
				@fecha_tasa		,
				@cAct_Tasa		,
				@vAct_Tasa      



	SELECT @cValMonHoy = ISNULL(vmvalor,0) 
	FROM view_valor_moneda 
	WHERE vmcodigo = CASE WHEN @cMoneda = 13 THEN 994 ELSE @cMoneda END
	  AND vmfecha  = (CASE @cMoneda WHEN 998 THEN @FechaCalculos /*@Fecha_devengo*/ ELSE @Fecha_Proceso END)

	SELECT @vValMonHoy = ISNULL(vmvalor,0) 
	FROM view_valor_moneda 
	WHERE vmcodigo = @vMoneda 
	  AND vmfecha  = (CASE @vMoneda WHEN 998 THEN @FechaCalculos /*@Fecha_devengo*/ ELSE @Fecha_Proceso END)

	SELECT @ValorDolarObsDia    = ISNULL(vmvalor,0) 
	FROM view_valor_moneda 
	WHERE vmcodigo = 994 AND vmfecha  = @Fecha_Proceso 

	IF @ValorDolarObsDia IS NULL 
	   SELECT @ValorDolarObsDia = 0

	SELECT @ValorDolarObsDiaANT = ISNULL(vmvalor,0) 
	FROM view_valor_moneda 
	WHERE vmcodigo = 994 AND vmfecha  = @Fecha_Anterior

	IF @ValorDolarObsDiaANT IS NULL 
	   SELECT @ValorDolarObsDiaANT = 0

	IF @cValMonHoy IS NULL OR @cValMonHoy = 0
	   SELECT @cValMonHoy = 1.0

	IF @vValMonHoy IS NULL OR @vValMonHoy = 0
	   SELECT @vValMonHoy = 1.0

	SELECT @ValorDolarObsDiaORI = ISNULL(vmvalor,0) 
	FROM view_valor_moneda 
	WHERE vmcodigo = 994 AND vmfecha  = @fecInicio
	
	IF @ValorDolarObsDiaORI IS NULL 
	   SELECT @ValorDolarObsDiaORI = 0


----<< Indica que se deben recalcular todos los Flujos posteriores a este
----<< Caso en que estaba en cartera pero aun no comenzaba flujos, solo se contabilizaba el capital 

        IF @fecInicioFlujo = @Fecha_Proceso AND @fecCierre < @fecInicio AND @Flujo = 1 	
        BEGIN
		SELECT @Vcto = 1
	END      

	SELECT @fecha_Ant_Ant = @fecha_tasa

	--<< Ciclo Devengamiento 
	SELECT @FlujoMinCompra = min(numero_flujo)
	FROM #carteracur where tipo_flujo = 1 

	SELECT @FlujoMinVenta = min(numero_flujo)
	FROM #carteracur where tipo_flujo = 2
               
	--select @FlujoMinCompra , @FlujoMinVenta
	-- MAP 20080429 se cambia filtro del flujo vigente, siempre es el con estado_Flujo = 1
	select @CapitalVigenteCompra = 0.0
	select @CapitalVigenteVenta  = 0.0
	
	SELECT @CapitalVigenteCompra = compra_amortiza + compra_saldo + Compra_Flujo_Adicional 
	FROM #carteracur 
	WHERE estado_flujo = 1 AND tipo_flujo = 1
	
	SELECT @CapitalVigenteVenta  = venta_amortiza  + venta_saldo  + venta_Flujo_Adicional  
	FROM #carteracur 
	WHERE estado_flujo = 1  AND tipo_flujo = 2    



WHILE (@@FETCH_STATUS = 0)
BEGIN

	IF @Tipoflujo = 1 
		BEGIN

			SELECT @cValMonHoy  = ISNULL(vmvalor,0),
			       @Cextranjera = mnextranj
			 FROM view_valor_moneda, view_moneda
			 WHERE vmcodigo = CASE WHEN @cMoneda = 13 THEN 994 ELSE @cMoneda END
			   AND vmfecha  = (CASE @cMoneda WHEN 998 THEN @Fecha_devengo ELSE @Fecha_Proceso END)
			   AND vmcodigo = MNCODMON

			SELECT @cValorMonedaAnt = ISNULL(vmvalor,0)
			 FROM view_valor_moneda
			 WHERE vmcodigo = CASE WHEN @cMoneda = 13 THEN 994 ELSE @cMoneda END
			   AND vmfecha  = (CASE @cMoneda WHEN 998 THEN @Fecha_devengoA ELSE @Fecha_Anterior END)

			IF @cValorMonedaAnt is NULL
				SELECT @cValorMonedaAnt = 1

			IF @cValMonHoy is NULL
				SELECT @cValMonHoy = 1

		END

	ELSE
		BEGIN

			SELECT @vValMonHoy = ISNULL(vmvalor,0),
			       @Vextranjera = mnextranj
			FROM  view_valor_moneda, view_moneda 
			WHERE vmcodigo = @vMoneda
		      AND vmfecha  = (CASE @vMoneda WHEN 998 THEN @Fecha_devengo ELSE @Fecha_Proceso END)
			  AND vmcodigo = MNCODMON

			SELECT @vValorMonedaAnt = ISNULL(vmvalor,0)
			FROM  view_valor_moneda
			WHERE vmcodigo = @vMoneda 
			  AND vmfecha  = (CASE @vMoneda WHEN 998 THEN @Fecha_devengoA ELSE @Fecha_Anterior END)

			IF @vValorMonedaAnt is NULL
				SELECT @vValorMonedaAnt = 1

			IF @cValMonHoy is NULL
				SELECT @cValMonHoy = 1

		END

	SELECT @cDevengo = 0.0,
           @vDevengo = 0.0

	SELECT @cValorHoy    = 0.0,
           @cVariaHoy    = 0.0, 
           @Valorizacion = 0.0

	SELECT @vValorHoy    = 0.0,
	       @vVariaHoy    = 0.0

     ----<< Define fecha de Devengos para Flujo Vigente y Venciendo
	IF  @Estado IN (1, 2) 
	BEGIN

		SELECT @DiasFlujo = DATEDIFF(day, @fecInicioFlujo, @fecVenceFlujo )
		
		IF @Fecha_DevengoA < @FecInicioFlujo
		        SELECT @devDiasA  = 0
		ELSE
			SELECT @devDiasA  = DATEDIFF(day, @fecInicioFlujo, @Fecha_DevengoA)
/*
	SELECT   @cValTasaHoy = ISNULL( tasa, 0.0 )
       	FROM     View_Moneda_Tasa
        WHERE    codmon      = (CASE WHEN @Tipoflujo = 1 THEN @cMoneda ELSE @vMoneda END)
       	      	 AND codtasa = @cCodTasa
               	 AND periodo = @cPeriodo
		 AND fecha   = @Fecha_Proceso
*/
	END 
	ELSE 
	BEGIN
		SELECT @DiasFlujo = 0
	    SELECT @devDias   = 0
        SELECT @devDiasA  = 0 
	END

      --> 'Cambio' Descrimina la Asignación del Valor para las tasas que se recalculan todos los días
      IF (SELECT SUBSTRING(nemo,1,1) FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 and tbcodigo1 = @cCodTasa) = 'N'
      BEGIN
         IF @Estado = 1 
         BEGIN
            IF @Tipoflujo = 1
            BEGIN
               IF @cAct_Tasa = 0
                  SELECT @cValTasaHoy = ISNULL(tasa,0.0)
                  FROM   VIEW_MONEDA_TASA
                  WHERE  codmon   = CASE WHEN @cMoneda = 13 THEN 994 ELSE @cMoneda END
                  AND    codtasa  = @cCodTasa
                  AND    periodo  = 1 -- MAP 20080105 @cPeriodo
                  AND    fecha    = @fecha_tasa -- MAP 20080105 @fecInicioFlujo, debe ser la fecha fijacion tasa 
				ELSE
                  SELECT  @cValTasaHoy = @cValTasa
            END 
            ELSE
            BEGIN
               IF @vAct_Tasa = 0
                  SELECT  @vValTasaHoy = ISNULL( tasa, 0.0 )
                  FROM    VIEW_MONEDA_TASA
                  WHERE   codmon  = CASE WHEN @vMoneda = 13 THEN 994 ELSE @vMoneda END
                  AND     codtasa = @vCodTasa
                  AND   periodo   = 1 -- MAP 20080105 @vPeriodo
                  AND     fecha   = @fecha_tasa -- MAP 20080105 @fecInicioFlujo, debe ser la fecha fijacion tasa
               ELSE
                  SELECT  @vValTasaHoy = @vValTasa
            END
         END
      END
/*
MAP 20081215 Contingencia
	-- TASA COMPRAMOS
 	IF @Estado <> 1 OR @Vcto=0
	  	SELECT @cValTasaHoy  = @cValTasa

	IF (@cValTasaHoy = 0.0 ) 
	BEGIN 
		IF @cCodTasa > 0 AND @Vcto = 1  
		BEGIN
			CLOSE curOperacion
			DEALLOCATE curOperacion
			SELECT -1, 'No se encontro Tasa de Compra para Actualizar Flujos'
			RETURN -1    
		END 
	END 

	-- TASA VENDEMOS
	IF @Estado <> 1 OR @Vcto=0
       		SELECT @vValTasaHoy  = @vValTasa

	IF (@vValTasaHoy = 0.0) 
	BEGIN 
		IF @vCodTasa > 0 AND @Vcto = 1
		BEGIN	        	
			SELECT -1, 'No se encontro Tasa de Venta para Actualizar Flujos'
			CLOSE curOperacion
			DEALLOCATE curOperacion
			RETURN    
		END
	END 
MAP 20081215 Contingencia
*/

     -------------------------------------<< Recalculo de Intereses
     ----<< Hubo Vencimiento de Flujo, actualiza los flujos vigentes no el que esta venciendo
	IF (@Vcto = 1 AND @Producto IN (1,2) AND @Estado = 1) OR (@Producto = 3 or @Producto = 4)   
        BEGIN
            --<< Recalcula intereses de Compra   sp_devengamiento 11
            IF @cCodTasa > 0 AND @cCodTasa <> 13 
            BEGIN  
               SELECT @Tasa = @cValTasaHoy + @cSpread * 1.0
               EXECUTE SP_BASEINTERES @cBase         ,  
                                      @fecInicioFlujo,
                                      @fecVenceFlujo ,
									  @cPeriodo	     ,
                                      @Tasa          ,
                                      @Tasa          OUTPUT
                                      
               SELECT @cInteres = (@cSaldo + @cAmortiza) * @Tasa / 1.
               SELECT @cInteres = @cInteres + ISNULL(@cMontoSpread,0.0)    -- nuevo
               
               IF @Cextranjera = '1' 
               BEGIN
                  SELECT @cInteres = ROUND(@cInteres ,2)
               END 	
            END
            
            --<< Recalcula intereses de Venta
            IF @vCodTasa > 0 AND @vCodTasa <> 13
            BEGIN  
               SELECT @Tasa = @vValTasaHoy + @vSpread * 1.0
               EXECUTE SP_BASEINTERES @vBase         ,  
                                      @fecInicioFlujo,
                                      @fecVenceFlujo ,
									  @vPeriodo	     ,	
                                      @Tasa          ,
                                      @Tasa          OUTPUT
               SELECT @vInteres = (@vSaldo + @vAmortiza) * @Tasa / 1.
               SELECT @vInteres = @vInteres + isnull(@vMontoSpread,0)     -- nuevo
               
               IF @Cextranjera = '1' 
	       BEGIN
                  SELECT @cInteres = ROUND(@cInteres ,2)
	       END 	
            END
         END


     -------------------------------------<< Devengamiento
     ----<< Swaps Vigente o Venciendo
	IF @Producto IN (1,2,4) AND @Estado IN (1,2) AND @fecInicio <= @FechaCalculos --> @Fecha_Proceso
	BEGIN

		--MEB
		SELECT @nPlazoRes     = DATEDIFF(DAY, @FechaCalculos, @fecVenceFlujo) -->  DATEDIFF(day, @Fecha_Proceso,@fecVenceFlujo)
		IF @Estado = 1	   
			BEGIN
				IF @Tipoflujo = 1 
					SELECT @ccurva = ( CASE WHEN @cmoneda IN (998,999) THEN 'SWAP UF' ELSE 'SWAP DOLARES' END )
				ELSE
					SELECT @ccurva = ( CASE WHEN @vmoneda IN (998,999) THEN 'SWAP UF' ELSE 'SWAP DOLARES' END )

				SELECT @vpmtm = @cInteres + @vInteres
				EXECUTE SP_MARKTOMARKET @cCurva, @nPlazoRes, @vpmtm, @FecVenceFlujo, @Monto_MTM OUTPUT, @Tasa_MTM OUTPUT  
			END

		
          --<< Venciendo select estado_flujo , * from cartera
		IF @Estado = 2  
		begin
		-- SELECT @fecInicioFlujo, @fecVenceFlujo
        		SELECT @devDias  = DATEDIFF(day, @fecInicioFlujo, @fecVenceFlujo)
		end
          --<< Intereses Flujos Vigente y Venciendo considera sus Intereses

		--***	 IF @Flujo <= @FlujoVigente or @Estado = 2 
		IF  @Estado IN (1, 2) 
		BEGIN
                	SELECT @cDevengo = @cDevengo + @cInteres,
                    	   @vDevengo = @vDevengo + @vInteres


			IF @Cextranjera = '1' OR @Vextranjera = '1'
	                	SELECT @cDevengo = ROUND(@cDevengo ,2),
        	            	   @vDevengo = ROUND(@vDevengo ,2)

		END
          --<< Capital Vigente para Flujos Vigente y Venciendo de los Swaps de Monedas 

		--***	        IF ( @Flujo <= @FlujoVigente or @Estado = 2 ) AND @Producto = 2   

	    IF (@Estado IN (1, 2) ) AND @Producto = 2   
		BEGIN
                        /* -- Se saco debido al que la suma la realiza mas arriba --
        		SELECT @cDevengo = @cDevengo + @cSaldo + @cAmortiza,
	                       @vDevengo = @vDevengo + @vSaldo + @vAmortiza
                        */
			IF @Cextranjera = '1' OR @Vextranjera = '1'
        			SELECT @cDevengo = ROUND(@cDevengo ,2 ),
		                   @vDevengo = ROUND(@vDevengo ,2 )
		END
          --<< Swaps de Monedas en Pesos

		SELECT @devMonto = 0.0

		--***IF @Flujo <= @FlujoVigente or @Estado = 2
		IF  @Estado IN (1, 2) 
			BEGIN
				IF  @TipoFlujo = 1
					BEGIN
		          		SELECT @devMonto = @cDevengo 
					END
				ELSE 
					BEGIN	
						SELECT @devMonto = @vDevengo
					END 
			END
          --<< Devengo diario

		EXECUTE SP_DIV @cDevengo, @DiasFlujo, @cDevAcum OUTPUT  
        EXECUTE SP_DIV @vDevengo, @DiasFlujo, @vDevAcum OUTPUT  

		IF @Cextranjera = '1' OR @Vextranjera = '1'
			SELECT @cDevAcum = ROUND( @cDevAcum ,2 ) ,
				   @vDevAcum = ROUND( @vDevAcum ,2 ) 

          --<< Devengos Acumulados 
		
		SELECT @cDevAcumAyer = @cDevAcum * @devDiasA
	    SELECT @vDevAcumAyer = @vDevAcum * @devDiasA

		IF @Cextranjera = '1' OR @Vextranjera = '1'
			SELECT @cDevAcumAyer = ROUND( @cDevAcumAyer , 2 ) ,
				   @vDevAcumAyer = ROUND( @vDevAcumAyer , 2 ) 

          --<< Flujo esta Venciendo
		IF @Estado = 2   BEGIN
			SELECT @cDevAcum = @cDevengo
			SELECT @vDevAcum = @vDevengo

		END ELSE BEGIN

			SELECT @cDevAcum = @cDevAcum * @devDias
			SELECT @vDevAcum = @vDevAcum * @devDias

			IF @Cextranjera = '1' OR @Vextranjera = '1'
				SELECT @cDevAcum = ROUND( @cDevAcum , 2 ) ,
					   @vDevAcum = ROUND( @vDevAcum , 2 ) 

		END

	  --<< Neto en Pesos Acumulado a la Fecha


-- sp_Devengamiento 41
		IF @Tipoflujo = 1 
			BEGIN    
			
			    SELECT @devMontoPeso = ROUND( (@cDevAcum ) * CASE WHEN @cMoneda IN (13,994) THEN @ValorDolarObsDia ELSE  @cValMonHoy END, 0)  --   -<< Metodo 1
				SELECT @devMtoAcum   = ROUND( (@cDevAcum ) * CASE WHEN @cMoneda IN (13,994) THEN @ValorDolarObsDia ELSE  @cValMonHoy END, 0)  
				SELECT @devMtoAcumAyer = ROUND( @cDevAcumAyer * CASE WHEN @cMoneda IN (13,994) THEN @ValorDolarObsDiaANT ELSE  @cValorMonedaAnt END,0)			
--				SELECT @Flujo,@devMtoAcumAyer , @cDevAcumAyer ,@ValorDolarObsDiaANT 
         		END
		ELSE 
			BEGIN 

				SELECT @devMontoPeso = ROUND( (@vDevAcum) * CASE WHEN @vMoneda IN (13,994) THEN @ValorDolarObsDia ELSE  @vValMonHoy END, 0)  --   -<< Metodo 1
				SELECT @devMtoAcum   = ROUND( (@vDevAcum) * CASE WHEN @vMoneda IN (13,994) THEN @ValorDolarObsDia ELSE  @vValMonHoy END, 0)  --BUSACR VALOR MON AYEEER
				SELECT @devMtoAcumAyer = ROUND( @vDevAcumAyer * CASE WHEN @vMoneda IN (13,994) THEN @ValorDolarObsDiaANT ELSE  @vValorMonedaAnt END , 0 )
---				SELECT @Flujo,@devMtoAcumAyer , @vDevAcumAyer ,@ValorDolarObsDiaANT 
			END 
	END

     ----<< Forward Rate Agreements
	IF @Producto = 3
	  BEGIN
	SELECT @devMonto = 0
	END


	IF @Flujo = @FlujoVigente   
    BEGIN

		SELECT @cValorHoy = @cSaldo + @cAmortiza + @cInteres,
					@vValorHoy = @vSaldo + @vAmortiza + @vInteres

		SELECT @cVariaHoy = @cValorHoy,
				@vVariaHoy = @vValorHoy 

		----<< Valorizacion y Variacion de T/C para la Compra

		SELECT @cValorHoy = ROUND( @cValorHoy * vmvalor, 0) 
		FROM view_valor_moneda 
		WHERE vmcodigo = CASE WHEN @cMoneda = 13 THEN 994 ELSE @cMoneda END 
			AND vmfecha  = CASE WHEN @cMoneda = 998 THEN @FechaCalculos ELSE @Fecha_Proceso END

		SELECT @cVariaHoy = ROUND( @cVariaHoy * vmvalor, 0) 
		FROM view_valor_moneda 
		WHERE vmcodigo   = CASE WHEN @cMoneda = 13 THEN 994 ELSE @cMoneda END 
			AND vmfecha    = @fecInicioFlujo
              
		-- CBB LO OMITE
		--	SELECT @cVariaHoy = ROUND( @cVariaHoy2 * vmvalor, 0) FROM view_valor_moneda 
		--WHERE vmcodigo = CASE WHEN @cMoneda = 13 THEN 994 ELSE @cMoneda END AND vmfecha = @fecInicioFlujo
			
		SELECT @cVariaHoy = @cValorHoy - @cVariaHoy 

		----<< Valorizacion y Variacion de T/C para la Venta
		SELECT @vValorHoy = ROUND( @vValorHoy * vmvalor, 0) 
		FROM view_valor_moneda 
		WHERE vmcodigo = @vMoneda 
			AND vmfecha  = CASE WHEN @vMoneda = 998 THEN @FechaCalculos ELSE @Fecha_Proceso END 

		SELECT @vVariaHoy = ROUND( @vVariaHoy * vmvalor, 0) 
		FROM view_valor_moneda 
		WHERE vmcodigo = @vMoneda 
			AND vmfecha  = @fecInicioFlujo

		SELECT @vVariaHoy = @vValorHoy - @vVariaHoy 

		----<< Valorizacion del Dia
		SELECT @Valorizacion = @cValorHoy - @vValorHoy
	END

----<< Calculo de Margenes Art.81/84 o Liquidaciones
	IF @Flujo <= @FlujoVigente  
	BEGIN
        	SELECT @cPago = @cInteres,
               	   @vPago = @vInteres

        --<< Solo Swaps de Monedas consideran Capital Vigente
	        IF @Producto = 2
        		SELECT @cPago = @cPago + @cSaldo + @cAmortiza,
		               @vPago = @vPago + @vSaldo + @vAmortiza

        --<< Montos de Pago a convertir
	        SELECT @cPagoCLP = @cPago,
        	       @vPagoCLP = @vPago,
               	   @cPagoUSD = @cPago,
	               @vPagoUSD = @vPago

		--<< Convertir a Pesos o USD según T/C para la Compra inicial o por liquidacion
	        IF @cMoneda <> 999  
	        BEGIN
		        SELECT @cPagoCLP = ROUND( @cPago * vmvalor, 0)  
        		FROM view_valor_moneda 
		        WHERE vmcodigo = CASE WHEN @cMoneda IN (13,994) THEN 994 ELSE @cMoneda END
	        	AND vmfecha = @fecCalculo
	        END

		--<< Convertir a Pesos o USD según T/C para la Venta inicial o por liquidacion
	        IF @vMoneda <> 999  
	        BEGIN
				SELECT @vPagoCLP = ROUND( @vPago * vmvalor, 0) 
				FROM view_valor_moneda 
				WHERE vmcodigo = CASE WHEN @vMoneda IN (13,994) THEN 994 ELSE @vMoneda END
				  AND vmfecha = @fecCalculo
	        END

        --<< Montos de Pago 
	        IF NOT @cMoneda IN (13,994)  --<< No es USA y Observado
		        SELECT @cPagoUSD = ROUND( @cPagoCLP / vmvalor, 0)  
		        FROM view_valor_moneda
                WHERE vmcodigo = 994 AND vmfecha = @fecCalculo AND vmvalor <> 0

	        IF NOT @vMoneda IN (13,994)  --<< No es USA y Observado
		        SELECT @vPagoUSD = ROUND( @vPagoCLP / vmvalor, 0)  
		        FROM view_valor_moneda
                WHERE vmcodigo = 994 AND vmfecha = @fecCalculo AND vmvalor <> 0

	END


	SELECT @CapitalVigentePesos_H	= 0
	SELECT @CapitalVigentePesos_A	= 0

	IF @Tipoflujo = 1
		BEGIN
			SELECT @CapitalVigentePesos_H = ROUND( @CapitalVigenteCompra * CASE WHEN @cMoneda IN (13,994) THEN @ValorDolarObsDia 	ELSE  @cValMonHoy 	 END,0)  
			SELECT @CapitalVigentePesos_A = ROUND( @CapitalVigenteCompra * CASE WHEN @cMoneda IN (13,994) THEN @ValorDolarObsDiaORI ELSE  @cValorMonedaAnt END,0)
		END
	IF @Tipoflujo = 2
		BEGIN
			SELECT @CapitalVigentePesos_H = ROUND( @CapitalVigenteVenta  * CASE WHEN @vMoneda IN (13,994) THEN @ValorDolarObsDia 	ELSE  @vValMonHoy 	 END,0)  
			SELECT @CapitalVigentePesos_A = ROUND( @CapitalVigenteventa  * CASE WHEN @vMoneda IN (13,994) THEN @ValorDolarObsDiaORI ELSE  @vValorMonedaAnt END,0)
		END

	-- SELECT @CapitalVigentePesos_H, @CapitalVigentePesos_A	,@Fecha_Anterior,@ValorDolarObsDia,@ValorDolarObsDiaANT

	IF @tipoflujo = 1 
		BEGIN 
			UPDATE Cartera
		      SET compra_interes        = CASE WHEN tipo_swap <> 3 THEN CASE WHEN compra_moneda = 999 THEN round(@cInteres,0)
                  															 ELSE @cInteres 
		                                                                END
                                               ELSE compra_interes 
		                                  END,
		        compra_valor_tasa_hoy = compra_valor_tasa , /* CASE WHEN tipo_swap <> 3 THEN @cValTasaHoy ELSE compra_valor_tasa_hoy END, */
		        compra_valor_tasa	  = compra_valor_tasa , /*CASE WHEN tipo_swap <> 3 THEN @cValTasaHoy ELSE compra_valor_tasa END , */
		        recibimos_monto       = @cPago          		,
		        recibimos_monto_USD   = @cPagoUSD       		,
		        recibimos_monto_CLP   = @cPagoCLP       		,
		        devengo_compra        = @cDevengo       		,
		        devengo_compra_acum   = @cDevAcum       		,
		        devengo_compra_ayer   = @cDevAcumAyer   		,
			    devengo_monto         = @devMonto       		,
		        devengo_monto_acum    = @devMtoAcum     		,
		        devengo_monto_ayer    = CASE WHEN tipo_swap = 4 THEN DevAntPromCam ELSE @devMtoAcumAyer END,
			    devengo_monto_peso    = @devMontoPeso   		,
		        devengo_dias          = @devDias       		    ,
		        compra_valorizada     = @cValorHoy      		,
		        compra_variacion      = @cVariaHoy      		,
		        valorizacion_dia      = @Valorizacion   		,
			    Compra_Capital		  = @CapitalVigenteCompra	,
			    compra_mercado_tasa	  = ISNULL(@Tasa_MTM,0)	    ,
--			    compra_valor_presente = ISNULL(@Monto_MTM,0)	, MAP 20080430, Se usará para sp_Calculo_ActPas_C08
			    capital_pesos_actual  = @CapitalVigentePesos_H	,
			    capital_pesos_ayer	  = @CapitalVigentePesos_A  ,
                Monto_diferido_diario = ROUND(@CapitalVigentePesos_H - @CapitalVigentePesos_A,0)
			WHERE numero_operacion  = @Numero_Operacion
		        AND numero_flujo        = @Flujo
			AND Tipo_flujo 		= @TipoFlujo	
		END  	
	ELSE 
		BEGIN 
			UPDATE Cartera
			SET venta_interes         = CASE WHEN Tipo_Swap <> 3 THEN CASE WHEN venta_moneda = 999 THEN round(@vInteres,0)
                  														   else @vInteres 
			                                                          END
                                             ELSE Venta_interes 
			                            END,
		        venta_valor_tasa_hoy  = venta_Valor_tasa , /*CASE WHEN Tipo_Swap <> 3 THEN @vValTasaHoy ELSE venta_valor_tasa_hoy END, */
		        venta_valor_tasa	  = venta_Valor_tasa , /*CASE WHEN Tipo_swap <> 3 THEN @vValTasaHoy ELSE venta_valor_tasa END ,*/
		        pagamos_monto         = @vPago          		,
		        pagamos_monto_USD     = @vPagoUSD       		,
		        pagamos_monto_CLP     = @vPagoCLP       		,
		        devengo_venta         = @vDevengo       		,
		        devengo_venta_acum    = @vDevAcum       		,
		        devengo_venta_ayer    = @vDevAcumAyer   		,
		        devengo_monto         = @devMonto       		,
		        devengo_monto_acum    = @devMtoAcum     		,
		        devengo_monto_ayer    = CASE WHEN tipo_swap = 4 THEN DevAntPromCam ELSE @devMtoAcumAyer END,
			    devengo_monto_peso    = @devMontoPeso   		,
		        devengo_dias          = @devDias        		,
		        venta_valorizada      = @vValorHoy      		,
		        venta_variacion       = @vVariaHoy      		,
		        valorizacion_dia	  = @Valorizacion   		,
			    Venta_Capital		  = @CapitalVigenteVenta	,
			    venta_mercado_tasa	  = ISNULL(@Tasa_MTM,0)	    ,
--			    venta_valor_presente  = ISNULL(@Monto_MTM,0)	, MAP 20080430, Se usará para sp_Calculo_ActPas_			    
			    capital_pesos_actual  = @CapitalVigentePesos_H	,
			    capital_pesos_ayer	  = @CapitalVigentePesos_A  ,
				Monto_diferido_diario = ROUND(@CapitalVigentePesos_H - @CapitalVigentePesos_A,0)
			WHERE numero_operacion	  = @Numero_Operacion
		      AND numero_flujo        = @Flujo
			  AND Tipo_flujo 		  = @TipoFlujo	
		END     


	IF @@error <> 0
	  BEGIN
        	SELECT @Cont = -1 
  	        SELECT -1, 'No se puede Actualizar Devengo de' + @Oper + ' Flujo # ' + CONVERT(VARCHAR(5), @Flujo)
        	BREAK
	END

	IF @fecVenceFlujo = @Fecha_Proceso
           SELECT @Vcto = 1

         /*
         IF @Estado = 2 
         BEGIN
            IF (@cAmortiza <> 0  AND @Tipoflujo = 1)
            BEGIN
            -- ACTUALIZA CAPITAL DE FLUJO RESTANTES SI ES QUE HAY AMORTIZACION DE CAPITAL
               SET @CapitalVigenteCompra = @cSaldo
            END ELSE 
            IF (@vAmortiza <> 0  AND @Tipoflujo = 2)
            BEGIN
               SET @CapitalVigenteVenta = @vSaldo
            END	
         END
         */
	
	SELECT @Cont = @Cont + 1

	FETCH NEXT FROM curOperacion
                INTO @Producto       ,
                     @Flujo          ,
					 @Tipoflujo	     ,		
                     @Estado         ,
                     @TipOpe         ,
                     @Moneda         ,
                     @Cartera        ,
                     @fecCalculo     ,
                     @fecCierre      ,
					 @fecInicio      ,
                     @fecTermino     ,
					 @fecInicioFlujo ,
					 @fecVenceFlujo  ,
                     @Tenor          ,
                     @cMoneda        ,
                     @cAmortiza      ,
                     @cSaldo         ,
                     @cInteres       ,
                     @cCodTasa       ,
                     @cValTasa       ,
                     @cValTasaHoy    ,
					 @cSpread        ,
                     @cPeriodo       ,
					 @cBase          ,
					 @cDevengo       ,
	 				 @cDevAcum       ,
                     @cDevAcumAyer   ,
                     @cMonedaPago    ,
                     @cPago          ,
                     @cPagoUSD       ,
                     @cPagoCLP       ,
					 @vMoneda        ,
                     @vAmortiza      ,
                     @vSaldo         ,
                     @vInteres       ,
                     @vCodTasa       ,
                     @vValTasa       ,
                     @vValTasaHoy    ,
                     @vSpread        ,
                     @vPeriodo       ,
                     @vBase          ,
 					 @vDevengo		 ,
                     @vDevAcum       ,
                     @vDevAcumAyer   ,
                     @vMonedaPago    ,
                     @vPago          ,
                     @vPagoUSD       ,
                     @vPagoCLP       ,
                     @devMonto       ,
                     @devMtoAcum     ,
                     @devMtoAcumAyer ,
					 @devMontoPeso   ,
                     @devDias        ,
                     @cValorHoy      ,
                     @cVariaHoy      ,
                     @vValorHoy      ,
          			 @vVariaHoy      ,
                     @Valorizacion   ,
                     @Modalidad      ,
					 @fecha_tasa     ,
	   				 @cAct_Tasa	     ,
					 @vAct_Tasa

END -- WHILE de Cursor

CLOSE curOperacion

DEALLOCATE curOperacion

SET NOCOUNT OFF

END


GO
