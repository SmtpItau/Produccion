USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSPAPELETATASA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATOSPAPELETATASA] 
(		@numoper         FLOAT    
						,	@CatLibro	CHAR(10) = '1552'
						,	@CatCartNorm	CHAR(10) = '1111'
						,	@CatSubCart	CHAR(10) = '1554'
						,	@CatCartFin	CHAR(10) = '204'
						,	@CatAreaResp	CHAR(10) = '1553'
						)
AS
BEGIN

      SET NOCOUNT ON

      DECLARE @Firma1           CHAR(15)
      DECLARE @Firma2           CHAR(15) 
      DECLARE @sMooper          CHAR(15)
      DECLARE @sMoterm          CHAR(15)
      DECLARE @opcuser	   	VARCHAR(15)
      DECLARE @estadope       	VARCHAR(2)
      DECLARE @fechatermino   	DATETIME
      DECLARE @fecha_proc	CHAR(8)
      DECLARE @fecha_operacion	CHAR(8)
      DECLARE @UF 		FLOAT
      DECLARE @OBS 	        FLOAT
      DECLARE @Banco 	        CHAR(45)	
      DECLARE @lugares 	        CHAR(50)	

      SELECT  @Firma1     = res.Firma1
      ,	      @Firma2     = res.Firma2
      ,	      @sMooper    = ori.operador
      ,	      @sMoterm    = ''
      FROM    BacLineas..DETALLE_APROBACIONES res
              LEFT JOIN  MOVDIARIO ori ON res.Numero_Operacion = ori.Numero_Operacion
      WHERE   res.Numero_Operacion =  @numoper

      /*****************************************/
      /*         Estado de la operacion        */
      /*****************************************/

      SELECT @Banco 	   = ISNULL(nombre ,' ')
      ,      @fecha_proc   = CONVERT(CHAR(8),fechaproc,112)
      FROM   SwapGeneral
   
      SELECT @estadope        = ISNULL((SELECT DISTINCT estado
    			                FROM  CARTERALOG
			                WHERE numero_operacion = @numoper AND estado = 'A'),'NO')

      IF @estadope = 'A'
      BEGIN
         SELECT @opcuser = '  Anulacion'
      END ELSE 
      BEGIN 
         SELECT @estadope = ISNULL((SELECT DISTINCT estado
			            FROM   CARTERALOG
                                    WHERE  numero_operacion = @numoper AND estado = 'M'),'NO')

         IF @estadope = 'M'
         BEGIN
            SELECT @opcuser = 'Modificacion'
         END ELSE 
         BEGIN
            SELECT @opcuser = '   Ingreso  '
         END
      END 

      SELECT DISTINCT @fecha_operacion = CONVERT(CHAR(8),fecha_cierre,112)
      FROM   CARTERA mov
      WHERE  mov.numero_operacion      = @numoper  
      AND    tipo_flujo                = 1

      --   GENERA DIAS EN BASE A LA CONVENCION DE DIAS --
      DECLARE @iRegistros INTEGER
      ,       @iRegistro  INTEGER
      ,       @iOperacion NUMERIC(10)
      ,       @iFlujo     NUMERIC(10)
      ,       @iTipo      NUMERIC(10)
      ,       @iDesde     DATETIME
      ,       @iHasta     DATETIME
      ,       @iDias      NUMERIC(10)
      ,       @iBase      NUMERIC(10) -- MAP 20060718
      
      CREATE TABLE #Flujos
      (   SwOperacion   NUMERIC(10)
      ,   SwFlujo       NUMERIC(10)
      ,   SwTipo        INTEGER
      ,   SwInicio      DATETIME
      ,   SwTermino     DATETIME
      ,   SwBase        NUMERIC(10) -- MAP 20060718
      ,   SwDias        NUMERIC(10)
      ,   Correlativo   INT identity (1,1) NOT NULL
      )

	INSERT INTO #Flujos
	SELECT numero_operacion 
	,	numero_flujo 
	,	tipo_flujo 
	,	fecha_inicio_flujo 
	,	fecha_vence_flujo 
        ,       case when Tipo_Flujo = 1 then Compra_Base else Venta_base end -- MAP 20060718
	,	0 
	FROM	MOVHISTORICO 
	WHERE	numero_operacion =  @numoper
	UNION
	SELECT	numero_operacion 
	,	numero_flujo 
	,	tipo_flujo 
	,	fecha_inicio_flujo 
	,	fecha_vence_flujo 
        ,       case when Tipo_Flujo = 1 then Compra_Base else Venta_base end  -- MAP 20060718
	,	0 
	FROM	CARTERA      
	WHERE	numero_operacion =  @numoper

      SELECT @iRegistros = MAX(Correlativo)
      ,      @iRegistro  = MIN(Correlativo)
      FROM   #Flujos

      WHILE @iRegistros >= @iRegistro
      BEGIN
         SELECT @iOperacion = SwOperacion
         ,      @iFlujo     = SwFlujo
 ,      @iTipo      = SwTipo
         ,      @iDesde     = SwInicio
         ,      @iHasta     = SwTermino
         ,      @iBase      = SwBase                                           -- MAP 20060718
         ,      @iDias      = 0
         FROM   #Flujos
         WHERE  Correlativo = @iRegistro

         if @iBase in ( 4, 5 )                                                 -- MAP 20060718
            EXECUTE BACBONOSEXTSUDA..SVC_FMU_DIF_D30 @iDesde , @iHasta , @iDias OUTPUT    
         else                                                                  -- MAP 20060718
            select @iDias = datediff( dd, @iDesde, @iHasta )                   -- MAP 20060718
         
         UPDATE #Flujos SET SwDias = @iDias WHERE Correlativo = @iRegistro

         SELECT @iRegistro  = @iRegistro + 1
      END
      --   GENERA DIAS EN BASE A LA CONVENCION DE DIAS --


      IF @fecha_operacion <> @fecha_proc OR @fecha_operacion IS NULL
      BEGIN

         SELECT  DISTINCT
            /*001*/   'Numero_Operacion'        = Mov.Numero_Operacion
         ,  /*002*/   'codigo_cliente'          = Mov.codigo_cliente
         ,  /*003*/   'Nombrecli'		= ISNULL((clnombre ),'*')
         ,  /*004*/   'Tipo_operacion'          = Mov.Tipo_operacion
         ,  /*005*/   'NombreOp'		= CASE WHEN Mov.tipo_operacion = 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END
         ,  /*006*/   'FechaInicio'		= CONVERT(CHAR(10),Mov.fecha_inicio,103)
         ,  /*007*/   'FechaCierre'		= CONVERT(CHAR(10),Mov.fecha_cierre,103)
         ,  /*008*/   'Fechatermino'		= CONVERT(CHAR(10),Mov.fecha_termino,103)
         ,  /*009*/   'MonedaOperacion'	        = compra_moneda
         ,  /*010*/   'NombreMoneda'		= ISNULL(mco.mnglosa,'*')
         ,  /*011*/   'MontoOperacion'	        = compra_capital
         ,  /*012*/   'pagamosbase'	   	= @lugares
         ,  /*013*/   'recibirbase'	   	= ISNULL(bco.glosa,'*')
         ,  /*014*/   'ValorTasaPag' 		= venta_valor_tasa
         ,  /*015*/   'ValorTasaRec' 		= compra_valor_tasa
         ,  /*016*/   'rutcli' 		        = clrut
         ,  /*017*/   'dv'			= '-' + cldv
         ,  /*018*/   'banco' 		        = @BANCO
         ,  /*019*/   'operador'                = operador
         ,  /*020*/   'NombreOperador' 	        = ISNULL((Op.opNombre),'No Encontrado')
         ,  /*021*/   'RutOperador' 	    	= RTRIM(ISNULL(CONVERT(CHAR(10),Op.oprutope),'*')) +  '-' + ISNULL(CONVERT(CHAR(10),op.opdvope),'*')
         ,  /*022*/   'cartinversion' 	        = ISNULL(cfinan.tbglosa,'')
         ,  /*023*/   'tasarecibimos'		= ISNULL(trecib.tbglosa,' ')
         ,  /*024*/   'tasapagamos'		= ISNULL(tpagam.tbglosa,' ')
         ,  /*025*/   'operacionuser'		= @opcuser
         ,  /*026*/   'hora'			= CONVERT(CHAR(10),GETDATE(),108)
         ,  /*027*/   'pagamosdoc'		= ISNULL(pagdoc.glosa,' ')
         ,  /*028*/   'recibimosdoc'		= ISNULL(recdoc.glosa,' ')
         ,  /*029*/   'MonedaPagamos'		= @lugares
         ,  /*030*/   'MonedaRecibimos'	        = ISNULL(mre.mnglosa,'*')
         ,  /*031*/   'Modalidad'  		= CASE WHEN Mov.Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA     ' END
         ,  /*032*/   'AmortCap'  		= isnull(amocom.glosa,' ')
         ,  /*033*/   'amortInt'   		= isnull(intcom.glosa,'')
         ,  /*034*/   'AmortCappag'  		= @lugares
         ,  /*035*/   'amortIntpag'  		= @lugares
         ,  /*036*/   'UFDia'     		= ISNULL(valmon.vmvalor,0)
         ,  /*037*/   'PeriodoDia'   		= CONVERT(CHAR(4),intcom.Dias)
         ,  /*038*/   'PeriodoDiapagamos'	= @lugares
         ,  /*039*/   'moneda'		        = compra_moneda
         ,  /*040*/   'SpreadRec'		= compra_spread
         ,  /*041*/   'SpreadPag'		= @OBS
         ,  /*042*/   'Limites'		        = Observacion_Limites
         ,  /*043*/   'Lineas'		        = Observacion_Lineas
         ,  /*044*/   'Libro'			= ISNULL(iLibro.tbglosa,'')
         ,  /*045*/   'Cartera_Super'		= ISNULL(icsupe.tbglosa,'')
         ,  /*046*/   'SubCartera_Super'	= ISNULL(scarts.tbglosa,'')
         ,  /*047*/   'Area_Responsable'	= ISNULL(arespo.tbglosa,'')
         INTO 	#encabezado
         FROM  	MOVHISTORICO                     mov
            LEFT JOIN VIEW_VALOR_MONEDA          valmon ON valmon.vmcodigo      = 998                AND valmon.vmfecha     = Mov.Fecha_Cierre
            LEFT JOIN VIEW_CLIENTE                 Cli  ON Mov.rut_cliente      = Cli.clrut          AND Mov.codigo_cliente = Cli.clcodigo
            LEFT JOIN VIEW_CLIENTE_OPERADOR        Op   ON Mov.operador_cliente = op.oprutope        AND Mov.codigo_cliente = Op.opcodcli
            LEFT JOIN VIEW_MONEDA                  mco  ON Mov.compra_moneda    = mco.mncodmon
            LEFT JOIN VIEW_MONEDA                  mre  ON Mov.recibimos_moneda = mre.mncodmon
            LEFT JOIN BASE                         bco  ON bco.codigo           = Mov.Compra_Base
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE trecib ON trecib.tbcateg       = 1042               AND trecib.tbcodigo1   = Mov.compra_codigo_tasa
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE tpagam ON tpagam.tbcateg       = 1042               AND tpagam.tbcodigo1   = Mov.venta_codigo_tasa
            LEFT JOIN VIEW_PERIODO_AMORTIZACION  amocom ON amocom.tabla         = 1043               AND amocom.Codigo      = Mov.compra_codamo_capital
            LEFT JOIN VIEW_PERIODO_AMORTIZACION  intcom ON amocom.tabla         = 1044               AND amocom.Codigo      = Mov.compra_codamo_interes
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE cfinan ON cfinan.tbcateg       = @CatCartFin        AND cfinan.tbcodigo1   = Mov.cartera_inversion
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE iLibro ON iLibro.tbcateg       = @CatLibro          AND iLibro.tbcodigo1   = Mov.mhi_libro
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE icsupe ON icsupe.tbcateg       = @CatCartNorm       AND icsupe.tbcodigo1   = Mov.mhi_cartera_normativa
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE scarts ON scarts.tbcateg       = @CatSubCart        AND scarts.tbcodigo1   = Mov.mhi_subcartera_normativa
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE arespo ON arespo.tbcateg       = @CatAreaResp       AND arespo.tbcodigo1   = Mov.mhi_area_responsable
            LEFT JOIN VIEW_FORMA_DE_PAGO         pagdoc ON pagdoc.codigo        = Mov.pagamos_documento
            LEFT JOIN VIEW_FORMA_DE_PAGO         recdoc ON recdoc.codigo        = Mov.recibimos_documento
         WHERE 	mov.numero_operacion            =  @numoper
         AND    tipo_flujo                      =  1

         SELECT @fechatermino        = MAX(Mov.Fecha_termino)
         FROM  	movhistorico          mov
                LEFT JOIN View_Cliente Cli ON Cli.clcodigo = Mov.codigo_cliente AND Cli.clrut = Mov.rut_cliente  
                LEFT JOIN View_Cliente_Operador Op  ON Op.opcodcli = Mov.codigo_cliente        
                   AND    op.oprutope          = Mov.operador_cliente  
         WHERE 	mov.numero_operacion =  @numoper       

         UPDATE #encabezado
         SET	Fechatermino         = CONVERT(CHAR(10),@fechatermino,103)
         ,      pagamosbase          = ISNULL((SELECT glosa         FROM BASE                       WHERE codigo       = Venta_Base ),'*')
         ,      ValorTasaPag         = Venta_valor_tasa
         ,      tasapagamos          = ISNULL((SELECT TBGLOSA       FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1    = venta_codigo_tasa AND TBCATEG = 1042),' ')
         ,      pagamosdoc           = ISNULL((SELECT glosa         FROM VIEW_FORMA_DE_PAGO         WHERE codigo       = pagamos_documento ),' ')
         ,      MonedaPagamos        = ISNULL((SELECT mnglosa       FROM VIEW_MONEDA                WHERE mncodmon     = Pagamos_moneda),'*')
         ,      AmortCappag          = (SELECT glosa                FROM VIEW_PERIODO_AMORTIZACION  WHERE Codigo       = venta_codamo_capital AND tabla = 1043)
         ,      amortIntpag          = (SELECT glosa                FROM VIEW_PERIODO_AMORTIZACION  WHERE Codigo       = venta_codamo_interes AND tabla = 1044)
         ,      PeriodoDiapagamos    = CONVERT(CHAR(4),(SELECT Dias from View_Periodo_Amortizacion  WHERE Codigo       = venta_codamo_interes AND tabla = 1044))
         ,      SpreadPag	     = venta_spread
         FROM  	movhistorico mov
         ,      #encabezado
         WHERE 	mov.numero_operacion = @numoper  
         AND    mov.tipo_flujo       = 2

         SELECT e.Numero_Operacion
         ,      e.codigo_cliente
         ,      e.Nombrecli
         ,      e.Tipo_operacion
         ,      e.NombreOp
         ,      e.FechaInicio
         ,      e.FechaCierre
         ,      e.Fechatermino
         ,      e.MonedaOperacion
         ,      e.NombreMoneda
         ,      e.MontoOperacion
         ,      e.pagamosbase
         ,      e.recibirbase
         ,      e.ValorTasaPag
         ,      e.ValorTasaRec
         ,      e.rutcli
         ,      e.dv
         ,      e.banco
         ,      e.operador
         ,      e.NombreOperador
         ,      e.RutOperador
         ,      e.cartinversion
         ,      e.tasarecibimos
         ,      e.tasapagamos
         ,      e.operacionuser
         ,      e.hora
         ,      e.pagamosdoc
         ,      e.recibimosdoc
         ,      e.MonedaPagamos
         ,      e.MonedaRecibimos
         ,      e.Modalidad
         ,      e.AmortCap
         ,      e.amortInt
         ,      e.AmortCappag
         ,      e.amortIntpag
         ,      e.UFDia
         ,      e.PeriodoDia
         ,      e.PeriodoDiapagamos
         ,      mov.numero_flujo
         ,      e.moneda
         ,      e.SpreadRec
         ,      e.SpreadPag
         ,      e.Limites
         ,      e.Lineas
         ,      'fechainicioflujo' 	= CONVERT(CHAR(10),Fecha_inicio_flujo,103)
         ,      'fechavenceflujo'  	= CONVERT(CHAR(10),Fecha_vence_flujo,103)
         ,      'capital'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_capital      ELSE venta_capital             END
         ,      'amortiza'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_amortiza     ELSE venta_amortiza            END
         ,      'saldo'			= CASE WHEN mov.tipo_flujo = 1 THEN compra_saldo        ELSE venta_saldo               END
         ,      'interes'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_interes      ELSE venta_interes             END
         ,      'comprainteres'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_interes      ELSE 0		               END
         ,      'ventainteres'		= CASE WHEN mov.tipo_flujo = 1 THEN 0		        ELSE venta_interes             END
         ,      'valor_tasa'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_valor_tasa + compra_spread    ELSE venta_valor_tasa + venta_spread END
         ,      'monto'			= CASE WHEN mov.tipo_flujo = 1 THEN recibimos_monto     ELSE pagamos_monto             END
         ,      'monto_USD'		= CASE WHEN mov.tipo_flujo = 1 THEN recibimos_monto_USD ELSE pagamos_monto_USD         END
         ,      'monto_CLP'		= CASE WHEN mov.tipo_flujo = 1 THEN recibimos_monto_CLP ELSE pagamos_monto_CLP         END
         ,      'compraCLP'		= CASE WHEN mov.tipo_flujo = 1 THEN recibimos_monto_CLP	ELSE 0			       END
         ,      'ventaCLP'		= CASE WHEN mov.tipo_flujo = 1 THEN 0			ELSE pagamos_monto_CLP         END
         ,      'CodTasaRec'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_codigo_tasa  ELSE 0 	    		       END
         ,      'CodTasaPag'		= CASE WHEN mov.tipo_flujo = 1 THEN 0			ELSE venta_codigo_tasa 	       END
         ,      'grupo'			= CASE WHEN mov.tipo_flujo = 1 THEN 'COMPRA' 		ELSE 'VENTA' 		       END
         ,      'dias'			= DATEDIFF(dd,Fecha_inicio,Fecha_vence_flujo)
         ,      'diasPëriodo' 		= DATEDIFF(dd,Fecha_inicio_flujo,Fecha_vence_flujo)
 ,      @Firma1                 as 'Firma1'
         ,      @Firma2                 as 'Firma2'
         ,      @sMooper                as 'sMooper'
         ,      @sMoterm                as 'sMoterm'
         ,      'Titulo'                = descripcion 
         ,      Libro
         ,      Cartera_Super
         ,      SubCartera_Super
         ,      Area_Responsable
         ,      'DiasAcuerdo'           = isnull(SwDias,0)
         ,      'TipoConvencion'        = CASE WHEN mov.tipo_flujo = 1 THEN e.recibirbase	ELSE e.pagamosbase             END
         FROM  	#encabezado  e
                LEFT JOIN movhistorico mov ON e.numero_operacion   = mov.numero_operacion
                LEFT JOIN #Flujos ON mov.numero_operacion = SwOperacion AND mov.numero_flujo = SwFlujo and tipo_flujo = SwTipo
		LEFT JOIN VIEW_PRODUCTO    ON codigo_producto      = mov.tipo_swap AND id_sistema = 'PCS'
         WHERE 	mov.numero_operacion =  @numoper

      END ELSE
      BEGIN
         SELECT  DISTINCT
            /*001*/   'Numero_Operacion'        = Mov.Numero_Operacion
         ,  /*002*/   'codigo_cliente'          = Mov.codigo_cliente
         ,  /*002*/   'Nombrecli'		= ISNULL((Cli.clnombre ),'*')
         ,  /*002*/   'Tipo_operacion'          = Mov.Tipo_operacion
         ,  /*002*/   'NombreOp'		= CASE WHEN Mov.Tipo_operacion = 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END
         ,  /*002*/   'FechaInicio'		= CONVERT(CHAR(10),Mov.Fecha_inicio,103)
         ,  /*002*/   'FechaCierre'		= CONVERT(CHAR(10),Mov.Fecha_Cierre,103)
         ,  /*002*/   'Fechatermino'		= CONVERT(CHAR(10),Mov.Fecha_termino,103)
         ,  /*002*/   'MonedaOperacion'	        = compra_moneda
         ,  /*002*/   'NombreMoneda'		= ISNULL((SELECT mnglosa FROM VIEW_moneda WHERE mncodmon = compra_moneda ),'*')
         ,  /*002*/   'MontoOperacion'	        = Compra_capital
         ,  /*002*/   'pagamosbase'	   	= @lugares
         ,  /*002*/   'recibirbase'	   	= ISNULL((SELECT glosa FROM BASE WHERE codigo = Compra_Base ),'*' )
         ,  /*002*/   'ValorTasaPag' 		= Venta_valor_tasa
         ,  /*002*/   'ValorTasaRec' 		= Compra_valor_tasa
         ,  /*002*/   'rutcli' 		        = (Cli.clrut)
         ,  /*002*/   'dv'			= '-' + cldv
         ,  /*002*/   'banco' 		        = @BANCO
         ,  /*002*/   'operador'                = operador
         ,  /*002*/   'NombreOperador' 	        = ISNULL((Op.opNombre),'No Encontrado')
         ,  /*002*/   'RutOperador' 	    	= RTRIM(ISNULL(CONVERT(CHAR(10),Op.oprutope),'*')) +  '-' + ISNULL(CONVERT(CHAR(10),op.opdvope),'*')
         ,  /*002*/   'cartinversion' 	        = ISNULL(cfinan.tbglosa,'')
         ,  /*002*/   'tasarecibimos'		= ISNULL((SELECT TBGLOSA FROM view_tabla_general_detalle WHERE TBCODIGO1 = compra_codigo_tasa AND TBCATEG = 1042),' ')
         ,  /*002*/   'tasapagamos'		= ISNULL((SELECT TBGLOSA FROM view_tabla_general_detalle WHERE TBCODIGO1 = venta_codigo_tasa  AND TBCATEG = 1042),' ')
         ,  /*002*/   'operacionuser'		= @opcuser
         ,  /*002*/   'hora'			= CONVERT(CHAR(10),GETDATE(),108)
         ,  /*002*/   'pagamosdoc'		= ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = pagamos_documento),' ')
         ,  /*002*/   'recibimosdoc'		= ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = recibimos_documento),' ')
         ,  /*002*/   'MonedaPagamos'		= @lugares
         ,  /*002*/   'MonedaRecibimos'	        = ISNULL((SELECT mnglosa FROM VIEW_moneda WHERE mncodmon = recibimos_moneda),'*')
         ,  /*002*/   'Modalidad'  		= CASE WHEN Mov.Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA     ' END
         ,  /*002*/   'AmortCap'  		= (SELECT glosa FROM VIEW_PERIODO_AMORTIZACION WHERE Codigo=compra_codamo_capital AND tabla = 1043)
         ,  /*002*/   'amortInt'   		= (SELECT glosa FROM VIEW_PERIODO_AMORTIZACION WHERE Codigo=compra_codamo_interes AND tabla = 1044)
         ,  /*002*/   'AmortCappag'  		= @lugares
         ,  /*002*/   'amortIntpag'  		= @lugares
         ,  /*002*/   'UFDia'     		= ISNULL((SELECT vmvalor FROM View_Valor_Moneda WHERE vmcodigo = 998 AND vmfecha = Fecha_Cierre ),0)
         ,  /*002*/   'PeriodoDia'   		= CONVERT(CHAR(4),(Select Dias from View_Periodo_Amortizacion Where Codigo = compra_codamo_interes And tabla = 1044))
         ,  /*002*/   'PeriodoDiapagamos'	= @lugares
         ,  /*002*/   'moneda'		        = compra_moneda
         ,  /*002*/   'SpreadRec'		= compra_spread
         ,  /*002*/   'SpreadPag'		= @OBS
         ,  /*002*/   'Limites'		        = Observacion_Limites
         ,  /*002*/   'Lineas'		        = Observacion_Lineas
         ,  /*002*/   'Libro'			= ISNULL(iLibro.tbglosa,'')
         ,  /*002*/   'Cartera_Super'		= ISNULL(icsupe.tbglosa,'')
         ,  /*002*/   'SubCartera_Super'	= ISNULL(scarts.tbglosa,'')
         ,  /*002*/   'Area_Responsable'	= ISNULL(arespo.tbglosa,'')
         INTO   #encabezado1
         FROM  	      CARTERA                    Mov
            LEFT JOIN VIEW_CLIENTE               Cli 	ON Mov.rut_cliente      = Cli.clrut   AND Mov.codigo_cliente  = Cli.clcodigo
            LEFT JOIN VIEW_CLIENTE_OPERADOR      Op 	ON Mov.operador_cliente = op.oprutope AND Mov.codigo_cliente  = Op.opcodcli

            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE cfinan ON cfinan.tbcateg       = @CatCartFin  AND cfinan.tbcodigo1   = Mov.cartera_inversion
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE iLibro ON iLibro.tbcateg       = @CatLibro    AND iLibro.tbcodigo1   = Mov.car_libro
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE icsupe ON icsupe.tbcateg       = @CatCartNorm AND icsupe.tbcodigo1   = Mov.car_cartera_normativa
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE scarts ON scarts.tbcateg       = @CatSubCart  AND scarts.tbcodigo1   = Mov.car_subcartera_normativa
            LEFT JOIN VIEW_TABLA_GENERAL_DETALLE arespo ON arespo.tbcateg       = @CatAreaResp AND arespo.tbcodigo1   = Mov.car_area_responsable
         WHERE 	mov.numero_operacion = @numoper  
         AND    tipo_flujo           = 1


         SELECT @fechatermino        = MAX(Mov.Fecha_termino)
         FROM  	cartera Mov
                LEFT JOIN View_Cliente Cli  ON Cli.clcodigo  = Mov.codigo_cliente AND  Cli.clrut = Mov.rut_cliente  
                LEFT JOIN View_Cliente_Operador Op  ON Op.opcodcli  = Mov.codigo_cliente AND  op.oprutope  = Mov.operador_cliente  
         WHERE 	mov.numero_operacion =  @numoper  	      

         UPDATE #encabezado1
         SET	Fechatermino         = CONVERT(CHAR(10),@fechatermino,103)
         ,      pagamosbase          = ISNULL((SELECT glosa         FROM BASE WHERE codigo = Venta_Base ),'*')
         ,      ValorTasaPag         = venta_valor_tasa
         ,      tasapagamos          = ISNULL((SELECT TBGLOSA       FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = venta_codigo_tasa AND tbcateg = 1042),' ')
         ,      pagamosdoc           = ISNULL((SELECT glosa         FROM VIEW_FORMA_DE_PAGO         WHERE codigo    = pagamos_documento),' ')
         ,      MonedaPagamos        = ISNULL((SELECT mnglosa       FROM VIEW_MONEDA                WHERE mncodmon  = Pagamos_moneda),'*')
         ,      AmortCappag          =        (SELECT glosa         FROM VIEW_PERIODO_AMORTIZACION  WHERE Codigo    = venta_codamo_capital AND tabla = 1043)
         ,      amortIntpag          =        (SELECT glosa         FROM VIEW_PERIODO_AMORTIZACION  WHERE Codigo    = venta_codamo_interes AND tabla = 1044)
         ,      PeriodoDiapagamos    = CONVERT(CHAR(4),(SELECT Dias FROM VIEW_PERIODO_AMORTIZACION  WHERE Codigo    = venta_codamo_interes AND tabla = 1044))
         ,      SpreadPag	     = venta_spread
         FROM  	cartera Mov
         ,      #encabezado1
         WHERE 	mov.numero_operacion = @numoper  
         AND    mov.tipo_flujo       = 2

         SELECT e.Numero_Operacion
         ,      e.codigo_cliente
         ,      e.Nombrecli
         ,      e.Tipo_operacion
         ,      e.NombreOp
         ,      e.FechaInicio
         ,      e.FechaCierre
         ,      e.Fechatermino
         ,      e.MonedaOperacion
         ,      e.NombreMoneda
         ,      e.MontoOperacion
         ,      e.pagamosbase
         ,      e.recibirbase
         ,      e.ValorTasaPag
         ,      e.ValorTasaRec
         ,      e.rutcli
         ,      e.dv
         ,      e.banco
         ,      e.operador
         ,      e.NombreOperador
         ,      e.RutOperador
         ,      e.cartinversion
         ,      e.tasarecibimos
