USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDACION_FECHA_CONDICION_PACTO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VALIDACION_FECHA_CONDICION_PACTO]
	(	@iRut		NUMERIC(12)
	,	@iCodigo	NUMERIC(9)
	)
AS
BEGIN
	
	SET NOCOUNT ON
	
	SELECT	Sw			= CASE WHEN FechaFirmaCG_Pactos = '19000101' THEN 'No'	ELSE 'Si'	END
	,		Id			= CASE WHEN FechaFirmaCG_Pactos = '19000101' THEN 0		ELSE 1		END
	,		Fecha		= FechaFirmaCG_Pactos
	,		Nombre		= clnombre
	,		Mensaje		= 'Cliente NO Registra la Firma de las Condiciones Generales de Pactos.' 
	FROM	BacParamSuda.dbo.CLIENTE with(nolock) 
	WHERE	clrut		= @iRut 
		AND clcodigo	= @iCodigo

END
GO
