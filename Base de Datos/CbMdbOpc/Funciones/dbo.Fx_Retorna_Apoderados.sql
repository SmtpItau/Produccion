USE [CbMdbOpc]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Retorna_Apoderados]    Script Date: 16-05-2022 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--CONTRATO_LEER_DATOS_CONTRATO_RF  94470, 'VI', 91021000,1,6865868,6865868,9853769,9853769

--sp_helptext CONTRATO_LEER_DATOS_CONTRATO_RF

--sp_helptext Fx_Retorna_Apoderados

--dbo.Fx_Retorna_Apoderados 97023000, 1, 9853769, 1


create FUNCTION [dbo].[Fx_Retorna_Apoderados]
	(	@nRutCliente		NUMERIC(11)
	,	@nCodCliente		NUMERIC(10)
	,	@nRutApoderado		NUMERIC(11)
	,	@iRetorna			INT			-->		1 = Nombre;	2 = Rut
	)	RETURNS				VARCHAR(40)

AS
BEGIN

	DECLARE @cRetorno		VARCHAR(40)
		SET @cRetorno		= ''

	IF @nRutApoderado = 0 OR @nRutCliente = 0
	BEGIN
		RETURN @cRetorno
	END

	IF @nRutCliente <> 97023000
	BEGIN
		SELECT	@cRetorno		= CASE	WHEN @iRetorna = 1 THEN isnull(APNOMBRE, '')
									WHEN @iRetorna = 2 THEN RTRIM(LTRIM(CONVERT(CHAR(10), isnull(APRUTAPO,0) ))) 
															+ '-' 
															+ isnull(APDVAPO, '')
								END
		FROM	BacParamSuda.dbo.CLIENTE_APODERADO with(nolock)
		WHERE	aprutcli		= @nRutCliente
		--and		apcodcli		= @nCodCliente
		and		aprutapo		= @nRutApoderado
	END ELSE
	BEGIN
		SELECT	@cRetorno		= CASE	WHEN @iRetorna = 1 THEN isnull(APNOMBRE, '')
									WHEN @iRetorna = 2 THEN RTRIM(LTRIM(CONVERT(CHAR(10), isnull(APRUTAPO,0) ))) 
															+ '-' 
															+ isnull(APDVAPO, '')
								END
		FROM	BacParamSuda.dbo.CLIENTE_APODERADO with(nolock)
		WHERE	aprutcli		= @nRutCliente
		--and		apcodcli		= @nCodCliente
		and		aprutapo		= @nRutApoderado
	END

	RETURN @cRetorno

END

GO
