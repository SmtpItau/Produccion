USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELCARVIGTICKET]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PAPELCARVIGTICKET]
	(	@numOper	NUMERIC(19)		)
AS
BEGIN
	SET NOCOUNT ON

	/*=======================================================================*/
	DECLARE @firma1 char(15)
	DECLARE @firma2 char(15)

	DECLARE @nvaluf           FLOAT
	DECLARE @cnomprop         CHAR(40)
	DECLARE @cdirprop         CHAR(40)
	DECLARE @cSettlement      CHAR(50)
	DECLARE @cPFE             CHAR(50)
	DECLARE @cCCE             CHAR(50)
	DECLARE @cEmisorInstPlazo CHAR(50)
	DECLARE @cEstado          CHAR(15)
	DECLARE @cFecproc         CHAR(10)
	DECLARE @cadena           CHAR(1) 
	DECLARE @cadena1          CHAR(1) 

	SELECT @cadena1          = ' '  
	SELECT @cadena           = ' '

	SELECT	  @cnomprop = acnomprop   
		, @cdirprop = acdirprop   
		, @cfecproc = CONVERT(Char(10),acfecproc,103) 
		, @nvaluf   = vmvalor
	FROM	MFAC, VIEW_VALOR_MONEDA
	WHERE	vmcodigo  = accodmonuf     
	AND	vmfecha   = acfecproc

	   SET @cestado = ' ' 
	SELECT @cEstado = 'VIGENTE' from  TBL_MOV_TICKETFWD where Numero_Operacion = @numOper and estado='V'
	SELECT @cEstado = 'ANULADO' from  TBL_MOV_TICKETFWD where Numero_Operacion = @numOper and estado='A'
 
	IF NOT EXISTS( SELECT 1 FROM TBL_CARTICKETFWD WITH(NOLOCK) WHERE numero_operacion = @numOper )
	BEGIN
		 SET @cEstado = 'VENCIDA'
		
		SELECT  'Numero Operacion'		= a.Numero_Operacion,
				'Fecha Proceso'			= CONVERT(CHAR(10), a.Fecha_Operacion,  103 ), --2
				'Fecha Inicio'			= CONVERT(CHAR(10), a.Fecha_Operacion,  103 ), --2
				'Fecha Vcto'         	= CONVERT(CHAR(10), a.FechaVencimiento, 103 ), --3
				'Plazo'              	= a.Plazo                                    , --4
				'Hora'					= a.Hora,
				'CodCarteraOrigen'		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA		WHERE rcsistema = 'BFW' AND RCCODPRO = 10 and rcrut = a.CodCarteraOrigen),'No Especificado')),
				'CodMesaOrigen'			= RTRIM(ISNULL((SELECT tbglosa  FROM dbo.VIEW_TABLA_MESA	WHERE tbcodigo1 = a.CodMesaOrigen),'No Especificado')),
				'CodCarteraDestino'		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA		WHERE rcsistema	= 'BFW' AND	RCCODPRO = 10 and rcrut	= a.CodCarteraDestino),'No Especificado')),
				'CodMesaDestino'		= RTRIM(ISNULL((SELECT tbglosa	FROM dbo.VIEW_TABLA_MESA	WHERE tbcodigo1 = a.CodMesaDestino),'No Especificado')),
				'Tipo_Operacion'		= CASE a.Tipo_Operacion WHEN 'V' THEN 'Venta' ELSE	'Compra' END,
				'Tipo_Operacion2'		= CASE a.Tipo_Operacion WHEN 'V' THEN 'Compra' ELSE	'Venta' END,
				'Moneda_Mercado'		= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado')),
				'Tc Inicial'			= a.Precio2,
				'Tc Inicial'			= a.Precio1,
				'Pago MX'				= 'X',
				'Modalidad'				= CASE a.Modalidad WHEN	'C' THEN 'Compensación' ELSE 'Entrega Fisica' END,
				'Usuario'				= a.Usuario,
				'Estado'				= @cEstado,
				'CodMoneda1'			= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado')),
				'MontoMoneda1'			= a.MontoMoneda1,
				'CodMoneda2'			= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda2),'No Especificado')),
				'MontoMoneda2'			= a.MontoMoneda2,
				'TipoCambio'			= a.TipoCambio,
				'UnionMoneda'			= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado')) +'/'+ RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda2),'No Especificado')),
				'Moneda'				= RTRIM(ISNULL((SELECT mnglosa FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado')),
				'Precio1'				= a.Precio1, --> case when a.Codigo_Producto = 2 then a.TipoCambio else a.Precio1 end,
				'Precio2'				= a.Precio2, --> case when a.Codigo_Producto = 2 then a.TipoCambio else a.Precio2 end,
				'Equivalente_USD'		= a.MontoMoneda1 * a.Precio2,
				'Fecha_Fijacion_Par'	= a.Fecha_Fijacion_Par,
				'Producto_Operacion'	= (SELECT descripcion FROM bacparamsuda.dbo.PRODUCTO WHERE Id_Sistema='BFW' AND codigo_producto=a.Codigo_Producto),
				'PrecioFwd'				= CASE WHEN a.Codigo_Producto = 2 THEN a.tipocambio ELSE a.Precio2 end
		FROM	TBL_MOV_TICKETFWD		a
		WHERE	a.Numero_Operacion		= @numOper

	END ELSE
	BEGIN
		SELECT  'Numero Operacion'		= a.Numero_Operacion,
				'Fecha Proceso'			= CONVERT(CHAR(10), a.Fecha_Operacion, 103 )                                ,--2
				'Fecha Inicio'			= CONVERT(CHAR(10), a.Fecha_Operacion, 103 )                                ,--2
				'Fecha Vcto'         	= CONVERT(CHAR(10), a.FechaVencimiento, 103 )                              ,--3
				'Plazo'              	= a.Plazo                                                         ,--4
				'Hora'					= a.Hora,
				'CodCarteraOrigen'		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA		WHERE rcsistema = 'BFW' AND RCCODPRO = 10 and rcrut = a.CodCarteraOrigen),'No Especificado')),
				'CodMesaOrigen'			= RTRIM(ISNULL((SELECT tbglosa  FROM dbo.VIEW_TABLA_MESA	WHERE tbcodigo1 = a.CodMesaOrigen),'No Especificado')),
				'CodCarteraDestino'		= RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA		WHERE rcsistema	= 'BFW' AND	RCCODPRO = 10 and rcrut	= a.CodCarteraDestino),'No Especificado')),
				'CodMesaDestino'		= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA WHERE tbcodigo1=a.CodMesaDestino),'No Especificado')),
				'Tipo_Operacion'		= CASE a.Tipo_Operacion WHEN	'V' THEN 'Venta' ELSE	'Compra' END,
				'Tipo_Operacion2'		= CASE a.Tipo_Operacion WHEN	'V' THEN 'Compra' ELSE	'Venta' END,
				'Moneda_Mercado'		= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado')),
				'Tc Inicial'			= a.Precio2,
				'Tc Inicial'			= a.Precio1,
				'Pago MX'				= 'X',
				'Modalidad'				= CASE a.Modalidad WHEN	'C' THEN 'Compensación' ELSE 'Entrega Fisica' END,
				'Usuario'				= a.Usuario,
				'Estado'				= @cEstado,
				'CodMoneda1'			= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado')),
				'MontoMoneda1'			= a.MontoMoneda1,
				'CodMoneda2'			= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda2),'No Especificado')),
				'MontoMoneda2'			= a.MontoMoneda2,
				'TipoCambio'			= a.TipoCambio,
				'UnionMoneda'			= RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado')) +'/'+ RTRIM(ISNULL((SELECT mnnemo FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda2),'No Especificado')),
				'Moneda'				= RTRIM(ISNULL((SELECT mnglosa FROM dbo.VIEW_MONEDA where mncodmon = a.CodMoneda1),'No Especificado')),
				'Precio1'				= a.Precio1, --> case when a.Codigo_Producto = 2 then a.TipoCambio else a.Precio1 end,
				'Precio2'				= a.Precio2, --> case when a.Codigo_Producto = 2 then a.TipoCambio else a.Precio2 end,
				'Equivalente_USD'		= a.MontoMoneda1 * a.Precio2,
				'Fecha_Fijacion_Par'	= a.Fecha_Fijacion_Par,
				'Producto_Operacion'	= (SELECT descripcion FROM bacparamsuda.dbo.PRODUCTO WHERE Id_Sistema='BFW' AND codigo_producto=a.Codigo_Producto),
				'PrecioFwd'				= CASE WHEN a.Codigo_Producto = 2 THEN a.tipocambio ELSE a.Precio2 end
		FROM	TBL_CARTICKETFWD a
		WHERE	a.Numero_Operacion		= @numOper
	END

	SET NOCOUNT OFF

END
GO
