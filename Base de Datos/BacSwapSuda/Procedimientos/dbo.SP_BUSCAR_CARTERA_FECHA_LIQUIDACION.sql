USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_CARTERA_FECHA_LIQUIDACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_CARTERA_FECHA_LIQUIDACION] (@FechaInicio		DATETIME
													     ,@FechaFin			DATETIME
													     ,@IncluyeLiquidacion	SMALLINT)
 AS
 BEGIN
 SET NOCOUNT ON   

	/*
	exec SP_BUSCAR_CARTERA_FECHA_LIQUIDACION '20130116', '20160226', 1
	exec SP_BUSCAR_CARTERA_FECHA_LIQUIDACION '20151231', '20170101', 0
	exec SP_BUSCAR_CARTERA_FECHA_LIQUIDACION '20150623', '20150623', 1
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
	,FECHA_LIQUIDACION		DATETIME
	,LIQUIDACION_CHECK_USA	SMALLINT
	,LIQUIDACION_CHECK_ING	SMALLINT
	,LIQUIDACION_CHECK_SCL	SMALLINT
	,FECHA_PROPUESTA		DATETIME
	,PROPUESTA_CHECK_USA	SMALLINT
	,PROPUESTA_CHECK_ING	SMALLINT
	,PROPUESTA_CHECK_SCL	SMALLINT
	,CHECK_USA				SMALLINT
	,CHECK_ING				SMALLINT
	,CHECK_SCL				SMALLINT
	,FECHA_FIJACION			DATETIME
	,FECHA_PROCESO			DATETIME
	, CadenaPais            VARCHAR(30)
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
			    c.FechaLiquidacion, 
			    0,
			    0,
			    0,
			    '',
			    0,
			    0,
			    0,
			    CASE WHEN C.FeriadoLiquiEEUU = 1 THEN 1 ELSE 0 END, 
                CASE WHEN C.FeriadoLiquiChile = 1 THEN 1 ELSE 0 END, 
                CASE WHEN C.FeriadoLiquiEnglan = 1 THEN 1 ELSE 0 END,
                Fecha_Fijacion_Tasa,
                '',
				case when C.FeriadoLiquiEEUU     = 1 then ';225' else '' end
				+ case when C.FeriadoLiquiChile  = 1 then ';6' else '' end
				+ case when C.FeriadoLiquiEnglan = 1 then ';510' else '' end + ';'
FROM BacSwapSuda.dbo.cartera C
   
    LEFT JOIN bacparamsuda.dbo.tabla_general_detalle TipoTasa 
	ON TipoTasa.tbcateg = 1042 
	AND c.Compra_Codigo_Tasa = TipoTasa.tbcodigo1
			 
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
			
WHERE tipo_Flujo = 1
AND C.fechaliquidacion BETWEEN @FechaInicio AND @FechaFin 
and c.estado not in ( 'C', 'N' )

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
	   FechaLiquidacion,
		0,
		0,
		0,
		'',
		0,
		0,
		0,
		CASE WHEN C.FeriadoLiquiEEUU = 1 THEN 1 ELSE 0 END, 
        CASE WHEN C.FeriadoLiquiChile = 1 THEN 1 ELSE 0 END, 
        CASE WHEN C.FeriadoLiquiEnglan = 1 THEN 1 ELSE 0 END,
        Fecha_Fijacion_Tasa,
        '',
		case when C.FeriadoLiquiEEUU     = 1 then ';225' else '' end
				+ case when C.FeriadoLiquiChile  = 1 then ';6' else '' end
				+ case when C.FeriadoLiquiEnglan = 1 then ';510' else '' end + ';'
FROM BacSwapSuda.dbo.cartera C

    LEFT JOIN bacparamsuda.dbo.tabla_general_detalle TipoTasa 
	on TipoTasa.tbcateg = 1042 
	and c.venta_Codigo_Tasa = TipoTasa.tbcodigo1 
         
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
			
WHERE tipo_Flujo = 2 
AND C.fechaliquidacion BETWEEN @FechaInicio AND @FechaFin
and c.estado not in ( 'C', 'N' )

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
      
	UPDATE #TEMP
	SET	FECHA_PROCESO = SG.fechaproc
	FROM BacSwapSuda.DBO.SwapGeneral sg      
	
     
	update #TEMP
	   set FECHA_PROPUESTA = bacparamsuda.dbo.fx_regla_feriados_internacionales( fecha_liquidacion, CadenaPais   )
	      
	     , LIQUIDACION_CHECK_USA =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(fecha_liquidacion, ';225;') 
		                                   <> fecha_liquidacion
		                           then 1 else 0 end
	
		 , LIQUIDACION_CHECK_ING =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(fecha_liquidacion, ';510;') 
		                                   <> fecha_liquidacion
		                           then 1 else 0 end
		 , LIQUIDACION_CHECK_SCL = case when bacparamsuda.dbo.fx_regla_feriados_internacionales(fecha_liquidacion, ';6;') 
		                                   <> fecha_liquidacion
		                           then 1 else 0 end 

    update #TEMP
	   set
	       PROPUESTA_CHECK_USA =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_PROPUESTA, ';225;') 
		                                   <> FECHA_PROPUESTA
		                           then 1 else 0 end
		 , PROPUESTA_CHECK_ING =  case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_PROPUESTA, ';510;') 
		                                   <> FECHA_PROPUESTA
		                           then 1 else 0 end
		 , PROPUESTA_CHECK_SCL = case when bacparamsuda.dbo.fx_regla_feriados_internacionales(FECHA_PROPUESTA, ';6;') 
		                                   <> FECHA_PROPUESTA
		                           then 1 else 0 end 
	
	/*FIN BUSCA FECHA PROPUESTA*****************************************************************************************/
	
	if @IncluyeLiquidacion = 0
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
					, FECHA_LIQUIDACION
					, LIQUIDACION_CHECK_USA
					, LIQUIDACION_CHECK_ING
					, LIQUIDACION_CHECK_SCL
					, FECHA_PROPUESTA
					, PROPUESTA_CHECK_USA
					, PROPUESTA_CHECK_ING
					, PROPUESTA_CHECK_SCL
					, RUT_CLIENTE
					, TIPO_FLUJO
					, FECHA_FIJACION

			FROM #TEMP
			WHERE LIQUIDACION_CHECK_USA = 1 OR LIQUIDACION_CHECK_ING = 1 OR LIQUIDACION_CHECK_SCL = 1
			ORDER BY OPERACION, FECHA_LIQUIDACION DESC
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
					, FECHA_LIQUIDACION
					, LIQUIDACION_CHECK_USA
					, LIQUIDACION_CHECK_ING
					, LIQUIDACION_CHECK_SCL
					, FECHA_PROPUESTA
					, PROPUESTA_CHECK_USA
					, PROPUESTA_CHECK_ING
					, PROPUESTA_CHECK_SCL
					, RUT_CLIENTE
					, TIPO_FLUJO
					, FECHA_FIJACION
			FROM #TEMP
			ORDER BY OPERACION, FECHA_LIQUIDACION DESC
		END
    SET NOCOUNT OFF
 END

GO
