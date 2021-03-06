USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEA_GEN_USUARIO]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BLOQUEA_GEN_USUARIO]
                                       (@xusuario char(12),
                                        @xbloqueo char(1))
AS
BEGIN
   SET NOCOUNT ON
   UPDATE VIEW_USUARIO SET bloqueado = @xbloqueo 
   WHERE usuario  = @xusuario 
   AND usuario <> 'ADMINISTRA'
   SET NOCOUNT OFF
   SELECT 'OK'
END

GO
