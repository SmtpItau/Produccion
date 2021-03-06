USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSCARTALIQUIDACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DATOSCARTALIQUIDACION]  
   (   @numoperacion	FLOAT
   ,   @BaseParam 	CHAR(20)
   ,   @FechaVcto	VARCHAR(10)
   )
AS
BEGIN

   SET NOCOUNT ON	

   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @TotalFlujos	  VARCHAR(09)
   DECLARE @FechaSistema  DATETIME
   DECLARE @Dia		  VARCHAR(02)
   DECLARE @Mes		  VARCHAR(02)
   DECLARE @Anio	  VARCHAR(04)
   DECLARE @DiaSem	  VARCHAR(01)
   DECLARE @Ciudad	  VARCHAR(10)
   DECLARE @espacios	  VARCHAR(50)
   DECLARE @EstadoTasa    VARCHAR(50)

   SELECT @espacios = SPACE(50) 	
   
   /*=======================================================================*/
   /* Encabezado de la Consulta						    */	
   /*=======================================================================*/

	SELECT  @FechaSistema	= fechaproc
        ,       @Ciudad		= Ciudad
        ,       @EstadoTasa     = CASE WHEN devengo = 0 THEN 'Tasa ICP No Actualizada'
                                       WHEN devengo = 1 THEN 'Tasa ICP Actualizada'
                                  END
	FROM    SWAPGENERAL

        SELECT  @EstadoTasa     = CASE WHEN Vencimientos = 0 THEN 'Tasa ICP No Actualizada'
                                       WHEN Vencimientos = 1 THEN 'Tasa ICP Actualizada'
                                  END
	FROM    SWAPGENERAL


