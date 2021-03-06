USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEPASSWORD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TRAEPASSWORD] 
                              ( @tipo          CHAR(15)  ,
                                @usuario       CHAR(15) ,
                                @clave         CHAR(15) )
AS
BEGIN
      SET NOCOUNT ON
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
