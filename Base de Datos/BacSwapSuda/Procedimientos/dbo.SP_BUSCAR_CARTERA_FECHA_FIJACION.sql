USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_CARTERA_FECHA_FIJACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_CARTERA_FECHA_FIJACION] (@FechaInicio		DATETIME
													  ,@FechaFin		DATETIME
													  ,@IncluyeFijacion SMALLINT)
 AS
 BEGIN
 SET NOCOUNT ON   

	/*
	exec SP_BUSCAR_CARTERA_FECHA_FIJACION '20130116', '20130226', 1
	exec SP_BUSCAR_CARTERA_FECHA_FIJACION '20140130', '20150501', 0
	exec SP_BUSCAR_CARTERA_FECHA_FIJACION '20150529', '20150529', 1
	
		SELECT car.numero_operacion, car.fecha_cierre, car.fecha_inicio, car.fecha_termino,
	       car.fecha_inicio_flujo, car.fecha_vence_flujo, car.fecha_fijacion_tasa,
	       car.fecha_modifica, car.fecha_valoriza, car.FechaEfectiva,
	       car.PrimerPago, car.PenultimoPago, car.Madurez, car.FechaLiquidacion,
	       car.FechaReset, car.fecha_sinacofi, car.FechaValuta
	  from cartera car WHERE car.numero_operacion = 9511
	  
	  SP_BUSCAR_CARTERA_FECHA_FIJACION '20130101','20130501',1
	*/

	
	CREATE TABLE #TEMP
	(OPERACION				NUMERIC(7,0)
	,NUMERO_FLUJO			NUMERIC(3,0)
	,RUT_CLIENTE			NUMERIC(9,0)
	,NOMBRE_CLIENTE			CHAR(70)
	,TIPO_CLIENTE			VARCHAR(50)
	,PAIS_CLIENTE			VARCHAR(50)
	,TIPO_MONEDA			VARCHAR(50)
	,TIPO_TASA				VARCHAR(50)
	,TIPO_FLUJO				NUMERIC(1,0)
	,Compra_moneda			SMALLINT
	,FECHA_FIJACION			DATETIME
	,FIJACION_CHECK_USA		SMALLINT
	,FIJACION_CHECK_ING		SMALLINT
	,FIJACION_CHECK_SCL		SMALLINT
	,FECHA_PROPUESTA		DATETIME
	,PROPUESTA_CHECK_USA	SMALLINT
	,PROPUESTA_CHECK_ING	SMALLINT
	,PROPUESTA_CHECK_SCL	SMALLINT
	,CHECK_USA				SMALLINT
	,CHECK_ING				SMALLINT
	,CHECK_SCL				SMALLINT
	,FECHA_LIQUIDACION		DATETIME
	,FECHA_INICIO_FLUJO		DATETIME
	,SPOTLAG				INT
	, PAIS                  varchar(10)
	 )

INSERT #TEMP
SELECT DISTINCT numero_operacion,
			    numero_Flujo,
			    CLI.Clrut, 
			    CLI.ClNombre,
			    TipoCliente.tbGlosa,
			    Pais.Nombre, 
			    convert( varchar(15), Mda.mnNemo ),   
			    ltrim( rtrim(TipoTasa.TbGlosa )) +' / '+ Mda.mnNemo, 
			    Tipo_Flujo,
			    Compra_moneda,
			    Fecha_Fijacion_Tasa, 
			    0,
			    0,
			    0,
			    '',
			    0,
			    0,
			    0,
			    CASE WHEN C.FeriadoFlujoEEUU = 1 THEN 1 ELSE 0 END, 
                CASE WHEN C.FeriadoFlujoChile = 1 THEN 1 ELSE 0 END, 
                CASE WHEN C.FeriadoFlujoEnglan = 1 THEN 1 ELSE 0 END,
                C.FechaLiquidacion,  
                C.fecha_inicio_flujo,
                TPais.SpotLag,
				Pais = ';' + ltrim(rtrim(TPais.Pais)) + ';'
