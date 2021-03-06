USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAOPETKINMESA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LISTAOPETKINMESA](
	@FechaDesde		CHAR(8)		= '' ,
	@FechaHasta		CHAR(8)		= '' ,
	@Numero_Operacion	numeric(10,0)	= 0 ,
	@Estado			varchar(1)	= ''
)
AS 
BEGIN
   SET NOCOUNT ON
	IF @Numero_Operacion <> 0
	BEGIN
		SELECT	a.Fecha_Operacion,
			a.codigo_producto,
			a.Numero_Operacion,
			a.Numero_Operacion_Relacion,
			a.Tipo_Operacion ,
			a.CodMoneda1,
			a.Modalidad,
			a.MontoMoneda1,
			a.TipoCambio,
			a.CodMoneda2,
			a.MontoMoneda2,
			a.FechaVencimiento,
			a.Plazo,			a.Precio1,			a.Precio2
		FROM    TBL_CARTICKETFWD a
		WHERE	a.Fecha_Operacion BETWEEN @FechaDesde AND @FechaHasta
		AND	a.Numero_Operacion =@Numero_Operacion
	END
	ELSE
	BEGIN
		SELECT	'Fecha_Operacion '		= a.Fecha_Operacion,
			'Codigo_Producto'		= ISNULL((SELECT descripcion FROM VIEW_TABLA_PRODUCTO where codigo_producto= a.codigo_producto),'No Especificado'),
			'Numero_Operacion'		= a.Numero_Operacion,
			'Numero_Operacion_Relacion'	= a.Numero_Operacion_Relacion,
			'Tipo Operacion'		= CASE a.Tipo_Operacion 
							  WHEN	'V' THEN 'Venta'
							  ELSE	'Compra'
							  END,
			'Moneda1'			= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado'))+ '/' + RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda2),'No Especificado')),
			'MontoMoneda1'			= a.MontoMoneda1,
			'TipoCambio'			= a.TipoCambio,
			'MontoMoneda2'			= a.MontoMoneda2,
			'CodCarteraOrigen'		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
								WHERE 	rcsistema		= 'BFW'
								AND	RCCODPRO		=10
								and	rcrut			=a.CodCarteraOrigen),'No Especificado')),
			'CodMesaOrigen'			= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
							  WHERE 	tbcodigo1=a.CodMesaOrigen),'No Especificado')),
			'CodCarteraDestino'		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
								WHERE 	rcsistema		= 'BFW'
								AND	RCCODPRO		=10
								and	rcrut			=a.CodCarteraDestino),'No Especificado')),
			'CodMesaDestino'		= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
							  WHERE 	tbcodigo1=a.CodMesaDestino),'No Especificado')),
			'Usuario'			= a.Usuario,
			'CodigoProducto'		= a.codigo_producto

		INTO    #TBL_CARTICKETFWD
		FROM    TBL_CARTICKETFWD a
		WHERE	a.Fecha_Operacion BETWEEN @FechaDesde AND @FechaHasta
		AND	Anticipo		<> 'S'


		SELECT * FROM #TBL_CARTICKETFWD
	END
END

GO