--select * from swapgeneral
	SELECT @Dia = CONVERT(CHAR(02),DATEPART(DAY,@FechaSistema))
	SELECT @Mes = CONVERT(CHAR(02),DATEPART(MONTH,@FechaSistema))
	SELECT @Anio = CONVERT(CHAR(04),DATEPART(YEAR,@FechaSistema))
	SELECT @DiaSem = CONVERT(CHAR(02),DATEPART(dw,(CONVERT(CHAR(10), @FechaSistema, 112))) )

	SELECT  @TotalFlujos = CONVERT(CHAR(09),MAX(Numero_flujo))	
	FROM Cartera Where Numero_Operacion = @numoperacion	

	IF @FechaVcto = (CONVERT(CHAR(10), @FechaSistema, 112)) 
		BEGIN
			
			SET ROWCOUNT 1
			SELECT DISTINCT  
				Numero_Operacion	, 
				'Nombrecli'		= ISNULL((SELECT clnombre FROM View_Cliente WHERE clcodigo = codigo_cliente AND clrut = rut_cliente ),'*Conflicto con Nombre*'), 
				'banco'			= ISNULL((SELECT nombre FROM SwapGeneral),'No ha registrado Nombre') ,  
				Tipo_operacion 		, 
				'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103), 
				Fecha_Cierre		, 
				'NombreMoneda'		= (CASE Tipo_operacion WHEN 'C' THEN 
								ISNULL((SELECT mnglosa FROM View_Moneda WHERE  mncodmon = compra_moneda) , ' ')  
								ELSE ISNULL((SELECT mnglosa FROM View_Moneda WHERE  mncodmon = venta_moneda), ' ') END), 
				'MontoOperacion' 	= (CASE Tipo_operacion WHEN 'C' THEN Compra_capital ELSE Venta_capital END), 		
				Compra_amortiza    , 
				Compra_interes     , 
				Venta_amortiza     ,  	
				Venta_interes      ,  	
				Numero_Flujo       ,  
		'DiaCierre'			= CONVERT ( CHAR(2), DATEPART(DAY, Fecha_cierre)) ,   
		'MesCierre'			= DATEPART(MONTH, Fecha_cierre) ,   
		'AñoCierre'			= CONVERT ( CHAR(4) ,DATEPART(YEAR, Fecha_cierre)) ,   
				Fecha_Inicio_Flujo , 
				Fecha_Vence_Flujo  , 
		'Dias'				= DATEDIFF(dd,Fecha_Inicio_Flujo,Fecha_vence_flujo),  
		'ObligacionBanco'	= @espacios, --(CASE Tipo_operacion WHEN 'V' THEN 'Paga Fijo    ' ELSE 'Paga Flotante' END) ,  
		'ObligacionCli'		= @espacios, --(CASE Tipo_operacion WHEN 'V' THEN 'Paga Flotante' ELSE 'Paga Fijo    ' END) ,  
		'TasaCompra'		= Compra_valor_tasa ,  
		'NombreTasaCompra'	= @espacios,  
		'BaseCompra'		= ISNULL( ( SELECT glosa FROM base WHERE codigo = compra_Base ) , '*' ),
		'TasaVenta'			= Venta_valor_tasa,  
		'NombreTasaVenta'	= @espacios,  
	'BaseVenta'		= ISNULL( ( SELECT glosa FROM base WHERE codigo = venta_Base ) , '*' ),
		'TotalFlujos'		= @TotalFlujos ,  
		'DiaCarta'			= @Dia  ,  
		'MesCarta'			= @Mes ,  
		'AnioCarta'			= @Anio,   
		'DiaSemana'			= @DiaSem,  
		'Ciudad'			= @Ciudad ,  
		'MontoPesos'		= 0,  
		'montouf'               = ISNULL((SELECT vmvalor FROM View_Valor_Moneda WHERE vmcodigo = 998 AND vmfecha = fecha_vence_flujo),0), 
				'montoobs'              = ISNULL((SELECT vmvalor FROM View_Valor_Moneda WHERE vmcodigo = 994 AND vmfecha = fecha_vence_flujo),0) 
                                                        , CASE WHEN Tipo_Swap	= 4 then @EstadoTasa else ' ' end as EstadoDevengo 
                                , RecibimosDocDsc	= SPACE(50)
                                , PagamosDocDsc		= SPACE(50)
			INTO 	#tmp1
			FROM 	Cartera 
			WHERE 	Numero_operacion = @numoperacion	AND
				fecha_vence_flujo =  @Fechavcto

			SET ROWCOUNT 0

			UPDATE 	#tmp1
			SET	NombreMoneda		= ISNULL((SELECT mnglosa FROM View_Moneda WHERE  mncodmon = a.compra_moneda) , ' ')  ,
				Compra_amortiza    	= a.compra_amortiza + a.compra_saldo , 
				MontoOperacion	 	= a.Compra_capital 	,
				Compra_interes     	= a.Compra_interes	, 
				Numero_Flujo       	= a.numero_flujo		,
				Fecha_Inicio_Flujo 	= a.Fecha_Inicio_Flujo	,
				Fecha_Vence_Flujo  	= a.Fecha_Vence_Flujo	, 
				TasaCompra		= a.Compra_valor_tasa 	,
				NombreTasaCompra	= ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = a.compra_codigo_tasa 
								AND tbcateg = 1042 ), ' '),
				BaseCompra		= ISNULL( ( SELECT glosa FROM base WHERE codigo = a.compra_Base ) , '*' )	,
				MontoPesos		= a.devengo_monto_peso
                                , RecibimosDocDsc = ( select glosa from View_Forma_de_pago where Codigo = recibimos_documento )

			FROM 	Cartera a
			WHERE 	a.Numero_operacion 	= @numoperacion	AND
				a.fecha_vence_flujo 	=  @Fechavcto 	AND
				a.tipo_flujo = 1
			
			UPDATE 	#tmp1
			SET	NombreMoneda		= ISNULL((SELECT mnglosa FROM View_Moneda WHERE  mncodmon = a.venta_moneda) , ' ')  ,
				Venta_amortiza    	= a.venta_amortiza + a.venta_saldo , 
				MontoOperacion	 	= a.venta_capital 	,
				Venta_interes      	= a.venta_interes	,  	
				Numero_Flujo       	= a.numero_flujo	,
				Fecha_Inicio_Flujo 	= a.Fecha_Inicio_Flujo	,
				Fecha_Vence_Flujo  	= a.Fecha_Vence_Flujo	, 
				TasaVenta		= a.venta_valor_tasa 	,
				NombreTasaVenta		= ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = a.venta_codigo_tasa 
								AND tbcateg = 1042 ), ' '),
				BaseVenta		= ISNULL( ( SELECT glosa FROM base WHERE codigo = a.venta_Base ) , '*' ),
				MontoPesos		= ABS( MontoPesos - a.devengo_monto_peso )
                                , PagamosDocDsc   = ( select glosa from View_Forma_de_pago where Codigo = pagamos_documento ) 
			FROM 	Cartera a
			WHERE 	a.Numero_operacion 	= @numoperacion	AND
				a.fecha_vence_flujo 	=  @Fechavcto 	AND
				a.tipo_flujo = 2

			UPDATE 	#tmp1
			SET	ObligacionBanco		= CASE nombretasaventa  WHEN 'FIJA' THEN 'Paga Fijo    ' WHEN '' THEN '' ELSE 'Paga Flotante' END ,
				ObligacionCli		= CASE nombretasacompra WHEN 'FIJA' THEN 'Paga Fijo    ' WHEN '' THEN '' ELSE 'Paga Flotante' END 

			SELECT * FROM #tmp1
	

	END ELSE 
        BEGIN


			SET ROWCOUNT 1
			SELECT DISTINCT  
				Numero_Operacion	, 
				'Nombrecli'		= ISNULL((SELECT clnombre FROM View_Cliente WHERE clcodigo = codigo_cliente AND clrut = rut_cliente ),'*Conflicto con Nombre*'), 
				'banco'			= ISNULL((SELECT nombre FROM SwapGeneral),'No ha registrado Nombre') ,  
				Tipo_operacion 		, 
		'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103),   
				Fecha_Cierre		, 
				'NombreMoneda'		= (CASE Tipo_operacion WHEN 'C' THEN 
								ISNULL((SELECT mnglosa FROM View_Moneda WHERE  mncodmon = compra_moneda) , ' ')  
								ELSE ISNULL((SELECT mnglosa FROM View_Moneda WHERE  mncodmon = venta_moneda), ' ') END), 
				'MontoOperacion' 	= (CASE Tipo_operacion WHEN 'C' THEN Compra_capital ELSE Venta_capital END), 		
				Compra_amortiza    , 
				Compra_interes     , 
				Venta_amortiza     ,  	
				Venta_interes      ,  	
				Numero_Flujo       ,  
		'DiaCierre'			= CONVERT ( CHAR(2), DATEPART(DAY, Fecha_cierre)) ,   
		'MesCierre'			= DATEPART(MONTH, Fecha_cierre) ,   
		'AñoCierre'			= CONVERT ( CHAR(4) ,DATEPART(YEAR, Fecha_cierre)) ,   
				Fecha_Inicio_Flujo , 
				Fecha_Vence_Flujo  , 
		'Dias'				= DATEDIFF(dd,Fecha_Inicio_Flujo,Fecha_vence_flujo),  
		'ObligacionBanco'	= @espacios ,--(CASE Tipo_operacion WHEN 'V' THEN 'Paga Fijo    ' ELSE 'Paga Flotante' END) ,  
		'ObligacionCli'		= @espacios ,--(CASE Tipo_operacion WHEN 'V' THEN 'Paga Flotante' ELSE 'Paga Fijo    ' END) ,  
		'TasaCompra'		= Compra_valor_tasa ,  
		'NombreTasaCompra'	= ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = compra_codigo_tasa 
								AND tbcateg = 1042 ), ' '),
				'BaseCompra'		= ISNULL( ( SELECT glosa FROM base WHERE codigo = compra_Base ) , '*' ),
				'TasaVenta'		= Venta_valor_tasa,
				'NombreTasaVenta'		= ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = venta_codigo_tasa 
								AND tbcateg = 1042 ), ' '),
				'BaseVenta'		= ISNULL( ( SELECT glosa FROM base WHERE codigo = venta_Base ) , '*' ),
				'TotalFlujos'		= @TotalFlujos ,
				'DiaCarta'		= @Dia  ,
				'MesCarta'		= @Mes ,
				'AnioCarta'		= @Anio, 
				'DiaSemana'		= @DiaSem,
				'Ciudad'		= @Ciudad ,
				'MontoPesos'		= 0,
				'montouf'  = ISNULL((SELECT vmvalor FROM View_Valor_Moneda WHERE vmcodigo = 998 AND vmfecha = fecha_vence_flujo),0), 
				'montoobs'  = ISNULL((SELECT vmvalor FROM View_Valor_Moneda WHERE vmcodigo = 994 AND vmfecha = fecha_vence_flujo),0) 
                                , CASE WHEN Tipo_Swap	= 4 then @EstadoTasa else ' ' end as EstadoDevengo 
                                , RecibimosDocDsc	= space(50)
                                , PagamosDocDsc		= space(50)
			INTO 	#tmp2
			FROM 	CarteraHis 
			WHERE 	Numero_operacion = @numoperacion	AND
				fecha_vence_flujo =  @Fechavcto

			SET ROWCOUNT 0

			UPDATE 	#tmp2
			SET	NombreMoneda		= ISNULL((SELECT mnglosa FROM View_Moneda WHERE  mncodmon = a.compra_moneda) , ' ')  ,
				Compra_amortiza    	= a.compra_amortiza + a.compra_saldo , 
				MontoOperacion	 	= a.Compra_capital 	,
				Compra_interes     	= a.Compra_interes	, 
				Numero_Flujo       	= a.numero_flujo		,
				Fecha_Inicio_Flujo 	= a.Fecha_Inicio_Flujo	,
				Fecha_Vence_Flujo  	= a.Fecha_Vence_Flujo	, 
				TasaCompra		= a.Compra_valor_tasa 	,
				NombreTasaCompra	= ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = a.compra_codigo_tasa 
								AND tbcateg = 1042 ), ' '),
				BaseCompra		= ISNULL( ( SELECT glosa FROM base WHERE codigo = a.compra_Base ) , '*' )	,
				MontoPesos		= a.devengo_monto_peso
                                , RecibimosDocDsc = ( select glosa from View_Forma_de_pago where Codigo = recibimos_documento )
			FROM 	CarteraHis a
			WHERE 	a.Numero_operacion 	= @numoperacion	AND
				a.fecha_vence_flujo 	=  @Fechavcto 	AND
				a.tipo_flujo = 1
			
			UPDATE 	#tmp2
			SET	NombreMoneda		= ISNULL((SELECT mnglosa FROM View_Moneda WHERE  mncodmon = a.venta_moneda) , ' ')  ,
				Venta_amortiza    	= a.venta_amortiza + a.venta_saldo , 
				MontoOperacion	 	= a.venta_capital 	,
				Venta_interes      	= a.venta_interes	,  	
				Numero_Flujo       	= a.numero_flujo	,
				Fecha_Inicio_Flujo 	= a.Fecha_Inicio_Flujo	,
				Fecha_Vence_Flujo  	= a.Fecha_Vence_Flujo	, 
				TasaVenta		= a.venta_valor_tasa 	,
				NombreTasaVenta		= ISNULL((SELECT tbglosa FROM View_Tabla_General_Detalle WHERE tbcodigo1 = a.venta_codigo_tasa 
								AND tbcateg = 1042 ), ' '),
				BaseVenta		= ISNULL( ( SELECT glosa FROM base WHERE codigo = a.venta_Base ) , '*' ),
				MontoPesos		= ABS( MontoPesos - a.devengo_monto_peso )
                                , PagamosDocDsc   = ( select glosa from View_Forma_de_pago where Codigo = pagamos_documento ) 
			FROM 	CarteraHis a
			WHERE 	a.Numero_operacion 	= @numoperacion	AND
				a.fecha_vence_flujo 	=  @Fechavcto 	AND
				a.tipo_flujo = 2

			UPDATE 	#tmp2
			SET	ObligacionBanco		= CASE nombretasaventa  WHEN 'FIJA' THEN 'Paga Fijo    ' WHEN '' THEN '' ELSE 'Paga Flotante' END ,
				ObligacionCli		= CASE nombretasacompra WHEN 'FIJA' THEN 'Paga Fijo    ' WHEN '' THEN '' ELSE 'Paga Flotante' END 

			SELECT * FROM #tmp2

END

END
GO