,      e.tasapagamos
         ,      e.operacionuser
         ,      e.hora
         ,      e.pagamosdoc
         ,      e.recibimosdoc
         ,      e.MonedaPagamos
         ,      e.MonedaRecibimos
         ,      e.Modalidad
         ,      e.AmortCap
         ,      e.amortInt
         ,      e.AmortCappag
         ,      e.amortIntpag
         ,      e.UFDia
         ,      e.PeriodoDia
         ,      e.PeriodoDiapagamos
         ,      mov.numero_flujo
         ,      e.moneda
         ,      e.SpreadRec
         ,      e.SpreadPag
         ,      e.Limites
         ,      e.Lineas
         ,      'fechainicioflujo' 	= CONVERT(CHAR(10),Fecha_inicio_flujo,103)
         ,      'fechavenceflujo'  	= CONVERT(CHAR(10),Fecha_vence_flujo,103)
         ,      'capital'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_capital  ELSE venta_capital  END
         ,      'amortiza'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_amortiza ELSE venta_amortiza END
         ,      'saldo'			= CASE WHEN mov.tipo_flujo = 1 THEN compra_saldo    ELSE venta_saldo    END
         ,      'interes'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_interes  ELSE venta_interes  END
         ,      'comprainteres'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_interes  ELSE 0		END
         ,      'ventainteres'		= CASE WHEN mov.tipo_flujo = 1 THEN 0		    ELSE venta_interes  END
         ,      'valor_tasa'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_valor_tasa + compra_spread    ELSE venta_valor_tasa + venta_spread END
         ,      'monto'			= CASE WHEN mov.tipo_flujo = 1 THEN recibimos_monto     ELSE pagamos_monto      END
         ,      'monto_USD'		= CASE WHEN mov.tipo_flujo = 1 THEN recibimos_monto_USD ELSE pagamos_monto_USD  END
         ,      'monto_CLP'		= CASE WHEN mov.tipo_flujo = 1 THEN recibimos_monto_CLP ELSE pagamos_monto_CLP  END
         ,      'compraCLP'		= CASE WHEN mov.tipo_flujo = 1 THEN recibimos_monto_CLP	ELSE 0			END
         ,      'ventaCLP'		= CASE WHEN mov.tipo_flujo = 1 THEN 0			ELSE pagamos_monto_CLP  END
         ,      'CodTasaRec'		= CASE WHEN mov.tipo_flujo = 1 THEN compra_codigo_tasa  ELSE 0 	    			END
         ,      'CodTasaPag'		= CASE WHEN mov.tipo_flujo = 1 THEN 0			ELSE venta_codigo_tasa 	    	END
         ,      'grupo'			= CASE WHEN mov.tipo_flujo = 1 THEN 'COMPRA' 		ELSE 'VENTA' 			END
         ,      'dias'			= DATEDIFF(dd,Fecha_inicio,Fecha_vence_flujo)
         ,      'diasPëriodo' 		= DATEDIFF(dd,Fecha_inicio_flujo,Fecha_vence_flujo)
         ,      @Firma1                 as 'Firma1'
         ,      @Firma2                 as 'Firma2'
         ,      @sMooper                as 'sMooper'
         ,      @sMoterm                as 'sMoterm'
         ,      'Titulo'                = descripcion 
         ,      Libro
         ,      Cartera_Super
         ,      SubCartera_Super
         ,      Area_Responsable
         ,      'DiasAcuerdo'           = isnull(SwDias,0)
         ,      'TipoConvencion'        = CASE WHEN mov.tipo_flujo = 1 THEN e.recibirbase	ELSE e.pagamosbase             END
         FROM  	#encabezado1       e
                LEFT JOIN cartera  Mov ON e.numero_operacion   = mov.numero_operacion
                LEFT JOIN #Flujos      ON mov.numero_operacion = SwOperacion AND mov.numero_flujo = SwFlujo and tipo_flujo = SwTipo
		LEFT JOIN VIEW_PRODUCTO ON codigo_producto = tipo_swap AND id_sistema = 'PCS'
         WHERE 	mov.numero_operacion = @numoper	

      END

END
GO
