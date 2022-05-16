USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_EXTRAE_CONEXION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_EXTRAE_CONEXION]
	(	@Id	INT	)
AS
BEGIN
	
	SET NOCOUNT ON 

	SELECT	Id
		,	cHost
		,	cName
		,	cPort
		,	cUser
		,	cService
		,	cDescription
	FROM	dbo.SADP_DATOS_ENVIO
	WHERE	Id = @Id
	
END
GO
