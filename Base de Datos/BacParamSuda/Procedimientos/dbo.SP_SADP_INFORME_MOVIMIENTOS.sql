USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_INFORME_MOVIMIENTOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_INFORME_MOVIMIENTOS]
	(	@fecha		DATETIME
	,	@usuario	CHAR(15)
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @fechaProc		DATETIME
		SET @fechaProc		= (SELECT dfechaproceso FROM SADP_Control with(nolock) )
	
	SELECT  'cModulo'			= dp.cModulo
		,	'Descripcion'		= me.Descripcion
		,	'fecha'				= md.fecha
		,	'Folio'				= convert(varchar,dp.nContrato)
		,	'tipo_operacion'	= md.tipo_operacion
		,	'Det. T.Oper.'		= pr.Producto
		,	'Clrut'				= md.rut_cliente
		,	'Contraparte'		= dbo.fxCliente(md.rut_cliente,md.codigo_cliente,dp.cModulo)
		,	'Id_Detalle_Pago'	= dp.Id_Detalle_Pago
		,	'iMoneda'			= dp.iMoneda
		,	'mnnemo'			= mo.mnnemo
		,	'iFormaPago'		= dp.iFormaPago
		,	'Forma Pago'		= ISNULL(fp.glosa, 'Sin Forma de Pago')
		,	'Fecha Pago'		= md.fecha_operacion
		,	'nMonto'			= dp.nMonto
		,	'cEstado'			= dp.cEstado
		,	'Estado'			= CASE WHEN dp.cEstado = '' THEN 'Sin Estado' ELSE ee.sDescripcion END
		,	'Fecha'				= @fecha
		,	'Usuario'			= @usuario
		,	'FechaProc'			= @fechaProc
	FROM				BacParamSuda.dbo.SADP_DETALLE_PAGOS		dp
		INNER JOIN BacParamSuda.dbo.mdlbtr md 	  on md.numero_operacion = dp.nContrato    
	  AND md.sistema=dp.cModulo
      AND   md.numero_operacion=dp.nContrato
      AND  md.Secuencia=dp.iSecuencia
	 
			LEFT  JOIN BacParamSuda.dbo.SADP_MODULOS_EXTERNOS		me ON me.Nemo		= dp.cModulo 
			LEFT  JOIN BacParamSuda.dbo.SADP_PRODUCTO_MODULOEXTERNO pr ON pr.Modulo		= dp.cModulo AND pr.CodIgo = md.tipo_mercado
			LEFT  JOIN BacParamSuda.dbo.MONEDA						mo ON dp.iMoneda	= mo.mncodmon
			LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO				fp ON dp.iFormaPago = fp.codigo
			LEFT  JOIN SADP_EstadosEnvio							ee ON dp.cEstado	= ee.sCodigo  
	WHERE	dp.cModulo		IN('GPI', 'CDB', 'FFMM')
	  and md.fecha		= @fecha
 ORDER BY	md.fecha
		,	dp.cModulo
		,	dp.nContrato
		,	md.tipo_operacion
		,	md.rut_cliente
		,	dp.iMoneda
		,	dp.iFormaPago
		,	md.fecha_operacion


END
GO
