USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_MONEDAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_MONEDAS] 
   (   @Fecha DATETIME
     , @Numero_Simulaciones int  ) 
AS
BEGIN
-- SP_RIEFIN_CONSULTA_MONEDAS '20110314', 0

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set @Numero_Simulaciones = @Numero_Simulaciones + 1
	select TOP (@Numero_Simulaciones) --SELECT TOP 301 -- mientras se migran mas temas 40 + 1
		Fecha = acfecproc
	INTO #TEMP_FECHA
    FROM
		BactraderSuda.dbo.fechas_proceso
    WHERE
		fecha <= @Fecha
    ORDER BY
		acfecproc
	DESC
	
	SELECT	
		Tabla.Fecha
	,	Parametrizacion.Codigo
	,	Tabla.Valor
	FROM
		(
			(
			SELECT	
				Fecha = Tabla1.fecha
			,	Codigo = ( case when Tabla1.codigo_moneda = 994 then 13 else Tabla1.codigo_moneda  end ) -- MAP: 
			,	Valor = CASE
					WHEN Tabla1.codigo_moneda = 994 THEN Tabla1.tipo_cambio -- MAP: antes era 13
					ELSE CASE
						WHEN MONEDA.Convencion = 1 then Tabla1.spotcompra
						ELSE 1/Tabla1.spotcompra
						END
					END
			FROM	
				BacParamSuda.dbo.VALOR_MONEDA_CONTABLE Tabla1  -- Tabla Original Parametros.dbo.VALOR_MONEDA_CONTABLE
			,	#TEMP_FECHA TEMP_FECHA
			,	VALORIZACIONdboparam_curva_fwd MONEDA          -- select * from VALORIZACIONdboparam_curva_fwd
			WHERE
				tabla1.fecha = TEMP_FECHA.Fecha
			AND	(
				--MONEDA.Codigo_BAC = Tabla1.codigo_moneda        -- MAP: Antes
                (case when MONEDA.Codigo_BAC = 13 then 994 else MONEDA.Codigo_BAC end) = Tabla1.codigo_moneda 
				OR	Tabla1.codigo_moneda = 994                    -- MAP: antes era 13
				)
			)  -- select * From BacParamSuda.dbo.VALOR_MONEDA_CONTABLE
               -- select * from VALORIZACIONdboparam_curva_fwd
		UNION
			(
			SELECT
				Tabla2.vmfecha
			,	Tabla2.vmcodigo
			,	Tabla2.vmvalor
			FROM
				bacparamsuda.dbo.valor_moneda Tabla2
			,	#TEMP_FECHA TEMP_FECHA
			WHERE
				tabla2.vmcodigo=998
			AND	tabla2.vmfecha = TEMP_FECHA.Fecha
			)
		) AS Tabla
	,	ParametrosdboParametrizacion_monedas Parametrizacion -- select * from ParametrosdboParametrizacion_monedas
	WHERE
		Parametrizacion.codigo_BAC = Tabla.codigo
	ORDER BY
		Tabla.Fecha DESC
	,	Parametrizacion.Codigo
    
END
GO
