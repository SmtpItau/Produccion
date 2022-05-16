USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEA_GEN_USUARIO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BLOQUEA_GEN_USUARIO]
                                       (@xUsuario CHAR(12),
                                        @xBloqueo CHAR(1))
AS
BEGIN
      SET NOCOUNT ON
  UPDATE VIEW_USUARIO SET bloqueado = @xBloqueo WHERE Usuario = @xUsuario and usuario <> 'ADMINISTRA'
   SET NOCOUNT OFF
   SELECT 'OK'
END


GO