FROM BacSwapSuda.dbo.cartera C
   
    LEFT JOIN bacparamsuda.dbo.tabla_general_detalle TipoTasa 
	ON TipoTasa.tbcateg = 1042 
	AND c.Compra_Codigo_Tasa = TipoTasa.tbcodigo1

	LEFT JOIN bacparamsuda.dbo.Tasa_pais Tpais  -- select * from bacparamsuda.dbo.Tasa_pais
	ON c.Compra_Codigo_Tasa = TPais.Cod_tasa 
			 
    LEFT JOIN bacparamsuda.dbo.Moneda Mda 
	ON Mda.MnCodMon = Compra_Moneda
			           
    LEFT JOIN Bacparamsuda.dbo.Cliente Cli 
	ON Clrut = Rut_Cliente 
	AND ClCodigo = codigo_cliente 
			
    LEFT JOIN bacparamsuda.dbo.tabla_general_detalle TipoCliente 
	ON TipoCliente.tbcateg = 72 
	AND TipoCliente.tbcodigo1 = Cli.Cltipcli
			 
    LEFT JOIN BacParamSuda.dbo.pais Pais 
	on Pais.Codigo_pais = Cli.ClPais
			
WHERE tipo_Flujo = 1 AND TipoTasa.tbValor = 2
AND C.fecha_fijacion_tasa BETWEEN @FechaInicio AND @FechaFin 
and c.estado not in ('C', 'N' )  -- descartar cotizaciones y anticipos

UNION 
SELECT numero_operacion,
	   numero_Flujo,
	   CLI.Clrut,
	   CLI.ClNombre,
	   TipoCliente.tbGlosa,
	   Pais.Nombre, 
	   convert( varchar(15), Mda.mnNemo ),   
	   ltrim( rtrim(TipoTasa.TbGlosa )) +' / '+ Mda.mnNemo , 
	   Tipo_Flujo  ,  
	   Venta_Moneda,
	   Fecha_Fijacion_Tasa,
		0,
		0,
		0,
		'',
		0,
		0,
		0,
		CASE WHEN C.FeriadoFlujoEEUU = 1 THEN 1 ELSE 0 END, 
        CASE WHEN C.FeriadoFlujoChile = 1 THEN 1 ELSE 0 END, 
        CASE WHEN C.FeriadoFlujoEnglan = 1 THEN 1 ELSE 0 END,
        C.FechaLiquidacion,  
        C.fecha_inicio_flujo ,
        TPais.SpotLag,
		Pais = ';' + ltrim(rtrim(TPais.Pais)) + ';'
FROM BacSwapSuda.dbo.cartera C

    LEFT JOIN bacparamsuda.dbo.tabla_general_detalle TipoTasa 
	on TipoTasa.tbcateg = 1042 
	and c.venta_Codigo_Tasa = TipoTasa.tbcodigo1 

	LEFT JOIN bacparamsuda.dbo.Tasa_pais Tpais 
	ON c.Venta_Codigo_Tasa = TPais.Cod_tasa 
         
    LEFT JOIN bacparamsuda.dbo.Moneda Mda 
	on Mda.MnCodMon = Venta_Moneda            
         
    LEFT JOIN Bacparamsuda.dbo.Cliente Cli 
	on Clrut = Rut_Cliente 
	and ClCodigo = codigo_cliente 
         
    LEFT JOIN bacparamsuda.dbo.tabla_general_detalle TipoCliente 
	on TipoCliente.tbcateg = 72 
	and TipoCliente.tbcodigo1 = Cli.Cltipcli 
         
    LEFT JOIN BacParamSuda.dbo.pais Pais 
	on Pais.Codigo_pais = Cli.ClPais
			
