USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEE_MOVIMIENTOS_MANUALES_DEL_DIA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEE_MOVIMIENTOS_MANUALES_DEL_DIA]
AS
BEGIN
	SET NOCOUNT ON

	SELECT	id_Transaccion		= mm.id_Transaccion  --> mm.id_Transaccion
		,	dFechaCarga			= mm.dFechaCarga
		,	dFechaMovto			= mm.dFechaMovto
		,	idTX_Carga			= mm.id_Transaccion --> mm.idTX_Carga
		,	sOrigen				= me.Descripcion
		,	Movimiento			= mm.Movimiento
		,	Tipo_Operacion		= mm.Tipo_Operacion
		,	RutCliente			= mm.RutCliente
		,	sNombreCliente		= BacparamSuda.dbo.fxCliente( mm.RutCliente, 1, mm.sOrigen)
		,	iFormadPago			= mm.iFormadPago
		,	Monto				= mm.Monto
		,	sMoneda				= isnull(mn.mnnemo, '')
		,	iBanco				= mm.iBanco
		,	sCuenta				= mm.sCuenta
		,	sBeneficiario		= mm.sBeneficiario
		,	idNumeroSistema		= mm.idNumeroSistema
		,	sUserNT				= mm.sUserNT
		,	sUserAutoriza		= mm.sUserAutoriza
	FROM	BacParamSuda.dbo.SADP_MOVIMIENTOS_MANUALES			mm	with(nolock)
 			LEFT JOIN BacParamSuda.dbo.MONEDA					mn	with(nolock)	ON mn.mncodmon	= mm.sMoneda
 			LEFT JOIN BacParamSuda.dbo.SADP_MODULOS_EXTERNOS	me	with(nolock)	ON me.Nemo		= mm.sOrigen
	WHERE   mm.sUserAutoriza	= ''
END
GO
