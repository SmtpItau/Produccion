USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S012_VencimientoCaptaciones]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S012_VencimientoCaptaciones]
   (   @fecha_desde       DATETIME
   ,   @fecha_hasta       DATETIME
   )
as
begin

----	SP_S012_VencimientoCaptaciones '2013-01-01', '2013-12-01'

	SET NOCOUNT ON
	
	DECLARE	@Fecha_Extraccion	DATETIME
	SELECT	@Fecha_Extraccion = GETDATE()
	
	
	SELECT	RTRIM(LTRIM(STR(rut_cliente)))
	+		dv_cliente 					AS	'Rut_Cliente'
	,		cap_inicio					AS	'Monto_Transaccion'
	,		0							AS	'Monto_CLP'
	,		moneda						AS	'Moneda_Emision'
	,		tasa_interes				AS	'Tasa_Emision'
	,		ejecutivo					AS	'Operador'
	,		''							AS 	'Canal_Deposito'
	,		fec_emision					AS	'Fecha_Emision'
	,		num_depo					AS	'Numero_Operacion'	
	FROM	BANCO..CAPTA
	WHERE	fec_vcto >= @fecha_desde
	AND		fec_vcto  <= @fecha_hasta
 
END
GO
