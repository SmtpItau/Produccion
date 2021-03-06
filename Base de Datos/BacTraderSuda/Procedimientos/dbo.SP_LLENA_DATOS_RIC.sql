USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_DATOS_RIC]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LLENA_DATOS_RIC]
	(	@NUMOPER	NUMERIC(10,0)	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @SFORPAV	CHAR(25)
		,	@STIPCAR	CHAR(25)
		,	@NVALMON	FLOAT

	SELECT	@SFORPAV	= ''
		,	@STIPCAR	= ''

	SELECT	TOP 1 
			'RUT_CARTERA'				= convert(char(9), cap.entidad)
		,	'DIGITO_VERI'				= Entidad.rcdv
		,	'CARTERA'					= Entidad.rcnombre
		,	'FORMA_PAGO_INICIO'			= cap.forma_pago
		,	'FORMA_PAGO_VENCIMIENTO'	= ''
		,	'TIPO_RETIRO'				= cap.retiro
		,	'RUT_CLI'					= convert(char(9), cap.rut_cliente)
		,	'DIG_CLI'					= convert(char(7), cap.codigo_rut)
		,	'NOMBRE_CLIENTE'			= isnull(clnombre, '')
		,	'NUMERO_OPERACION'			= cap.numero_operacion

		,	'EJECUTIVO'					= ''
		,	'SUCURSAL'					= ''
		,	'MERCADO'					= ''
		,	'Observacion'				= ''
	FROM	BACTRADERSUDA.DBO.GEN_CAPTACION cap WITH(NOLOCK) 
			left join 
			(	select	clrut, clcodigo, cldv, clnombre, cltipcli
				from	bacparamsuda.dbo.cliente with(nolock)
			)	cliente	On	cliente.clrut		= cap.rut_cliente
						and	cliente.clcodigo	= cap.codigo_rut
			left join
			(	select	rcrut, rcdv, rcnombre
				from	view_entidad with(nolock)
			)	Entidad	On Entidad.rcrut		= cap.entidad
	WHERE (	cap.numero_operacion	= @NUMOPER or @NUMOPER = 0)
	AND		cap.entidad				= Entidad.rcrut
	AND		cap.estado				= ''

END
GO
