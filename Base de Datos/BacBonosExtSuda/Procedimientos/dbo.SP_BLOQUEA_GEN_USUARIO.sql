USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEA_GEN_USUARIO]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_BLOQUEA_GEN_USUARIO]
(
	@xUsuario CHAR(12),
	@xBloqueo CHAR(1)
)
AS
BEGIN
      SET NOCOUNT ON
  UPDATE VIEW_USUARIO SET bloqueado = @xBloqueo WHERE Usuario = @xUsuario and usuario <> 'ADMINISTRA'
   SET NOCOUNT OFF
   SELECT 'OK'
END

GO
