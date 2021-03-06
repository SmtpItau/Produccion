USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTAOPETKINMESA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNTAOPETKINMESA]
   (
	@Tipo_Seleccion		char(1)	,
	@FechaDesde		CHAR(8)		= '' ,
	@FechaHasta		CHAR(8)		= '' ,
	@Numero_Operacion	numeric(10,0)	= 0 ,
	@Estado			varchar(1)	= ''
)
AS 
BEGIN
   SET NOCOUNT ON
	IF @Tipo_Seleccion = 'D'
	BEGIN
		BEGIN TRANSACTION

		DELETE	TBL_CARTICKETFWD
		WHERE	Numero_Operacion	= @Numero_Operacion

		DELETE	TBL_CARTICKETFWD
		WHERE	Numero_Operacion_Relacion	= @Numero_Operacion
		
		UPDATE	TBL_MOV_TICKETFWD
		SET	Estado	= @Estado
		WHERE	Numero_Operacion	= @Numero_Operacion

		UPDATE	TBL_MOV_TICKETFWD
		SET	Estado	= @Estado
		WHERE	Numero_Operacion_Relacion	= @Numero_Operacion

		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -1, 'NO SE PUEDE ACTUALIZAR LOS DATOS'
			RETURN
			END
		ELSE
			COMMIT
		SELECT 0
	END
	IF @Tipo_Seleccion = 'L'
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
			'Estado'			= a.Estado,
			'CodigoProducto'		= a.codigo_producto
			INTO    #TBL_MOV_TICKETFWD
		FROM    TBL_MOV_TICKETFWD a
		WHERE	a.Fecha_Operacion BETWEEN @FechaDesde AND @FechaHasta
		AND    (a.Estado = @Estado or ( @Estado = '' and a.Estado <> 'A') )


		SELECT * FROM #TBL_MOV_TICKETFWD
END


GO
