USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_USUARIO_PARAMOPERA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_USUARIO_PARAMOPERA]
AS
BEGIN
   SELECT usuario
         ,nombre
    FROM usuario
END
GO
