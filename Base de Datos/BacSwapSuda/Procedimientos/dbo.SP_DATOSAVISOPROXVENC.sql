USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSAVISOPROXVENC]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DATOSAVISOPROXVENC]   
       (
        @numoperacion	FLOAT

       )
AS
BEGIN
-- Swap: Guardar Como  
   DECLARE @FechaVcto	  varchar(10) 	
   DECLARE @TotalFlujos	  VARCHAR(09)
   DECLARE @FechaSistema  DATETIME
   DECLARE @Dia		  VARCHAR(02)
   DECLARE @Mes		  VARCHAR(02)
   DECLARE @Anio	  VARCHAR(04)
   DECLARE @DiaSem	  VARCHAR(01)
   DECLARE @Ciudad	  VARCHAR(10)

   /*=======================================================================*/
   /* Encabezado de la Consulta						    */	
   /*=======================================================================*/
	SELECT  @FechaSistema	= fechaproc ,
		@Ciudad		= Ciudad 
	FROM    SwapGeneral

	SELECT @Dia = CONVERT(CHAR(2) ,DATEPART(DAY, @FechaSistema))
	SELECT @Mes = CONVERT(CHAR(2) ,DATEPART(MONTH,@FechaSistema))
	SELECT @Anio = CONVERT(CHAR(4) ,DATEPART(YEAR,@FechaSistema))
	SELECT @DiaSem = CONVERT(CHAR(1) ,DATEPART(dw,(CONVERT(CHAR(10), @FechaSistema, 112)))) 

	SELECT  @FechaVcto = ((CONVERT(CHAR(10), MIN(Fecha_vence_flujo), 112))) ,
		@TotalFlujos =CONVERT(CHAR(9) , MAX(Numero_flujo))	
	FROM Cartera 
        Where Numero_Operacion = @numoperacion and estado <> 'C'	
   /*=======================================================================*/

	SET ROWCOUNT 0
	SELECT DISTINCT  
		'Swap'	 		= (CASE Tipo_Swap WHEN 1 THEN 'TASA   ' ELSE 'MONEDA ' END), 
		Numero_Operacion	, 
		Codigo_Cliente		, 
		'Nombrecli'		= ISNULL((SELECT clnombre FROM view_cliente WHERE clcodigo = codigo_cliente and clrut = rut_cliente ),'*Conflicto con Nombre*'), 
		'banco'			= ISNULL((SELECT nombre FROM swapgeneral),'No ha registrado Nombre') ,  
		Tipo_operacion 		, 
		'NombreOp'		= (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END),   	 
		'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103), 
		Fecha_Cierre		, 
		'MonedaOperacion'	= (CASE Tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END), 
		'NombreMoneda'		= (CASE Tipo_operacion WHEN 'C' THEN ISNULL((SELECT mnglosa FROM view_moneda WHERE  mncodmon = compra_moneda) , ' ')  
					  ELSE ISNULL((SELECT mnglosa FROM view_moneda WHERE  mncodmon = venta_moneda), ' ') END), 
		'MontoOperacion' 	= (CASE Tipo_operacion WHEN 'C' THEN Compra_capital ELSE Venta_capital END), 		
		'TasaBase'		= (CASE Tipo_operacion WHEN 'C' THEN Compra_Base ELSE Venta_Base END), 		
		'MontoConversion'	= (CASE Tipo_operacion WHEN 'C' THEN Venta_capital ELSE Compra_capital END), 		
		'TasaConversion'	= (CASE Tipo_operacion WHEN 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END), 		
		Compra_amortiza												, 
		Compra_Saldo       											, 
		Numero_Flujo 												,
		'DiaCierre'		= CONVERT ( CHAR(2), DATEPART(DAY, Fecha_cierre)) 				,
		'MesCierre'		= DATEPART(MONTH,Fecha_cierre) 							,
		'AnioCierre'		= CONVERT ( CHAR(10) ,DATEPART (YEAR,Fecha_cierre)) 				,
		Fecha_Inicio_Flujo											,
		Fecha_Vence_Flujo 											, 
		'Dias'			= DATEDIFF(dd,Fecha_Inicio_Flujo, Fecha_vence_flujo)				,
		'ObligacionBanco'	= (CASE Tipo_operacion WHEN 'V' THEN 'Paga Fijo    ' ELSE 'Paga Flotante' END) 	,
		'ObligacionCli'		= (CASE Tipo_operacion WHEN 'V' THEN 'Paga Flotante' ELSE 'Paga Fijo    ' END) 	,
		'TasaFija'		= Compra_valor_tasa 								,
		'NombreTasafija'	= ISNULL((SELECT tbglosa FROM view_tabla_general_detalle WHERE TBCODIGO1 = compra_codigo_tasa
					  AND TBCATEG = 1042 ), ' ')							,
		'BaseFija'		= Compra_Base 									,
		'TasaVariable'		= Venta_valor_tasa								,
		'NombreTasaVar'		= ISNULL((SELECT tbglosa FROM view_tabla_general_detalle WHERE TBCODIGO1 = venta_codigo_tasa 
					  AND TBCATEG = 1042 ), ' ')							,
		'BaseVariable'		= Venta_Base 									,
		'TotalFlujos'		= @TotalFlujos 									,
		'DiaCarta'		= @Dia  									,
	 	'MesCarta'		= @Mes  									,
		'AnioCarta'		= @Anio 									, 
		'DiaSemana'		= @DiaSem									,
		'Ciudad'		= @Ciudad  									
	INTO	#tmp_1
	FROM	Cartera 
	WHERE	Numero_operacion   =  @numoperacion	AND
		Fecha_Inicio_Flujo <= @FechaSistema  	AND 
		fecha_vence_flujo  >  @FechaSistema     and estado <> 'C'

	SET ROWCOUNT 1

	UPDATE  #tmp_1
	SET	MonedaOperacion		= a.compra_moneda 								,
		NombreMoneda		= ISNULL((SELECT mnglosa FROM view_moneda WHERE mncodmon=a.compra_moneda),' ')	,
		MontoOperacion	 	= a.Compra_capital								,
		TasaBase		= a.Compra_Base									,
		Numero_Flujo 		= a.numero_flujo								,
		Fecha_Inicio_Flujo	= a.fecha_inicio_flujo								,
		Fecha_Vence_Flujo 	= a.fecha_vence_flujo								, 
		Dias			= DATEDIFF(dd,a.Fecha_Inicio_Flujo,a.Fecha_vence_flujo)				,
		TasaFija		= a.Compra_valor_tasa 								,
		NombreTasafija		= ISNULL((SELECT tbglosa FROM view_tabla_general_detalle WHERE TBCODIGO1 = a.compra_codigo_tasa
					  AND TBCATEG = 1042 ), ' ')							,
		BaseFija		= c.Base
	FROM 	Cartera a	,
		#tmp_1	b	,
		base	c
	WHERE	a.Numero_operacion    = b.Numero_Operacion 	AND
		a.Fecha_Inicio_Flujo <= @FechaSistema  		AND
		a.fecha_vence_flujo  >  @FechaSistema		AND
		a.tipo_flujo = 1				AND
		a.compra_base = c.codigo    and estado <> 'C'

	UPDATE #tmp_1
	SET	MonedaOperacion		= a.venta_moneda 								,
		NombreMoneda		= ISNULL((SELECT mnglosa FROM view_moneda WHERE mncodmon=a.venta_moneda),' ')	,
		MontoOperacion	 	= a.venta_capital								,
		TasaBase		= a.venta_Base									,
		Numero_Flujo 		= a.numero_flujo								,
		Fecha_Inicio_Flujo	= a.fecha_inicio_flujo								,
		Fecha_Vence_Flujo 	= a.fecha_vence_flujo								, 
		Dias			= DATEDIFF(dd,a.Fecha_Inicio_Flujo,a.Fecha_vence_flujo)				,
		TasaVariable		= a.Venta_valor_tasa								,
		NombreTasaVar		= ISNULL((SELECT tbglosa FROM view_tabla_general_detalle WHERE TBCODIGO1 = a.venta_codigo_tasa
					  AND TBCATEG = 1042 ), ' ')							,
		BaseVariable		= c.Base 
	FROM 	Cartera a	,
		#tmp_1	b	,
		base	c
	WHERE	a.Numero_operacion   =  b.Numero_Operacion 	AND
		a.Fecha_Inicio_Flujo <= @FechaSistema  		AND
		a.fecha_vence_flujo  >  @FechaSistema		AND
		a.tipo_flujo = 2				AND
		a.venta_base = c.codigo                         and estado <> 'C'

	SELECT * FROM #tmp_1

END
GO