WHERE tipo_Flujo = 2 AND TipoTasa.tbValor = 2   
AND C.fecha_fijacion_tasa BETWEEN @FechaInicio AND @FechaFin
and c.estado not in ('C', 'N' )  -- descartar cotizaciones y anticipos

	UPDATE #TEMP
    SET  TIPO_MONEDA= ltrim(rtrim(TIPO_MONEDA)) + ' / ' +  Mda.mnNemo 
	FROM BacSwaPSuda.dbo.Cartera  c
    LEFT JOIN BacParamSuda.dbo.Moneda Mda 
		ON Mda.mncodmon = c.Venta_moneda 
		AND c.tipo_Flujo = 2
	WHERE #TEMP.tipo_Flujo = 1  
	  AND #TEMP.OPERACION  = c.numero_operacion

	UPDATE #TEMP
	SET TIPO_MONEDA = ltrim(rtrim(TIPO_MONEDA)) + ' / ' +  Mda.mnNemo 
	FROM BacSwaPSuda.dbo.Cartera  c
    LEFT JOIN BacParamSuda.dbo.Moneda Mda 
		ON Mda.mncodmon = c.Compra_moneda 
		AND c.tipo_Flujo = 1
	WHERE #TEMP.tipo_Flujo = 2  
      AND #TEMP.OPERACION  = c.numero_operacion
	
	update #TEMP
	   set FECHA_PROPUESTA = bacparamsuda.dbo.fx_AGREGA_N_DIAS_HABILES( fecha_inicio_flujo, -SpotLag, Pais  )
	     , FIJACION_CHECK_USA =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_FIJACION, ';225;') 
		                                   <> FECHA_FIJACION
		                           then 1 else 0 end
		 , FIJACION_CHECK_ING =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_FIJACION, ';510;') 
		                                   <> FECHA_FIJACION
		                           then 1 else 0 end
		 , FIJACION_CHECK_SCL = case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_FIJACION, ';6;') 
		                                   <> FECHA_FIJACION
		                           then 1 else 0 end 

    update #TEMP
       set PROPUESTA_CHECK_USA =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_PROPUESTA, ';225;') 
		                                   <> FECHA_PROPUESTA
		                           then 1 else 0 end
		 , PROPUESTA_CHECK_ING  =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_PROPUESTA, ';510;') 
		                                   <> FECHA_PROPUESTA
		                           then 1 else 0 end
	     , PROPUESTA_CHECK_SCL  =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_PROPUESTA, ';6;') 
		                                   <> FECHA_PROPUESTA
		                           then 1 else 0 end	


	
	if @IncluyeFijacion = 0
	BEGIN
			SELECT    OPERACION
					, NUMERO_FLUJO
					, NOMBRE_CLIENTE
					, TIPO_CLIENTE
					, PAIS_CLIENTE
					, TIPO_TASA
					, CHECK_USA
					, CHECK_ING 
					, CHECK_SCL
					, FECHA_FIJACION
					, FIJACION_CHECK_USA
					, FIJACION_CHECK_ING
					, FIJACION_CHECK_SCL
					, FECHA_PROPUESTA
					, PROPUESTA_CHECK_USA
					, PROPUESTA_CHECK_ING
					, PROPUESTA_CHECK_SCL
					, RUT_CLIENTE
					, TIPO_FLUJO
					, FECHA_LIQUIDACION
					, FECHA_INICIO_FLUJO
					, SPOTLAG 
			FROM #TEMP
			WHERE FIJACION_CHECK_USA = 1 OR FIJACION_CHECK_ING = 1 OR FIJACION_CHECK_SCL = 1
			ORDER BY FECHA_FIJACION DESC
			
	END
	ELSE
		BEGIN
	SELECT    OPERACION
			, NUMERO_FLUJO
			, NOMBRE_CLIENTE
			, TIPO_CLIENTE
			, PAIS_CLIENTE
			, TIPO_TASA
			, CHECK_USA
			, CHECK_ING 
			, CHECK_SCL
			, FECHA_FIJACION
			, FIJACION_CHECK_USA
			, FIJACION_CHECK_ING
			, FIJACION_CHECK_SCL
			, FECHA_PROPUESTA
			, PROPUESTA_CHECK_USA
			, PROPUESTA_CHECK_ING
			, PROPUESTA_CHECK_SCL
			, RUT_CLIENTE
			, TIPO_FLUJO
			, FECHA_LIQUIDACION
			, FECHA_INICIO_FLUJO
			, SPOTLAG 
			FROM #TEMP
			ORDER BY FECHA_FIJACION DESC
		END
    SET NOCOUNT OFF
 END
GO
