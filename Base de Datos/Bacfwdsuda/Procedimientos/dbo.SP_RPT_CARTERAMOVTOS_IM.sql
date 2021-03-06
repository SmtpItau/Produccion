USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_CARTERAMOVTOS_IM]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_RPT_CARTERAMOVTOS_IM](
			@codProd	SMALLINT
		,	@TipoOp		VARCHAR(1)='T'
		,	@nCarteraOrigen	SMALLINT=0
		)
AS
BEGIN
	DECLARE @cnomprop   CHAR(40)
	DECLARE @cdirprop   CHAR(40)
	DECLARE @cfecproc   CHAR(10)
	DECLARE @dfecproc   DATETIME
	DECLARE @nspotuhoy  FLOAT
	DECLARE @observado  NUMERIC(12,04) ,
		@uf   NUMERIC(12,04) ,
		@fecha_observado CHAR(10) ,
		@fecha_uf  CHAR(10)

	SELECT	@cnomprop = (Select rcnombre from VIEW_ENTIDAD)  ,
       		@cdirprop = acdirprop                          ,
	       	@dfecproc = acfecproc                          ,
       		@cfecproc = CONVERT( CHAR(10), acfecproc, 103 )
	FROM    MFAC

	EXECUTE sp_parametros_reporte 	@observado  OUTPUT ,
		@uf   OUTPUT ,
		@fecha_observado OUTPUT ,
		@fecha_uf  OUTPUT

	SET NOCOUNT ON

	SELECT 	@TipoOp AS 'TipoOp',
		a.Numero_Operacion,
		a.Tipo_Operacion,
		c.descripcion AS 'Tipo Producto',
		@dfecproc as 'Fecha Proceso',
		@uf AS 'Valor UF',
		@fecha_uf AS 'Fecha UF',
		@observado AS 'Valor Observado',
		@fecha_observado AS 'Fecha Observado',
		a.Fecha_Operacion AS 'Fecha Inicio',
		a.FechaVencimiento AS 'Fecha Termino',
		a.Plazo,
		datediff(day, @dfecproc, a.FechaVencimiento) AS 'Plazo Vcto.',
		d1.tbglosa AS 'Cartera Origen',
		d2.tbglosa AS 'Cartera Destino',
		d3.tbglosa AS 'Portafolio',
		d4.tbglosa AS 'Contraparte',
		m1.mnnemo AS 'CodMoneda1',
		a.MontoMoneda1,
		m2.mnnemo AS 'CodMoneda2',
		a.MontoMoneda2,
		a.TipoCambio,
		a.Paridad,
		a.Mto_Inicial_Mon1,
		a.Mto_Final_Mon1,
		a.Mto_Inicial_Mon2,
		a.Mto_Final_Mon2,
		ISNULL(b.Valorizacion, 0) AS 'Valorizacion',
		ISNULL(b.Res_Obtenido, 0) AS 'Devengado Acum.',
		a.Modalidad,
		a.Serie,
		a.Anticipo,
		ISNULL(b.Val_Obtenido, 0) AS 'Valor Obtenido',
		ISNULL(b.Res_Obtenido, 0) AS 'Res. Obtenido',
		ISNULL(b.ValorRazonableActivo, 0) AS 'ValorRazonableActivo',
		ISNULL(b.ValorRazonablePasivo, 0) AS 'ValorRazonablePasivo',
		CASE WHEN a.Tipo_Operacion = 'C' THEN b.ValorRazonablePasivo ELSE b.ValorRazonableActivo END AS 'ValorPresente',
		CASE WHEN a.Tipo_Operacion = 'C' THEN b.ValorRazonableActivo ELSE b.ValorRazonablePasivo END AS 'ValorMercado',
		(CASE WHEN a.Tipo_Operacion = 'C' THEN b.ValorRazonablePasivo ELSE b.ValorRazonableActivo END)
                - (CASE WHEN a.Tipo_Operacion = 'C' THEN b.ValorRazonableActivo ELSE b.ValorRazonablePasivo END) AS 'VarDia'
	/*FROM dbo.tbl_carticketfwd a
		,dbo.tbl_resticketfwd b
		,view_producto c
		,view_moneda m1
		,view_moneda m2
		,VIEW_TABLA_GENERAL_DETALLE d1
		,VIEW_TABLA_GENERAL_DETALLE d2
		,VIEW_TABLA_GENERAL_DETALLE d3
		,VIEW_TABLA_GENERAL_DETALLE d4

	WHERE	b.Numero_Operacion =* a.Numero_Operacion
	AND	a.Codigo_Producto = c.codigo_producto
	AND	a.CodMoneda1 = m1.mncodmon
	AND	a.CodMoneda2 = m2.mncodmon
	AND 	a.CodCarteraOrigen = d1.tbcodigo1
	AND	d1.tbcateg = '204'
	AND	a.CodCarteraDestino = d2.tbcodigo1
	AND	d2.tbcateg = '204'
	AND	a.CodMesaOrigen = d3.tbcodigo1
	AND	d3.tbcateg= '245'
	AND	a.CodMesaDestino = d4.tbcodigo1
	AND	d4.tbcateg= '245'
	AND	a.Codigo_Producto = @codProd
	AND	(a.Tipo_Operacion  = @TipoOp OR @TipoOp = 'T')
	AND	(a.CodCarteraOrigen  = @nCarteraOrigen OR @nCarteraOrigen = 0)
	ORDER BY a.Codigo_Producto, a.codCarteraOrigen, a.CodMesaOrigen, a.Tipo_Operacion, a.Modalidad, a.Numero_Operacion */
    
    --RQ 7619
    FROM dbo.tbl_resticketfwd b RIGHT OUTER JOIN  dbo.tbl_carticketfwd a ON b.Numero_Operacion = a.Numero_Operacion
		,view_producto c
		,view_moneda m1
		,view_moneda m2
		,VIEW_TABLA_GENERAL_DETALLE d1
		,VIEW_TABLA_GENERAL_DETALLE d2
		,VIEW_TABLA_GENERAL_DETALLE d3
		,VIEW_TABLA_GENERAL_DETALLE d4

	WHERE a.Codigo_Producto = c.codigo_producto
	AND	a.CodMoneda1 = m1.mncodmon
	AND	a.CodMoneda2 = m2.mncodmon
	AND 	a.CodCarteraOrigen = d1.tbcodigo1
	AND	d1.tbcateg = '204'
	AND	a.CodCarteraDestino = d2.tbcodigo1
	AND	d2.tbcateg = '204'
	AND	a.CodMesaOrigen = d3.tbcodigo1
	AND	d3.tbcateg= '245'
	AND	a.CodMesaDestino = d4.tbcodigo1
	AND	d4.tbcateg= '245'
	AND	a.Codigo_Producto = @codProd
	AND	(a.Tipo_Operacion  = @TipoOp OR @TipoOp = 'T')
	AND	(a.CodCarteraOrigen  = @nCarteraOrigen OR @nCarteraOrigen = 0)
	ORDER BY a.Codigo_Producto, a.codCarteraOrigen, a.CodMesaOrigen, a.Tipo_Operacion, a.Modalidad, a.Numero_Operacion

	SET NOCOUNT OFF
END



GO
