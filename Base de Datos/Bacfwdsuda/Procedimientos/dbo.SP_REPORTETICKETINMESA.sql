USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTETICKETINMESA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_REPORTETICKETINMESA] (
	@nProducto		CHAR(5)		= '',
	@Fecha			CHAR(8)		= ''
)

AS 
BEGIN
   SET NOCOUNT ON


	  DECLARE @FecProceso   	DATETIME
       		SET @FecProceso    	= (SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock))

   	  DECLARE @FecEmision   	CHAR(10)
       		SET @FecEmision    	= (SELECT  CONVERT ( CHAR(10) , GETDATE() , 103 ) )

   	  DECLARE @HoraEmision   	CHAR(10)
       		SET @HoraEmision   	= (SELECT  CONVERT ( CHAR(10) , GETDATE() , 108 ) )


		SELECT	'Fecha_Operacion '		= a.Fecha_Operacion,
			'Codigo_Producto'		= ISNULL((SELECT descripcion FROM VIEW_TABLA_PRODUCTO where codigo_producto= a.codigo_producto),'No Especificado'),
			'Numero_Operacion'		= a.Numero_Operacion,
			'Numero_Operacion_Relacion'	= a.Numero_Operacion_Relacion,
			'Tipo Operacion'		= CASE a.Tipo_Operacion WHEN	'V' THEN 'Venta' ELSE 'Compra' END,
			'Moneda1'			= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA WHERE mncodmon = a.CodMoneda1),'No Especificado'))+ '/' + RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA WHERE mncodmon = a.CodMoneda2),'No Especificado')),
			'MontoMoneda1'			= a.MontoMoneda1,
			'TipoCambio'			= a.TipoCambio,
			'MontoMoneda2'			= a.MontoMoneda2,
			'CodCarteraOrigen'		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
								WHERE 	rcsistema		= 'BFW'
								AND	RCCODPRO		= 10
								AND	rcrut			= a.CodCarteraOrigen),'No Especificado')),
			'CodMesaOrigen'			= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
							  WHERE 	tbcodigo1=a.CodMesaOrigen),'No Especificado')),
			'CodCarteraDestino'		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
								WHERE 	rcsistema		= 'BFW'
								AND	RCCODPRO		= 10
								AND	rcrut			= a.CodCarteraDestino),'No Especificado')),
			'CodMesaDestino'		= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
							  WHERE 	tbcodigo1=a.CodMesaDestino),'No Especificado')),
			'Usuario'			= a.Usuario,
			'Estado'			= CASE WHEN a.Estado='V' THEN 'VIGENTE' 
							       WHEN a.Estado='A' THEN 'ANULADA' 
							       ELSE a.Estado END,
			'CodigoProducto'		= a.codigo_producto,
			'FechaProceso'			= @FecProceso,
			'FechaEmision' 			= @FecEmision,
			'HoraEmision'			= @HoraEmision
		INTO    #TBL_MOV_TICKETFWD
		FROM    TBL_MOV_TICKETFWD a
		WHERE	a.Fecha_Operacion = @Fecha
		AND 	a.Codigo_Producto = @nProducto OR @nProducto = ''
		ORDER BY a.Numero_Operacion

		SELECT * FROM #TBL_MOV_TICKETFWD
END


GO
