USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TraePassWord]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TraePassWord] 
                              ( @tipo          CHAR(15)  ,
                                @usuario       CHAR(15) ,
                                @clave         CHAR(15) )


AS
BEGIN

      SET NOCOUNT ON
      SET DATEFORMAT dmy

            SELECT clave_anterior1 
                  ,clave_anterior2 
                  ,clave_anterior3
                  ,clave

            FROM   USUARIO 
            WHERE  usuario = @usuario AND
                   tipo_usuario = @tipo


      SET NOCOUNT OFF

END







GO
