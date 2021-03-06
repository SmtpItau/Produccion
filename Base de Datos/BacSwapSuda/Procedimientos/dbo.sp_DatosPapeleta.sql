USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_DatosPapeleta]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

--     EXECUTE sp_DatosPapeleta 100 , 1552 , 1111 , 1554 , 204 , 1553
CREATE PROCEDURE [dbo].[sp_DatosPapeleta]
   (    @numoper        FLOAT
   ,	@CatLibro      CHAR(10)
   ,	@CatCartNorm   CHAR(10)
   ,	@CatSubCart    CHAR(10)
   ,	@CatCartFin    CHAR(10)
   ,	@CatAreaResp   CHAR(10)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Firma1          CHAR(15)
   DECLARE @Firma2          CHAR(15)
   DECLARE @sMooper         CHAR(15)
   DECLARE @sMoterm         CHAR(15)
   DECLARE @ParidadCompra   NUMERIC(21,4)
   DECLARE @ParidadVenta    NUMERIC(21,4)

   SELECT  @ParidadCompra   = 0.0
   SELECT  @ParidadVenta    = 0.0

   IF EXISTS( SELECT 1 FROM MOVDIARIO WHERE numero_operacion = @numoper )
   BEGIN
      SELECT @ParidadCompra   = ParidadCompra
      ,      @ParidadVenta    = ParidadVenta
      FROM   BacSwapSuda..MOVDIARIO
      WHERE  numero_operacion = @numoper
   END ELSE
   BEGIN
      SELECT @ParidadCompra   = ParidadCompra
      ,      @ParidadVenta    = ParidadVenta
      FROM   BacSwapSuda..MOVDIARIO
      WHERE  numero_operacion = @numoper
   END

   SELECT @Firma1     = res.Firma1
   ,	  @Firma2     = res.Firma2
   ,	  @sMooper    = ori.operador
   ,	  @sMoterm    = ''
   FROM   BacLineas..DETALLE_APROBACIONES res
          LEFT JOIN  MOVDIARIO            ori ON res.Numero_Operacion = ori.Numero_Operacion
   WHERE  res.Numero_Operacion =  @numoper

   DECLARE @encabezado	 VARCHAR(300)
   DECLARE @encabezado1	 VARCHAR(300)
   DECLARE @encabezado2	 VARCHAR(300)
   DECLARE @encabezado3	 VARCHAR(300)
   DECLARE @encabezado4	 VARCHAR(300)
   DECLARE @encabezado5	 VARCHAR(300)
   DECLARE @encabezado6	 VARCHAR(300)
   DECLARE @encabezado7	 VARCHAR(300)
   DECLARE @encabezado8	 VARCHAR(300)
   DECLARE @encabezado9	 VARCHAR(300)
   DECLARE @encabezado10 VARCHAR(300)
   DECLARE @encabezado11 VARCHAR(300)
   DECLARE @encabezado12 VARCHAR(300)
   DECLARE @encabezado13 VARCHAR(300)
   DECLARE @encabezado14 VARCHAR(300)

   DECLARE @encabcompra1 VARCHAR(300)
   DECLARE @encabcompra2 VARCHAR(300)
   DECLARE @encabcompra3 VARCHAR(300)
   DECLARE @encabcompra4 VARCHAR(300)

   DECLARE @encabVenta1	 VARCHAR(300)
   DECLARE @encabVenta2	 VARCHAR(300)
   DECLARE @encabVenta3	 VARCHAR(300)
   DECLARE @encabVenta4	 VARCHAR(300)
   DECLARE @desde	 VARCHAR(300)
   DECLARE @cuando	 VARCHAR(300)
   DECLARE @consulta	 VARCHAR(300)
   DECLARE @consulta1	 VARCHAR(300)
   DECLARE @opcuser	 VARCHAR(15)
   DECLARE @estadope     VARCHAR(2)	
   DECLARE @UF 		 FLOAT
   DECLARE @OBS 	 FLOAT	
   DECLARE @Banco 	 CHAR(45)	
   DECLARE @lugares 	 CHAR(50)	

   /*****************************************/
   /*         Estado de la operacion        */
   /*****************************************/  		
   SELECT @Banco    = ISNULL(nombre,' ')
   FROM   BacSwapSuda..SWAPGENERAL

   SELECT @estadope = ISNULL((SELECT DISTINCT estado FROM BacSwapSuda..CARTERALOG WHERE  numero_operacion = @numoper AND estado = 'A'),'NO')

   IF @estadope = 'A'
   BEGIN
	SELECT @opcuser = "  Anulación "	
   END ELSE 
   BEGIN 
      SELECT @estadope = ISNULL((SELECT DISTINCT estado FROM BacSwapSuda..CARTERALOG WHERE numero_operacion = @numoper AND estado = 'M'),'NO') 

      IF @estadope = 'M'
      BEGIN
         SELECT @opcuser = "Modificación"
      END ELSE 
      BEGIN
         SELECT @opcuser = "   Ingreso  "
      END
   END 

   DECLARE @vMonedaC   NUMERIC(21,4)
   ,       @vMonedaV   NUMERIC(21,4)

   SELECT  @vMonedaC        = CASE WHEN compra_moneda = 999 THEN 1 ELSE isnull(vmvalor,0.0) END
   FROM    BacSwapSuda..CARTERA
           INNER JOIN BacParamSuda..VALOR_MONEDA ON vmfecha = fecha_cierre AND vmcodigo = CASE WHEN compra_moneda = 13 THEN 994 ELSE compra_moneda END
   WHERE   numero_operacion = @numoper
   AND     tipo_flujo       = 1
   AND     numero_flujo     = 1
   
   SELECT  @vMonedaV        = CASE WHEN venta_moneda = 999 THEN 1 ELSE isnull(vmvalor,0.0) END
   FROM    BacSwapSuda..CARTERA
           INNER JOIN BacParamSuda..VALOR_MONEDA ON vmfecha = fecha_cierre AND vmcodigo = CASE WHEN venta_moneda = 13 THEN 994 ELSE venta_moneda END
   WHERE   numero_operacion = @numoper
   AND     tipo_flujo       = 2
   AND     numero_flujo     = 1


   /*=======================================================================*/
   /* Encabezado de la Consulta						    */	
   /*=======================================================================*/
   DECLARE @MiFlujo           INTEGER
   SELECT  @MiFlujo           = MIN(numero_flujo) 
   FROM    BacSwapSuda..CARTERA 
   ,       BacSwapSuda..SWAPGENERAL 
   WHERE   fecha_vence_flujo >= fechaproc

	SELECT	DISTINCT
		Numero_Operacion										,
		Codigo_Cliente											,
		Nombrecli 	= ISNULL(clnombre,'***') 							,
		Tipo_operacion 											,
		NombreOp	= (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END)		,
		FechaInicio	= CONVERT(CHAR(10), Fecha_inicio, 103)						,
		FechaCierre 	= CONVERT(CHAR(10), Fecha_Cierre, 103)						,
		Fechatermino 	= CONVERT(CHAR(10), Fecha_termino, 103)						,
		MonedaOperacion = (CASE Tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END)	,
		MonedaCompra 	= ISNULL((SELECT mnglosa FROM View_Moneda WHERE mncodmon = compra_moneda),' ')	,
		MonedaVenta  	= @lugares									,
		MontoCompra 	= Compra_capital 								,
		MontoVenta  	= Venta_capital 								,
		baseVenta	= @lugares									,
		Modalidad	= ISNULL((CASE Modalidad_Pago WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA     ' END),' ')	,
		rutcli  	= rut_cliente 									,
		dv	   	= '-' + ISNULL(cldv ,'*')							,
		montouf  	= CONVERT ( CHAR(20) , @UF ) 							,
		montoobs 	= CONVERT(CHAR(20),@OBS) 							,
		banco    	= @BANCO 									,
		operador											,
		operador_cliente 										,
		cartinversion	   = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartFin AND TBCODIGO1 = cartera_inversion),''),
		nombretasaCompra   = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = compra_codigo_tasa AND tbcateg = 1042 ),' '),
		nombretasacVenta   = @lugares									,
		operacionuser	   = @opcuser									,
		hora 		   = CONVERT( CHAR(08),GETDATE(),114) 						,
		pagamosdocVenta    = @lugares									,
		nemomonedaVenta    = @lugares									,
		compra_base	   = ISNULL( ( SELECT glosa FROM base WHERE codigo = Compra_Base ) , '*' ) 	,
		venta_base	   = @lugares									,
		compra_valor_tasa										,
		venta_valor_tasa 										,
		compra_spread											,
		venta_spread											,
		codamo_capital_c   = (Select glosa from View_Periodo_Amortizacion Where Codigo=compra_codamo_capital And tabla = 1043)	,
		codamo_interes_c   = (Select glosa from View_Periodo_Amortizacion Where Codigo=compra_codamo_interes And tabla = 1044)  , 
		codamo_capital_v   = @lugares									,
		codamo_interes_v   = @lugares									,
		recibimosdocCompra = ISNULL((SELECT glosa FROM View_Forma_de_Pago WHERE codigo = recibimos_documento),' ')		,
		NemoMonCompra      = ISNULL((SELECT mnnemo FROM View_Moneda WHERE mncodmon = compra_moneda ),' ')			,
		Limites		   = Observacion_Limites							,
		Lineas		   = Observacion_Lineas	
	,	'Libro'		   = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @CatLibro	AND tbcodigo1 = car_libro),'')
	,	'Cartera_Super'	   = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @CatCartNorm	AND tbcodigo1 = car_cartera_normativa),'')
	,	'SubCartera_Super' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @CatSubCart	AND tbcodigo1 = car_subcartera_normativa),'')
	,	'Area_Responsable' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @CatAreaResp	AND tbcodigo1 = car_area_responsable ),'')
        ,       'vMonedaC'         = @vMonedaC
        ,       'vMonedaV'         = @vMonedaV
        ,       'TasaSpreadCompra' = rtrim(ltrim(compra_valor_tasa)) + ' + ' + ltrim(rtrim(compra_spread))
        ,       'TasaSpreadVenta'  = rtrim(ltrim(compra_valor_tasa)) + ' + ' + ltrim(rtrim(compra_spread))
	INTO	#encabezado
	FROM 	Cartera 	,
		View_cliente 
	WHERE 	numero_operacion = CONVERT(CHAR(7) , @numoper )	
        AND     codigo_cliente 	*= clcodigo  	
        AND     rut_cliente    	*= clrut	
        AND     tipo_flujo	 = 1
        AND     numero_flujo     = @MiFlujo

	UPDATE  #encabezado
	SET	codamo_capital_v   = (Select glosa from View_Periodo_Amortizacion Where Codigo=a.venta_codamo_capital And tabla = 1043)				,
		codamo_interes_v   = (Select glosa from View_Periodo_Amortizacion Where Codigo=a.venta_codamo_interes And tabla = 1044)				, 
		MonedaVenta  	   = ISNULL((SELECT mnglosa FROM View_Moneda WHERE mncodmon = venta_moneda ),' ')						,
		pagamosdocVenta    = ISNULL((SELECT glosa FROM View_Forma_de_Pago WHERE codigo = a.pagamos_documento ),' ')					,
		nemomonedaVenta    = ISNULL((SELECT mnnemo FROM View_Moneda WHERE mncodmon = a.venta_moneda),' ')						,
		nombretasacVenta   = ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = a.venta_codigo_tasa  AND tbcateg = 1042),' ') 	,
		MontoVenta  	   = Venta_capital 								,
		venta_base	   = ISNULL( ( SELECT glosa FROM base WHERE codigo = a.venta_base ) , '*' ) 	,
		venta_valor_tasa   = a.venta_valor_tasa								,
		venta_spread	   = a.venta_spread                                                             ,
                TasaSpreadVenta    = rtrim(ltrim(a.venta_valor_tasa)) + ' + ' + ltrim(rtrim(a.venta_spread))
	FROM	cartera a
	WHERE 	a.numero_operacion = CONVERT(CHAR(7) , @numoper )	AND 
		tipo_flujo	=2


	SELECT	e.Numero_Operacion		,
		e.Codigo_Cliente		,
		e.Nombrecli			,
		e.Tipo_operacion		,
		e.NombreOp			,
		e.FechaInicio			,
		e.FechaCierre			,
		e.Fechatermino			,
		e.MonedaOperacion		,
		e.MonedaCompra			,
		e.MonedaVenta			,
		e.MontoCompra			,
		e.MontoVenta			,
		e.baseVenta			,
		e.Modalidad			,
		e.rutcli			,
		e.dv				,
		e.montouf			,
		e.montoobs			,
		e.banco				,
		e.operador			,
		e.operador_cliente		,
		e.cartinversion			,
		e.nombretasaCompra		,
		e.nombretasacVenta		,
		e.operacionuser			,
		e.hora				,
		e.pagamosdocVenta		,
		e.nemomonedaVenta		,
		e.compra_base			,
		e.venta_base			,
		e.compra_valor_tasa		,
		e.venta_valor_tasa		,
		e.compra_spread			,
		e.venta_spread			,
		e.recibimosdocCompra		,
		e.NemoMonCompra			,
		e.codamo_capital_c		,
		e.codamo_interes_c		,
		e.codamo_capital_v		,
		e.codamo_interes_v		,
		mov.numero_flujo		,
		e.Limites			,
		e.Lineas			,
		'fechainicioflujo' = CONVERT(CHAR(10),mov.Fecha_inicio_flujo,103)					,
		'fechavenceflujo'  = CONVERT(CHAR(10),mov.Fecha_vence_flujo,103)					,
		'moneda'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_moneda         ELSE mov.venta_moneda	 	END 	,
		'capital'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_capital        ELSE mov.venta_capital	 	END 	,
		'amortiza'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_amortiza       ELSE mov.venta_amortiza	END 	,
		'saldo'		   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_saldo          ELSE mov.venta_saldo	 	END 	,
		'interes'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_interes        ELSE mov.venta_interes	 	END 	,
		'comprainteres'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_interes        ELSE 0		 	END 	,
		'ventainteres'	   = CASE WHEN mov.tipo_flujo = 1 THEN 0	                 ELSE mov.venta_interes	 	END 	,
		'spread'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_valor_tasa + mov.compra_spread         ELSE mov.venta_valor_tasa + mov.venta_spread	 	END 	,
		'codigo_tasa'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_codigo_tasa    ELSE mov.venta_codigo_tasa 	END 	,
		'valor_tasa'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_valor_tasa     ELSE mov.venta_valor_tasa	END 	,
		'valor_tasa_hoy'   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_valor_tasa_hoy ELSE mov.venta_valor_tasa_hoy 	END 	,
