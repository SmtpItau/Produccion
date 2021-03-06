USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_DIA_ERR_TAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RPT_DIA_ERR_TAS] (
	@FECHA	char(8)
	)
AS
BEGIN
	SELECT  rtrim(t.Mensaje_Error) as Error
	,	sis.nombre_sistema  as Modulo
	,	t.numerooperacion as numoper
	,	t.Id_Sistema 
	,	t.Codigo_Producto
   	,	'tipoOperacion' =  CASE WHEN t.Codigo_Producto = 'CI'	THEN 'COMPRA CON PACTO'
					WHEN t.Codigo_Producto = 'CP'	THEN 'COMPRA PROPIA'
					WHEN t.Codigo_Producto = 'FLI'	THEN 'FACILIDAD DE LIQUIDEZ INTRADIA'
					WHEN t.Codigo_Producto = 'FLIP'	THEN 'PAGOS FACILIDAD DE LIQUIDEZ INTRADIA'
					WHEN t.Codigo_Producto = 'ICAP'	THEN 'INTERBANCARIO DE CAPTACION'
					WHEN t.Codigo_Producto = 'ICOL'	THEN 'INTERBANCARIO DE COLOCACION'
					WHEN t.Codigo_Producto = 'RC'	THEN 'RECOMPRA'                 
					WHEN t.Codigo_Producto = 'RCA'		THEN 'RECOMPRA ANTICIPADA'      
					WHEN t.Codigo_Producto = 'RV'	THEN 'REVENTA'                  
					WHEN t.Codigo_Producto = 'RVA'	THEN 'REVENTA ANTICIPADA'       
					WHEN t.Codigo_Producto = 'VI'	THEN 'VENTA CON PACTO'          
					WHEN t.Codigo_Producto = 'VP'	THEN 'VENTA PROPIA'
					WHEN t.Codigo_Producto = 'VPX'	THEN 'VENTA BONOS EXT.'
                            	    END
	,	'Cliente'	= cli.clnombre
	,	isnull(ins.inglosa,'Sin Instrumento')  as Instrumento
	,	ltrim(str(t.PlazoDesde)) + '-' + ltrim(str(t.PlazoHasta)) as Plazo_Ope
	,	CONVERT(CHAR(12),tra.FechaVencimiento,103) as FechaVcto
	,	t.MontoTransaccion as MontoOPe
	,	tra.MontoTransaccion as MontoOpe2
	,	ISNULL(ta.Tasa_inf,0) AS Tasa_min
	,       	ISNULL(ta.Tasa_sup,0) AS Tasa_max
	,	isnull(apo.Operador_Autoriza,'Sin Autorizador') as Autorizador
	,	tra.Operador		--apo.Operador_Origen as Operador
	,	 SUBSTRING(@FECHA,7,2) +'/'+ SUBSTRING(@FECHA,5,2) +'/'+  SUBSTRING(@FECHA,1,4) as Fecha

 	 into #temp 
	FROM 	linea_transaccion	tra	
	INNER Join linea_transaccion_detalle	t
	ON t.NumeroOperacion = tra.NumeroOperacion
	AND t.Error = 'S'
	AND t.linea_transsaccion='CTRLTA'
		--INNER join limites_TASAS	 ta
		LEFT join limites_TASAS	 ta
		ON  tra.Codigo_Producto = ta.Operacion
		AND  ta.Moneda = t.Moneda
			INNER join VIEW_SISTEMA_CNT		sis
			ON sis.id_sistema = tra.id_sistema
				INNER join VIEW_CLIENTE	cli
				ON clrut = tra.Rut_Cliente and cli.clcodigo = tra.Codigo_Cliente
--					INNER join view_instrumento	ins
					LEFT join view_instrumento	ins
					ON instrumento =ins. incodigo
						INNER join DETALLE_APROBACIONES	apo
						ON apo.Numero_Operacion  = tra.NumeroOperacion
						AND apo.Id_Sistema = tra.Id_Sistema

	WHERE FechaInicio =@FECHA
	ORDER BY tra.NumeroOperacion

	IF exists (Select * from #temp)
		Begin
	    	Select * from #temp
		End
	Else
		Begin
		Select '' as Error
		,'Sin Información' as Modulo
		,'' as numoper
		,'' as Id_Sistema 
		,'' as Codigo_Producto
		,'' as tipoOperacion
		,'' as Cliente
		,'' as Instrumento
		,'' as Plazo_Ope
		,'' as FechaVcto
		,0 as MontoOPe
		,0 as MontoOpe2
		,0 as Tasa_min
		,0 as Tasa_max
		,''  as Autorizador
		,''  as Operador		--apo.Operador_Origen as Operador
		, SUBSTRING(@FECHA,7,2) +'/'+ SUBSTRING(@FECHA,5,2) +'/'+  SUBSTRING(@FECHA,1,4) as Fecha
		End
END
GO
