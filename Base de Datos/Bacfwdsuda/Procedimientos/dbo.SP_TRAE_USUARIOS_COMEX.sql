USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_USUARIOS_COMEX]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TRAE_USUARIOS_COMEX] ( 
@Usuario  	CHAR(15)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @dFechaProceso DATETIME

	SELECT @dFechaProceso = acfecproc FROM bacfwdsuda..mfac  

	SELECT 'nombre' = USU.nombre
	,      'perfil'	= (CASE WHEN LTRIM(RTRIM(USU.clase)) = '' THEN TIPOUSU.clase ELSE USU.clase END)
	,      'mtomax' = (SELECT isnull(MAX(montomax),0) FROM BacCamSuda..COSTOS_COMEX 
				WHERE Fecha = @dFechaProceso 
				AND perfil_comercial = (CASE WHEN LTRIM(RTRIM(USU.clase)) = '' THEN TIPOUSU.clase ELSE USU.clase END) )
	FROM BacParamSuda..USUARIO USU 
	LEFT JOIN BacParamSuda..GEN_TIPOS_USUARIO TIPOUSU ON USU.Tipo_Usuario = TIPOUSU.Tipo_Usuario
	WHERE USU.usuario = @Usuario

	SET NOCOUNT OFF
END

GO
