USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACCESO_CLAVESANTERIORES]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACCESO_CLAVESANTERIORES]
                                    ( @usuario CHAR(15))
AS
BEGIN
      SET NOCOUNT ON
      SELECT clave_anterior1,
             clave_anterior2,
             clave_anterior3,
             clave
      FROM USUARIO
      WHERE usuario = @usuario 
      SET NOCOUNT OFF
END
GO