--		'codamo_capital'   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_codamo_capItal ELSE mov.venta_codamo_capital 	END 	,
		'mesamo_capital'   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_mesamo_capital ELSE mov.venta_mesamo_capital 	END 	,
--		'codamo_interes'   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_codamo_interes ELSE mov.venta_codamo_interes 	END 	, 
		'mesamo_interes'   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_mesamo_interes ELSE mov.venta_mesamo_interes 	END 	,
		'base'		   = CASE WHEN mov.tipo_flujo = 1 THEN mov.compra_base 	         ELSE mov.venta_base		END 	,
		'monflujo'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.recibimos_moneda	 ELSE mov.pagamos_moneda        END 	,
		'documento'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.recibimos_documento  ELSE mov.pagamos_documento	END 	,
		'monto'		   = CASE WHEN mov.tipo_flujo = 1 THEN mov.recibimos_monto	 ELSE mov.pagamos_monto		END 	,
		'monto_USD'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.recibimos_monto_USD   ELSE mov.pagamos_monto_usd	END 	,
		'monto_CLP'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.recibimos_monto_CLP   ELSE mov.pagamos_monto_clp	END 	,
		'compraCLP'	   = CASE WHEN mov.tipo_flujo = 1 THEN mov.recibimos_monto_CLP   ELSE 0		        	END 	,
		'ventaCLP'	   = CASE WHEN mov.tipo_flujo = 1 THEN 0		         ELSE mov.pagamos_monto_clp	END 	,
		'nombretasa'	   = CASE WHEN mov.tipo_flujo = 1 THEN ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = mov.compra_codigo_tasa AND tbcateg = 1042),' ') 
								  ELSE ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = mov.venta_codigo_tasa  AND tbcateg = 1042),' ') END ,
		'dias'		   = DATEDIFF(dd,mov.Fecha_inicio_flujo, mov.Fecha_vence_flujo)	,
		'grupo'		   = CASE WHEN mov.tipo_flujo = 1 THEN 'COMPRA' ELSE 'VENTA' END
	   	, @Firma1          as Firma1
                , @Firma2          as Firma2
                , @sMooper         as sMooper
                , @sMoterm         as sMoterm
                , @ParidadCompra   as ParidadCompra
                , @ParidadVenta    as ParidadVenta
	,	Libro			
	,	Cartera_Super		
	,	SubCartera_Super	
	,	Area_Responsable
        ,       vMonedaC
        ,       vMonedaV
        ,       TasaSpreadCompra
        ,       TasaSpreadVenta
	FROM  	#encabezado e	,
		cartera Mov	
	WHERE 	mov.numero_operacion = @numoper			AND 
		mov.numero_operacion =* e.numero_operacion 

	SET NOCOUNT OFF

END

GO
