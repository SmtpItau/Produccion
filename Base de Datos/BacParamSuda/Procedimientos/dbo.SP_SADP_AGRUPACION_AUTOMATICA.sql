USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_AGRUPACION_AUTOMATICA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_AGRUPACION_AUTOMATICA]
	(	@dFecha		DATETIME	
	,	@cUsuario	VARCHAR(15)
	)
AS
BEGIN
	
	SET NOCOUNT ON

	SELECT  fecha
		,   sistema
		,	tipo_mercado
		,	tipo_operacion
		,	estado_envio
		,	numero_operacion
		,	rut_cliente
		,	codigo_cliente
		,	moneda
		,	monto_operacion
		,	forma_pago
		,	fecha_operacion
		,	fecha_vencimiento
		,	liquidada
		,	RecRutBanco
		,	RecCodBanco
		,	RecCodSwift
		,	RecDireccion
		,	RecCtaCte
		,	Tipo_Movimiento
		,	GlosaAnticipo
		,	Id_Paquete
		,	Estado_Paquete 
		,	Reservado
	  FROM  dbo.MDLBTR
	 WHERE  fecha			= @dFecha 
	   AND  estado_envio	= 'P'
	   AND	Estado_Paquete	= 'D' 

	SELECT * FROM SADP_CRITERIOS 

	
END
GO
