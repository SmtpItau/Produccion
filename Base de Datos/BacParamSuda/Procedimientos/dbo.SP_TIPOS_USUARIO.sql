USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TIPOS_USUARIO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TIPOS_USUARIO]
   (  
      @TipoUsuario       CHAR(15) )
AS
BEGIN

    	SET NOCOUNT ON

    	SELECT  USU.Usuario
	,	USU.Nombre
	,	USU.fecha_expira
	,	CUS.Bloqueado
	,	USU.Tipo_Usuario
	,	GTU.Descripcion
    	FROM 	USUARIO	USU
	,	control_usuario CUS
	,	gen_TIPOS_usuario GTU
    	WHERE 	USU.tipo_usuario = @TipoUsuario
	AND	USU.tipo_usuario = GTU.Tipo_Usuario
	AND	USU.tipo_usuario = CUS.Usuario

    SET NOCOUNT OFF

END
GO
