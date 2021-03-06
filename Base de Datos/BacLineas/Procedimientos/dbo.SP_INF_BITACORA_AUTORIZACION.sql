USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_BITACORA_AUTORIZACION]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INF_BITACORA_AUTORIZACION]
		(
			@FechaInicio		CHAR(08)
		,	@FechaTermino		CHAR(08)
		,	@Usuario		CHAR(15)
		)
AS
BEGIN

    SET NOCOUNT ON
      IF EXISTS(SELECT 1
	  FROM APROBACION_OPERACIONES 		AO
	  ,    LINEA_TRANSACCION_DETALLE	LT
	  ,    VIEW_CLIENTE			CL
	  ,    VIEW_MDAC			MA
	 WHERE FechaOperacion BETWEEN @FechaInicio AND @FechaTermino
	   AND AO.NumeroOperacion	= LT.NumeroOperacion
	   AND AO.Id_Sistema		= LT.Id_Sistema
	   AND CL.clrut 		= LT.Rut_Cliente
	   AND CL.clcodigo		= LT.Codigo_Cliente
	   AND LT.Error			= 'N')
       BEGIN

	SELECT 'Fecha' 		= AO.FechaOperacion
	,      'Sistema'	= AO.Id_Sistema
	,      'Cliente'	= CL.clnombre
	,      'TipoCli'	= Cl.cltipcli
	,      'Moneda'  	= 'CLP'
	,      'MontoOperacion' = LT.MontoTransaccion
	,      'TipoExceso'     = LT.Mensaje_Error
	,      'MontoExc'	= LT.MontoExceso
	,      'Autorizado'	= AO.Operador_Ap_Limites
	,      'Hora'		= CONVERT(CHAR(10),GETDATE(),108)
	,      'FechaRepo'	= MA.acfecproc
	,      'Usuario' 	= @Usuario
	  FROM APROBACION_OPERACIONES 		AO
	  ,    LINEA_TRANSACCION_DETALLE	LT
	  ,    VIEW_CLIENTE			CL
	  ,    VIEW_MDAC			MA
	 WHERE FechaOperacion BETWEEN @FechaInicio AND @FechaTermino
	   AND AO.NumeroOperacion	= LT.NumeroOperacion
	   AND AO.Id_Sistema		= LT.Id_Sistema
	   AND CL.clrut 		= LT.Rut_Cliente
	   AND CL.clcodigo		= LT.Codigo_Cliente
	   AND LT.Error			= 'N'
       END
       
       ELSE

       BEGIN
	SELECT 'Fecha' 		= ''
	,      'Sistema'	= ''
	,      'Cliente'	= ''
	,      'TipoCli'	= ''
	,      'Moneda'  	= ''
	,      'MontoOperacion' = 0
	,      'TipoExceso'     = ''
	,      'MontoExc'	= 0
	,      'Autorizado'	= ''
	,      'Hora'		= CONVERT(CHAR(10),GETDATE(),108)
	,      'FechaRepo'	= acfecproc
	,      'Usuario' 	= @Usuario
	  FROM VIEW_MDAC


       END

    SET NOCOUNT OFF

END
GO
